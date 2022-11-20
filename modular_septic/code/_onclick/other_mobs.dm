/// WARNING: Shitcode!
/mob/living/carbon/human/ClickOn(atom/A, params)
	var/list/modifiers = params2list(params)
	if(attributes && LAZYACCESS(modifiers, RIGHT_CLICK))
		switch(combat_style)
			if(CS_DUAL)
				swap_hand()
				modifiers -= RIGHT_CLICK
				params = list2params(modifiers)
				. = ..()
				swap_hand()
				return
	return ..()

/// Return TRUE to cancel other attack foot effects that respect it. Modifiers is the assoc list for click info such as if it was a right click.
/atom/proc/attack_foot(mob/user)
	. = FALSE
	//Adding fingerprints for kicking would be a bit weird, wouldn't it?
	if(SEND_SIGNAL(src, COMSIG_ATOM_ATTACK_FOOT, user) & COMPONENT_CANCEL_ATTACK_CHAIN)
		. = TRUE

/// Return TRUE to cancel other attack jaw effects that respect it. Modifiers is the assoc list for click info such as if it was a right click.
/atom/proc/attack_jaw(mob/user, list/modifiers)
	. = FALSE
	//Adding fingerprints for kicking would be a bit weird, wouldn't it?
	if(SEND_SIGNAL(src, COMSIG_ATOM_ATTACK_JAW, user) & COMPONENT_CANCEL_ATTACK_CHAIN)
		. = TRUE
