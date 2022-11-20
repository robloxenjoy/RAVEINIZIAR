/mob/living/carbon/update_fatigue()
	. = ..()
	var/fatigueloss = getFatigueLoss()
	if(fatigueloss >= SPRINT_MAX_FATIGUELOSS)
		ADD_TRAIT(src, TRAIT_SPRINT_LOCKED, FATIGUE)
	else
		REMOVE_TRAIT(src, TRAIT_SPRINT_LOCKED, FATIGUE)
	if(fatigueloss >= FATIGUE_HALVE_MOVE)
		ADD_TRAIT(src, TRAIT_BASIC_SPEED_HALVED, FATIGUE)
	else
		REMOVE_TRAIT(src, TRAIT_BASIC_SPEED_HALVED, FATIGUE)
	if(fatigueloss >= FATIGUE_CRIT_THRESHOLD)
		enter_fatiguecrit()
	else if(HAS_TRAIT_FROM(src, TRAIT_INCAPACITATED, FATIGUE))
		REMOVE_TRAIT(src, TRAIT_INCAPACITATED, FATIGUE)
		REMOVE_TRAIT(src, TRAIT_IMMOBILIZED, FATIGUE)
		REMOVE_TRAIT(src, TRAIT_FLOORED, FATIGUE)

/mob/living/carbon/handle_fatigue(delta_time, times_fired)
	//regenerate fatigue if possible
	if(!combat_mode && COOLDOWN_FINISHED(src, fatigue_regen_cooldown) && getFatigueLoss())
		adjustFatigueLoss(-FATIGUE_REGEN_FACTOR * (body_position == LYING_DOWN ? FATIGUE_REGEN_LYING_MULTIPLIER : 1) * delta_time)

/mob/living/carbon/proc/enter_fatiguecrit()
	if(!(status_flags & CANKNOCKDOWN) || HAS_TRAIT(src, TRAIT_STUNIMMUNE))
		return
	if(HAS_TRAIT_FROM(src, TRAIT_INCAPACITATED, FATIGUE)) //Already in fatiguecrit
		return
	if(absorb_stun(0)) //continuous effect, so we don't want it to increment the stuns absorbed.
		return
	ADD_TRAIT(src, TRAIT_INCAPACITATED, FATIGUE)
	ADD_TRAIT(src, TRAIT_IMMOBILIZED, FATIGUE)
	ADD_TRAIT(src, TRAIT_FLOORED, FATIGUE)
	setFatigueLoss(FATIGUE_CRIT_THRESHOLD + 20, FALSE)
	fatigue_grunt()
	//rip
	if(diceroll(GET_MOB_ATTRIBUTE_VALUE(src, STAT_ENDURANCE), context = DICE_CONTEXT_MENTAL) <= DICE_CRIT_FAILURE)
		set_heartattack(TRUE)

/mob/living/carbon/proc/update_endurance_fatigue_modifier()
	var/fatigue_modification = (GET_MOB_ATTRIBUTE_VALUE(src, STAT_ENDURANCE)-ATTRIBUTE_MIDDLING)*10
	var/desc = span_info("Endurance.")
	if(fatigue_modification > 0)
		desc = span_green("Good endurance.")
	else if(fatigue_modification < 0)
		desc = span_alert("Poor endurance.")
	add_or_update_variable_fatigue_modifier(/datum/fatigue_modifier/endurance, TRUE, fatigue_modification, desc)
