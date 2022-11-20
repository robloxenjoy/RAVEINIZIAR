//This was modified a lot, enough for modularization to make sense
/mob/ClickOn(atom/A, params)
	if(world.time <= next_click)
		return

	next_click = world.time + 1

	if(check_click_intercept(params,A))
		return

	if(notransform)
		return

	if(SEND_SIGNAL(src, COMSIG_MOB_CLICKON, A, params) & COMSIG_MOB_CANCEL_CLICKON)
		return

	var/list/modifiers = params2list(params)
	if(LAZYACCESS(modifiers, SHIFT_CLICK))
		if(LAZYACCESS(modifiers, MIDDLE_CLICK))
			ShiftMiddleClickOn(A)
		else if(LAZYACCESS(modifiers, RIGHT_CLICK))
			shift_right_click_on(A)
		else if(LAZYACCESS(modifiers, CTRL_CLICK))
			CtrlShiftClickOn(A)
		else
			ShiftClickOn(A)
		return
	if(LAZYACCESS(modifiers, ALT_CLICK)) // alt and alt-gr (rightalt)
		if(LAZYACCESS(modifiers, MIDDLE_CLICK))
			alt_click_on_tertiary(A)
		else if(LAZYACCESS(modifiers, RIGHT_CLICK))
			alt_click_on_secondary(A)
		else
			AltClickOn(A)
		return
	if(LAZYACCESS(modifiers, CTRL_CLICK))
		CtrlClickOn(A)
		return

	if(incapacitated(ignore_restraints = TRUE, ignore_stasis = TRUE))
		return

	face_atom(A)

	if(next_move > world.time) // in the year 2000...
		//spam prevention
		if(!(world.time % 3))
			to_chat(src, click_fail_msg())
		return

	if(!LAZYACCESS(modifiers, "catcher") && A.IsObscured())
		return

	if(HAS_TRAIT(src, TRAIT_HANDS_BLOCKED))
		changeNext_move(CLICK_CD_HANDCUFFED)   //Doing shit in cuffs shall be vey slow
		UnarmedAttack(A, FALSE, modifiers)
		return

	if(throw_mode)
		changeNext_move(CLICK_CD_THROW)
		throw_item(A)
		return

	var/obj/item/active_held_item = get_active_held_item()
	if(active_held_item == A)
		if(LAZYACCESS(modifiers, MIDDLE_CLICK))
			active_held_item.attack_self_tertiary(src, modifiers)
			update_inv_hands()
			return
		else if(LAZYACCESS(modifiers, RIGHT_CLICK))
			active_held_item.attack_self_secondary(src, modifiers)
			update_inv_hands()
			return
		else
			active_held_item.attack_self(src, modifiers)
			update_inv_hands()
			return

	//These are always reachable.
	//User itself, current loc, and user inventory
	var/obj/item/atom_item
	if(isitem(A))
		atom_item = A
	if((A in DirectAccess()) || (atom_item?.stored_in && (atom_item.stored_in in DirectAccess()) ) )
		if(active_held_item)
			active_held_item.melee_attack_chain(src, A, params)
		else
			UnarmedAttack(A, FALSE, modifiers)
		return

	//Can't reach anything else in lockers or other weirdness
	if(!loc.AllowClick())
		return

	//Standard reach turf to turf or reaching inside storage
	if(CanReach(A, active_held_item) || (atom_item?.stored_in && CanReach(atom_item.stored_in, active_held_item)))
		if(active_held_item)
			active_held_item.melee_attack_chain(src, A, params)
		else
			UnarmedAttack(A, TRUE, modifiers)
	else
		if(active_held_item)
			if(LAZYACCESS(modifiers, MIDDLE_CLICK))
				var/after_attack_tertiary_result = active_held_item.afterattack_tertiary(A, src, FALSE, params)
				if(after_attack_tertiary_result == TERTIARY_ATTACK_CALL_NORMAL)
					active_held_item.afterattack(A, src, FALSE, params)
			else if(LAZYACCESS(modifiers, RIGHT_CLICK))
				var/after_attack_secondary_result = active_held_item.afterattack_secondary(A, src, FALSE, params)
				if(after_attack_secondary_result == SECONDARY_ATTACK_CALL_NORMAL)
					active_held_item.afterattack(A, src, FALSE, params)
			else
				active_held_item.afterattack(A, src, FALSE, params)
		else
			if(LAZYACCESS(modifiers, MIDDLE_CLICK))
				ranged_tertiary_attack(A, modifiers)
			else if(LAZYACCESS(modifiers, RIGHT_CLICK))
				ranged_secondary_attack(A, modifiers)
			else
				RangedAttack(A, modifiers)

/**
 * Ranged tertiary attack
 *
 * If the same conditions are met to trigger RangedAttack but it is
 * instead initialized via a middle click, this will trigger instead.
 * Useful for mobs that have their abilities mapped to middle click.
 */
/mob/proc/ranged_tertiary_attack(atom/target, modifiers)
	if(SEND_SIGNAL(src, COMSIG_MOB_ATTACK_RANGED_TERTIARY, target, modifiers) & COMPONENT_CANCEL_ATTACK_CHAIN)
		return TRUE
	if(special_attack == SPECIAL_ATK_JUMP)
		return attempt_jump(target, FALSE, modifiers)

/mob/proc/alt_click_on_tertiary(atom/A, params)
	return look_into_distance(A, params)

/mob/proc/shift_right_click_on(atom/A, params)
	if(!isitem(A))
		return
	var/obj/item/flipper = A
	if(!isliving(usr) || usr.incapacitated() || !usr.is_holding(flipper))
		return
	if(flipper.loc && SEND_SIGNAL(flipper.loc, COMSIG_CONTAINS_STORAGE))
		return
	var/old_width = flipper.tetris_width
	var/old_height = flipper.tetris_height
	flipper.tetris_height = old_width
	flipper.tetris_width = old_height
	to_chat(usr, span_notice("I have rearranged how i will store this item in backpacks."))
