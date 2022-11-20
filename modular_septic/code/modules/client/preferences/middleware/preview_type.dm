/datum/preference_middleware/character_preview_type
	action_delegations = list(
		"select_preview_type" = .proc/select_preview_type,
	)

/datum/preference_middleware/character_preview_type/get_ui_data(mob/user)
	var/list/data = list()
	data["character_preview_type"] = preferences.character_preview_type
	return data

/datum/preference_middleware/character_preview_type/proc/select_preview_type(list/params, mob/user)
	switch(params["new_preview_type"])
		if(PREVIEW_PREF_NAKED)
			preferences.character_preview_type = PREVIEW_PREF_NAKED
		if(PREVIEW_PREF_NAKED_AROUSED)
			preferences.character_preview_type = PREVIEW_PREF_NAKED_AROUSED
		else
			preferences.character_preview_type = PREVIEW_PREF_JOB
	preferences.character_preview_view.update_body()
	return TRUE
