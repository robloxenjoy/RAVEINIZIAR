/obj/structure/grille
	icon = 'modular_septic/icons/obj/structures/structures.dmi'
	icon_state = "grille"
	base_icon_state = "grille"
	frill_icon = null
	frill_uses_icon_state = FALSE
	/// Whether or not this is a grille that goes above windows
	var/window_grille = FALSE

/obj/structure/grille/Initialize()
	. = ..()
	AddElement(/datum/element/conditional_brittle, "fireaxe")

/obj/structure/grille/Bumped(atom/movable/bumped_atom)
	if(!ismob(bumped_atom))
		return
	//Don't shock if we have a fulltile winddow here
	if(window_grille)
		for(var/obj/structure/window/window in loc)
			if(window.fulltile)
				return FALSE
	shock(bumped_atom, 70)

/obj/structure/grille/shock(mob/user, prob)
	// Anchored/broken grilles are never connected
	if(!anchored || broken || !prob(prob))
		return FALSE
	// To prevent TK and mech users from getting shocked
	if(!in_range(src, user))
		return FALSE
	var/turf/T = get_turf(src)
	var/obj/structure/cable/C = T.get_cable_node()
	if(C)
		if(electrocute_mob(user, C, src, 1, TRUE))
			var/datum/effect_system/spark_spread/s = new /datum/effect_system/spark_spread
			s.set_up(3, 1, src)
			s.start()
			return TRUE
		else
			return FALSE
	return FALSE

/obj/structure/grille/attack_foot(mob/living/carbon/human/user, list/modifiers)
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

/obj/structure/grille/iron
	icon = 'modular_septic/icons/obj/structures/structures.dmi'
	icon_state = "grille"
	base_icon_state = "grille"
	frill_icon = null
	frill_uses_icon_state = FALSE