/obj/item/clothing/suit/hooded/medical
	name = "practitioner robes"
	desc = "Sterile robes often worn by the humorists of Nevado."
	icon = 'modular_septic/icons/obj/clothing/suits.dmi'
	icon_state = "medical_robes"
	worn_icon = 'modular_septic/icons/mob/clothing/suit.dmi'
	worn_icon_state = "medical_robes"
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
		/obj/item/sensor_device,
		/obj/item/soap,
		/obj/item/stack/medical,
		/obj/item/storage/pill_bottle,
		/obj/item/tank/internals/emergency_oxygen,
		/obj/item/tank/internals/plasmaman,
		/obj/item/melee/baton/telescopic,
		)
	body_parts_covered = NECK|CHEST|GROIN|ARMS|LEGS|VITALS
	cold_protection = NECK|CHEST|GROIN|ARMS|LEGS|VITALS
	heat_protection = NECK|CHEST|GROIN|ARMS|LEGS|VITALS
	mutant_variants = NONE
	armor = list(MELEE = 0, BULLET = 0, LASER = 0, ENERGY = 0, BOMB = 0, BIO = 50, FIRE = 50, ACID = 50)
	hoodtype = /obj/item/clothing/head/hooded/medical
	species_exception = list(/datum/species/golem)

/obj/item/clothing/suit/hooded/medical/cmo
	name = "hippocrite's robes"
	desc = "Robes worn by a true hypocrite."
	hoodtype = /obj/item/clothing/head/hooded/medical/cmo
