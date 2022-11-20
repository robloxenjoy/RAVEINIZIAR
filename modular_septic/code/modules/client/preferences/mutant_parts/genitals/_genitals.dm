/// Genitals preference
/datum/preference/choiced/genitals
	savefile_identifier = PREFERENCE_CHARACTER
	savefile_key = "genitals"
	priority = PREFERENCE_PRIORITY_MUTANT_PART
	can_randomize = FALSE

/datum/preference/choiced/genitals/create_informed_default_value(datum/preferences/preferences)
	var/gender = preferences.read_preference(/datum/preference/choiced/gender)
	switch(gender)
		if(MALE)
			return GENITALS_MALE
		if(FEMALE)
			return GENITALS_FEMALE
		else
			return GENITALS_MALE

/datum/preference/choiced/genitals/is_accessible(datum/preferences/preferences)
	. = ..()
	if(!.)
		return
	var/species_type = preferences.read_preference(/datum/preference/choiced/species)
	var/datum/species/species = new species_type()
	if(AGENDER in species.species_traits)
		. = FALSE
	var/list/genitals_possible = list()
	genitals_possible |= species.default_genitals
	if(!LAZYLEN(genitals_possible))
		. = FALSE
	qdel(species)

/datum/preference/choiced/genitals/init_possible_values()
	. = list()
	for(var/thing in GLOB.genital_sets)
		. += thing

/datum/preference/choiced/genitals/apply_to_human(mob/living/carbon/human/target, value, datum/preferences/preferences)
	target.genitals = value
	for(var/obj/item/organ/genital/genital in target.internal_organs)
		qdel(genital)
	var/species_type = preferences.read_preference(/datum/preference/choiced/species)
	var/datum/species/species = new species_type()
	if(target.dna)
		target.dna.features["breasts_size"] = BREASTS_DEFAULT_SIZE
		target.dna.features["breasts_lactation"] = BREASTS_DEFAULT_LACTATION
		target.dna.features["penis_size"] = PENIS_DEFAULT_LENGTH
		target.dna.features["penis_girth"] = PENIS_DEFAULT_GIRTH
		target.dna.features["penis_sheath"] = SHEATH_NONE
		target.dna.features["penis_circumcised"] = FALSE
		target.dna.features["balls_size"] = BALLS_DEFAULT_SIZE
		target.dna.features["body_size"] = BODY_SIZE_NORMAL
		for(var/genital_key in list("breasts", "penis", "testicles", "vagina"))
			if(LAZYACCESSASSOC(species.default_mutant_bodyparts, genital_key, MUTANT_INDEX_NAME))
				target.dna.mutant_bodyparts[genital_key] = species.default_mutant_bodyparts[genital_key].Copy()
			else
				target.dna.mutant_bodyparts[genital_key] = list(MUTANT_INDEX_NAME = "None", \
																MUTANT_INDEX_COLOR = "#FFFFFF")
	for(var/genital_slot in GLOB.genital_sets[value])
		var/obj/item/organ/genital/genital =  species.default_genitals[genital_slot]
		if(!genital)
			return
		genital = new genital()
		target.dna.mutant_bodyparts[genital.mutantpart_key] = genital.mutantpart_info.Copy()
		if(!genital.Insert(target, FALSE))
			qdel(genital)
	qdel(species)
