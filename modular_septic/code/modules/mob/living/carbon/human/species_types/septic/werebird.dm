/datum/species/werebird
	name = "Parotin"
	id = SPECIES_WEREBIRD
	default_color = "4B4B4B"
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
	inherent_quirks = list(
		/datum/quirk/glass_bones,
	)
	attribute_sheet = /datum/attribute_holder/sheet/werebird
	inherent_biotypes = MOB_ORGANIC | MOB_HUMANOID | MOB_BEAST
	mutant_bodyparts = list()
	default_mutant_bodyparts = list(
		"snout" = "Beak",
		"tail" = "Hawk",
		"wings" = "Feathery (alt 1)"
	)
	//barbed, knotted pp
	default_genitals = list(
		ORGAN_SLOT_PENIS = /obj/item/organ/genital/penis/hemi,
		ORGAN_SLOT_TESTICLES = /obj/item/organ/genital/testicles,
		ORGAN_SLOT_VAGINA = /obj/item/organ/genital/vagina,
		ORGAN_SLOT_WOMB = /obj/item/organ/genital/womb,
		ORGAN_SLOT_BREASTS = /obj/item/organ/genital/breasts,
		ORGAN_SLOT_ANUS = /obj/item/organ/genital/anus,
	)
	// Parotin are feathered and can stand lower temperatures than humans
	heatmod = 2
	coldmod = 0.5
	bodytemp_heat_damage_limit = (BODYTEMP_HEAT_DAMAGE_LIMIT - 10)
	bodytemp_cold_damage_limit = (BODYTEMP_COLD_DAMAGE_LIMIT - 10)
	liked_food = GRAIN | FRUIT | SEAFOOD | NUTS
	disliked_food = JUNKFOOD | DAIRY | CLOTH | SEWAGE
	changesource_flags = MIRROR_BADMIN | WABBAJACK | MIRROR_MAGIC | MIRROR_PRIDE | ERT_SPAWN | RACE_SWAP | SLIME_EXTRACT
	say_mod = "chirps"
	attack_verb = "slashes"
	attack_sharpness = SHARP_EDGED
	bite_sharpness = SHARP_POINTY
	limbs_icon = 'modular_septic/icons/mob/human/species/mammal/mammal_parts_greyscale.dmi'
	limbs_id = "mammal"
	examine_icon_state = "werebird"

/datum/species/werebird/get_random_features()
	var/list/returned = MANDATORY_FEATURE_LIST
	returned["mcolor"] = random_color()
	returned["mcolor2"] = random_color()
	returned["mcolor3"] = random_color()
	return returned

/datum/species/werebird/get_random_body_markings(list/passed_features)
	var/name = pick("Werecat", "Floof", "Floofer")
	var/datum/body_marking_set/body_marking_set = GLOB.body_marking_sets[name]
	var/list/markings = list()
	if(body_marking_set)
		markings = assemble_body_markings_from_set(body_marking_set, passed_features, src)
	return markings

/datum/species/werebird/random_name(gender,unique,lastname)
	var/randname
	if(gender != FEMALE)
		randname = pick(GLOB.first_names_male_werebird)
	else
		randname = pick(GLOB.first_names_female_werebird)

	if(lastname)
		randname += " [lastname]"
	else
		randname += " [pick(GLOB.last_names_werebird)]"

	return randname
