/datum/species/werewolf
	name = "Shibu"
	id = SPECIES_WEREWOLF
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
		/datum/quirk/congenial,
	)
	attribute_sheet = /datum/attribute_holder/sheet/werewolf
	inherent_biotypes = MOB_ORGANIC | MOB_HUMANOID | MOB_BEAST
	mutant_bodyparts = list()
	default_mutant_bodyparts = list(
		"tail" = ACC_RANDOM,
		"snout" = ACC_RANDOM,
		"ears" = ACC_RANDOM,
		"dick" = "Dick",
		"tits" = "Tits",
	)
	//knotted pp
	default_genitals = list(
		ORGAN_SLOT_PENIS = /obj/item/organ/genital/penis/knotted,
		ORGAN_SLOT_TESTICLES = /obj/item/organ/genital/testicles,
		ORGAN_SLOT_VAGINA = /obj/item/organ/genital/vagina,
		ORGAN_SLOT_WOMB = /obj/item/organ/genital/womb,
		ORGAN_SLOT_BREASTS = /obj/item/organ/genital/breasts,
		ORGAN_SLOT_ANUS = /obj/item/organ/genital/anus,
	)
	mutanttongue = /obj/item/organ/tongue/dog
	// Shibu are furred and can stand lower temperatures than humans
	heatmod = 1.5
	coldmod = 0.67
	bodytemp_heat_damage_limit = (BODYTEMP_HEAT_DAMAGE_LIMIT - 10)
	bodytemp_cold_damage_limit = (BODYTEMP_COLD_DAMAGE_LIMIT - 10)
	liked_food = RAW | MEAT
	disliked_food = GROSS | GRAIN | CLOTH | SEWAGE
	changesource_flags = MIRROR_BADMIN | WABBAJACK | MIRROR_MAGIC | MIRROR_PRIDE | ERT_SPAWN | RACE_SWAP | SLIME_EXTRACT
	say_mod = "growls"
	attack_verb = "slashes"
	attack_sharpness = SHARP_EDGED
	bite_sharpness = SHARP_EDGED
	limbs_icon = 'modular_septic/icons/mob/human/species/mammal/mammal_parts_greyscale.dmi'
	limbs_id = "mammal"
	examine_icon_state = "werewolf"

/datum/species/werewolf/get_random_features()
	var/list/returned = MANDATORY_FEATURE_LIST
	var/main_color
	var/second_color
	var/random = rand(1,5)
	//Choose from a variety of mostly brightish, animal, matching colors
	switch(random)
		if(1)
			main_color = "FFAA00"
			second_color = "FFDD44"
		if(2)
			main_color = "FF8833"
			second_color = "FFAA33"
		if(3)
			main_color = "FFCC22"
			second_color = "FFDD88"
		if(4)
			main_color = "FF8800"
			second_color = "FFFFFF"
		if(5)
			main_color = "999999"
			second_color = "EEEEEE"
	returned["mcolor"] = main_color
	returned["mcolor2"] = second_color
	returned["mcolor3"] = second_color
	return returned

/datum/species/werewolf/get_random_body_markings(list/passed_features)
	var/name = pick("Wolf", "Fox", "Floof", "Floofer")
	var/datum/body_marking_set/body_marking_set = GLOB.body_marking_sets[name]
	var/list/markings = list()
	if(body_marking_set)
		markings = assemble_body_markings_from_set(body_marking_set, passed_features, src)
	return markings

/datum/species/werewolf/random_name(gender,unique,lastname)
	var/randname
	if(gender != FEMALE)
		randname = pick(GLOB.first_names_male_werewolf)
	else
		randname = pick(GLOB.first_names_female_werewolf)

	if(lastname)
		randname += " [lastname]"
	else
		randname += " [pick(GLOB.last_names_werewolf)]"

	return randname
