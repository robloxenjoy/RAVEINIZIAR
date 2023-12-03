/obj/structure/window
	icon = 'modular_septic/icons/obj/structures/smooth_structures/window.dmi'
	icon_state = "window-0"
	base_icon_state = "window"

/obj/structure/window/fulltile
	icon = 'modular_septic/icons/obj/structures/smooth_structures/window.dmi'
	icon_state = "window-0"
	base_icon_state = "window"

/obj/structure/window/attack_foot(mob/living/carbon/human/user, list/modifiers)
	. = ..()
	if(.)
		return
	user.visible_message(span_notice("[user] kicks the [src]."),span_notice("You kick the [src]."), span_hear("You hear the sound of kicking."))
	user.changeNext_move(CLICK_CD_MELEE)
	user.adjustFatigueLoss(10)
	playsound(get_turf(src), 'sound/effects/beatfloorhand.ogg', 80 , FALSE, FALSE)
	sound_hint()
	var/damagee = ((GET_MOB_ATTRIBUTE_VALUE(user, STAT_STRENGTH)/2) + 5)
	take_damage(damagee, BRUTE, "melee", 1)