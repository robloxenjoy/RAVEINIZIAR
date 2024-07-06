/mob/living/carbon/human/UnarmedAttack(atom/attack_target, proximity_flag, list/modifiers, hit_zone)
	if(LAZYACCESS(modifiers, MIDDLE_CLICK))
		switch(special_attack)
			if(SPECIAL_ATK_KICK)
				unarmed_foot(attack_target, proximity_flag, modifiers)
			if(SPECIAL_ATK_JUMP)
				attempt_jump(attack_target, proximity_flag, modifiers)
			if(SPECIAL_ATK_BITE)
				unarmed_jaw(attack_target, proximity_flag, modifiers)
			if(SPECIAL_ATK_STEAL)
//				var/mob/living/carbon/target = attack_target
				steal_this(attack_target, proximity_flag, modifiers, hit_zone)
			if(SPECIAL_ATK_NONE)
				if(HAS_TRAIT(src, TRAIT_HANDS_BLOCKED))
					if(src == attack_target)
						check_self_for_injuries()
					return
				unarmed_hand(attack_target, proximity_flag, modifiers)
	else
		if(HAS_TRAIT(src, TRAIT_HANDS_BLOCKED))
			if(src == attack_target)
				check_self_for_injuries()
			return
		unarmed_hand(attack_target, proximity_flag, modifiers)

/mob/living/carbon/human/unarmed_hand(atom/attack_target, proximity_flag, list/modifiers)
	var/obj/item/bodypart/check_hand = get_active_hand()
	if(!check_hand)
		to_chat(src, span_notice("Фантомно."))
		return
	else if(check_hand?.bodypart_disabled)
		to_chat(src, span_warning("[check_hand.name] не в состоянии."))
		return
	else if(proximity_flag)
		for(var/thing in check_hand.getorganslot(ORGAN_SLOT_BONE))
			var/obj/item/organ/bone/bone = thing
			if(bone.attack_with_hurt_hand(src, check_hand, attack_target) & COMPONENT_CANCEL_ATTACK_CHAIN)
				return

	// Special glove functions:
	// If the gloves do anything, have them return 1 to stop
	// normal attack_hand() here.
	var/obj/item/clothing/gloves/our_gloves = gloves // not typecast specifically enough in defines
	if(proximity_flag && istype(our_gloves) && our_gloves.Touch(attack_target, proximity_flag, modifiers))
		return

	//This signal is needed to prevent gloves of the north star + hulk.
	if(SEND_SIGNAL(src, COMSIG_HUMAN_EARLY_UNARMED_ATTACK, attack_target, proximity_flag, modifiers) & COMPONENT_CANCEL_ATTACK_CHAIN)
		return
	SEND_SIGNAL(src, COMSIG_HUMAN_MELEE_UNARMED_ATTACK, attack_target, proximity_flag, modifiers)
	//Because species like monkeys dont use attack hand
	if(dna?.species?.spec_unarmedattack(src, attack_target, modifiers))
		return

	if(!right_click_attack_chain(attack_target, modifiers) && !tertiary_click_attack_chain(attack_target, modifiers))
		attack_target.attack_hand(src, modifiers)

/mob/living/carbon/human/unarmed_foot(atom/attack_target, proximity_flag, list/modifiers)
	var/obj/item/bodypart/check_foot = get_active_foot()
	if(!check_foot)
		to_chat(src, span_notice("Фантомно."))
		return
	else if(check_foot?.bodypart_disabled)
		to_chat(src, span_warning("[check_foot.name] не в состоянии."))
		return
	else if(attack_target == src)
		to_chat(src, span_warning("Не могу себя пнуть. Жаль."))
		return
	else if(proximity_flag)
		for(var/thing in check_foot.getorganslot(ORGAN_SLOT_BONE))
			var/obj/item/organ/bone/bone = thing
			if(bone.attack_with_hurt_foot(src, check_foot, attack_target) & COMPONENT_CANCEL_ATTACK_CHAIN)
				return

	//This signal is needed to prevent gloves of the north star + hulk
	if(SEND_SIGNAL(src, COMSIG_HUMAN_EARLY_UNARMED_ATTACK, attack_target, proximity_flag, modifiers) & COMPONENT_CANCEL_ATTACK_CHAIN)
		return
	SEND_SIGNAL(src, COMSIG_HUMAN_MELEE_UNARMED_ATTACK, attack_target, proximity_flag, modifiers)
	//Because species like monkeys dont use attack hand
	if(dna?.species?.spec_unarmedattack(src, attack_target, modifiers))
		return

	attack_target.attack_foot(src, modifiers)

/mob/living/carbon/human/unarmed_jaw(atom/attack_target, proximity_flag, list/modifiers)
	var/obj/item/bodypart/check_jaw = get_bodypart(BODY_ZONE_PRECISE_MOUTH)
	if(!check_jaw)
		to_chat(src, span_notice("Фантомно."))
		return
	else if(check_jaw?.bodypart_disabled)
		to_chat(src, span_warning("[check_jaw.name] не в состоянии."))
		return
	else if(proximity_flag)
		for(var/thing in check_jaw.getorganslot(ORGAN_SLOT_BONE))
			var/obj/item/organ/bone/bone = thing
			if(bone.attack_with_hurt_jaw(src, check_jaw, attack_target) & COMPONENT_CANCEL_ATTACK_CHAIN)
				return

	if(is_mouth_covered())
		to_chat(src, span_warning("Рот прикрыт."))
		return

	//This signal is needed to prevent gloves of the north star + hulk
	if(SEND_SIGNAL(src, COMSIG_HUMAN_EARLY_UNARMED_ATTACK, attack_target, proximity_flag, modifiers) & COMPONENT_CANCEL_ATTACK_CHAIN)
		return
	SEND_SIGNAL(src, COMSIG_HUMAN_MELEE_UNARMED_ATTACK, attack_target, proximity_flag, modifiers)
	//Because species like monkeys dont use attack hand
	if(dna?.species?.spec_unarmedattack(src, attack_target, modifiers))
		return

	attack_target.attack_jaw(src, modifiers)
