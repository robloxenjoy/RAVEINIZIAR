/obj/item/clothing/suit/hooded/labcoat/podpol/robe/chaotic
	name = "Robe"
	desc = "Chaotic Robe."
	icon = 'modular_pod/icons/obj/clothing/suits.dmi'
	icon_state = "robechaotic"
	worn_icon = 'modular_pod/icons/mob/clothing/suit.dmi'
	worn_icon_state = "robechaotic"
	inhand_icon_state = "robechaotic"
	blood_overlay_type = "coat"
	mutant_variants = NONE
	body_parts_covered = NECK|CHEST|VITALS|GROIN|ARMS|LEGS
	cold_protection = NECK|CHEST|VITALS|GROIN|ARMS|LEGS
	min_cold_protection_temperature = FIRE_SUIT_MIN_TEMP_PROTECT
	hoodtype = /obj/item/clothing/head/hooded/robechaotichood
	subarmor = list(SUBARMOR_FLAGS = SUBARMOR_FLEXIBLE, \
				EDGE_PROTECTION = 2, \
				CRUSHING = 2, \
				CUTTING = 2, \
				PIERCING = 2, \
				IMPALING = 2, \
				LASER = 1, \
				ENERGY = 15, \
				BOMB = 2, \
				BIO = 15, \
				FIRE = 1, \
				ACID = 5, \
				MAGIC = 50, \
				WOUND = 1, \
				ORGAN = 1)
	strip_delay = 50
	equip_delay_other = 50
	carry_weight = 700 GRAMS
	allowed = list(
		/obj/item/analyzer,
		/obj/item/biopsy_tool,
		/obj/item/dnainjector,
		/obj/item/flashlight/pen,
		/obj/item/healthanalyzer,
		/obj/item/paper,
		/obj/item/reagent_containers/dropper,
		/obj/item/reagent_containers/glass/beaker,
		/obj/item/reagent_containers/glass/bottle,
		/obj/item/reagent_containers/hypospray,
		/obj/item/reagent_containers/pill,
		/obj/item/reagent_containers/syringe,
		/obj/item/gun/syringe,
		/obj/item/sensor_device,
		/obj/item/soap,
		/obj/item/stack/medical,
		/obj/item/storage/pill_bottle,
		/obj/item/tank/internals/emergency_oxygen,
		/obj/item/tank/internals/plasmaman,
		)

/obj/item/clothing/head/hooded/robechaotichood
	name = "Chaotic Hood"
	desc = "CHAOS."
	icon = 'icons/obj/clothing/head/winterhood.dmi'
	icon_state = "hood_chaotic"
	worn_icon = 'icons/mob/clothing/head/winterhood.dmi'
	worn_icon_state = "hood_chaotic"
	body_parts_covered = HEAD
	cold_protection = HEAD
	min_cold_protection_temperature = FIRE_SUIT_MIN_TEMP_PROTECT
	flags_inv = HIDEHAIR|HIDEEARS
	armor = list(MELEE = 2, BULLET = 2, LASER = 0, ENERGY = 0, BOMB = 0, BIO = 10, FIRE = 1, ACID = 5)
/*
/obj/item/clothing/suit/toggle/labcoat/science
	icon_state = "labcoat"

/obj/item/clothing/suit/toggle/labcoat/cmo
	name = "medical labcoat"
	desc = "Bluer than the standard model."
	icon_state = "labcoat_cmo"
	worn_icon_state = "labcoat_cmo"
*/
