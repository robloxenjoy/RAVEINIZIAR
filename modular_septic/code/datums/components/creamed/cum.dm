GLOBAL_LIST_INIT(cumfaceable, typecacheof(list(/mob/living/carbon/human)))

/datum/component/creamed/cum
	cover_lips = span_cummy("cum")
	mood_event_key = "cumface"
	var/bigcummies = FALSE

/datum/component/creamed/cum/InheritComponent(datum/component/C, i_am_original)
	. = ..()
	if(C)
		bigcummies = TRUE
		cover_lips = span_cummy("a lot of cum")

/datum/component/creamed/cum/return_creamable_list()
	return GLOB.cumfaceable

/datum/component/creamed/cum/cream()
	SEND_SIGNAL(parent, COMSIG_MOB_CREAMED, type)
	creamface = mutable_appearance('modular_septic/icons/effects/cum.dmi')
	creamface.color = COLOR_WHITE_CUM
	if(ishuman(parent))
		var/mob/living/carbon/human/humie = parent
		var/cummies_icon_state = "cumface"
		if(bigcummies)
			cummies_icon_state = "bigcumface"
		if(LAZYACCESS(humie.dna.species.mutant_bodyparts, "snout"))
			creamface.icon_state = "[cummies_icon_state]_lizard"
		else if(ismonkey(humie))
			creamface.icon_state = "[cummies_icon_state]_monkey"
		else
			creamface.icon_state = "[cummies_icon_state]_human"
		if(bigcummies)
			SEND_SIGNAL(humie, COMSIG_ADD_MOOD_EVENT, mood_event_key, /datum/mood_event/creampie/bukkake)
		else
			SEND_SIGNAL(humie, COMSIG_ADD_MOOD_EVENT, mood_event_key, /datum/mood_event/creampie/cummies)

	var/atom/A = parent
	A.add_overlay(creamface)
	return TRUE
