/datum/preference/color/eye_color
	savefile_key = "left_eye_color"
	savefile_identifier = PREFERENCE_CHARACTER
	category = PREFERENCE_CATEGORY_SECONDARY_FEATURES
	relevant_species_trait = EYECOLOR

/datum/preference/color/eye_color/create_default_value()
	return random_color()

/datum/preference/color/eye_color/apply_to_human(mob/living/carbon/human/target, value, datum/preferences/preferences)
	target.left_eye_color = value
	for(var/obj/item/organ/eyes/eyes_organ in target.internal_organs)
		if(eyes_organ.side != LEFT_SIDE)
			continue
		if(!initial(eyes_organ.eye_color))
			eyes_organ.eye_color = value
		eyes_organ.old_eye_color = value

/datum/preference/color/eye_color/right
	savefile_key = "right_eye_color"
	savefile_identifier = PREFERENCE_CHARACTER
	category = PREFERENCE_CATEGORY_SECONDARY_FEATURES
	relevant_species_trait = EYECOLOR

/datum/preference/color/eye_color/right/create_default_value()
	return random_color()

/datum/preference/color/eye_color/right/apply_to_human(mob/living/carbon/human/target, value, datum/preferences/preferences)
	target.right_eye_color = value
	for(var/obj/item/organ/eyes/eyes_organ in target.internal_organs)
		if(eyes_organ.side != RIGHT_SIDE)
			continue
		if(!initial(eyes_organ.eye_color))
			eyes_organ.eye_color = value
		eyes_organ.old_eye_color = value
