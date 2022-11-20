/obj/item/organ/cyberimp/chest/thrusters
	name = "implantable thrusters set"
	desc = "An implantable set of thruster ports. They use the gas from environment or subject's internals for propulsion in zero-gravity areas. \
	Unlike regular jetpacks, this device has no stabilization system."
	icon_state = "imp_jetpack"
	base_icon_state = "imp_jetpack"
	implant_overlay = null
	implant_overlay_color = null
	actions_types = list(/datum/action/item_action/organ_action/toggle)
	w_class = WEIGHT_CLASS_NORMAL
	var/on = FALSE
	var/datum/effect_system/trail_follow/ion/ion_trail

/obj/item/organ/cyberimp/chest/thrusters/Insert(mob/living/carbon/new_owner, special = FALSE, drop_if_replaced = TRUE, new_zone = null)
	. = ..()
	if(!ion_trail)
		ion_trail = new
		ion_trail.auto_process = FALSE
	ion_trail.set_up(new_owner)

/obj/item/organ/cyberimp/chest/thrusters/Remove(mob/living/carbon/old_owner, special = FALSE)
	if(on)
		toggle(silent = TRUE)
	return ..()

/obj/item/organ/cyberimp/chest/thrusters/ui_action_click()
	. = ..()
	toggle()

/obj/item/organ/cyberimp/chest/thrusters/proc/toggle(silent = FALSE)
	if(!on)
		if((organ_flags & ORGAN_FAILING))
			if(!silent)
				to_chat(owner, span_warning("Your thrusters set seems to be broken!"))
			return FALSE
		if(allow_thrust(0.01))
			on = TRUE
			ion_trail.start()
			RegisterSignal(owner, COMSIG_MOVABLE_MOVED, .proc/move_react)
			owner.add_movespeed_modifier(/datum/movespeed_modifier/jetpack/cybernetic)
			RegisterSignal(owner, COMSIG_MOVABLE_PRE_MOVE, .proc/pre_move_react)
			if(!silent)
				to_chat(owner, span_notice("You turn your thrusters set on."))
	else
		ion_trail.stop()
		UnregisterSignal(owner, COMSIG_MOVABLE_MOVED)
		owner.remove_movespeed_modifier(/datum/movespeed_modifier/jetpack/cybernetic)
		UnregisterSignal(owner, COMSIG_MOVABLE_PRE_MOVE)
		if(!silent)
			to_chat(owner, span_notice("You turn your thrusters set off."))
		on = FALSE
	update_appearance()

/obj/item/organ/cyberimp/chest/thrusters/update_icon_state()
	. = ..()
	icon_state = "[base_icon_state][on ? "-on" : null]"

/obj/item/organ/cyberimp/chest/thrusters/proc/move_react()
	if(!on)//If jet dont work, it dont work
		return
	if(!owner)//Don't allow jet self using
		return
	if(!isturf(owner.loc))//You can't use jet in nowhere or in mecha/closet
		return
	if(!(owner.movement_type & FLOATING) || owner.buckled)//You don't want use jet in gravity or while buckled.
		return
	if(owner.pulledby)//You don't must use jet if someone pull you
		return
	if(owner.throwing)//You don't must use jet if you thrown
		return
	if(length(owner.client.keys_held & owner.client.movement_keys))//You use jet when press keys. yes.
		allow_thrust(0.01)

/obj/item/organ/cyberimp/chest/thrusters/proc/pre_move_react()
	ion_trail.oldposition = get_turf(owner)

/obj/item/organ/cyberimp/chest/thrusters/proc/allow_thrust(num)
	if(!owner)
		return FALSE

	var/turf/T = get_turf(owner)
	if(!T) // No more runtimes from being stuck in nullspace.
		return FALSE

	// Priority 1: use air from environment.
	var/datum/gas_mixture/environment = T.return_air()
	if(environment && environment.return_pressure() > 30)
		ion_trail.generate_effect()
		return TRUE

	// Priority 2: use plasma from internal plasma storage.
	// (just in case someone would ever use this implant system to make cyber-alien ops with jetpacks and taser arms)
	if(owner.getPlasma() >= num*100)
		owner.adjustPlasma(-num*100)
		ion_trail.generate_effect()
		return TRUE

	// Priority 3: use internals tank.
	var/obj/item/tank/I = owner.internal
	if(I && I.air_contents && I.air_contents.total_moles() > num)
		var/datum/gas_mixture/removed = I.air_contents.remove(num)
		if(removed.total_moles() > 0.005)
			T.assume_air(removed)
			ion_trail.generate_effect()
			return TRUE
		else
			T.assume_air(removed)
			ion_trail.generate_effect()

	toggle(silent = TRUE)
	return FALSE
