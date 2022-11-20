/client/Process_Grab()
	if(!mob.pulledby)
		return FALSE
	if(mob.pulledby == mob.pulling && mob.pulledby.grab_state == GRAB_PASSIVE) //Don't autoresist passive grabs if we're grabbing them too.
		return FALSE
	if(mob.incapacitated(ignore_restraints = TRUE))
		COOLDOWN_START(src, move_delay, 1 SECONDS)
		return TRUE
	else if(HAS_TRAIT(mob, TRAIT_RESTRAINED))
		COOLDOWN_START(src, move_delay, 1 SECONDS)
		to_chat(src, span_warning("I'm restrained! I can't move!"))
		return TRUE
	return mob.resist_grab(TRUE)
