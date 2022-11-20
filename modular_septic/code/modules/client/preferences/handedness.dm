/datum/preference/choiced/handedness
	category = PREFERENCE_CATEGORY_NON_CONTEXTUAL
	priority = PREFERENCE_PRIORITY_BODY_TYPE
	savefile_key = "handedness"
	savefile_identifier = PREFERENCE_CHARACTER

/datum/preference/choiced/handedness/init_possible_values()
	return list("Right Handed", \
				"Left Handed", \
				"Poorly Ambidextrous")

/datum/preference/choiced/handedness/create_default_value()
	return "Right Handed"

/datum/preference/choiced/handedness/apply_to_human(mob/living/carbon/human/target, value)
	target.handed_flags = unparse_handedness(value)
