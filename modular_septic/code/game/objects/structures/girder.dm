/obj/structure/girder
	icon = 'modular_septic/icons/obj/structures/tall/structures_tall.dmi'
	plane = GAME_PLANE_ABOVE_WINDOW
	layer = GIRDER_LAYER

/obj/structure/windowed
	name = "Wooden Window"
	desc = "Can open and close!"
	icon = 'modular_septic/icons/obj/structures/tall/structures_tall.dmi'
	icon_state = "wooden"
	plane = GAME_PLANE_ABOVE_WINDOW
	layer = GIRDER_LAYER
	opacity = FALSE
	density = TRUE
	anchored = TRUE
	var/openet = FALSE
	var/can_walk = FALSE
	var/openwindowound = 'modular_pod/sound/eff/openwindows.ogg'
	var/closewindowound = 'modular_pod/sound/eff/closewindows.ogg'

/obj/structure/windowed/update_icon_state()
	. = ..()
	if(!openet)
		icon_state = "[icon_state]_closed"
		set_opacity(FALSE)
		set_density(TRUE)
	else
		icon_state = "[icon_state]_opened"
		set_opacity(TRUE)
		if(can_walk)
			set_density(FALSE)

/obj/structure/windowed/attack_hand(mob/living/carbon/user, list/modifiers)
	. = ..()
	if(.)
		return
	if(user.a_intent == INTENT_HELP)
		user.visible_message(span_notice("[user] touches the [src]."),span_notice("You touch the [src]."), span_hear("You hear the sound of touching."))
//		user.visible_message("<span class='notice'>\[user] touches the [src].</span>")
		user.changeNext_move(CLICK_CD_WRENCH)
	if(user.a_intent == INTENT_GRAB)
		user.visible_message(span_notice("[user] opens [src]."),span_notice("You open the [src]."), span_hear("You hear the sound of opening."))
//		user.visible_message("<span class='notice'>\[user] beats the [src].</span>")
		user.changeNext_move(CLICK_CD_MELEE)
		user.adjustFatigueLoss(5)
		sound_hint()
		if(!openet)
			openet = TRUE
			playsound(get_turf(src), openwindowound, 80 , FALSE, FALSE)
		else
			openet = FALSE
			playsound(get_turf(src), openwindowound, 80 , FALSE, FALSE)
		update_appearance(UPDATE_ICON)

/obj/structure/windowed/windows
	name = "Window"
	desc = "Can open and close!"
	icon = 'modular_septic/icons/obj/structures/tall/structures_tall.dmi'
	icon_state = "windows"
	plane = GAME_PLANE_ABOVE_WINDOW
	layer = GIRDER_LAYER
	can_walk = TRUE