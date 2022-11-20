/// Middleware to handle languages
/datum/preference_middleware/languages
	action_delegations = list(
		"give_language" = .proc/give_language,
		"remove_language" = .proc/remove_language,
	)

/datum/preference_middleware/languages/New(datum/preferences)
	. = ..()
	// Run this at least once to verify if everything is valid here
	if(preferences)
		get_ui_data()

/datum/preference_middleware/languages/on_new_character(mob/user)
	. = ..()
	if(preferences.tainted_character_profiles)
		preferences.languages = GLOB.species_to_default_languages[/datum/species/human].Copy()
	// Run this at least once to verify if everything is valid here
	get_ui_data()

/datum/preference_middleware/languages/get_ui_assets()
	return list(get_asset_datum(/datum/asset/spritesheet/languages))

/datum/preference_middleware/languages/get_ui_data(mob/user)
	var/list/data = list()

	// How?
	if(!islist(preferences.languages))
		preferences.languages = list()

	var/species_type = preferences.read_preference(/datum/preference/choiced/species)
	// Checking if this species can have these languages
	for(var/language_type in preferences.languages)
		// Invalid language
		if(!(language_type in LAZYACCESS(GLOB.species_to_learnable_languages, species_type)))
			preferences.languages -= language_type

	// Ensuring that the necessary languages are present
	for(var/language_type in LAZYACCESS(GLOB.species_to_necessary_languages, species_type))
		var/current_understanding = LAZYACCESS(preferences.languages, language_type)
		var/necessary_understanding = LAZYACCESSASSOC(GLOB.species_to_necessary_languages, species_type, language_type)
		if(!current_understanding || (necessary_understanding && (current_understanding < necessary_understanding)))
			preferences.languages[language_type] = GLOB.species_to_necessary_languages[species_type][language_type]

	var/language_balance = preferences.GetQuirkBalance()

	// Too litle languages or too many languages
	if(!LAZYLEN(preferences.languages) || (language_balance < 0))
		// Try the default languages first
		preferences.languages = list()
		for(var/language_type in LAZYACCESS(GLOB.species_to_default_languages, species_type))
			preferences.languages[language_type] = LAZYACCESSASSOC(GLOB.species_to_default_languages, species_type, language_type)
		language_balance = preferences.GetQuirkBalance()
		// Necessary ones second
		if(!LAZYLEN(preferences.languages) || (language_balance < 0))
			preferences.languages = list()
			for(var/language_type in LAZYACCESS(GLOB.species_to_necessary_languages, species_type))
				preferences.languages[language_type] = GLOB.species_to_necessary_languages[species_type][language_type]
		language_balance = preferences.GetQuirkBalance()
		// First learnable one lastly
		if(!LAZYLEN(preferences.languages) || (language_balance < 0))
			preferences.languages = list()
			for(var/language_type in LAZYACCESS(GLOB.species_to_learnable_languages, species_type))
				preferences.languages[language_type] = LAZYACCESSASSOC(GLOB.species_to_learnable_languages, species_type, language_type)
				break
		language_balance = preferences.GetQuirkBalance()
		// At this point, give up, literally everything that could fail did
		if(!LAZYLEN(preferences.languages) || (language_balance < 0))
			preferences.languages[/datum/language/common] = LANGUAGE_SPOKEN

	language_balance = preferences.GetQuirkBalance()

	var/list/selected_languages = list()
	var/list/unselected_languages = list()
	for(var/language_type in LAZYACCESS(GLOB.species_to_learnable_languages, species_type))
		var/datum/language/language = GLOB.language_datum_instances[language_type]
		if(language.secret)
			continue
		if(preferences.languages[language.type])
			var/list/this_language = list()
			var/already_taken_cost = (preferences.languages[language_type] == LANGUAGE_SPOKEN ? LANGUAGE_COST_SPOKEN : LANGUAGE_COST_UNDERSTOOD)

			this_language["name"] = language.name
			this_language["description"] = language.desc
			this_language["understand_type"] = preferences.languages[language.type]
			this_language["icon"] = sanitize_css_class_name(language.name)
			this_language["value_understand"] = LANGUAGE_COST_UNDERSTOOD
			this_language["value_speak"] = LANGUAGE_COST_SPOKEN
			this_language["cant_learn_understand"] = ((language_balance+already_taken_cost < LANGUAGE_COST_UNDERSTOOD) ? \
												"Not enough points!" : \
												((GLOB.species_to_necessary_languages[species_type][language_type] > LANGUAGE_UNDERSTOOD) ? \
												"Must be spoken!" : \
												((GLOB.species_to_learnable_languages[species_type][language_type] < LANGUAGE_UNDERSTOOD) ? \
												"Cannot understand this language!" : null))
												)
			this_language["cant_learn_speak"] = ((language_balance+already_taken_cost < LANGUAGE_COST_SPOKEN) ? \
												"Not enough points!" : \
												((GLOB.species_to_necessary_languages[species_type][language_type] > LANGUAGE_SPOKEN) ? \
												"Must be more than spoken!" : \
												((GLOB.species_to_learnable_languages[species_type][language_type] < LANGUAGE_SPOKEN) ? \
												"Cannot speak this language!" : null))
												)
			this_language["cant_forget"] = (GLOB.species_to_necessary_languages[species_type][language_type] ? \
										"This is a required language!" : \
										(LAZYLEN(preferences.languages) <= 1 ? "You need at least one language!" : null)
										)
			selected_languages += list(this_language)
		else
			var/list/this_language = list()

			this_language["name"] = language.name
			this_language["description"] = language.desc
			this_language["understand_type"] = LANGUAGE_NOT_UNDERSTOOD
			this_language["icon"] = sanitize_css_class_name(language.name)
			this_language["value_understand"] = LANGUAGE_COST_UNDERSTOOD
			this_language["value_speak"] = LANGUAGE_COST_SPOKEN
			this_language["cant_learn_understand"] = ((language_balance < LANGUAGE_COST_UNDERSTOOD) ? \
												"Not enough points!" : \
												((GLOB.species_to_necessary_languages[species_type][language_type] > LANGUAGE_UNDERSTOOD) ? \
												"Must be spoken!" : \
												((GLOB.species_to_learnable_languages[species_type][language_type] < LANGUAGE_UNDERSTOOD) ? \
												"Cannot understand this language!" : null))
												)
			this_language["cant_learn_speak"] = ((language_balance < LANGUAGE_COST_SPOKEN) ? \
												"Not enough points!" : \
												((GLOB.species_to_necessary_languages[species_type][language_type] > LANGUAGE_SPOKEN) ? \
												"Must be more than spoken!" : \
												((GLOB.species_to_learnable_languages[species_type][language_type] < LANGUAGE_SPOKEN) ? \
												"Cannot speak this language!" : null))
												)
			this_language["cant_forget"] = (GLOB.species_to_necessary_languages[species_type][language_type] ? \
										"This is a required language!" : \
										(LAZYLEN(preferences.languages) <= 1 ? "You need at least one language!" : null)
										)

			unselected_languages += list(this_language)

	data["language_balance"] = language_balance
	data["selected_languages"] = selected_languages
	data["unselected_languages"] = unselected_languages

	return data

/datum/preference_middleware/languages/post_set_preference(mob/user, preference, value)
	if(preference == "species")
		preferences.languages = list()
		var/species_type = preferences.read_preference(/datum/preference/choiced/species)
		var/datum/species/species = new species_type()
		for(var/language_type in species.default_languages)
			preferences.languages[language_type] = species.default_languages[language_type]
		qdel(species)
	return ..()

/datum/preference_middleware/languages/apply_to_human(mob/living/carbon/human/target, datum/preferences/preferences)
	target.language_holder.understood_languages.Cut()
	target.language_holder.spoken_languages.Cut()
	for(var/language_type in preferences.languages)
		if(LAZYACCESS(preferences.languages, language_type) >= LANGUAGE_UNDERSTOOD)
			target.language_holder.understood_languages[language_type] = list(LANGUAGE_ATOM)
		if(LAZYACCESS(preferences.languages, language_type) >= LANGUAGE_SPOKEN)
			target.language_holder.spoken_languages[language_type] = list(LANGUAGE_ATOM)

/datum/preference_middleware/languages/proc/give_language(list/params, mob/user)
	var/language_name = params["language_name"]
	var/understand_type = params["understand_type"]
	var/understand_cost = 0
	switch(understand_type)
		if(LANGUAGE_UNDERSTOOD)
			understand_cost = LANGUAGE_COST_UNDERSTOOD
		if(LANGUAGE_SPOKEN)
			understand_cost = LANGUAGE_COST_SPOKEN
	var/already_understood_type = params["already_understood_type"]
	var/already_understood_cost = 0
	switch(already_understood_type)
		if(LANGUAGE_UNDERSTOOD)
			already_understood_cost = LANGUAGE_COST_UNDERSTOOD
		if(LANGUAGE_SPOKEN)
			already_understood_cost = LANGUAGE_COST_SPOKEN
	var/language_balance = params["language_balance"]+already_understood_cost
	// too many languages
	if(preferences.languages && ((language_balance-understand_cost) < 0))
		return TRUE
	var/datum/language/language = GLOB.name_to_language_datum[language_name]
	preferences.languages[language.type] = understand_type
	return TRUE

/datum/preference_middleware/languages/proc/remove_language(list/params, mob/user)
	var/language_name = params["language_name"]
	var/datum/language/language = GLOB.name_to_language_datum[language_name]
	preferences.languages -= language.type
	return TRUE
