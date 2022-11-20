/// Middleware to handle markings
/datum/preference_middleware/markings
	action_delegations = list(
		"add_marking" = .proc/add_marking,
		"change_marking" = .proc/change_marking,
		"remove_marking" = .proc/remove_marking,
		"color_marking" = .proc/color_marking,
		"move_marking_up" = .proc/move_marking_up,
		"move_marking_down" = .proc/move_marking_down,
		"set_preset" = .proc/set_preset,
	)

/datum/preference_middleware/markings/New(datum/preferences)
	. = ..()
	// Run this at least once to verify if everything is valid here
	if(src.preferences)
		get_ui_data()

/datum/preference_middleware/markings/on_new_character(mob/user)
	. = ..()
	if(preferences.tainted_character_profiles)
		preferences.body_markings = list()
	get_ui_data()

/datum/preference_middleware/markings/get_ui_data(mob/user)
	var/list/data = list()

	// How?
	if(!islist(preferences.body_markings))
		preferences.body_markings = list()

	var/mismatched_parts = preferences.read_preference(/datum/preference/toggle/mismatched_parts)
	var/datum/species/species_type = preferences.read_preference(/datum/preference/choiced/species)

	var/list/presets = list()
	for(var/body_marking_set in GLOB.body_marking_sets)
		presets += body_marking_set
	if(!mismatched_parts)
		for(var/name in presets)
			var/datum/body_marking_set/body_marking_set = GLOB.body_marking_sets[name]
			if(body_marking_set.recommended_species && !(initial(species_type.id) in body_marking_set.recommended_species))
				presets -= name

	data["body_marking_sets"] = presets

	var/list/marking_parts = list()
	for(var/zone in GLOB.marking_zones)
		var/list/this_zone = list()

		this_zone["body_zone"] = zone
		this_zone["name"] = capitalize_like_old_man(parse_zone(zone))
		var/list/this_zone_marking_choices = list()
		if(LAZYACCESS(GLOB.body_markings_per_limb, zone))
			this_zone_marking_choices |= GLOB.body_markings_per_limb[zone]
		for(var/choice in this_zone_marking_choices)
			var/datum/body_marking/body_marking = GLOB.body_markings[choice]
			if(body_marking.recommended_species && !(initial(species_type.id) in body_marking.recommended_species))
				this_zone_marking_choices -= choice
		var/list/this_zone_markings = list()
		for(var/name in preferences.body_markings[zone])
			this_zone_marking_choices -= name
			var/list/this_marking = list()
			this_marking["name"] = name
			this_marking["color"] = sanitize_hexcolor(preferences.body_markings[zone][name], 6, TRUE)
			this_marking["marking_index"] = preferences.body_markings[zone].Find(name)
			this_zone_markings += list(this_marking)
		this_zone["markings"] = this_zone_markings
		this_zone["markings_choices"] = this_zone_marking_choices
		this_zone["can_add_markings"] = (LAZYLEN(this_zone_markings) < MAXIMUM_MARKINGS_PER_LIMB)

		marking_parts += list(this_zone)

	data["marking_parts"] = marking_parts
	data["maximum_markings_per_limb"] = MAXIMUM_MARKINGS_PER_LIMB
	return data

/datum/preference_middleware/markings/apply_to_human(mob/living/carbon/human/target, datum/preferences/preferences)
	target.dna.body_markings = LAZYCOPY(preferences.body_markings)
	target.dna.species.body_markings = LAZYCOPY(preferences.body_markings)
	for(var/obj/item/bodypart/bodypart as anything in target.bodyparts)
		bodypart.body_markings = list()
		if(bodypart.advanced_rendering)
			if(bodypart.body_zone && target.dna.body_markings[bodypart.body_zone])
				bodypart.body_markings[bodypart.aux_zone] = target.dna.body_markings[bodypart.body_zone].Copy()
			if(bodypart.aux_zone && target.dna.body_markings[bodypart.aux_zone])
				bodypart.body_markings[bodypart.aux_zone] = target.dna.body_markings[bodypart.aux_zone].Copy()
		if(!LAZYLEN(bodypart.body_markings))
			bodypart.body_markings = null

/datum/preference_middleware/markings/proc/add_marking(list/params, mob/user)
	var/zone = params["body_zone"]
	LAZYINITLIST(preferences.body_markings[zone])
	var/list/marking_list = preferences.body_markings[zone]
	if(LAZYLEN(marking_list) < MAXIMUM_MARKINGS_PER_LIMB)
		var/name = GLOB.body_markings_per_limb[zone][LAZYLEN(marking_list)+1]
		var/datum/body_marking/body_marking = GLOB.body_markings[name]
		var/pref_species = preferences.read_preference(/datum/preference/choiced/species)
		marking_list[name] = sanitize_hexcolor(body_marking.get_default_color(preferences.get_features(), pref_species), 6, FALSE)
		preferences.character_preview_view.update_body()
		return TRUE

/datum/preference_middleware/markings/proc/change_marking(list/params, mob/user)
	var/zone = params["body_zone"]
	var/index = params["marking_index"]
	var/new_marking = params["new_marking"]
	var/list/marking_list = preferences.body_markings[zone].Copy()
	preferences.body_markings[zone] = list()
	var/count = 0
	for(var/previousmarking in marking_list)
		count++
		if(count == index)
			preferences.body_markings[zone][new_marking] = marking_list[previousmarking]
		else
			preferences.body_markings[zone][previousmarking] = marking_list[previousmarking]
	preferences.character_preview_view.update_body()
	return TRUE

/datum/preference_middleware/markings/proc/color_marking(list/params, mob/user)
	var/zone = params["body_zone"]
	var/marking_name = params["marking_name"]
	if(marking_name)
		var/old_color = preferences.body_markings[zone][marking_name]
		var/new_color = input(user, "Select new color", "New marking color", "#[old_color]") as color
		preferences.body_markings[zone][marking_name] = sanitize_hexcolor(new_color, 6, FALSE)
		preferences.character_preview_view.update_body()
		return TRUE

/datum/preference_middleware/markings/proc/remove_marking(list/params, mob/user)
	var/zone = params["body_zone"]
	var/index = params["marking_index"]
	var/list/marking_list = preferences.body_markings[zone]
	if(LAZYACCESS(marking_list, index))
		marking_list -= marking_list[index]
		if(LAZYLEN(marking_list) <= 0)
			marking_list = null
		preferences.character_preview_view.update_body()
		return TRUE

/datum/preference_middleware/markings/proc/move_marking_up(list/params, mob/user)
	var/zone = params["body_zone"]
	var/index = params["marking_index"]
	var/list/marking_list = preferences.body_markings[zone]
	if(LAZYLEN(marking_list) >= 2 && (index >= 2))
		marking_list.Swap(index, index-1)
		preferences.character_preview_view.update_body()
		return TRUE

/datum/preference_middleware/markings/proc/move_marking_down(list/params, mob/user)
	var/zone = params["body_zone"]
	var/index = params["marking_index"]
	var/list/marking_list = preferences.body_markings[zone]
	if(LAZYLEN(marking_list) >= 2 && (index < LAZYLEN(marking_list)))
		marking_list.Swap(index, index+1)
		preferences.character_preview_view.update_body()
		return TRUE

/datum/preference_middleware/markings/proc/set_preset(list/params, mob/user)
	var/preset = params["preset"]
	if(preset)
		var/datum/body_marking_set/body_marking_set = GLOB.body_marking_sets[preset]
		var/pref_species = preferences.read_preference(/datum/preference/choiced/species)
		preferences.body_markings = assemble_body_markings_from_set(body_marking_set, preferences.get_features(), pref_species)
	preferences.character_preview_view.update_body()
	return TRUE
