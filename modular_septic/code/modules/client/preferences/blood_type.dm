/datum/preference/choiced/blood_type
	category = PREFERENCE_CATEGORY_NON_CONTEXTUAL
	priority = PREFERENCE_PRIORITY_SKINTONES
	savefile_key = "blood_type"
	savefile_identifier = PREFERENCE_CHARACTER

/datum/preference/choiced/blood_type/is_accessible(datum/preferences/preferences)
	. = ..()
	var/species_type = preferences.read_preference(/datum/preference/choiced/species)
	var/datum/species/species = species_type
	if(initial(species.exotic_bloodtype))
		. = FALSE

/datum/preference/choiced/blood_type/init_possible_values()
	return list("A+", "A-", "B+", "B-", "AB+", "AB-", "O+", "O-")

/datum/preference/choiced/blood_type/apply_to_human(mob/living/carbon/human/target, value)
	target.dna?.blood_type = value
