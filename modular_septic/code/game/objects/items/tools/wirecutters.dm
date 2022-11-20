/obj/item/wirecutters
	icon = 'modular_septic/icons/obj/items/tools.dmi'
	icon_state = "cutter"
	inhand_icon_state = "cutter"
	righthand_file = 'modular_septic/icons/obj/items/inhands/items_and_weapons_righthand.dmi'
	lefthand_file = 'modular_septic/icons/obj/items/inhands/items_and_weapons_lefthand.dmi'
	carry_weight = 500 GRAMS
	greyscale_config = null

/obj/item/wirecutters/attack(mob/living/carbon/attacked, mob/user, params)
	if(!istype(attacked))
		return
	var/mob/living/loser = user
	if(!istype(loser))
		return

	var/list/modifiers = params2list(params)
	if(IS_DISARM_INTENT(loser, modifiers))
		switch(loser.zone_selected)
			if(BODY_ZONE_PRECISE_L_HAND, BODY_ZONE_PRECISE_R_HAND)
				if(attacked.handcuffed)
					loser.visible_message(span_notice("<b>[loser]</b> attempts to cut the [attacked.handcuffed] from around <b>[attacked]</b>'s wrists."))
					if(do_mob(loser, attacked, 4 SECONDS))
						loser.visible_message(span_notice("<b>[loser]</b> cuts <b>[attacked]</b>'s restraints with [src]!"), \
											span_notice("I cut <b>[attacked]</b>'s restraints."))
						qdel(attacked.handcuffed)
					return
			if(BODY_ZONE_PRECISE_NECK)
				if(attacked.has_status_effect(STATUS_EFFECT_CHOKINGSTRAND))
					loser.visible_message(span_notice("<b>[loser]</b> attempts to cut the durathread strand from around <b>[attacked]</b>'s neck."), \
										span_notice("I cut <b>[attacked]</b>'s choking strand."))
					if(do_mob(loser, attacked, 2 SECONDS))
						loser.visible_message(span_notice("<b>[loser]</b> succesfully cuts the durathread strand from around <b>[attacked]</b>'s neck."))
						attacked.remove_status_effect(STATUS_EFFECT_CHOKINGSTRAND)
						playsound(loc, usesound, 50, TRUE, -1)
					return
	else if(IS_GRAB_INTENT(loser, modifiers))
		switch(loser.zone_selected)
			if(BODY_ZONE_PRECISE_MOUTH)
				var/obj/item/bodypart/mouth/jaw = attacked.get_bodypart(BODY_ZONE_PRECISE_MOUTH)
				if(!jaw)
					to_chat(loser, span_danger("[attacked.p_they(TRUE)] have no mouth and they must scream!"))
					return
				if(!jaw.teeth_object?.amount)
					to_chat(loser, span_danger("[attacked.p_they(TRUE)] don't have any teeth left!"))
					return
				attacked.visible_message(span_warning("<b>[loser]</b> shoves [src] into <b>[attacked]</b>'s mouth!"), \
								span_userdanger("<b>[loser]</b> is trying to rip my teeth off!!"), \
								vision_distance = COMBAT_MESSAGE_RANGE, \
								ignored_mobs = loser)
				to_chat(loser, span_danger("I start ripping <b>[attacked]</b>'s tooth off!"))
				if(do_mob(loser, attacked, 3 SECONDS))
					attacked.visible_message(span_danger("<b>[loser]</b> rips a tooth out of <b>[attacked]</b>'s mouth!"), \
									span_userdanger("FUCK!!!"), \
									vision_distance = COMBAT_MESSAGE_RANGE, \
									ignored_mobs = loser)
					to_chat(loser, span_danger("I rip <b>[attacked]</b>'s tooth off!"))
					jaw.knock_out_teeth(1, pick(GLOB.alldirs))
					attacked.agony_scream()
					jaw.add_pain(25)
				return
	return ..()
