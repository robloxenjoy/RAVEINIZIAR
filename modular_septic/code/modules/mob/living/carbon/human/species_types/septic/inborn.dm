/datum/species/inborn
	name = "INBORN"
	id = SPECIES_INBORN
	default_color = "4B4B4B"
	sexes = FALSE
	species_traits = list(
		AGENDER,
        NOEYESPRITES,
	)
	inherent_traits = list(
		TRAIT_ADVANCEDTOOLUSER,
		TRAIT_CAN_STRIP,
		TRAIT_FLUORIDE_STARE,
	)
	attribute_sheet = /datum/attribute_holder/sheet/job/inborn
	inherent_biotypes = MOB_ORGANIC | MOB_BEAST
	mutant_bodyparts = list()
	heatmod = 4
	coldmod = 0
	liked_food = RAW | MEAT | SEWAGE
	disliked_food = VEGETABLES
	changesource_flags = MIRROR_BADMIN | WABBAJACK | MIRROR_MAGIC | MIRROR_PRIDE | ERT_SPAWN | RACE_SWAP | SLIME_EXTRACT
	say_mod = "berates"
	attack_verb = "slashes"
	bite_sharpness = SHARP_POINTY
	limbs_icon = 'modular_septic/icons/mob/human/species/human/creepypasta_parts.dmi'
	limbs_id = "human"
	examine_icon_state = "inborn"

/datum/species/weakwillet
	name = "WEAK WILLET"
	id = SPECIES_WEAKWILLET
	default_color = "#4B4B4B"
	sexes = FALSE
	species_traits = list(
		AGENDER,
		NOEYESPRITES,
	)
	inherent_traits = list(
		TRAIT_ADVANCEDTOOLUSER,
		TRAIT_CAN_STRIP,
		TRAIT_FLUORIDE_STARE,
	)
	attribute_sheet = /datum/attribute_holder/sheet/job/weakwillet
	inherent_biotypes = MOB_ORGANIC | MOB_BEAST
	mutant_bodyparts = list()
	mutantspleen = /obj/item/organ/spleen/vilir
	heatmod = 4
	coldmod = 0
	liked_food = RAW | MEAT | SEWAGE
	disliked_food = VEGETABLES
	changesource_flags = MIRROR_BADMIN | WABBAJACK | MIRROR_MAGIC | MIRROR_PRIDE | ERT_SPAWN | RACE_SWAP | SLIME_EXTRACT
	say_mod = "chaotises"
	attack_verb = "flouts"
	bite_sharpness = SHARP_POINTY
	attack_sharpness = NONE
	limbs_icon = 'modular_septic/icons/mob/human/species/human/weak_parts.dmi'
	limbs_id = "human"
	examine_icon_state = "willetweak"

/datum/species/halbermensch
	name = "Halbermensch"
	id = SPECIES_HALBERMENSCH
	default_color = "#ff6a00"
	sexes = FALSE
	species_traits = list(
		NO_UNDERWEAR,
		AGENDER,
		NOEYESPRITES,
	)
	inherent_traits = list(
		TRAIT_ADVANCEDTOOLUSER,
		TRAIT_CAN_STRIP,
		TRAIT_CHUNKYFINGERS,
		TRAIT_FLUORIDE_STARE,
		TRAIT_DEPRESSION,
		TRAIT_INSANITY,
	)
	no_equip = list(ITEM_SLOT_LEAR,
					ITEM_SLOT_REAR,
					ITEM_SLOT_MASK,
					ITEM_SLOT_HEAD,
					ITEM_SLOT_EYES,
					ITEM_SLOT_NECK,
					ITEM_SLOT_OCLOTHING,
					ITEM_SLOT_BELT,
					ITEM_SLOT_ID,
					ITEM_SLOT_GLOVES,
					ITEM_SLOT_WRISTS,
					ITEM_SLOT_FEET,
					ITEM_SLOT_ICLOTHING,
					ITEM_SLOT_OVERSUIT,
					ITEM_SLOT_PANTS,
					ITEM_SLOT_SUITSTORE)
	attribute_sheet = /datum/attribute_holder/sheet/job/halbermensch
	inherent_biotypes = MOB_ORGANIC | MOB_BEAST
	mutant_bodyparts = list()
	bodypart_overides = list(
		BODY_ZONE_L_ARM = /obj/item/bodypart/l_arm/halber,
		BODY_ZONE_PRECISE_L_HAND = /obj/item/bodypart/l_hand/halber,
		BODY_ZONE_R_ARM = /obj/item/bodypart/r_arm/halber,
		BODY_ZONE_PRECISE_R_HAND = /obj/item/bodypart/r_hand/halber,
		BODY_ZONE_PRECISE_L_EYE = /obj/item/bodypart/l_eyelid/halber,
		BODY_ZONE_PRECISE_R_EYE = /obj/item/bodypart/r_eyelid/halber,
		BODY_ZONE_PRECISE_FACE = /obj/item/bodypart/face/halber,
		BODY_ZONE_PRECISE_MOUTH = /obj/item/bodypart/mouth/halber,
		BODY_ZONE_PRECISE_NECK = /obj/item/bodypart/neck/halber,
		BODY_ZONE_HEAD = /obj/item/bodypart/head/halber,
		BODY_ZONE_L_LEG = /obj/item/bodypart/l_leg/halber,
		BODY_ZONE_PRECISE_L_FOOT = /obj/item/bodypart/l_foot/halber,
		BODY_ZONE_R_LEG = /obj/item/bodypart/r_leg/halber,
		BODY_ZONE_PRECISE_R_FOOT = /obj/item/bodypart/r_foot/halber,
		BODY_ZONE_PRECISE_GROIN = /obj/item/bodypart/groin/halber,
		BODY_ZONE_PRECISE_VITALS = /obj/item/bodypart/vitals/halber,
		BODY_ZONE_CHEST = /obj/item/bodypart/chest/halber,
	)
	mutantspleen = /obj/item/organ/spleen/halber
	mutantbrain = /obj/item/organ/brain/halber
	mutantlungs = /obj/item/organ/lungs/halber
	mutantvocal = /obj/item/organ/vocal_cords/halber
	mutantstomach = /obj/item/organ/stomach/halber
	mutantliver = /obj/item/organ/liver/halber
	mutantkidneys = /obj/item/organ/kidneys/halber
	mutantheart = /obj/item/organ/heart/halber
	armor = 5
	punchdamagelow = 5
	punchdamagehigh = 14
	liked_food = MEAT | RAW
	changesource_flags = MIRROR_BADMIN | WABBAJACK | MIRROR_MAGIC | MIRROR_PRIDE | ERT_SPAWN | RACE_SWAP | SLIME_EXTRACT
	say_mod = "defigures"
	attack_verb = "crashes"
	bite_sharpness = SHARP_POINTY
	attack_sharpness = NONE
	limbs_icon = 'modular_pod/icons/mob/human/species/human/halbermensch_parts.dmi'
	limbs_id = "halbermensch"
	examine_icon_state = "halbermensch"
	damage_overlay_type = ""

/datum/species/pighuman
	name = "Pighuman"
	id = SPECIES_PIGHUMAN
	default_color = "4B4B4B"
	species_traits = list(
		EYECOLOR,
		LIPS,
		HAS_FLESH,
		HAS_BONE,
	)
	inherent_traits = list(
		TRAIT_ADVANCEDTOOLUSER,
		TRAIT_CAN_STRIP,
	)
	inherent_quirks = list(
		/datum/quirk/voracious,
	)
	attribute_sheet = /datum/attribute_holder/sheet/pighuman
	inherent_biotypes = MOB_ORGANIC | MOB_HUMANOID | MOB_BEAST
	mutant_bodyparts = list()
	default_mutant_bodyparts = list(
		"snout" = "Piglet",
		"ears" = "Pig Ears",
	)
	default_genitals = list(
		ORGAN_SLOT_PENIS = /obj/item/organ/genital/penis/knotted/barbed,
		ORGAN_SLOT_TESTICLES = /obj/item/organ/genital/testicles,
		ORGAN_SLOT_VAGINA = /obj/item/organ/genital/vagina,
		ORGAN_SLOT_WOMB = /obj/item/organ/genital/womb,
		ORGAN_SLOT_BREASTS = /obj/item/organ/genital/breasts/sextuple,
		ORGAN_SLOT_ANUS = /obj/item/organ/genital/anus,
	)
//	mutanttongue = /obj/item/organ/tongue/pig
	speedmod = 2
	heatmod = 1.2
	coldmod = 0.5
	bodytemp_heat_damage_limit = (BODYTEMP_HEAT_DAMAGE_LIMIT - 10)
	bodytemp_cold_damage_limit = (BODYTEMP_COLD_DAMAGE_LIMIT - 10)
	liked_food = RAW | MEAT | GROSS | GRAIN | SEWAGE
	disliked_food = CLOTH
	changesource_flags = MIRROR_BADMIN | WABBAJACK | MIRROR_MAGIC | MIRROR_PRIDE | ERT_SPAWN | RACE_SWAP | SLIME_EXTRACT
	say_mod = "oinks"
	attack_verb = "beats"
	attack_sharpness = NONE
	bite_sharpness = SHARP_EDGED
//	species_language_holder = /datum/language/yoinky
	limbs_icon = 'modular_pod/icons/mob/human/species/pighuman/pighuman_parts.dmi'
	limbs_id = "pighuman"
	examine_icon_state = "pighuman"