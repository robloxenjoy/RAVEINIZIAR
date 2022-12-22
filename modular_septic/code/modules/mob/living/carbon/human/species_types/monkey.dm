/datum/species/monkey
	bodypart_overides = list(
		BODY_ZONE_L_ARM = /obj/item/bodypart/l_arm/monkey,
		BODY_ZONE_PRECISE_L_HAND = /obj/item/bodypart/l_hand/monkey,
		BODY_ZONE_R_ARM = /obj/item/bodypart/r_arm/monkey,
		BODY_ZONE_PRECISE_R_HAND = /obj/item/bodypart/r_hand/monkey,
		BODY_ZONE_PRECISE_L_EYE = /obj/item/bodypart/l_eyelid/monkey,
		BODY_ZONE_PRECISE_R_EYE = /obj/item/bodypart/r_eyelid/monkey,
		BODY_ZONE_PRECISE_FACE = /obj/item/bodypart/face/monkey,
		BODY_ZONE_PRECISE_MOUTH = /obj/item/bodypart/mouth/monkey,
		BODY_ZONE_PRECISE_NECK = /obj/item/bodypart/neck/monkey,
		BODY_ZONE_HEAD = /obj/item/bodypart/head/monkey,
		BODY_ZONE_L_LEG = /obj/item/bodypart/l_leg/monkey,
		BODY_ZONE_PRECISE_L_FOOT = /obj/item/bodypart/l_foot/monkey,
		BODY_ZONE_R_LEG = /obj/item/bodypart/r_leg/monkey,
		BODY_ZONE_PRECISE_R_FOOT = /obj/item/bodypart/r_foot/monkey,
		BODY_ZONE_PRECISE_GROIN = /obj/item/bodypart/groin/monkey,
		BODY_ZONE_PRECISE_VITALS = /obj/item/bodypart/vitals/monkey,
		BODY_ZONE_CHEST = /obj/item/bodypart/chest/monkey,
	)
	no_equip = list(ITEM_SLOT_LEAR, \
					ITEM_SLOT_REAR, \
					ITEM_SLOT_EYES, \
					ITEM_SLOT_OCLOTHING, \
					ITEM_SLOT_GLOVES, \
					ITEM_SLOT_WRISTS,
					ITEM_SLOT_FEET, \
					ITEM_SLOT_ICLOTHING, \
					ITEM_SLOT_SUITSTORE)
	mutant_organs = list()
	mutant_bodyparts = list()
	limbs_icon = 'modular_septic/icons/mob/human/species/monkey/monkey_parts.dmi'
	limbs_id = "monkey"
	examine_icon_state = "monkey"
