/datum/species/moth
	name = "Lepidopterathrope"
	mutant_bodyparts = list()
	default_mutant_bodyparts = list(
		"wings" = ACC_RANDOM,
		"moth_antennae" = ACC_RANDOM,
		"moth_markings" = ACC_RANDOM,
	)
	inherent_biotypes = MOB_ORGANIC|MOB_HUMANOID|MOB_BUG|MOB_BEAST
	limbs_icon = 'modular_septic/icons/mob/human/species/insect/moth_parts_greyscale.dmi'
	limbs_id = "moth"
	attack_verb = "punch"
	attack_effect = ATTACK_EFFECT_PUNCH
	examine_icon_state = "weremoth"
