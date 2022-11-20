/mob/living/carbon/human/dummy
	num_hands = 2
	num_legs = 4
	num_eyes = 2
	attributes = null

/mob/living/carbon/human/dummy/Initialize(mapload)
	. = ..()
	if(dna)
		dna.features["breasts_size"] = BREASTS_DEFAULT_SIZE
		dna.features["breasts_lactation"] = BREASTS_DEFAULT_LACTATION
		dna.features["penis_size"] = PENIS_DEFAULT_LENGTH
		dna.features["penis_girth"] = PENIS_DEFAULT_GIRTH
		dna.features["penis_sheath"] = SHEATH_NONE
		dna.features["penis_circumcised"] = FALSE
		dna.features["balls_size"] = BALLS_DEFAULT_SIZE
		dna.features["body_size"] = BODY_SIZE_NORMAL
		dna.features["uses_skintones"] = FALSE

/mob/living/carbon/human/dummy/update_smelly()
	return

/mob/living/carbon/human/dummy/set_usable_legs(new_value)
	return

/mob/living/carbon/human/dummy/set_usable_hands(new_value)
	return

/mob/living/carbon/human/dummy/set_usable_eyes(new_value)
	return

/mob/living/carbon/human/dummy/set_num_legs(new_value)
	return

/mob/living/carbon/human/dummy/set_num_hands(new_value)
	return

/mob/living/carbon/human/dummy/set_num_legs(new_value)
	return

/mob/living/carbon/human/dummy/update_organ_requirements()
	return

/mob/living/carbon/human/dummy/update_limb_efficiencies()
	return
