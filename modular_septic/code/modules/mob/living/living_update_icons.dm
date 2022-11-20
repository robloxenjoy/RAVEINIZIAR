/mob/living/update_transform()
	perform_update_transform() // carbon mobs do it differently than silicons and simple animals.
	update_shadow()
	SEND_SIGNAL(src, COMSIG_LIVING_POST_UPDATE_TRANSFORM) // ...and we want the signal to be sent now.

/mob/living/update_shadow()
	vis_contents |= get_mob_shadow(NORMAL_MOB_SHADOW)
