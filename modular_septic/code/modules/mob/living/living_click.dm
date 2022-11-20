/// Checks for MIDDLE_CLICK in modifiers and runs attack_hand_tertiary if so. Returns TRUE if normal chain blocked.
/mob/living/proc/tertiary_click_attack_chain(atom/target, list/modifiers)
	if(!LAZYACCESS(modifiers, MIDDLE_CLICK))
		return

	var/tertiary_result = target.attack_hand_tertiary(src, modifiers)
	if((tertiary_result == TERTIARY_ATTACK_CANCEL_ATTACK_CHAIN) || (tertiary_result == TERTIARY_ATTACK_CONTINUE_CHAIN))
		return TRUE
	else if(tertiary_result != TERTIARY_ATTACK_CALL_NORMAL)
		CRASH("attack_hand_tertiary did not return a TERTIARY_ATTACK_* define.")
