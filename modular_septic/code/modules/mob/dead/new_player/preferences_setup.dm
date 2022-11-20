/datum/preferences/render_new_preview_appearance(mob/living/carbon/human/dummy/mannequin)
	var/datum/job/preview_job = get_highest_priority_job()

	if(preview_job)
		// Silicons only need a very basic preview since there is no customization for them.
		if (istype(preview_job,/datum/job/ai))
			return image('icons/mob/ai.dmi', icon_state = resolve_ai_icon(read_preference(/datum/preference/choiced/ai_core_display)), dir = SOUTH)
		if (istype(preview_job,/datum/job/cyborg))
			return image('icons/mob/robots.dmi', icon_state = "robot", dir = SOUTH)

	switch(character_preview_type)
		if(PREVIEW_PREF_NAKED)
			mannequin.underwear_visibility = UNDERWEAR_HIDE_UNDIES | UNDERWEAR_HIDE_SHIRT | UNDERWEAR_HIDE_SOCKS
			mannequin.set_arousal(0)
		if(PREVIEW_PREF_NAKED_AROUSED)
			mannequin.underwear_visibility = UNDERWEAR_HIDE_UNDIES | UNDERWEAR_HIDE_SHIRT | UNDERWEAR_HIDE_SOCKS
			mannequin.set_arousal(AROUSAL_LEVEL_MAXIMUM)
		else
			if(preview_job)
				mannequin.job = preview_job.title
				mannequin.dress_up_as_job(preview_job, TRUE)
			mannequin.underwear_visibility = NONE
			mannequin.set_arousal(0)

	// Set up the dummy for its photoshoot
	apply_prefs_to(mannequin, TRUE)

	COMPILE_OVERLAYS(mannequin)
	return mannequin.appearance
