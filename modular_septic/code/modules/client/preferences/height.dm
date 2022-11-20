/datum/preference/choiced/height
	category = PREFERENCE_CATEGORY_NON_CONTEXTUAL
	priority = PREFERENCE_PRIORITY_BODY_TYPE
	savefile_key = "height"
	savefile_identifier = PREFERENCE_CHARACTER

/datum/preference/choiced/height/init_possible_values()
	return list(capitalize_like_old_man(HUMAN_HEIGHT_SHORTEST), \
				capitalize_like_old_man(HUMAN_HEIGHT_SHORT), \
				capitalize_like_old_man(HUMAN_HEIGHT_MEDIUM), \
				capitalize_like_old_man(HUMAN_HEIGHT_TALL), \
				capitalize_like_old_man(HUMAN_HEIGHT_TALLEST))

/datum/preference/choiced/height/create_default_value()
	return capitalize_like_old_man(HUMAN_HEIGHT_MEDIUM)

/datum/preference/choiced/height/apply_to_human(mob/living/carbon/human/target, value)
	target.height = lowertext(value)
