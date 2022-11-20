/obj/item/clothing/suit/armor/vest/alt/discrete
	name = "discrete armor vest"
	desc = "A discrete armor vest for when you don't want to scare the children. \
			Fake muscles not included."
	icon_state = "discrete"
	worn_icon_state = "discrete"
	body_parts_covered = CHEST|GROIN|VITALS
	custom_materials = list(/datum/material/iron = 1000, \
						/datum/material/titanium = 250,
						/datum/material/plastic = 500)

/obj/item/clothing/suit/armor/vest/alt/ordinator
	name = "ordinator's roman vest"
	desc = "An ordinator's standard issue ballistic armor vest. \
			Fake muscles included, to give the impression of strength where there is none."
	icon_state = "ordinatorvest"
	worn_icon_state = "ordinatorvest"
	body_parts_covered = CHEST|GROIN|VITALS
	custom_materials = list(/datum/material/iron = 1000, \
						/datum/material/titanium = 250, \
						/datum/material/plastic = 500)

/obj/item/clothing/suit/armor/vest/alt/ordinator/coordinator
	name = "\proper coordinator's roman vest"
	desc = "A coordinator's armor vest. \
			Pretty, but not gold plated - it's just cheap paint made out of \
			fine yellow metallic particles suspended in a medium such as gum, glycerine, acrylic etc."
	icon_state = "coordinatorvest"
	worn_icon_state = "coordinatorvest"
	body_parts_covered = CHEST|GROIN|VITALS
	custom_materials = list(/datum/material/gold = 10, \
						/datum/material/iron = 1000, \
						/datum/material/titanium = 250, \
						/datum/material/plastic = 500)

/obj/item/clothing/suit/armor/vest/alt/bobby
	name = "bobby coat"
	desc = "A dark armored leather coat."
	icon = 'modular_septic/icons/obj/clothing/suits.dmi'
	icon_state = "bobby_coat"
	worn_icon = 'modular_septic/icons/mob/clothing/suit.dmi'
	worn_icon_state = "bobby_coat"
	lefthand_file = 'modular_septic/icons/mob/inhands/clothing/clothing_lefthand.dmi'
	righthand_file = 'modular_septic/icons/mob/inhands/clothing/clothing_righthand.dmi'
	inhand_icon_state = "ordinator_cloak"
	blood_overlay_type = "coat"
	subarmor = list(SUBARMOR_FLAGS = SUBARMOR_FLEXIBLE, \
				EDGE_PROTECTION = 25, \
				CRUSHING = 9, \
				CUTTING = 13, \
				PIERCING = 24, \
				IMPALING = 5, \
				LASER = 1, \
				ENERGY = 0, \
				BOMB = 8, \
				BIO = 0, \
				FIRE = 2, \
				ACID = 2, \
				MAGIC = 0, \
				WOUND = 0, \
				ORGAN = 0)
	body_parts_covered = NECK|CHEST|VITALS|GROIN|ARMS
	cold_protection = NECK|CHEST|VITALS|GROIN|ARMS
	heat_protection = NECK|CHEST|VITALS|GROIN|ARMS
	mutant_variants = NONE
	carry_weight = 7 KILOGRAMS

/obj/item/clothing/suit/armor/vest/alt/bobby/constable
	name = "\proper constable's coat"
	desc = "A dark armored leather coat."
	subarmor = list(SUBARMOR_FLAGS = SUBARMOR_FLEXIBLE, \
				EDGE_PROTECTION = 30, \
				CRUSHING = 11, \
				CUTTING = 15, \
				PIERCING = 28, \
				IMPALING = 6, \
				LASER = 2, \
				ENERGY = 0, \
				BOMB = 10, \
				BIO = 0, \
				FIRE = 2, \
				ACID = 2, \
				MAGIC = 0, \
				WOUND = 0, \
				ORGAN = 0)
	carry_weight = 8 KILOGRAMS
