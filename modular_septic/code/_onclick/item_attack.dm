/**
 * This is the proc that handles the order of an item_attack.
 *
 * The order of procs called is:
 * * [/atom/proc/tool_act] on the target. If it returns TOOL_ACT_TOOLTYPE_SUCCESS or TOOL_ACT_SIGNAL_BLOCKING, the chain will be stopped.
 * * [/obj/item/proc/pre_attack] on src. If this returns TRUE, the chain will be stopped.
 * * [/atom/proc/attackby] on the target. If it returns TRUE, the chain will be stopped.
 * * [/obj/item/proc/afterattack]. The return value does not matter.
 */
/obj/item/melee_attack_chain(mob/user, atom/target, params)
	var/list/modifiers = params2list(params)
	var/is_middle_clicking = LAZYACCESS(modifiers, MIDDLE_CLICK)
	var/is_right_clicking = LAZYACCESS(modifiers, RIGHT_CLICK)
	if(tool_behaviour && (target.tool_act(user, src, tool_behaviour, modifiers) & TOOL_ACT_MELEE_CHAIN_BLOCKING))
		return TRUE

	var/pre_attack_result
	if(is_middle_clicking)
		if(user.special_attack != SPECIAL_ATK_NONE)
			user.UnarmedAttack(target, TRUE, modifiers)
			return TRUE
		switch(pre_attack_tertiary(target, user, params))
			if(TERTIARY_ATTACK_CALL_NORMAL)
				pre_attack_result = pre_attack(target, user, params)
			if(TERTIARY_ATTACK_CANCEL_ATTACK_CHAIN)
				return TRUE
			if(TERTIARY_ATTACK_CONTINUE_CHAIN)
				// Normal behavior
			else
				CRASH("pre_attack_tertiary must return an TERTIARY_ATTACK_* define, please consult code/__DEFINES/zseptic_defines/combat.dm")
	else if(is_right_clicking)
		switch(pre_attack_secondary(target, user, params))
			if(SECONDARY_ATTACK_CALL_NORMAL)
				pre_attack_result = pre_attack(target, user, params)
			if(SECONDARY_ATTACK_CANCEL_ATTACK_CHAIN)
				return TRUE
			if(SECONDARY_ATTACK_CONTINUE_CHAIN)
				// Normal behavior
			else
				CRASH("pre_attack_secondary must return an SECONDARY_ATTACK_* define, please consult code/__DEFINES/combat.dm")
	else
		pre_attack_result = pre_attack(target, user, params)

	if(pre_attack_result)
		return TRUE

	var/attackby_result
	if(is_middle_clicking)
		switch(target.attackby_tertiary(src, user, params))
			if(TERTIARY_ATTACK_CALL_NORMAL)
				attackby_result = target.attackby(src, user, params)
			if(TERTIARY_ATTACK_CANCEL_ATTACK_CHAIN)
				return TRUE
			if(TERTIARY_ATTACK_CONTINUE_CHAIN)
				// Normal behavior
			else
				CRASH("attackby_tertiary must return an TERTIARY_ATTACK_* define, please consult code/__DEFINES/zseptic_defines/combat.dm")
	else if(is_right_clicking)
		switch(target.attackby_secondary(src, user, params))
			if(SECONDARY_ATTACK_CALL_NORMAL)
				attackby_result = target.attackby(src, user, params)
			if(SECONDARY_ATTACK_CANCEL_ATTACK_CHAIN)
				return TRUE
			if(SECONDARY_ATTACK_CONTINUE_CHAIN)
				// Normal behavior
			else
				CRASH("attackby_secondary must return an SECONDARY_ATTACK_* define, please consult code/__DEFINES/combat.dm")
	else
		attackby_result = target.attackby(src, user, params)

	if(attackby_result)
		return TRUE

	if(QDELETED(src) || QDELETED(target))
		attack_qdeleted(target, user, TRUE, params)
		return TRUE

	if(is_middle_clicking)
		var/after_attack_tertiary_result = afterattack_tertiary(target, user, TRUE, params)

		// There's no chain left to continue at this point, so CANCEL_ATTACK_CHAIN and CONTINUE_CHAIN are functionally the same.
		if((after_attack_tertiary_result == TERTIARY_ATTACK_CANCEL_ATTACK_CHAIN) || (after_attack_tertiary_result == TERTIARY_ATTACK_CONTINUE_CHAIN))
			return TRUE
	else if(is_right_clicking)
		var/after_attack_secondary_result = afterattack_secondary(target, user, TRUE, params)

		// There's no chain left to continue at this point, so CANCEL_ATTACK_CHAIN and CONTINUE_CHAIN are functionally the same.
		if((after_attack_secondary_result == SECONDARY_ATTACK_CANCEL_ATTACK_CHAIN) || (after_attack_secondary_result == SECONDARY_ATTACK_CONTINUE_CHAIN))
			return TRUE

	return afterattack(target, user, TRUE, params)

/// Called when the item is in the active hand, and clicked; alternately, there is an 'activate held object' verb or you can hit pagedown.

/obj/item/attack_self_secondary(mob/user, modifiers)
	if(SEND_SIGNAL(src, COMSIG_ITEM_ATTACK_SELF, user) & COMPONENT_CANCEL_ATTACK_CHAIN)
		return TRUE
	if(HAS_TRAIT_FROM(src, TRAIT_WEAPON_UNREADY, ATTACKING_TRAIT))
		ready_weapon(user)
		return TRUE
	interact(user)

/// Called when the item is in the active hand, and middle-clicked. Intended for alternate or opposite functions, such as lowering reagent transfer amount. At the moment, there is no verb or hotkey.
/obj/item/proc/attack_self_tertiary(mob/user, modifiers)
	if(SEND_SIGNAL(src, COMSIG_ITEM_ATTACK_SELF_TERTIARY, user) & COMPONENT_CANCEL_ATTACK_CHAIN)
		return TRUE

/**
 * Called on the item before it hits something, when middle clicking.
 *
 * Arguments:
 * * atom/target - The atom about to be hit
 * * mob/living/user - The mob doing the htting
 * * params - click params such as alt/shift etc
 *
 * See: [/obj/item/proc/melee_attack_chain]
 */
/obj/item/proc/pre_attack_tertiary(atom/target, mob/living/user, params)
	var/signal_result = SEND_SIGNAL(src, COMSIG_ITEM_PRE_ATTACK_TERTIARY, target, user, params)

	if(signal_result & COMPONENT_TERTIARY_CANCEL_ATTACK_CHAIN)
		return TERTIARY_ATTACK_CANCEL_ATTACK_CHAIN

	if(signal_result & COMPONENT_TERTIARY_CONTINUE_ATTACK_CHAIN)
		return TERTIARY_ATTACK_CONTINUE_CHAIN

	return TERTIARY_ATTACK_CONTINUE_CHAIN

/// Called from [/obj/item/proc/attack_atom] and [/obj/item/proc/attack] if the attack succeeds
/atom/attacked_by(obj/item/weapon, mob/living/user)
	if(!uses_integrity)
		CRASH("attacked_by() was called on an object that doesnt use integrity!")

	var/attack_delay = weapon.attack_delay
	var/attack_fatigue_cost = weapon.attack_fatigue_cost
	var/no_damage = TRUE
	if(take_damage(weapon.force, weapon.damtype, MELEE, 1))
		no_damage = FALSE
	//only witnesses close by and the victim see a hit message.
	log_combat(user, src, "attacked", weapon)
//	user.do_attack_animation(src, no_effect = TRUE)
	playsound(user, weapon.hitsound, weapon.get_clamped_volume(), TRUE, extrarange = weapon.stealthy_audio ? SILENCED_SOUND_EXTRARANGE : -1, falloff_distance = 0)
	user.visible_message(span_danger("<b>[user]</b> бьёт [src] с помощью [weapon][no_damage ? ", и это не оставляет царапины" : ""]!"), \
						span_danger("Я бью [src] с помощью [weapon][no_damage ? ", и это не оставляет царапины" : ""]!"), \
						vision_distance = COMBAT_MESSAGE_RANGE)
	if(attack_delay)
		user.changeNext_move(attack_delay)
	if(attack_fatigue_cost)
		user.adjustFatigueLoss(attack_fatigue_cost)
	weapon.damageItem("SOFT")
	sound_hint()

/**
 * Called on an object being middle-clicked on by an item
 *
 * Arguments:
 * * obj/item/weapon - The item hitting this atom
 * * mob/user - The wielder of this item
 * * params - click params such as alt/shift etc
 *
 * See: [/obj/item/proc/melee_attack_chain]
 */
/atom/proc/attackby_tertiary(obj/item/weapon, mob/user, params)
	var/signal_result = SEND_SIGNAL(src, COMSIG_PARENT_ATTACKBY_TERTIARY, weapon, user, params)

	if(signal_result & COMPONENT_TERTIARY_CANCEL_ATTACK_CHAIN)
		return TERTIARY_ATTACK_CANCEL_ATTACK_CHAIN

	if(signal_result & COMPONENT_TERTIARY_CONTINUE_ATTACK_CHAIN)
		return TERTIARY_ATTACK_CONTINUE_CHAIN

	return TERTIARY_ATTACK_CONTINUE_CHAIN

/mob/living/attackby(obj/item/weapon, mob/living/user, params)
	if(..())
		return TRUE
	return weapon.attack(src, user, params)

/mob/living/attackby_secondary(obj/item/weapon, mob/living/user, params)
	return weapon.attack_secondary(src, user, params)

/mob/living/attackby_tertiary(obj/item/weapon, mob/living/user, params)
	return weapon.attack_tertiary(src, user, params)

/obj/item/attack(mob/living/victim, mob/living/user, params)
	var/signal_return = SEND_SIGNAL(src, COMSIG_ITEM_ATTACK, victim, user, params)
	if(signal_return & COMPONENT_CANCEL_ATTACK_CHAIN)
		return TRUE
	if(signal_return & COMPONENT_SKIP_ATTACK)
		return

	var/mob_signal_return = SEND_SIGNAL(user, COMSIG_MOB_ITEM_ATTACK, victim, user, params)
	if(mob_signal_return & COMPONENT_CANCEL_ATTACK_CHAIN)
		return TRUE
	if(mob_signal_return & COMPONENT_SKIP_ATTACK)
		return

	if(item_flags & NOBLUDGEON)
		return

	if(force && HAS_TRAIT(user, TRAIT_PACIFISM))
		to_chat(user, span_danger("I don't want to harm other living beings!"))
		return

	if(HAS_TRAIT(src, TRAIT_WEAPON_UNREADY))
		to_chat(user, span_warning("Я готов - [src] нет!"))
		return

	var/user_strength = GET_MOB_ATTRIBUTE_VALUE(user, STAT_STRENGTH)
	var/wielded = SEND_SIGNAL(src, COMSIG_TWOHANDED_WIELD_CHECK)
	if(!wielded)
		if((readying_flags & READYING_FLAG_HARD_TWO_HANDED) && (user_strength < (minimum_strength * 3)))
			to_chat(user, span_warning("Я не могу использовать [src] одной рукой!"))
			return
		else if((readying_flags & READYING_FLAG_SOFT_TWO_HANDED) && (user_strength < (minimum_strength * 1.5)))
			to_chat(user, span_warning("Я не могу использовать [src] одной рукой!"))
			return

	if(!ishuman(victim))
		if(!force)
			playsound(loc, 'sound/weapons/tap.ogg', get_clamped_volume(), TRUE, extrarange = stealthy_audio ? SILENCED_SOUND_EXTRARANGE : -1, falloff_distance = 0)
		else if(hitsound)
			playsound(loc, hitsound, get_clamped_volume(), TRUE, extrarange = stealthy_audio ? SILENCED_SOUND_EXTRARANGE : -1, falloff_distance = 0)

	victim.lastattacker = user.real_name
	victim.lastattackerckey = user.ckey

	if(force && (victim == user))
		user.client?.give_award(/datum/award/achievement/misc/selfouch, user)

//	user.do_attack_animation(victim, no_effect = TRUE)

	var/list/modifiers = params2list(params)
	victim.attacked_by(src, user, modifiers)

	log_combat(user, victim, "attacked", src.name, "(COMBAT MODE: [uppertext(user.combat_mode)]) INTENT: [uppertext(user.a_intent)] (DAMTYPE: [uppertext(damtype)])")
	add_fingerprint(user)

	if(readying_flags & READYING_FLAG_HARD_TWO_HANDED)
		if(user_strength < CEILING(minimum_strength * 1.5, 1))
			unready_weapon(user)
			return
	if(!wielded && (readying_flags & READYING_FLAG_SOFT_TWO_HANDED))
		if(user_strength < CEILING(minimum_strength * 2, 1))
			unready_weapon(user)
			return
	if(readying_flags & READYING_FLAG_JUSTCAUSE)
		unready_weapon(user)
		return

/// The equivalent of [/obj/item/proc/attack] but for alternate attacks, AKA middle clicking
/obj/item/proc/attack_tertiary(mob/living/victim, mob/living/user, params)
	var/signal_result = SEND_SIGNAL(src, COMSIG_ITEM_ATTACK_TERTIARY, victim, user, params)

	if(signal_result & COMPONENT_TERTIARY_CANCEL_ATTACK_CHAIN)
		return TERTIARY_ATTACK_CANCEL_ATTACK_CHAIN

	if(signal_result & COMPONENT_TERTIARY_CONTINUE_ATTACK_CHAIN)
		return TERTIARY_ATTACK_CONTINUE_CHAIN

	return TERTIARY_ATTACK_CONTINUE_CHAIN

/obj/item/attack_atom(atom/attacked_atom, mob/living/user, params)
	var/signal_return = SEND_SIGNAL(src, COMSIG_ITEM_ATTACK_OBJ, attacked_atom, user, params)
	if(signal_return & COMPONENT_CANCEL_ATTACK_CHAIN)
		return TRUE
	if(signal_return & COMPONENT_SKIP_ATTACK)
		return

	var/mob_signal_return = SEND_SIGNAL(user, COMSIG_MOB_ITEM_ATTACK, attacked_atom, user, params)
	if(mob_signal_return & COMPONENT_CANCEL_ATTACK_CHAIN)
		return TRUE
	if(mob_signal_return & COMPONENT_SKIP_ATTACK)
		return

	if(item_flags & NOBLUDGEON)
		return

	if(HAS_TRAIT_FROM(src, TRAIT_WEAPON_UNREADY, ATTACKING_TRAIT))
		to_chat(user, span_danger("Я готов, [src] - нет!"))
		return

	var/user_strength = GET_MOB_ATTRIBUTE_VALUE(user, STAT_STRENGTH)
	var/wielded = SEND_SIGNAL(src, COMSIG_TWOHANDED_WIELD_CHECK)
	if(!wielded)
		if((readying_flags & READYING_FLAG_HARD_TWO_HANDED) && (user_strength < (minimum_strength * 3)))
			to_chat(user, span_warning("Я не могу использовать [src] одной рукой!"))
			return
		else if((readying_flags & READYING_FLAG_SOFT_TWO_HANDED) && (user_strength < (minimum_strength * 1.5)))
			to_chat(user, span_warning("Я не могу использовать [src] одной рукой!"))
			return

	var/list/modifiers = params2list(params)
	attacked_atom.attacked_by(src, user, modifiers)

	if(readying_flags & READYING_FLAG_HARD_TWO_HANDED)
		if(user_strength < CEILING(minimum_strength * 1.5, 1))
			unready_weapon(user)
			return
	if(!wielded && (readying_flags & READYING_FLAG_SOFT_TWO_HANDED))
		if(user_strength < CEILING(minimum_strength * 2, 1))
			unready_weapon(user)
			return
	if(readying_flags & READYING_FLAG_JUSTCAUSE)
		unready_weapon(user)
		return

/obj/item/afterattack(atom/target, mob/user, proximity_flag, params)
	if(SEND_SIGNAL(src, COMSIG_ITEM_AFTERATTACK, target, user, proximity_flag, params) & COMPONENT_CANCEL_ATTACK_CHAIN)
		return TRUE
	else if(SEND_SIGNAL(user, COMSIG_MOB_ITEM_AFTERATTACK, target, user, proximity_flag, params) & COMPONENT_CANCEL_ATTACK_CHAIN)
		return TRUE

/**
 * Called at the end of the attack chain if the user middle-clicked.
 *
 * Arguments:
 * * atom/target - The thing that was hit
 * * mob/user - The mob doing the hitting
 * * proximity_flag - is 1 if this afterattack was called on something adjacent, in your square, or on your person.
 * * click_parameters - is the params string from byond [/atom/proc/Click] code, see that documentation.
 */
/obj/item/proc/afterattack_tertiary(atom/target, mob/user, proximity_flag, click_parameters)
	var/signal_result = SEND_SIGNAL(src, COMSIG_ITEM_AFTERATTACK_TERTIARY, target, user, proximity_flag, click_parameters)
	SEND_SIGNAL(user, COMSIG_MOB_ITEM_AFTERATTACK, target, user, proximity_flag, click_parameters)

	if(signal_result & COMPONENT_TERTIARY_CANCEL_ATTACK_CHAIN)
		return TERTIARY_ATTACK_CANCEL_ATTACK_CHAIN

	if(signal_result & COMPONENT_TERTIARY_CONTINUE_ATTACK_CHAIN)
		return TERTIARY_ATTACK_CONTINUE_CHAIN

	return TERTIARY_ATTACK_CONTINUE_CHAIN

/obj/item/proc/unready_weapon(mob/living/user, silent = FALSE)
	ADD_TRAIT(src, TRAIT_WEAPON_UNREADY, ATTACKING_TRAIT)
	if(!silent)
		unready_message(user)

/obj/item/proc/unready_message(mob/living/user)
	to_chat(user, span_danger("[src] прекращает готовность!"))

/obj/item/proc/ready_weapon(mob/living/user, silent = FALSE)
	user.changeNext_move(CLICK_CD_READY_WEAPON)
	REMOVE_TRAIT(src, TRAIT_WEAPON_UNREADY, ATTACKING_TRAIT)
	if(!silent)
		ready_message(user)

/obj/item/proc/ready_message(mob/living/user)
	to_chat(user, span_danger("Я готовлю [src]!"))
	if(ready_sound)
		playsound(user, ready_sound, get_clamped_volume(), TRUE, extrarange = stealthy_audio ? SILENCED_SOUND_EXTRARANGE : -1, falloff_distance = 0)
