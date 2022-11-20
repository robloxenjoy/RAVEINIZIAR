/datum/preference/toggle/mismatched_parts
	category = PREFERENCE_CATEGORY_NON_CONTEXTUAL
	savefile_identifier = PREFERENCE_CHARACTER
	savefile_key = "allow_mismatched_parts_toggle"
	priority = PREFERENCE_PRIORITY_MUTANT_COLORS
	can_randomize = FALSE
	default_value = FALSE

/datum/preference/toggle/mismatched_parts/create_default_value()
	return FALSE

/datum/preference/toggle/mismatched_parts/apply_to_human(mob/living/carbon/human/target, value, datum/preferences/preferences)
	return TRUE
