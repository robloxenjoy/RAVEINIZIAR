/datum/preference/choiced/body_type
	category = PREFERENCE_CATEGORY_NON_CONTEXTUAL
	priority = PREFERENCE_PRIORITY_BODY_TYPE
	savefile_key = "body_type"
	savefile_identifier = PREFERENCE_CHARACTER

/datum/preference/choiced/body_type/init_possible_values()
	return list(capitalize(BODY_TYPE_MASCULINE), capitalize(BODY_TYPE_FEMININE))

/datum/preference/choiced/body_type/create_informed_default_value(datum/preferences/preferences)
	var/gender = preferences?.read_preference(/datum/preference/choiced/gender)
	if(gender)
		if(gender == FEMALE)
			return capitalize(BODY_TYPE_FEMININE)
		else
			return capitalize(BODY_TYPE_MASCULINE)
	return pick(get_choices())

/datum/preference/choiced/body_type/apply_to_human(mob/living/carbon/human/target, value)
	target.body_type = lowertext(value)
