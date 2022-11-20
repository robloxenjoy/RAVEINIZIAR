/// Middleware to handle birthsign
/datum/preference_middleware/birthsign
	action_delegations = list(
		"select_birthsign" = .proc/select_birthsign,
	)

/datum/preference_middleware/birthsign/New(datum/preferences)
	. = ..()
	if(!LAZYLEN(GLOB.species_to_available_birthsigns))
		for(var/species_type in subtypesof(/datum/species))
			var/datum/species/species = new species_type()
			GLOB.species_to_available_birthsigns[species_type] = species.available_birthsigns.Copy()
			qdel(species)
	// Run this at least once to verify if everything is valid here
	if(src.preferences)
		get_ui_data()

/datum/preference_middleware/birthsign/on_new_character(mob/user)
	. = ..()
	if(preferences.tainted_character_profiles)
		preferences.birthsign = /datum/cultural_info/birthsign/starless
	// Run this at least once to verify if everything is valid here
	get_ui_data()

/datum/preference_middleware/birthsign/get_ui_assets()
	return list(get_asset_datum(/datum/asset/spritesheet/birthsigns))

/datum/preference_middleware/birthsign/get_ui_data(mob/user)
	var/list/data = list()

	// How?
	if(!ispath(preferences.birthsign))
		preferences.birthsign = /datum/cultural_info/birthsign/starless

	var/species_type = preferences.read_preference(/datum/preference/choiced/species)
	// Checking if this species can have this birthsign
	if(!LAZYLEN(GLOB.species_to_available_birthsigns[species_type]) || !(preferences.birthsign in GLOB.species_to_available_birthsigns[species_type]))
		preferences.birthsign = LAZYACCESSASSOC(GLOB.species_to_available_birthsigns, species_type, 1)
		if(!preferences.birthsign)
			preferences.birthsign = /datum/cultural_info/birthsign/starless

	var/birthsign_balance = preferences.GetQuirkBalance()
	// Something is fucked
	if(birthsign_balance < 0)
		preferences.birthsign = /datum/cultural_info/birthsign/starless
		birthsign_balance = preferences.GetQuirkBalance()

	var/list/selected_birthsign = list()
	var/datum/cultural_info/birthsign/birthsign_datum = GLOB.culture_birthsigns[preferences.birthsign]
	if(birthsign_datum)
		selected_birthsign["name"] = birthsign_datum.name
		selected_birthsign["description"] = birthsign_datum.description
		selected_birthsign["icon"] = sanitize_css_class_name(birthsign_datum.name)
		selected_birthsign["patron_saint"] = birthsign_datum.patron_saint
		selected_birthsign["favored_profession"] = birthsign_datum.favored_profession
		selected_birthsign["value"] = birthsign_datum.value
		selected_birthsign["cant_buy"] = null

		data["selected_birthsign"] = selected_birthsign
	var/list/unselected_birthsigns = list()
	for(var/birthsign_path in (GLOB.species_to_available_birthsigns[species_type]-birthsign_datum.type))
		var/list/this_birthsign = list()
		var/datum/cultural_info/birthsign/unselected_birthsign_datum = GLOB.culture_birthsigns[birthsign_path]

		this_birthsign["name"] = unselected_birthsign_datum.name
		this_birthsign["description"] = unselected_birthsign_datum.description
		this_birthsign["icon"] = sanitize_css_class_name(unselected_birthsign_datum.name)
		this_birthsign["patron_saint"] = unselected_birthsign_datum.patron_saint
		this_birthsign["favored_profession"] = unselected_birthsign_datum.favored_profession
		this_birthsign["value"] = unselected_birthsign_datum.value
		this_birthsign["cant_buy"] = (birthsign_balance < unselected_birthsign_datum.value ? "Not enough points!" : null)

		unselected_birthsigns += list(this_birthsign)
	data["unselected_birthsigns"] = unselected_birthsigns
	data["birthsign_balance"] = birthsign_balance

	return data

/datum/preference_middleware/birthsign/proc/select_birthsign(list/params, mob/user)
	var/birthsign_name = params["birthsign_name"]
	var/birthsign_balance = preferences.GetQuirkBalance()
	var/datum/cultural_info/birthsign/birthsign_datum = GLOB.culture_birthsigns[preferences.birthsign]
	if(birthsign_datum?.value)
		birthsign_balance += birthsign_datum.value
	birthsign_datum = null
	for(var/birthsign_path in GLOB.culture_birthsigns)
		var/datum/cultural_info/birthsign/possible_sign = GLOB.culture_birthsigns[birthsign_path]
		if(birthsign_name == possible_sign.name)
			birthsign_datum = possible_sign
			break
	if(birthsign_datum && ((birthsign_balance-birthsign_datum.value) >= 0))
		preferences.birthsign = birthsign_datum.type
		return TRUE
