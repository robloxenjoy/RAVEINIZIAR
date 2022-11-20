/mob/living/carbon/human/check_shields(atom/attacker, \
									damage = 0, \
									attack_text = "the attack", \
									user_attack_text = "my attack", \
									attacking_flags = BLOCK_FLAG_MELEE)
	/// Can only block while conscious, can only block in combat mode, can't block more than once every second, can only block in parry mode
	if((stat >= UNCONSCIOUS) || !combat_mode || !COOLDOWN_FINISHED(src, blocking_cooldown) || (dodge_parry != DP_PARRY))
		return COMPONENT_HIT_REACTION_CANCEL
	for(var/obj/item/held_item in held_items)
		//Blocking with clothing would be bad
		if(isclothing(held_item))
			continue
		var/signal_return = held_item.item_block(src, attacker, attack_text, user_attack_text, damage, attacking_flags)
		if(signal_return & COMPONENT_HIT_REACTION_CANCEL)
			return signal_return
	if(head)
		var/signal_return = head.item_block(src, attacker, attack_text, user_attack_text, damage, attacking_flags)
		if(signal_return & COMPONENT_HIT_REACTION_CANCEL)
			return signal_return
	if(wear_neck)
		var/signal_return = wear_neck.item_block(src, attacker, attack_text, user_attack_text, damage, attacking_flags)
		if(signal_return & COMPONENT_HIT_REACTION_CANCEL)
			return signal_return
	if(wear_suit)
		var/signal_return = wear_suit.item_block(src, attacker, attack_text, user_attack_text, damage, attacking_flags)
		if(signal_return & COMPONENT_HIT_REACTION_CANCEL)
			return signal_return
	if(w_uniform)
		var/signal_return = w_uniform.item_block(src, attacker, attack_text, user_attack_text, damage, attacking_flags)
		if(signal_return & COMPONENT_HIT_REACTION_CANCEL)
			return signal_return
	return FALSE

//blocking cooldown helper
/mob/living/carbon/human/proc/update_blocking_cooldown(duration = BLOCKING_COOLDOWN_DURATION)
	COOLDOWN_START(src, blocking_cooldown, duration)

//blocking can only be done once every BLOCKING_COOLDOWN_DURATION, but it can be penalized by feints
/mob/living/carbon/human/proc/update_blocking_penalty(incoming = 0, duration = BLOCKING_PENALTY_COOLDOWN_DURATION)
	//use remove_blocking_penalty() you idiot
	if(!incoming || !duration)
		return
	if(blocking_penalty_timer)
		deltimer(blocking_penalty_timer)
		blocking_penalty_timer = null
	//add incoming modification
	blocking_penalty += incoming
	blocking_penalty_timer = addtimer(CALLBACK(src, .proc/remove_blocking_penalty), duration, TIMER_STOPPABLE)

/mob/living/carbon/human/proc/remove_blocking_penalty()
	blocking_penalty = 0
	if(blocking_penalty_timer)
		deltimer(blocking_penalty_timer)
	blocking_penalty_timer = null

//blocking score helper
/mob/living/carbon/human/proc/get_blocking_score(skill_used = SKILL_SHIELD, modifier = 0)
	var/stun_penalty = 0
	if(incapacitated())
		stun_penalty = 4
	if(combat_mode && (combat_style == CS_DEFEND))
		modifier += 2
	return FLOOR(max(0, 3 + GET_MOB_SKILL_VALUE(src, skill_used)/2 + modifier - stun_penalty - blocking_penalty), 1)
