/datum/species/homie
	name = "Homie"
	id = SPECIES_HOMIE
	default_color = "FFFFFF"
	species_traits = list(HAS_FLESH,HAS_BONE)
	inherent_traits = list(
		TRAIT_ADVANCEDTOOLUSER,
		TRAIT_CAN_STRIP,
		TRAIT_CAN_USE_FLIGHT_POTION,
	)
	mutant_bodyparts = list()
	bodypart_overides = list(
		BODY_ZONE_L_ARM = /obj/item/bodypart/l_arm/homie,
		BODY_ZONE_PRECISE_L_HAND = /obj/item/bodypart/l_hand/homie,
		BODY_ZONE_R_ARM = /obj/item/bodypart/r_arm/homie,
		BODY_ZONE_PRECISE_R_HAND = /obj/item/bodypart/r_hand/homie,
		BODY_ZONE_PRECISE_L_EYE = /obj/item/bodypart/l_eyelid/homie,
		BODY_ZONE_PRECISE_R_EYE = /obj/item/bodypart/r_eyelid/homie,
		BODY_ZONE_PRECISE_FACE = /obj/item/bodypart/face/homie,
		BODY_ZONE_PRECISE_MOUTH = /obj/item/bodypart/mouth/homie,
		BODY_ZONE_PRECISE_NECK = /obj/item/bodypart/neck/homie,
		BODY_ZONE_HEAD = /obj/item/bodypart/head/homie,
		BODY_ZONE_L_LEG = /obj/item/bodypart/l_leg/homie,
		BODY_ZONE_PRECISE_L_FOOT = /obj/item/bodypart/l_foot/homie,
		BODY_ZONE_R_LEG = /obj/item/bodypart/r_leg/homie,
		BODY_ZONE_PRECISE_R_FOOT = /obj/item/bodypart/r_foot/homie,
		BODY_ZONE_PRECISE_GROIN = /obj/item/bodypart/groin/homie,
		BODY_ZONE_PRECISE_VITALS = /obj/item/bodypart/vitals/homie,
		BODY_ZONE_CHEST = /obj/item/bodypart/chest/homie,
	)
	no_equip = list(ITEM_SLOT_LEAR,
					ITEM_SLOT_REAR,
					ITEM_SLOT_EYES,
					ITEM_SLOT_NECK,
					ITEM_SLOT_OCLOTHING,
					ITEM_SLOT_BELT,
					ITEM_SLOT_GLOVES,
					ITEM_SLOT_WRISTS,
					ITEM_SLOT_FEET,
					ITEM_SLOT_ICLOTHING,
					ITEM_SLOT_SUITSTORE)
	skinned_type = /obj/item/stack/sheet/animalhide/human
	liked_food = RAW | MEAT | GROSS
	disliked_food = NUTS | CLOTH
	changesource_flags = MIRROR_BADMIN | WABBAJACK | MIRROR_MAGIC | MIRROR_PRIDE | RACE_SWAP
	limbs_id = "homie"
	examine_icon = 'modular_septic/icons/obj/items/deviouslick.dmi'
	examine_icon_state = "caucasian_homie"
	var/static/list/homie_types = list("caucasian", "nigger")
	var/homie_type = "caucasian"

/datum/species/homie/New()
	. = ..()
	homie_type = pick(homie_types)

/datum/species/homie/random_name(gender, unique, lastname = FALSE)
	return pick(GLOB.homie_names)

// Homies have a static sprite
/datum/species/homie/handle_body(mob/living/carbon/human/species_human)
	species_human.remove_overlay(BODY_LAYER)

/datum/species/homie/handle_mutant_bodyparts(mob/living/carbon/human/H, forced_colour, force_update)
	H.remove_overlay(BODY_BEHIND_LAYER)
	H.remove_overlay(BODY_ADJ_LAYER)
	H.remove_overlay(BODY_FRONT_LAYER)

/datum/species/homie/handle_bodyparts(mob/living/carbon/human/H)
	H.remove_overlay(BODYPARTS_LAYER)
	var/static/list/homie_images
	if(!homie_images)
		homie_images = list()
		for(var/homie_type in homie_types)
			var/image/homie_image = image('modular_septic/icons/obj/items/deviouslick.dmi', "[homie_type]_homie")
			homie_images[homie_type] = homie_image
	H.overlays_standing[BODYPARTS_LAYER] = homie_images[homie_type]
	H.apply_overlay(BODYPARTS_LAYER)

/datum/species/homie/handle_damage_overlays(mob/living/carbon/human/H)
	H.remove_overlay(DAMAGE_LAYER)
	H.remove_overlay(UPPER_DAMAGE_LAYER)

/datum/species/homie/handle_artery_overlays(mob/living/carbon/human/H)
	H.remove_overlay(ARTERY_LAYER)

/datum/species/homie/handle_medicine_overlays(mob/living/carbon/human/H)
	H.remove_overlay(LOWER_MEDICINE_LAYER)
	H.remove_overlay(UPPER_MEDICINE_LAYER)

/datum/species/homie/handle_hair(mob/living/carbon/human/H, forced_colour)
	H.remove_overlay(HAIR_LAYER)
