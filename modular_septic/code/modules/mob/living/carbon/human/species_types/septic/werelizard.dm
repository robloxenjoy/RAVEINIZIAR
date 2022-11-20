/datum/species/lizard
	name = "Iglaak"
	default_color = "D8FFCE"
	species_traits = list(
		MUTCOLORS,
		EYECOLOR,
		LIPS,
		HAS_FLESH,
		HAS_BONE,
		HAIR,
	)
	inherent_traits = list(
		TRAIT_ADVANCEDTOOLUSER,
		TRAIT_CAN_STRIP,
	)
	inherent_biotypes = MOB_ORGANIC | MOB_HUMANOID | MOB_BEAST | MOB_REPTILE
	mutant_bodyparts = list()
	mutant_organs = list()
	default_mutant_bodyparts = list(
		"tail" = "Smooth",
		"snout" = "Sharp",
		"spines" = ACC_RANDOM,
		"frills" = "None",
		"horns" = "None",
		"dick" = "Dick",
	)
	default_genitals = list(
		ORGAN_SLOT_PENIS = /obj/item/organ/genital/penis/hemi,
		ORGAN_SLOT_TESTICLES = /obj/item/organ/genital/testicles/internal,
		ORGAN_SLOT_VAGINA = /obj/item/organ/genital/vagina,
		ORGAN_SLOT_WOMB = /obj/item/organ/genital/womb,
		ORGAN_SLOT_ANUS = /obj/item/organ/genital/anus,
	)
	heatmod = 0.67
	coldmod = 1.5
	// Lizards are coldblooded and can stand greater temperatures than humans
	bodytemp_heat_damage_limit = (BODYTEMP_HEAT_DAMAGE_LIMIT + 10)
	bodytemp_cold_damage_limit = (BODYTEMP_COLD_DAMAGE_LIMIT + 10)
	liked_food = GROSS | RAW | MEAT | FRIED
	disliked_food = GRAIN | DAIRY | CLOTH | SEWAGE
	say_mod = "hisses"
	attack_verb = "slashes"
	attack_effect = ATTACK_EFFECT_PUNCH
	attack_sharpness = SHARP_EDGED
	bite_sharpness = SHARP_POINTY
	limbs_icon = 'modular_septic/icons/mob/human/species/lizard/lizard_parts_greyscale.dmi'
	limbs_id = "lizard"
	examine_icon_state = "werelizard"
