/datum/component/clinging
	/// Atom our parent mob is clinging to
	var/atom/clinging_to
	/// Clinging grab our parent mob is holding
	var/obj/item/clinging_grab/clinging_grab
	/// Used for do_after callback checks to cancel clings
	var/cling_valid = TRUE

/datum/component/clinging/Initialize(atom/clinging_to)
	if(!iscarbon(parent))
		return COMPONENT_INCOMPATIBLE
	src.clinging_to = clinging_to

/datum/component/clinging/RegisterWithParent()
	var/mob/living/carbon/carbon_parent = parent
	clinging_grab = new /obj/item/clinging_grab()
	clinging_grab.desc = "Clinging to <em>[clinging_to]</em>."
	if(!carbon_parent.put_in_active_hand(clinging_grab) || !carbon_parent.wield_active_hand())
		qdel(src)
		return
	RegisterClinging()
	RegisterSignal(clinging_grab, COMSIG_PARENT_QDELETING, PROC_REF(qdel_void))
	RegisterSignal(clinging_grab, COMSIG_PARENT_EXAMINE, PROC_REF(grab_examine))
	RegisterSignal(clinging_grab, COMSIG_MOUSEDROP_ONTO, PROC_REF(grab_mousedrop_onto))
	SEND_SIGNAL(carbon_parent, COMSIG_FIXEYE_DISABLE, TRUE, TRUE)
	RegisterSignal(carbon_parent, COMSIG_ATOM_DIR_CHANGE, PROC_REF(deny_dir_change))
	RegisterSignal(carbon_parent, COMSIG_MOUSEDROP_ONTO, PROC_REF(carbon_mousedrop_onto))
	RegisterSignal(carbon_parent, COMSIG_MOVABLE_MOVED, PROC_REF(parent_moved))
	ADD_TRAIT(carbon_parent, TRAIT_FORCED_STANDING, CLINGING_TRAIT)
	ADD_TRAIT(carbon_parent, TRAIT_IMMOBILIZED, CLINGING_TRAIT)
	ADD_TRAIT(carbon_parent, TRAIT_NO_FLOATING_ANIM, CLINGING_TRAIT)
	ADD_TRAIT(carbon_parent, TRAIT_MOVE_FLOATING, CLINGING_TRAIT)
	to_chat(carbon_parent, span_notice("Я цепляюсь за [clinging_to]."))
	SEND_SIGNAL(clinging_to, COMSIG_CLINGABLE_CLING_SOUNDING)

/datum/component/clinging/Destroy(force, silent)
	UnregisterClinging()
	clinging_to = null
	UnregisterSignal(clinging_grab, COMSIG_PARENT_QDELETING)
	UnregisterSignal(clinging_grab, COMSIG_PARENT_EXAMINE)
	UnregisterSignal(clinging_grab, COMSIG_MOUSEDROP_ONTO)
	if(!QDELETED(clinging_grab))
		qdel(clinging_grab)
	clinging_grab = null
	if(parent)
		UnregisterSignal(parent, COMSIG_CLICK)
		UnregisterSignal(parent, COMSIG_ATOM_DIR_CHANGE)
		UnregisterSignal(parent, COMSIG_MOUSEDROP_ONTO)
		UnregisterSignal(parent, COMSIG_MOVABLE_MOVED)
		REMOVE_TRAIT(parent, TRAIT_FORCED_STANDING, CLINGING_TRAIT)
		REMOVE_TRAIT(parent, TRAIT_IMMOBILIZED, CLINGING_TRAIT)
		REMOVE_TRAIT(parent, TRAIT_MOVE_FLOATING, CLINGING_TRAIT)
		REMOVE_TRAIT(parent, TRAIT_NO_FLOATING_ANIM, CLINGING_TRAIT)
		var/mob/living/carbon/carbon_parent = parent
		var/turf/parent_turf = get_turf(carbon_parent)
		if(carbon_parent.can_zFall(parent_turf))
			parent_turf.zFall(carbon_parent)
	return ..()

/datum/component/clinging/proc/RegisterClinging()
	if(!clinging_to)
		return
	RegisterSignal(clinging_to, COMSIG_PARENT_QDELETING, PROC_REF(qdel_void))

/datum/component/clinging/proc/UnregisterClinging()
	if(!clinging_to)
		return
	UnregisterSignal(clinging_to, COMSIG_PARENT_QDELETING)

/datum/component/clinging/proc/carbon_mousedrop_onto(mob/living/carbon/source, atom/over, mob/living/carbon/user)
	SIGNAL_HANDLER

	if(user != parent)
		return
	if(over == source)
		return
	if(DOING_INTERACTION_WITH_TARGET(user, over) || DOING_INTERACTION_WITH_TARGET(user, clinging_to))
		return COMPONENT_NO_MOUSEDROP
	var/turf/below_turf = SSmapping.get_turf_below(get_turf(user))
	//We're trying to move to an openspace adjacent to us
	if((over.z != user.z) && (over != below_turf))
		over = locate(over.x, over.y, user.z)
	//User to clinging = Go up
	if(clinging_to == over)
		if(HAS_TRAIT(clinging_to, TRAIT_CLIMBABLE))
			return
		. = COMPONENT_NO_MOUSEDROP
		INVOKE_ASYNC(src, PROC_REF(try_going_up))
	//User to clinging turf = Go up
	else if(get_turf(clinging_to) == over)
		var/turf/cling_turf = get_turf(clinging_to)
		if(HAS_TRAIT(cling_turf, TRAIT_CLIMBABLE))
			return
		. = COMPONENT_NO_MOUSEDROP
		INVOKE_ASYNC(src, PROC_REF(try_going_up))
	//User to turf below user's turf = Go down
	else if(below_turf == over)
		. = COMPONENT_NO_MOUSEDROP
		INVOKE_ASYNC(src, PROC_REF(try_going_down))
	//User to turf adjacent to user and clinger = Move to turf
	else if(isturf(over) && over.Adjacent(user) && over.Adjacent(clinging_to))
		. = COMPONENT_NO_MOUSEDROP
		INVOKE_ASYNC(src, PROC_REF(try_going_sideways), over)

/datum/component/clinging/proc/grab_mousedrop_onto(atom/source, atom/over, mob/living/carbon/user)
	SIGNAL_HANDLER

	if(user != parent)
		return
	if(over == source)
		return
	if(DOING_INTERACTION_WITH_TARGET(user, over) || DOING_INTERACTION_WITH_TARGET(user, clinging_to))
		return COMPONENT_NO_MOUSEDROP
	var/turf/below_turf = SSmapping.get_turf_below(get_turf(user))
	//Grab to turf below user = Go down
	if((get_turf(user) == over) || (below_turf == over))
		. = COMPONENT_NO_MOUSEDROP
		INVOKE_ASYNC(src, PROC_REF(try_going_down))
	//Grab to atom adjacent to user = Cling to the new atom
	else if(over.Adjacent(user))
		. = COMPONENT_NO_MOUSEDROP
		INVOKE_ASYNC(src, PROC_REF(try_clinging_to), over)

/datum/component/clinging/proc/try_clinging_to(atom/over)
	var/mob/living/carbon/carbon_parent = parent
	if(SEND_SIGNAL(over, COMSIG_CLINGABLE_CHECK, carbon_parent))
		UnregisterClinging()
		UnregisterSignal(carbon_parent, COMSIG_ATOM_DIR_CHANGE)
		carbon_parent.face_atom(over)
		clinging_to = over
		RegisterClinging()
		RegisterSignal(carbon_parent, COMSIG_ATOM_DIR_CHANGE, PROC_REF(deny_dir_change))
		to_chat(carbon_parent, span_notice("Я хватаюсь за [over]."))
		SEND_SIGNAL(clinging_to, COMSIG_CLINGABLE_CLING_SOUNDING)
	else
		to_chat(carbon_parent, span_notice("Я не могу схватиться за это."))

/datum/component/clinging/proc/try_going_sideways(atom/over)
	var/mob/living/carbon/carbon_parent = parent
	var/time = max(0, (35 - (GET_MOB_ATTRIBUTE_VALUE(carbon_parent, STAT_DEXTERITY)+GET_MOB_SKILL_VALUE(carbon_parent, SKILL_ACROBATICS)))/2)
	cling_valid = TRUE
	RegisterSignal(clinging_to, COMSIG_CLICK, PROC_REF(cancel_cling))
	if(!do_after(carbon_parent, time, clinging_to, extra_checks = CALLBACK(src, PROC_REF(did_not_cancel_cling))))
		UnregisterSignal(clinging_to, COMSIG_CLICK)
		to_chat(carbon_parent, span_warning(fail_msg()))
		carbon_parent.playsound_local(get_turf(carbon_parent), 'modular_pod/sound/eff/difficult1.ogg', 15, FALSE)
		return
	UnregisterSignal(clinging_to, COMSIG_CLICK)
	UnregisterSignal(carbon_parent, COMSIG_MOVABLE_MOVED)
	var/turf/over_turf = get_turf(over)
	var/dir = get_dir(carbon_parent, over_turf)
	if(carbon_parent.Move(over_turf, dir))
		to_chat(carbon_parent, span_notice("Я забираюсь на [over_turf]."))
	else
		to_chat(carbon_parent, span_warning(fail_msg()))
		carbon_parent.playsound_local(get_turf(carbon_parent), 'modular_pod/sound/eff/difficult1.ogg', 15, FALSE)
	RegisterSignal(carbon_parent, COMSIG_MOVABLE_MOVED, PROC_REF(parent_moved))

/datum/component/clinging/proc/try_going_up()
	var/mob/living/carbon/carbon_parent = parent
	var/dir = get_dir(carbon_parent, clinging_to)
	var/turf/ceiling = get_step_multiz(carbon_parent, UP)
	var/atom/new_clinger
	if(istype(ceiling))
		new_clinger = get_step(ceiling, dir)
	else
		to_chat(carbon_parent, span_warning("Я уже слишком высоко."))
		return
	//We can't get there anyways
	if(!carbon_parent.canZMove(UP, ceiling))
		to_chat(carbon_parent, span_warning("Я не могу подняться."))
		return
	if(!istype(new_clinger))
		new_clinger = null
	else if(!SEND_SIGNAL(new_clinger, COMSIG_CLINGABLE_CHECK, carbon_parent))
		//Turf is not clingable, but there could be something to grab onto in it
		var/turf/old_clinger = new_clinger
		new_clinger = null
		for(var/atom/clingable in old_clinger)
			if(SEND_SIGNAL(clingable, COMSIG_CLINGABLE_CHECK, carbon_parent))
				new_clinger = clingable
				break
		//Nothing to cling to, but turf could be an open turf
		if(isopenturf(old_clinger) && !old_clinger.can_zFall(carbon_parent, 1, get_step_multiz(old_clinger, DOWN)) )
			new_clinger = old_clinger
	if(!istype(new_clinger) || (!SEND_SIGNAL(new_clinger, COMSIG_CLINGABLE_CHECK, carbon_parent) && !isopenturf(new_clinger)) )
		to_chat(carbon_parent, span_warning("Не могу сверху ни за что схватиться."))
		return
	var/time = max(0, 50 - (GET_MOB_ATTRIBUTE_VALUE(carbon_parent, STAT_DEXTERITY)+GET_MOB_SKILL_VALUE(carbon_parent, SKILL_ACROBATICS)))
	cling_valid = TRUE
	RegisterSignal(clinging_to, COMSIG_CLICK, PROC_REF(cancel_cling))
	if(!do_after(carbon_parent, time, clinging_to, extra_checks = CALLBACK(src, PROC_REF(did_not_cancel_cling))))
		UnregisterSignal(clinging_to, COMSIG_CLICK)
		to_chat(span_warning(fail_msg()))
		carbon_parent.playsound_local(get_turf(carbon_parent), 'modular_pod/sound/eff/difficult1.ogg', 15, FALSE)
		return
	UnregisterSignal(clinging_to, COMSIG_CLICK)
	var/turf/landing_spot
	if(new_clinger)
		landing_spot = get_turf(new_clinger)
	//Don't move to open spaces lmao
	if(landing_spot.can_zFall(carbon_parent, 1, get_step_multiz(landing_spot, DOWN)))
		landing_spot = null
	UnregisterSignal(carbon_parent, COMSIG_MOVABLE_MOVED)
	//We somehow fucked up, despite all our checks! Do nothing.
	if(!carbon_parent.zMove(UP, TRUE))
		RegisterSignal(carbon_parent, COMSIG_MOVABLE_MOVED, PROC_REF(parent_moved))
		return
	UnregisterClinging()
	clinging_to = new_clinger
	//(Probably) Open turf available, try to move to it
	if(landing_spot?.Adjacent(carbon_parent) && carbon_parent.Move(landing_spot, dir))
		carbon_parent.Move(clinging_to, dir)
		to_chat(carbon_parent, span_notice("Я лезу на [clinging_to]."))
		SEND_SIGNAL(clinging_to, COMSIG_CLINGABLE_CLING_SOUNDING)
		qdel(src)
	//Cling to (probably) closed turf instead
	else if(new_clinger?.Adjacent(carbon_parent))
		SEND_SIGNAL(clinging_to, COMSIG_CLINGABLE_CLING_SOUNDING)
		to_chat(carbon_parent, span_notice("Я лезу на [clinging_to]."))
		RegisterSignal(carbon_parent, COMSIG_MOVABLE_MOVED, PROC_REF(parent_moved))
		RegisterClinging()

/datum/component/clinging/proc/try_going_down()
	var/mob/living/carbon/carbon_parent = parent
	var/dir = get_dir(carbon_parent, clinging_to)
	var/turf/floor = get_step_multiz(carbon_parent, DOWN)
	var/atom/new_clinger
	if(istype(floor))
		new_clinger = get_step(floor, dir)
	else
		to_chat(carbon_parent, span_warning("Я уже слишком низко."))
		return
	if(!istype(new_clinger))
		new_clinger = null
	else if(!SEND_SIGNAL(new_clinger, COMSIG_CLINGABLE_CHECK, carbon_parent))
		//Turf is not clingable, but there could be something to grab onto in it
		var/turf/old_clinger = new_clinger
		new_clinger = null
		for(var/atom/clingable in old_clinger)
			if(SEND_SIGNAL(new_clinger, COMSIG_CLINGABLE_CHECK, carbon_parent))
				new_clinger = clingable
				break
	//We can't get there anyways
	if(!carbon_parent.canZMove(DOWN, floor))
		to_chat(carbon_parent, span_warning("Я не могу спуститься."))
		return
	if(!istype(new_clinger) || !(SEND_SIGNAL(new_clinger, COMSIG_CLINGABLE_CHECK, carbon_parent)))
		to_chat(carbon_parent, span_warning("Особо не за что схватиться..."))
	var/time = max(0, 45 - (GET_MOB_ATTRIBUTE_VALUE(carbon_parent, STAT_DEXTERITY)+GET_MOB_SKILL_VALUE(carbon_parent, SKILL_ACROBATICS)))
	cling_valid = TRUE
	RegisterSignal(clinging_to, COMSIG_CLICK, PROC_REF(cancel_cling))
	if(!do_after(carbon_parent, time, clinging_to, extra_checks = CALLBACK(src, PROC_REF(did_not_cancel_cling))))
		UnregisterSignal(clinging_to, COMSIG_CLICK)
		to_chat(span_warning(fail_msg()))
		carbon_parent.playsound_local(get_turf(carbon_parent), 'modular_pod/sound/eff/difficult1.ogg', 15, FALSE)
		return
	UnregisterSignal(clinging_to, COMSIG_CLICK)
	var/turf/landing_spot
	//Remove floating trait temporarily to handle zfalling proper, if we aren't using a new clinger
	if(!new_clinger)
		REMOVE_TRAIT(parent, TRAIT_MOVE_FLOATING, CLINGING_TRAIT)
		REMOVE_TRAIT(parent, TRAIT_NO_FLOATING_ANIM, CLINGING_TRAIT)
	else
		landing_spot = get_turf(new_clinger)
	//Don't go on open spaces lmao
	if(landing_spot.can_zFall(carbon_parent, 1, get_step_multiz(landing_spot, DOWN)) )
		landing_spot = null
	//This proc will already do z fall logic if necessary
	UnregisterSignal(carbon_parent, COMSIG_MOVABLE_MOVED)
	if(!carbon_parent.zMove(DOWN, TRUE))
		RegisterSignal(carbon_parent, COMSIG_MOVABLE_MOVED, PROC_REF(parent_moved))
		return
	UnregisterClinging()
	clinging_to = new_clinger
	//(Probably) Open turf, try to move to it
	if(landing_spot?.Adjacent(carbon_parent) && carbon_parent.Move(landing_spot, dir))
		to_chat(carbon_parent, span_notice("Я спускаюсь на [landing_spot]."))
		qdel(src)
	//Cling instead
	else if(new_clinger?.Adjacent(carbon_parent))
		SEND_SIGNAL(clinging_to, COMSIG_CLINGABLE_CLING_SOUNDING)
		to_chat(carbon_parent, span_notice("Я хватаюсь за [clinging_to]."))
		RegisterSignal(carbon_parent, COMSIG_MOVABLE_MOVED, PROC_REF(parent_moved))
		RegisterClinging()

/datum/component/clinging/proc/cancel_cling()
	SIGNAL_HANDLER

	cling_valid = FALSE

/datum/component/clinging/proc/did_not_cancel_cling()
	return cling_valid

/datum/component/clinging/proc/deny_dir_change()
	SIGNAL_HANDLER

	return COMPONENT_NO_DIR_CHANGE

/datum/component/clinging/proc/qdel_void()
	SIGNAL_HANDLER

	qdel(src)

/datum/component/clinging/proc/parent_moved(atom/movable/mover, atom/oldloc, direction)
	SIGNAL_HANDLER

	to_chat(parent, span_warning(fail_msg()))
//	mover.playsound_local(get_turf(mover), 'modular_pod/sound/eff/difficult1.ogg', 15, FALSE)
	qdel(src)

/datum/component/clinging/proc/grab_examine(datum/source, mob/user, list/examine_list)
	SIGNAL_HANDLER

	examine_list += span_notice("Сейчас схвачен за [clinging_to].")

/obj/item/clinging_grab
	name = "clinging"
	icon = 'modular_septic/icons/hud/quake/screen_quake_64x32.dmi'
	icon_state = "offhand"
	base_icon_state = "offhand"
	carry_weight = 0
	item_flags = DROPDEL | NOBLUDGEON | ABSTRACT | HAND_ITEM
	mouse_opacity = MOUSE_OPACITY_OPAQUE

/obj/item/clinging_grab/apply_outline(outline_color)
	return
