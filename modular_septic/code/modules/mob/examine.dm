/mob/examine_chaser(mob/user)
	. = list()

/mob/topic_examine(mob/user)
	. = list()
	SEND_SIGNAL(src, COMSIG_ATOM_TOPIC_EXAMINE, user, .)

/mob/proc/on_examine_atom(atom/examined, examine_more = FALSE)
	return
