//main proc for parrying
/mob/living/carbon/human/proc/check_parry(atom/attacker, \
									damage = 0, \
									attack_text = "attack", \
									user_attack_text = "my attack", \
									attacking_flags = BLOCK_FLAG_MELEE)
	/// Can only parry while conscious, can only parry in combat mode, can only parry in parry mode
	if((stat >= UNCONSCIOUS) || !combat_mode || (dodge_parry != DP_PARRY))
		return COMPONENT_HIT_REACTION_CANCEL
	for(var/obj/item/held_item in held_items)
		var/signal_return = held_item.item_parry(src, attacker, attack_text, user_attack_text, damage, attacking_flags)
		if(signal_return & COMPONENT_HIT_REACTION_CANCEL)
			return signal_return
	if(head)
		var/signal_return = head.item_parry(src, attacker, attack_text, user_attack_text, damage, attacking_flags)
		if(signal_return & COMPONENT_HIT_REACTION_CANCEL)
			return signal_return
	if(wear_neck)
		var/signal_return = wear_neck.item_parry(src, attacker, attack_text, user_attack_text, damage, attacking_flags)
		if(signal_return & COMPONENT_HIT_REACTION_CANCEL)
			return signal_return
	if(wear_suit)
		var/signal_return = wear_suit.item_parry(src, attacker, attack_text, user_attack_text, damage, attacking_flags)
		if(signal_return & COMPONENT_HIT_REACTION_CANCEL)
			return signal_return
	if(w_uniform)
		var/signal_return = w_uniform.item_parry(src, attacker, attack_text, user_attack_text, damage, attacking_flags)
		if(signal_return & COMPONENT_HIT_REACTION_CANCEL)
			return signal_return
	return FALSE

//parrying can be done more than once every PARRYING_PENALTY_COOLDOWN_DURATION, but with penalties
/mob/living/carbon/human/proc/update_parrying_penalty(incoming = PARRYING_PENALTY, duration = PARRYING_PENALTY_COOLDOWN_DURATION)
	//use remove_parrying_penalty() you idiot
	if(!incoming || !duration)
		return
	if(parrying_penalty_timer)
		deltimer(parrying_penalty_timer)
		parrying_penalty_timer = null
	//add incoming modification
	parrying_penalty += incoming
	parrying_penalty_timer = addtimer(CALLBACK(src, PROC_REF(remove_parrying_penalty)), duration, TIMER_STOPPABLE)

/mob/living/carbon/human/proc/remove_parrying_penalty()
	parrying_penalty = 0
	if(parrying_penalty_timer)
		deltimer(parrying_penalty_timer)
	parrying_penalty_timer = null

//parrying score helper
/mob/living/carbon/human/proc/get_parrying_score(skill_used = SKILL_IMPACT_WEAPON, modifier = 0)
	var/stun_penalty = 0
	if(incapacitated())
		stun_penalty = 4
	if(combat_mode && (combat_style == CS_DEFEND))
		modifier += 2
	return FLOOR(max(0, 3 + GET_MOB_SKILL_VALUE(src, skill_used)/2 + modifier - stun_penalty - parrying_penalty), 1)

//main proc for dodging
/mob/living/carbon/human/proc/check_dodge(atom/attacker, \
									damage = 0, \
									attack_text = "attack", \
									user_attack_text = "my attack", \
									attacking_flags = BLOCK_FLAG_MELEE)
	/// Can only dodge while conscious, can only dodge in combat mode, can only dodge once every second, can only dodge in dodge mode
	if((stat >= UNCONSCIOUS) || !combat_mode || !COOLDOWN_FINISHED(src, dodging_cooldown) || (dodge_parry != DP_DODGE) || !CHECK_MULTIPLE_BITFIELDS(dodging_flags, attacking_flags))
		return COMPONENT_HIT_REACTION_CANCEL
	var/dodging_modifier = 0
	for(var/obj/item/held_item in held_items)
		dodging_modifier += held_item.dodging_modifier
	if(head)
		dodging_modifier += head.dodging_modifier
	if(wear_neck)
		dodging_modifier += wear_neck.dodging_modifier
	if(wear_suit)
		dodging_modifier += wear_suit.dodging_modifier
	if(w_uniform)
		dodging_modifier += w_uniform.dodging_modifier
	var/dodging_score = get_dodging_score(dodging_modifier)
	update_dodging_cooldown(DODGING_COOLDOWN_DURATION)
	// successful dodge attempt, if we manage to move to any adjacent time that is
	if(diceroll(dodging_score, context = DICE_CONTEXT_PHYSICAL) >= DICE_SUCCESS)
		for(var/direction in shuffle(GLOB.alldirs))
			var/turf/move_to = get_step(src, direction)
			if(istype(move_to) && Move(move_to, direction))
				visible_message(span_danger("<b>[src]</b> dodges [attack_text]!"), \
								span_userdanger("I dodge [attack_text]!"), \
								vision_distance = COMBAT_MESSAGE_RANGE, \
								ignored_mobs = attacker)
				to_chat(attacker, span_userdanger("<b>[src]</b> dodges [user_attack_text]!"))
				var/matrix/return_matrix = matrix(transform)
				var/matrix/dodge_matrix = matrix(transform)
				dodge_matrix = dodge_matrix.Turn(rand(-20, -30))
				animate(src, transform = dodge_matrix, time = 2, easing = ELASTIC_EASING)
				sleep(2)
				animate(src, transform = return_matrix, time = 2, easing = ELASTIC_EASING)
//				playsound(src, 'modular_pod/sound/eff/dodged.ogg', 70, TRUE)
				return COMPONENT_HIT_REACTION_CANCEL | COMPONENT_HIT_REACTION_BLOCK
	return COMPONENT_HIT_REACTION_CANCEL

//dodging cooldown helper
/mob/living/carbon/human/proc/update_dodging_cooldown(duration = DODGING_COOLDOWN_DURATION)
	COOLDOWN_START(src, dodging_cooldown, duration)

//dodging can only be done once every DODGING_PENALTY_COOLDOWN_DURATION, but it can be penalized by feints
/mob/living/carbon/human/proc/update_dodging_penalty(incoming = 0, duration = DODGING_PENALTY_COOLDOWN_DURATION)
	//use remove_dodging_penalty() you idiot
	if(!incoming || !duration)
		return
	if(dodging_penalty_timer)
		deltimer(dodging_penalty_timer)
		dodging_penalty_timer = null
	//add incoming modification
	dodging_penalty += incoming
	dodging_penalty_timer = addtimer(CALLBACK(src, PROC_REF(remove_dodging_penalty)), duration, TIMER_STOPPABLE)

/mob/living/carbon/human/proc/remove_dodging_penalty()
	dodging_penalty = 0
	if(dodging_penalty_timer)
		deltimer(dodging_penalty_timer)
	dodging_penalty_timer = null

//dodging score helper
/mob/living/carbon/human/proc/get_dodging_score(modifier = 0)
	var/basic_speed = GET_MOB_ATTRIBUTE_VALUE(src, STAT_DEXTERITY)/4
	var/encumbrance_penalty = 0
	switch(encumbrance)
		if(ENCUMBRANCE_LIGHT)
			encumbrance_penalty = 1
		if(ENCUMBRANCE_MEDIUM)
			encumbrance_penalty = 2
		if(ENCUMBRANCE_HEAVY)
			encumbrance_penalty = 3
		if(ENCUMBRANCE_EXTREME)
			encumbrance_penalty = 4
	var/stun_penalty = 0
	if(incapacitated())
		stun_penalty = 4
	if(combat_mode && (combat_style == CS_DEFEND))
		modifier += 2
	return FLOOR(max(0, 3 + basic_speed + modifier - encumbrance_penalty - stun_penalty - dodging_penalty), 1)
/*
//handblock score helper
/mob/living/carbon/human/proc/get_handblock_score(skill_used = SKILL_BRAWLING, modifier = 0)
	var/stun_penalty = 0
	if(incapacitated())
		stun_penalty = 4
	if(combat_mode && (combat_style == CS_DEFEND))
		modifier += 2
	return FLOOR(max(0, 3 + GET_MOB_SKILL_VALUE(src, skill_used)/2 + modifier - stun_penalty), 1)
*/
