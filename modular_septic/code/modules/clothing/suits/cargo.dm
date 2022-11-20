//freighter coat
/obj/item/clothing/suit/cargo
	name = "\improper freighter coat"
	desc = "I like trains."
	icon = 'modular_septic/icons/obj/clothing/suits.dmi'
	icon_state = "freighter_coat"
	worn_icon = 'modular_septic/icons/mob/clothing/suit.dmi'
	worn_icon_state = "freighter_coat"
	inhand_icon_state = "lawyer_blue"
	blood_overlay_type = "coat"
	subarmor = list(SUBARMOR_FLAGS = SUBARMOR_FLEXIBLE, \
                EDGE_PROTECTION = 8, \
                CRUSHING = 5, \
                CUTTING = 5, \
                PIERCING = 5, \
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
	body_parts_covered = NECK|CHEST|GROIN|ARMS|VITALS
	cold_protection = NECK|CHEST|GROIN|ARMS|VITALS
	heat_protection = NECK|CHEST|GROIN|ARMS|VITALS
	mutant_variants = NONE

//postal coat
/obj/item/clothing/suit/cargo/postal
	name = "\improper black trenchcoat"
	desc = "Sign the petition, damn it."
	icon_state = "dude_jacket"
	worn_icon_state = "dude_jacket"
	subarmor = list(SUBARMOR_FLAGS = SUBARMOR_FLEXIBLE, \
                EDGE_PROTECTION = 8, \
                CRUSHING = 5, \
                CUTTING = 5, \
                PIERCING = 5, \
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
	body_parts_covered = NECK|CHEST|GROIN|LEGS|ARMS|VITALS
	cold_protection = NECK|CHEST|GROIN|LEGS|ARMS|VITALS
	heat_protection = NECK|CHEST|GROIN|LEGS|ARMS|VITALS

//merchant coat
/obj/item/clothing/suit/cargo/merchant
	name = "\proper merchant's coat"
	desc = "What are ya buying? Hehehe! Thank you."
	icon = 'modular_septic/icons/obj/clothing/suits.dmi'
	icon_state = "merchant_coat"
	worn_icon = 'modular_septic/icons/mob/clothing/suit.dmi'
	worn_icon_state = "merchant_coat"
	inhand_icon_state = "brownjsuit"
	subarmor = list(SUBARMOR_FLAGS = SUBARMOR_FLEXIBLE, \
                EDGE_PROTECTION = 8, \
                CRUSHING = 5, \
                CUTTING = 5, \
                PIERCING = 5, \
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
	body_parts_covered = NECK|CHEST|GROIN|ARMS|VITALS
	cold_protection = NECK|CHEST|GROIN|ARMS|VITALS
	heat_protection = NECK|CHEST|GROIN|ARMS|VITALS
