/mob/living/carbon/Move(atom/newloc, direct = 0)
	. = ..()
	if(.)
		for(var/thing in all_injuries)
			var/datum/injury/injury = thing
			injury.movement_infect(src)
		for(var/thing in getorganslotlist(ORGAN_SLOT_BONE))
			var/obj/item/organ/bone/bone = thing
			if(bone.movement_jostle(src))
				break
		// Floating is easy
		if(!(movement_type & FLOATING))
			var/is_sprinting = (combat_flags & COMBAT_FLAG_SPRINTING)
			var/germ_level_increase = GERM_LEVEL_MOVEMENT_INCREASE
			var/hint_probability = 0
			//sprinting makes you sweaty faster
			if(is_sprinting)
				germ_level_increase *= 2
				hint_probability = 30
			if(prob(hint_probability))
				sound_hint()
			adjust_germ_level(germ_level_increase)
			if(!pulledby)
				if(is_sprinting)
					sprint_loss_tiles(1)
				if(HAS_TRAIT(src, TRAIT_NOHUNGER))
					set_nutrition(NUTRITION_LEVEL_FED - 1) //just less than feeling vigorous
				else if(nutrition && stat != DEAD)
					adjust_nutrition(-(total_nutriment_req/10))
					if(combat_flags & COMBAT_FLAG_SPRINTING)
						adjust_nutrition(-(total_nutriment_req/10))
				if(HAS_TRAIT(src, TRAIT_NOTHIRST))
					set_hydration(HYDRATION_LEVEL_HYDRATED - 1)
				else if(hydration && stat != DEAD)
					adjust_hydration(-(total_hydration_req/10))
					if(combat_flags & COMBAT_FLAG_SPRINTING)
						adjust_hydration(-(total_hydration_req/10))
				switch(encumbrance)
					if(ENCUMBRANCE_EXTREME)
						adjustFatigueLoss(5)
					if(ENCUMBRANCE_HEAVY)
						adjustFatigueLoss(1)

/mob/living/carbon/update_move_intent_slowdown()
	. = ..()
	update_basic_speed_modifier()

/mob/living/carbon/set_usable_legs(new_value)
	. = ..()
	if(isnull(.))
		return

	if(. < 3 && usable_legs >= 3)
		REMOVE_TRAIT(src, TRAIT_FLOORED, LACKING_LOCOMOTION_APPENDAGES_TRAIT)
		REMOVE_TRAIT(src, TRAIT_IMMOBILIZED, LACKING_LOCOMOTION_APPENDAGES_TRAIT)
	else if(usable_legs < 3 && !(movement_type & (FLYING | FLOATING))) //From having enough usable legs to no longer having them
		ADD_TRAIT(src, TRAIT_FLOORED, LACKING_LOCOMOTION_APPENDAGES_TRAIT)
		if(!usable_hands)
			ADD_TRAIT(src, TRAIT_IMMOBILIZED, LACKING_LOCOMOTION_APPENDAGES_TRAIT)

	if(usable_legs < default_num_legs)
		ADD_TRAIT(src, TRAIT_SPRINT_LOCKED, LACKING_LOCOMOTION_APPENDAGES_TRAIT)
	else
		REMOVE_TRAIT(src, TRAIT_SPRINT_LOCKED, LACKING_LOCOMOTION_APPENDAGES_TRAIT)

	if(!(status_flags & BUILDING_ORGANS))
		update_basic_speed_modifier()

/mob/living/carbon/on_lying_down(new_lying_angle)
	. = ..()
	movement_locked = TRUE
	ADD_TRAIT(src, TRAIT_SPRINT_LOCKED, LYING_DOWN_TRAIT)

/mob/living/carbon/on_standing_up()
	. = ..()
	movement_locked = FALSE
	REMOVE_TRAIT(src, TRAIT_SPRINT_LOCKED, LYING_DOWN_TRAIT)

/mob/living/carbon/Bump(atom/A)
	. = ..()
	if(((combat_flags & COMBAT_FLAG_SPRINTING) || HAS_TRAIT(src, TRAIT_STUMBLE)) && !A.CanPass(src, get_dir(A, src)))
		A.on_rammed(src)

/mob/living/carbon/proc/ram_stun()
	//Deal with knockdown
	switch(diceroll(GET_MOB_ATTRIBUTE_VALUE(src, STAT_DEXTERITY), context = DICE_CONTEXT_PHYSICAL))
		if(DICE_CRIT_SUCCESS)
			Immobilize(1 SECONDS)
		if(DICE_SUCCESS)
			Immobilize(2 SECONDS)
		if(DICE_FAILURE)
			Immobilize(2 SECONDS)
			CombatKnockdown(rand(50, 75))
		if(DICE_CRIT_FAILURE)
			drop_all_held_items()
			Immobilize(5 SECONDS)
			CombatKnockdown(rand(75, 100))
	//Deal with damage
	switch(diceroll(GET_MOB_ATTRIBUTE_VALUE(src, STAT_ENDURANCE), context = DICE_CONTEXT_PHYSICAL))
		if(DICE_SUCCESS)
			var/obj/item/bodypart/head = get_bodypart(BODY_ZONE_HEAD)
			if(head)
				head.receive_damage((ATTRIBUTE_MASTER - GET_MOB_ATTRIBUTE_VALUE(src, STAT_ENDURANCE))/2)
			else
				take_bodypart_damage((ATTRIBUTE_MASTER - GET_MOB_ATTRIBUTE_VALUE(src, STAT_ENDURANCE))/2)
		if(DICE_FAILURE)
			var/obj/item/bodypart/head = get_bodypart(BODY_ZONE_HEAD)
			if(head)
				head.receive_damage((ATTRIBUTE_MASTER - GET_MOB_ATTRIBUTE_VALUE(src, STAT_ENDURANCE)) * 2)
			else
				take_bodypart_damage((ATTRIBUTE_MASTER - GET_MOB_ATTRIBUTE_VALUE(src, STAT_ENDURANCE)) * 2)
		if(DICE_CRIT_FAILURE)
			var/obj/item/bodypart/head = get_bodypart(BODY_ZONE_HEAD)
			if(head)
				head.receive_damage((ATTRIBUTE_MASTER - GET_MOB_ATTRIBUTE_VALUE(src, STAT_ENDURANCE)) * 3)
			else
				take_bodypart_damage((ATTRIBUTE_MASTER - GET_MOB_ATTRIBUTE_VALUE(src, STAT_ENDURANCE)) * 3)
	SEND_SIGNAL(src, COMSIG_CARBON_CLEAR_WOUND_MESSAGE)

/mob/living/carbon/human/proc/go_somewhere(down = FALSE)
	if(incapacitated())
		return
	if(next_move > world.time)
		playsound_local(get_turf(src), 'modular_pod/sound/eff/difficult1.ogg', 15, FALSE)
		return
	if(down)
		var/turf/closed/waller = get_step_multiz(src, DOWN)
		if(istype(waller))
			to_chat(src, span_warning("I can't move down."))
			return
		var/turf/open/floore = get_step_multiz(src, DOWN)
		var/turf/open/floord = get_turf(src)
		if(!floore.liquids || (floore.liquids.liquid_state <= LIQUID_STATE_FULLTILE))
			return
		if(!floord.liquids || (floord.liquids.liquid_state < LIQUID_STATE_PUDDLE))
			return
		var/encumbrance_penalty = 0
		switch(encumbrance)
			if(ENCUMBRANCE_LIGHT)
				encumbrance_penalty = 2
			if(ENCUMBRANCE_MEDIUM)
				encumbrance_penalty = 5
			if(ENCUMBRANCE_HEAVY)
				encumbrance_penalty = 10
			if(ENCUMBRANCE_EXTREME)
				encumbrance_penalty = 15
		var/diceroll = diceroll(GET_MOB_SKILL_VALUE(src, SKILL_SWIMMING), context = DICE_CONTEXT_MENTAL)
			switch(diceroll)
				if(DICE_CRIT_SUCCESS)
					src.adjustFatigueLoss(5 + encumbrance_penalty)
					to_chat(src, span_notice("I move down perfectly."))
					floore.forceMove(src)
				if(DICE_SUCCESS)
					src.adjustFatigueLoss(10 + encumbrance_penalty)
					to_chat(src, span_notice("I move down succesfully."))
					floore.forceMove(src)
				if(DICE_FAILURE)
					src.adjustFatigueLoss(10 + encumbrance_penalty)
					to_chat(src, span_notice("I failed at moving down."))
				if(DICE_CRIT_FAILURE)
					src.adjustFatigueLoss(15 + encumbrance_penalty)
					to_chat(src, span_notice("I horribly failed at moving down."))
	else
		var/turf/closed/waller = get_step_multiz(src, UP)
		if(istype(waller))
			to_chat(src, span_warning("I can't move up."))
			return
		var/turf/open/floore = get_step_multiz(src, UP)
		var/turf/open/floord = get_turf(src)
		if(!floore.liquids || (floore.liquids.liquid_state < LIQUID_STATE_PUDDLE))
			return
		if(!floord.liquids || (floord.liquids.liquid_state <= LIQUID_STATE_FULLTILE))
			return
		var/encumbrance_penalty = 0
		switch(encumbrance)
			if(ENCUMBRANCE_LIGHT)
				encumbrance_penalty = 2
			if(ENCUMBRANCE_MEDIUM)
				encumbrance_penalty = 5
			if(ENCUMBRANCE_HEAVY)
				encumbrance_penalty = 10
			if(ENCUMBRANCE_EXTREME)
				encumbrance_penalty = 15
		var/diceroll = diceroll(GET_MOB_SKILL_VALUE(src, SKILL_SWIMMING), context = DICE_CONTEXT_MENTAL)
			switch(diceroll)
				if(DICE_CRIT_SUCCESS)
					src.adjustFatigueLoss(5 + encumbrance_penalty)
					to_chat(src, span_notice("I move up perfectly."))
					floore.forceMove(src)
				if(DICE_SUCCESS)
					src.adjustFatigueLoss(10 + encumbrance_penalty)
					to_chat(src, span_notice("I move up succesfully."))
					floore.forceMove(src)
				if(DICE_FAILURE)
					src.adjustFatigueLoss(10 + encumbrance_penalty)
					to_chat(src, span_notice("I failed at moving up."))
				if(DICE_CRIT_FAILURE)
					src.adjustFatigueLoss(15 + encumbrance_penalty)
					to_chat(src, span_notice("I horribly failed at moving up."))