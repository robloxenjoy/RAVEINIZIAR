// Skin tone toggle
/datum/preference/toggle/skin_tone
	category = PREFERENCE_CATEGORY_NON_CONTEXTUAL
	savefile_identifier = PREFERENCE_CHARACTER
	savefile_key = "skin_tone_toggle"
	priority = PREFERENCE_PRIORITY_SKINTONES_TOGGLE
	can_randomize = FALSE
	default_value = FALSE

/datum/preference/toggle/skin_tone/is_accessible(datum/preferences/preferences)
	. = ..()
	if(!.)
		return FALSE
	var/datum/species/species_type = preferences.read_preference(/datum/preference/choiced/species)
	return initial(species_type.use_skintones)

/datum/preference/toggle/skin_tone/create_informed_default_value(datum/preferences/preferences)
	var/datum/species/species_type = preferences.read_preference(/datum/preference/choiced/species)
	return initial(species_type.use_skintones)

/datum/preference/toggle/skin_tone/apply_to_human(mob/living/carbon/human/target, value, datum/preferences/preferences)
	target.dna.features["uses_skintones"] = value

//Skin tone type
/datum/preference/choiced/skin_tone
	priority = PREFERENCE_PRIORITY_SKINTONES

/datum/preference/choiced/skin_tone/apply_to_human(mob/living/carbon/human/target, value)
	target.skin_tone = value
