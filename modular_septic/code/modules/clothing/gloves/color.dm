/obj/item/clothing/gloves/color/black
	icon = 'modular_septic/icons/obj/clothing/gloves.dmi'
	icon_state = "black"
	worn_icon = 'modular_septic/icons/mob/clothing/hands.dmi'
	worn_icon_state = "black"
	color = "#757575"

/obj/item/clothing/gloves/combat
	icon = 'modular_septic/icons/obj/clothing/gloves.dmi'
	icon_state = "combat"
	worn_icon = 'modular_septic/icons/mob/clothing/hands.dmi'
	worn_icon_state = "combat"

/obj/item/clothing/gloves/leathercool
	name = "Leather Gloves"
	desc = "Leather gloves. They can help you a little."
	icon = 'modular_septic/icons/obj/clothing/gloves.dmi'
	icon_state = "leather"
	worn_icon = 'modular_septic/icons/mob/clothing/hands.dmi'
	worn_icon_state = "leather"
	armor_broken_sound = "light"
	armor_damaged_sound = "light"
	max_integrity = 100
	integrity_failure = 0.1
	limb_integrity = 90
	repairable_by = /obj/item/stack/ballistic
	carry_weight = 800 GRAMS
	armor = null
	body_parts_covered = HANDS
	subarmor = list(SUBARMOR_FLAGS = SUBARMOR_FLEXIBLE, \
				EDGE_PROTECTION = 25, \
				CRUSHING = 5, \
				CUTTING = 20, \
				PIERCING = 25, \
				IMPALING = 5, \
				LASER = 5, \
				ENERGY = 0, \
				BOMB = 8, \
				BIO = 0, \
				FIRE = 2, \
				ACID = 2, \
				MAGIC = 0, \
				WOUND = 5, \
				ORGAN = 3)
	resistance_flags = FIRE_PROOF | ACID_PROOF

/obj/item/clothing/gloves/fingerless
		icon = 'modular_septic/icons/obj/clothing/gloves.dmi'
		icon_state = "ifingerless"
		worn_icon = 'modular_septic/icons/mob/clothing/hands.dmi'
		worn_icon_state = "fingerless"
