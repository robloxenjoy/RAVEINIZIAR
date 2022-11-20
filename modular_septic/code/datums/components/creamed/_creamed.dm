/datum/component/creamed
	dupe_mode = COMPONENT_DUPE_UNIQUE_PASSARGS
	var/cover_lips = "<span style='color: #fffdda;'>cream</span>"
	var/mood_event_key = "creampie"

/datum/component/creamed/Initialize()
	if(!is_type_in_typecache(parent, return_creamable_list()))
		return COMPONENT_INCOMPATIBLE
	cream()

/datum/component/creamed/proc/return_creamable_list()
	return GLOB.creamable

/datum/component/creamed/proc/cream()
	// do not use the god damn base component PLEASE
	if(type == /datum/component/creamed)
		qdel(src)
		parent.AddComponent(/datum/component/creamed/cream)
		return FALSE
	SEND_SIGNAL(parent, COMSIG_MOB_CREAMED, type)
	creamface = mutable_appearance('icons/effects/creampie.dmi')
	if(ishuman(parent))
		var/mob/living/carbon/human/humie = parent
		if(LAZYACCESS(humie.dna.species.mutant_bodyparts, "snout"))
			creamface.icon_state = "creampie_lizard"
		else if(ismonkey(humie))
			creamface.icon_state = "creampie_monkey"
		else
			creamface.icon_state = "creampie_human"
		SEND_SIGNAL(humie, COMSIG_ADD_MOOD_EVENT, mood_event_key, /datum/mood_event/creampie)
	else if(iscorgi(parent))
		creamface.icon_state = "creampie_corgi"
	else if(isAI(parent))
		creamface.icon_state = "creampie_ai"

	var/atom/A = parent
	A.add_overlay(creamface)
	return TRUE

/datum/component/creamed/Destroy(force, silent)
	var/atom/A = parent
	A.cut_overlay(creamface)
	qdel(creamface)
	if(mood_event_key)
		SEND_SIGNAL(A, COMSIG_CLEAR_MOOD_EVENT, mood_event_key)
	return ..()
