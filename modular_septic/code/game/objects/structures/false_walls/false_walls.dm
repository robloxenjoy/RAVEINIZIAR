/obj/structure/falsewall
	icon = 'modular_septic/icons/turf/tall/walls/victorian.dmi'
	frill_icon = 'modular_septic/icons/turf/tall/walls/frills/victorian_frill.dmi'
	icon_state = "wall-0"
	base_icon_state = "wall"
	/// Should this falsewall get the clingable element?
	var/clingable = FALSE
	/// If we are clingable, this var stores which sound we make when clung to
	var/clinging_sound = 'modular_septic/sound/effects/clung.wav'
	/// Can this false wall be opened with your hand?
	var/can_open = TRUE

/obj/structure/falsewall/Initialize(mapload)
	. = ..()
	initialize_clinging()

/obj/structure/falsewall/attack_hand(mob/user, list/modifiers)
	if(opening)
		return
	. = ..()
	if(.)
		return

	if(!can_open)
		user.changeNext_move(CLICK_CD_MELEE)
		to_chat(user, span_notice("I push the wall but nothing happens!"))
		playsound(src, 'sound/weapons/genhit.ogg', 25, TRUE)
		return

	opening = TRUE
	update_appearance()
	if(!density)
		var/srcturf = get_turf(src)
		for(var/mob/living/obstacle in srcturf) //Stop people from using this as a shield
			opening = FALSE
			return
	addtimer(CALLBACK(src, /obj/structure/falsewall/proc/toggle_open), 5)

/obj/structure/falsewall/proc/initialize_clinging()
	if(clingable)
		AddElement(/datum/element/clingable, SKILL_ACROBATICS, 12, clinging_sound)
		return TRUE
	return FALSE

/obj/structure/falsewall/reinforced
	icon = 'modular_septic/icons/turf/tall/walls/reinforced_victorian.dmi'
	frill_icon = 'modular_septic/icons/turf/tall/walls/frills/reinforced_victorian_frill.dmi'
	icon_state = "reinforced_wall-0"
	base_icon_state = "reinforced_wall"
