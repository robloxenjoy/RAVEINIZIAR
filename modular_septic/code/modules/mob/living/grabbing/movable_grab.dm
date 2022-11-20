/atom/movable/setGrabState(newstate)
	if(newstate == grab_state)
		return
	SEND_SIGNAL(src, COMSIG_MOVABLE_SET_GRAB_STATE, newstate)
	. = grab_state
	grab_state = newstate
	if(pulling)
		switch(grab_state) // Current state.
			if(GRAB_PASSIVE)
				REMOVE_TRAIT(pulling, TRAIT_IMMOBILIZED, CHOKEHOLD_TRAIT)
				REMOVE_TRAIT(pulling, TRAIT_HANDS_BLOCKED, CHOKEHOLD_TRAIT)
				if(. >= GRAB_NECK) // Previous state was a a neck-grab or higher.
					REMOVE_TRAIT(pulling, TRAIT_FLOORED, CHOKEHOLD_TRAIT)
			if(GRAB_AGGRESSIVE)
				if(. >= GRAB_NECK) // Grab got downgraded.
					REMOVE_TRAIT(pulling, TRAIT_FLOORED, CHOKEHOLD_TRAIT)
				else // Grab got upgraded from a passive one.
					ADD_TRAIT(pulling, TRAIT_IMMOBILIZED, CHOKEHOLD_TRAIT)
					ADD_TRAIT(pulling, TRAIT_HANDS_BLOCKED, CHOKEHOLD_TRAIT)
			if(GRAB_NECK, GRAB_KILL)
				if(. <= GRAB_AGGRESSIVE)
					ADD_TRAIT(pulling, TRAIT_FLOORED, CHOKEHOLD_TRAIT)

/atom/movable/stop_pulling()
	if(pulling)
		var/atom/was_pulling = pulling
		pulling.set_pulledby(null)
		setGrabState(GRAB_PASSIVE)
		pulling = null
		//We want to call this once we actually stop pulling to avoid runtimes
		if(!QDELETED(was_pulling))
			SEND_SIGNAL(was_pulling, COMSIG_ATOM_NO_LONGER_PULLED, src)
