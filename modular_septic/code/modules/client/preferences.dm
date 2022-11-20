/datum/preferences
	/// Supporting table, default is 5:
	/// Byond supporter: +5
	/// Patreon supporter: +5
	max_save_slots = 5
	/// Gives us our donator tier, if we are a donator
	var/donator_rank
	/// Preview type
	var/character_preview_type = PREVIEW_PREF_JOB
	/// Associative list, keyed by language typepath, pointing to LANGUAGE_UNDERSTOOD, or LANGUAGE_SPOKEN, for whether we understand or speak the language
	var/list/languages = list()
	/// List of chosen augmentations - It's an associative list with key name of the slot, pointing to a typepath of an augment datum
	var/list/augments = list()
	/// List of chosen preferred styles for limb replacements - Associative list, augment slot to augment style
	var/list/augment_styles = list()
	/// A list of all body markings
	var/list/list/body_markings = list()
	/// Our currently chosen birthsign type
	var/datum/cultural_info/birthsign/birthsign

/datum/preferences/New(client/C)
	//handle giving all the fucking antagonists by default
	enable_all_antagonists(C)
	. = ..()
	max_save_slots = 5
	if(C.IsByondMember())
		max_save_slots += 5
	var/is_donator = C.is_donator()
	if(is_donator)
		SSdonators.add_donator(C.ckey, is_donator)
		donator_rank = is_donator
		max_save_slots += 5

/datum/preferences/ui_static_data(mob/user)
	var/list/data = ..()
	data["donator_rank"] = donator_rank
	data["maximum_customization_points"] = MAXIMUM_CUSTOMIZATION_POINTS
	return data

/datum/preferences/ui_act(action, list/params, datum/tgui/ui, datum/ui_state/state)
	. = ..()
	if(.)
		return

	switch(action)
		if("set_preference")
			var/requested_preference_key = params["preference"]
			var/value = params["value"]
			for(var/datum/preference_middleware/preference_middleware as anything in middleware)
				if(preference_middleware.post_set_preference(usr, requested_preference_key, value))
					return TRUE
		if("rotateleft")
			character_preview_view.dir = turn(character_preview_view.dir, 90)
			return TRUE
		if("rotateright")
			character_preview_view.dir = turn(character_preview_view.dir, -90)
			return TRUE
		if("character_preview_update")
			return TRUE
		if("set_tricolor_preference")
			var/requested_preference_key = params["preference"]
			var/requested_preference_index = params["preferenceindex"]

			var/datum/preference/requested_preference = GLOB.preference_entries_by_key[requested_preference_key]
			if(isnull(requested_preference))
				return FALSE

			if(!istype(requested_preference, /datum/preference/tri_color) )
				return FALSE

			var/list/color_list = read_preference(requested_preference.type)
			var/default_value = sanitize_hexcolor(color_list[requested_preference_index], 6, TRUE)

			// Yielding
			var/new_color = input(
				usr,
				"Select new color",
				null,
				default_value || COLOR_WHITE,
			) as color | null

			if(!new_color)
				return FALSE

			var/list/new_color_list = list(
				(requested_preference_index == 1 ? new_color : color_list[1]),
				(requested_preference_index == 2 ? new_color : color_list[2]),
				(requested_preference_index == 3 ? new_color : color_list[3])
			)

			if(!update_preference(requested_preference, new_color_list))
				return FALSE

			return TRUE
		if("set_tricolor_default_colors")
			var/requested_preference_key = params["preference"]

			var/datum/preference/requested_preference = GLOB.preference_entries_by_key[requested_preference_key]
			if(isnull(requested_preference))
				return FALSE

			if(!istype(requested_preference, /datum/preference/tri_color))
				return FALSE

			var/list/new_color_list = requested_preference.create_informed_default_value(src)
			if(!update_preference(requested_preference, new_color_list))
				return FALSE

			return TRUE
		if("set_tricolor_mutant_colors")
			var/requested_preference_key = params["preference"]

			var/datum/preference/requested_preference = GLOB.preference_entries_by_key[requested_preference_key]
			if(isnull(requested_preference))
				return FALSE

			if(!istype(requested_preference, /datum/preference/tri_color))
				return FALSE

			var/list/new_color_list = read_preference(/datum/preference/tri_color/mutant_colors)
			if(!update_preference(requested_preference, new_color_list))
				return FALSE

			return TRUE
		if("set_color_default_colors")
			var/requested_preference_key = params["preference"]

			var/datum/preference/requested_preference = GLOB.preference_entries_by_key[requested_preference_key]
			if(isnull(requested_preference))
				return FALSE

			if(!istype(requested_preference, /datum/preference/color))
				return FALSE

			var/new_color = requested_preference.create_informed_default_value(src)
			if(!update_preference(requested_preference, new_color))
				return FALSE

			return TRUE
		if("set_color_mutant_colors")
			var/requested_preference_key = params["preference"]

			var/datum/preference/requested_preference = GLOB.preference_entries_by_key[requested_preference_key]
			if(isnull(requested_preference))
				return FALSE

			if(!istype(requested_preference, /datum/preference/color))
				return FALSE

			var/list/new_color_list = read_preference(/datum/preference/tri_color/mutant_colors)
			if(!update_preference(requested_preference, new_color_list[1]))
				return FALSE

			return TRUE

/datum/preferences/apply_all_client_preferences()
	for (var/datum/preference/preference as anything in get_preferences_in_priority_order())
		if (preference.savefile_identifier != PREFERENCE_PLAYER)
			continue

		value_cache -= preference.type
		var/read_value = read_preference(preference.type)
		if(preference.should_apply_to_client(parent, read_value, src))
			preference.apply_to_client(parent, read_value, src)

/datum/preferences/apply_prefs_to(mob/living/carbon/human/character, icon_updates = TRUE)
	character.dna.features = MANDATORY_FEATURE_LIST
	character.underwear = "Nude"
	character.socks = "Nude"
	character.undershirt = "Nude"
	var/has_bad_preference = FALSE
	for(var/datum/preference/preference as anything in get_preferences_in_priority_order())
		if(preference.savefile_identifier != PREFERENCE_CHARACTER)
			continue

		var/read_value = read_preference(preference.type)
		if(preference.should_apply_to_human(character, read_value, src))
			preference.apply_to_human(character, read_value, src)
			if(!has_bad_preference && preference.is_bad_preference(parent, read_value, src))
				has_bad_preference = TRUE

	character.dna.real_name = character.real_name
	character.regenerate_limbs(FALSE)
	character.assimilate_dna_to_species()
	character.dna.species.regenerate_organs(character, character.dna.species, TRUE)
	character.build_all_organs_from_dna()

	//Apply markings/augments after everything else is done
	for(var/datum/preference_middleware/preference_middleware as anything in middleware)
		preference_middleware.apply_to_human(character, src)

	character.dna.update_body_size()
	if(icon_updates)
		character.regenerate_icons()
	if(has_bad_preference)
		character.gain_trauma(pick(/datum/brain_trauma/mild/stuttering, \
								/datum/brain_trauma/mild/dumbness, \
								/datum/brain_trauma/mild/speech_impediment, \
								/datum/brain_trauma/mild/expressive_aphasia))

/datum/preferences/update_preference(datum/preference/preference, preference_value)
	if(!preference.is_accessible(src))
		return FALSE

	var/new_value = preference.deserialize(preference_value, src)
	var/success = preference.write(null, new_value)

	if(!success)
		return FALSE

	recently_updated_keys |= preference.type
	value_cache[preference.type] = new_value

	if(preference.savefile_identifier == PREFERENCE_PLAYER)
		preference.apply_to_client_updated(parent, read_preference(preference.type), src)
	else
		character_preview_view?.update_body()

	if(preference.is_bad_preference(parent, new_value, src))
		var/chat_warning = preference.bad_preference_warning(parent, new_value, src)
		if(chat_warning)
			to_chat(parent, chat_warning)

	return TRUE

/datum/preferences/GetQuirkBalance()
	var/bal = MAXIMUM_CUSTOMIZATION_POINTS
	for(var/quirk_type in all_quirks)
		var/datum/quirk/quirk = SSquirks.quirks[quirk_type]
		bal -= initial(quirk.value)
	for(var/augment_slot in augments)
		var/augment_type = augments[augment_slot]
		var/datum/augment_item/augment_item = GLOB.augment_item_datums[augment_type]
		bal -= initial(augment_item.value)
	for(var/language_type in languages)
		bal -= (languages[language_type] == LANGUAGE_SPOKEN ? LANGUAGE_COST_SPOKEN : LANGUAGE_COST_UNDERSTOOD)
	return bal

/datum/preferences/proc/get_features()
	var/list/features = list()

	var/list/mutant_colors = read_preference(/datum/preference/tri_color/mutant_colors)
	var/uses_skintones = read_preference(/datum/preference/toggle/skin_tone)
	var/skin_tone = read_preference(/datum/preference/choiced/skin_tone)

	features["mcolor"] = LAZYACCESS(mutant_colors, 1)
	features["mcolor2"] = LAZYACCESS(mutant_colors, 2)
	features["mcolor3"] = LAZYACCESS(mutant_colors, 3)
	features["uses_skintones"] = uses_skintones
	features["skin_tone"] = skin_tone
	features["skin_color"] = skintone2hex(skin_tone)

	return features

/datum/preferences/proc/read_preference_if_accessible(preference_type)
	var/datum/preference/preference_entry = GLOB.preference_entries[preference_type]
	if (isnull(preference_entry))
		var/extra_info = ""

		// Current initializing subsystem is important to know because it might be a problem with
		// things running pre-assets-initialization.
		if (!isnull(Master.current_initializing_subsystem))
			extra_info = "Info was attempted to be retrieved while [Master.current_initializing_subsystem] was initializing."

		CRASH("Preference type `[preference_type]` is invalid! [extra_info]")
	if(preference_entry.is_accessible(src))
		return read_preference(preference_type)

/datum/preferences/proc/enable_all_antagonists(client/owner)
	// Antagonists that don't have a dynamic ruleset, but do have a preference
	var/static/list/non_ruleset_antagonists = list(
		ROLE_LONE_OPERATIVE = /datum/antagonist/nukeop/lone,
	)

	var/list/antagonists = non_ruleset_antagonists.Copy()

	for(var/datum/dynamic_ruleset/ruleset as anything in subtypesof(/datum/dynamic_ruleset))
		var/datum/antagonist/antagonist_type = initial(ruleset.antag_datum)
		if(isnull(antagonist_type))
			continue

		// antag_flag is guaranteed to be unique by unit tests.
		antagonists += initial(ruleset.antag_flag)
	for(var/antag_flag in antagonists)
		be_special |= antag_flag
