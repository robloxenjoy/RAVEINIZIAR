GLOBAL_LIST_INIT(femcumfaceable, typecacheof(list(/mob/living/carbon/human)))

/datum/component/creamed/femcum
	cover_lips = span_femcummy("squirt")
	mood_event_key = "cumface"
	var/bigcummies = FALSE

/datum/component/creamed/femcum/InheritComponent(datum/component/C, i_am_original)
	. = ..()
	if(C)
		bigcummies = TRUE
		cover_lips = span_femcummy("a lot of squirt")

/datum/component/creamed/femcum/return_creamable_list()
	return GLOB.femcumfaceable

/datum/component/creamed/femcum/cream()
	SEND_SIGNAL(parent, COMSIG_MOB_CREAMED, type)
	creamface = mutable_appearance('modular_septic/icons/effects/femcum.dmi')
	creamface.color = COLOR_WHITE_FEMCUM
	if(ishuman(parent))
		var/mob/living/carbon/human/humie = parent
		var/cummies_icon_state = "femcumface"
		if(bigcummies)
			cummies_icon_state = "bigfemcumface"
		if(LAZYACCESS(humie.dna.species.mutant_bodyparts, "snout"))
			creamface.icon_state = "[cummies_icon_state]_lizard"
		else if(ismonkey(humie))
			creamface.icon_state = "[cummies_icon_state]_monkey"
		else
			creamface.icon_state = "[cummies_icon_state]_human"
		if(bigcummies)
			SEND_SIGNAL(humie, COMSIG_ADD_MOOD_EVENT, mood_event_key, /datum/mood_event/creampie/fembukkake)
		else
			SEND_SIGNAL(humie, COMSIG_ADD_MOOD_EVENT, mood_event_key, /datum/mood_event/creampie/femcummies)

	var/atom/A = parent
	A.add_overlay(creamface)
	return TRUE
