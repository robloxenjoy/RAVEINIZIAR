/mob/living/carbon/proc/update_shock_penalty(incoming = 0, duration = SHOCK_PENALTY_COOLDOWN_DURATION)
	//use remove_shock_penalty() you idiot
	if(!incoming || !duration)
		return
	if(shock_penalty_timer)
		deltimer(shock_penalty_timer)
		shock_penalty_timer = null
	//pick the bigger value between what we already are suffering and the incoming modification
	shock_penalty = max(incoming, shock_penalty)
	attributes?.add_or_update_variable_attribute_modifier(/datum/attribute_modifier/shock_penalty, TRUE, list(STAT_DEXTERITY = -shock_penalty, STAT_INTELLIGENCE = -shock_penalty))
	shock_penalty_timer = addtimer(CALLBACK(src, .proc/remove_shock_penalty), duration, TIMER_STOPPABLE)

/mob/living/carbon/proc/remove_shock_penalty()
	attributes?.remove_attribute_modifier(/datum/attribute_modifier/shock_penalty)
	shock_penalty = 0
	shock_penalty_timer = null

/mob/living/carbon/proc/major_wound_effects(incoming_pain = 0, body_zone = BODY_ZONE_CHEST, wound_messages = TRUE)
	//Try not to stack too much
	if((world.time - last_major_wound) <= 1 SECONDS)
		return
	var/attribute_modifier = GET_MOB_ATTRIBUTE_VALUE(src, STAT_ENDURANCE)
	var/modifier = 0
	switch(body_zone)
		if(BODY_ZONE_PRECISE_NECK, BODY_ZONE_HEAD, BODY_ZONE_PRECISE_R_EYE, BODY_ZONE_PRECISE_L_EYE)
			modifier -= 10
		if(BODY_ZONE_PRECISE_FACE, BODY_ZONE_PRECISE_VITALS)
			modifier -= 5
	var/list/diceroll = diceroll(attribute_modifier+modifier, context = DICE_CONTEXT_MENTAL, return_flags = RETURN_DICE_BOTH)
	//Got out scott free!
	if(LAZYACCESS(diceroll, RETURN_DICE_INDEX_SUCCESS) == DICE_CRIT_SUCCESS)
		return
	//Oof!
	if(wound_messages)
		SEND_SIGNAL(src, COMSIG_CARBON_ADD_TO_WOUND_MESSAGE, span_danger(" Серьёзное ранение!"))
//	var/vomiting = FALSE
	switch(body_zone)
		if(BODY_ZONE_HEAD, BODY_ZONE_PRECISE_FACE, BODY_ZONE_PRECISE_MOUTH, BODY_ZONE_PRECISE_R_EYE, BODY_ZONE_PRECISE_L_EYE)
			if(prob(50))
				drop_all_held_items()
				HeadRape(8 SECONDS)
				flash_pain_major()
				//rev deconversion through trauma
				var/datum/antagonist/rev/rev = mind?.has_antag_datum(/datum/antagonist/rev)
				if(rev && prob(incoming_pain * 3))
					rev.remove_revolutionary(FALSE)
				if(wound_messages)
					SEND_SIGNAL(src, COMSIG_CARBON_ADD_TO_WOUND_MESSAGE, span_danger(" [src] дезориентирован!"))
			else
				if(stat >= UNCONSCIOUS)
					drop_all_held_items()
					HeadRape(8 SECONDS)
					flash_pain_major()
					//rev deconversion through trauma
					var/datum/antagonist/rev/rev = mind?.has_antag_datum(/datum/antagonist/rev)
					if(rev && prob(incoming_pain * 3))
						rev.remove_revolutionary(FALSE)
					if(wound_messages)
						SEND_SIGNAL(src, COMSIG_CARBON_ADD_TO_WOUND_MESSAGE, span_danger(" [src] дезориентирован!"))
				else
					drop_all_held_items()
					flash_screen_flash()
					var/dicerolli = diceroll(GET_MOB_ATTRIBUTE_VALUE(src, STAT_LUCK), context = DICE_CONTEXT_MENTAL)
					if(dicerolli >= DICE_SUCCESS)
						Unconscious(10 SECONDS)
					if(dicerolli <= DICE_FAILURE)
						Unconscious(15 SECONDS)
					//rev deconversion through trauma
					var/datum/antagonist/rev/rev = mind?.has_antag_datum(/datum/antagonist/rev)
					if(rev && prob(incoming_pain * 3))
						rev.remove_revolutionary(FALSE)
					if(wound_messages)
						SEND_SIGNAL(src, COMSIG_CARBON_ADD_TO_WOUND_MESSAGE, span_danger(" [src] теряет сознание!"))
		if(BODY_ZONE_PRECISE_NECK)
			flash_pain_major()
			adjustOxyLoss((rand(30, 45)) - GET_MOB_ATTRIBUTE_VALUE(src, STAT_ENDURANCE))
			if(wound_messages)
				SEND_SIGNAL(src, COMSIG_CARBON_ADD_TO_WOUND_MESSAGE, span_danger(" [src] [p_are()] деоксигенирован!"))
		if(BODY_ZONE_PRECISE_R_HAND, BODY_ZONE_R_ARM)
			var/obj/item/held_item = get_item_for_held_index(RIGHT_HANDS)
			if(held_item)
				//if it's an offhand, drop the main item
				if(istype(held_item, /obj/item/offhand))
					held_item = get_item_for_held_index(LEFT_HANDS)
				dropItemToGround(held_item)
				flash_pain_major()
				if(wound_messages)
					SEND_SIGNAL(src, COMSIG_CARBON_ADD_TO_WOUND_MESSAGE, span_danger(" [src] спазмирован!"))
		if(BODY_ZONE_PRECISE_L_HAND, BODY_ZONE_L_ARM)
			var/obj/item/held_item = get_item_for_held_index(LEFT_HANDS)
			if(held_item)
				//if it's an offhand, drop the main item
				if(istype(held_item, /obj/item/offhand))
					held_item = get_item_for_held_index(RIGHT_HANDS)
				dropItemToGround(held_item)
				flash_pain_major()
				if(wound_messages)
					SEND_SIGNAL(src, COMSIG_CARBON_ADD_TO_WOUND_MESSAGE, span_danger(" [src] спазмирован!"))
		if(BODY_ZONE_PRECISE_VITALS)
//			vomiting = prob(80)
			emote("fart")
			shit(FALSE)
			Stun(1 SECONDS)
			flash_pain_major()
			if(wound_messages)
				SEND_SIGNAL(src, COMSIG_CARBON_ADD_TO_WOUND_MESSAGE, span_danger(" [src] тошнит!"))
		if(BODY_ZONE_CHEST, BODY_ZONE_PRECISE_GROIN)
			flash_pain_major()
			Daze(3 SECONDS)
//			blur_eyes(3)
			if(wound_messages)
				SEND_SIGNAL(src, COMSIG_CARBON_ADD_TO_WOUND_MESSAGE, span_danger(" [src] импульсирован!"))
/*
		if(BODY_ZONE_PRECISE_GROIN)
			if(getorganslotefficiency(ORGAN_SLOT_TESTICLES) > ORGAN_FAILING_EFFICIENCY)
				flash_pain_major()
				Stumble(10 SECONDS)
				if(wound_messages)
					SEND_SIGNAL(src, COMSIG_CARBON_ADD_TO_WOUND_MESSAGE, span_danger(" [src] !"))
*/
/*
	if(LAZYACCESS(diceroll, RETURN_DICE_INDEX_SUCCESS) == DICE_SUCCESS)
		KnockToFloor(5 SECONDS)
	if(LAZYACCESS(diceroll, RETURN_DICE_INDEX_SUCCESS) <= DICE_SUCCESS)
		KnockToFloor(7 SECONDS)
*/
	//OW!
	if(LAZYACCESS(diceroll, RETURN_DICE_INDEX_DIFFERENCE) <= -5)
		//vomit with blood
//		if(vomiting && (stat < DEAD))
//			vomit(10, TRUE, FALSE)
		Unconscious(4 SECONDS)
//		if(wound_messages)
//			if((body_zone == BODY_ZONE_PRECISE_VITALS) && prob(10))
//				//gut status: busted
//				playsound(src, 'modular_septic/sound/effects/gutbusted.ogg', 100, 0)
//				SEND_SIGNAL(src, COMSIG_CARBON_ADD_TO_WOUND_MESSAGE, span_bolddanger(" [span_big("<u>Разгруз кишок</u>!")]"))
//			else
//				SEND_SIGNAL(src, COMSIG_CARBON_ADD_TO_WOUND_MESSAGE, span_bolddanger(" [span_big("<u>Нокаутирован</u>!")]"))
//	else if(vomiting)
//		//vomit without blood
//		vomit(10, FALSE, FALSE)
	last_major_wound = world.time
