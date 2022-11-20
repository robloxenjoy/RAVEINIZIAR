/obj/item/clothing/suit/armor/kelzad
	name = "Type IV armored suit"
	desc = "A type IV armored suit for usage against entire rooms full of armored operatives. Manufactured by ITOBE."
	icon = 'modular_septic/icons/obj/clothing/itobe.dmi'
	icon_state = "karmor"
	worn_icon = 'modular_septic/icons/mob/clothing/suit.dmi'
	worn_icon_state = "karmor"
	lefthand_file = 'modular_septic/icons/mob/inhands/clothing/clothing_lefthand.dmi'
	righthand_file = 'modular_septic/icons/mob/inhands/clothing/clothing_righthand.dmi'
	inhand_icon_state = "karmor"
	armor_broken_sound = "heavy"
	armor_damaged_sound = "heavy"
	max_integrity = 600
	integrity_failure = 0.05
	limb_integrity = 500
	repairable_by = /obj/item/stack/ballistic
	subarmor = list(SUBARMOR_FLAGS = NONE, \
                EDGE_PROTECTION = 75, \
                CRUSHING = 30, \
                CUTTING = 30, \
                PIERCING = 60, \
                IMPALING = 30, \
                LASER = 1, \
                ENERGY = 0, \
                BOMB = 60, \
                BIO = 0, \
                FIRE = 2, \
                ACID = 2, \
                MAGIC = 0, \
                WOUND = 0, \
                ORGAN = 0)
	//Kelzad Enjoyers
	carry_weight = 8 KILOGRAMS
	body_parts_covered = CHEST|GROIN|LEGS|FEET|ARMS|VITALS
