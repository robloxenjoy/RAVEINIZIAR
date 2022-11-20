GLOBAL_LIST_INIT(shitfaceable, typecacheof(list(/mob/living/carbon/human)))

/datum/component/creamed/shit
	cover_lips = span_shitty("shit")
	mood_event_key = "shitface"

/datum/component/creamed/shit/return_creamable_list()
	return GLOB.shitfaceable

/datum/component/creamed/shit/cream()
	SEND_SIGNAL(parent, COMSIG_MOB_CREAMED, type)
	creamface = mutable_appearance('modular_septic/icons/effects/shit.dmi')
	if(ishuman(parent))
		var/mob/living/carbon/human/humie = parent
		if(LAZYACCESS(humie.dna.species.mutant_bodyparts, "snout"))
			creamface.icon_state = "shitface_lizard"
		else if(ismonkey(humie))
			creamface.icon_state = "shitface_monkey"
		else
			creamface.icon_state = "shitface_human"
		SEND_SIGNAL(humie, COMSIG_ADD_MOOD_EVENT, mood_event_key, /datum/mood_event/creampie/shitface)

	var/atom/A = parent
	A.add_overlay(creamface)
	return TRUE
