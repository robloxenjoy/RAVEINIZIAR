/obj/item/clothing/head/helmet/ordinator
	name = "conical steel helmet"
	desc = "A conical hat worn by the greatest dunces."
	icon = 'modular_septic/icons/obj/clothing/hats.dmi'
	icon_state = "ordinator_hat"
	worn_icon = 'modular_septic/icons/mob/clothing/head.dmi'
	worn_icon_state = "ordinator_hat"
	lefthand_file = 'modular_septic/icons/mob/inhands/clothing/clothing_lefthand.dmi'
	righthand_file = 'modular_septic/icons/mob/inhands/clothing/clothing_righthand.dmi'
	inhand_icon_state = "ordinator_hat"
	max_integrity = 40
	integrity_failure = 0.1
	limb_integrity = 40
	carry_weight = 3 KILOGRAMS
	armor = list(MELEE = 0, \
				BULLET = 0, \
				LASER = 0, \
				ENERGY = 0, \
				BOMB = 25, \
				BIO = 0, \
				FIRE = 50, \
				ACID = 50, \
				WOUND = 10)
	subarmor = list(SUBARMOR_FLAGS = NONE, \
                EDGE_PROTECTION = 25, \
                CRUSHING = 10, \
                CUTTING = 10, \
                PIERCING = 25, \
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
	custom_materials = list(/datum/material/iron = 1000, \
							/datum/material/titanium = 100)

/obj/item/clothing/head/helmet/bobby
	name = "bobby helmet"
	desc = "Protect and suffer crushing brain damage."
	icon = 'modular_septic/icons/obj/clothing/hats.dmi'
	icon_state = "bobby_hat"
	worn_icon = 'modular_septic/icons/mob/clothing/head.dmi'
	worn_icon_state = "bobby_hat"
	lefthand_file = 'modular_septic/icons/mob/inhands/clothing/clothing_lefthand.dmi'
	righthand_file = 'modular_septic/icons/mob/inhands/clothing/clothing_righthand.dmi'
	inhand_icon_state = "ordinator_hat"
	max_integrity = 40
	integrity_failure = 0.1
	limb_integrity = 40
	carry_weight = 3 KILOGRAMS
	armor = list(MELEE = 0, \
				BULLET = 0, \
				LASER = 0, \
				ENERGY = 0, \
				BOMB = 25, \
				BIO = 0, \
				FIRE = 50, \
				ACID = 50, \
				WOUND = 10)
	subarmor = list(SUBARMOR_FLAGS = NONE, \
                EDGE_PROTECTION = 25, \
                CRUSHING = 10, \
                CUTTING = 10, \
                PIERCING = 25, \
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
	custom_materials = list(/datum/material/iron = 1000, \
							/datum/material/titanium = 100)

/obj/item/clothing/head/helmet/bobby/constable
	name = "constable helmet"
	desc = "Protect and suffer crushing brain damage.\n\
			This one has the insignia of the South Wales police emblazoned on it."
	icon = 'modular_septic/icons/obj/clothing/hats.dmi'
	icon_state = "constable_hat"
	worn_icon = 'modular_septic/icons/mob/clothing/head.dmi'
	worn_icon_state = "constable_hat"
	lefthand_file = 'modular_septic/icons/mob/inhands/clothing/clothing_lefthand.dmi'
	righthand_file = 'modular_septic/icons/mob/inhands/clothing/clothing_righthand.dmi'
	inhand_icon_state = "ordinator_hat"
	max_integrity = 40
	integrity_failure = 0.1
	limb_integrity = 40
	carry_weight = 3 KILOGRAMS
	armor = list(MELEE = 0, \
				BULLET = 0, \
				LASER = 0, \
				ENERGY = 0, \
				BOMB = 25, \
				BIO = 0, \
				FIRE = 50, \
				ACID = 50, \
				WOUND = 10)
	subarmor = list(SUBARMOR_FLAGS = NONE, \
                EDGE_PROTECTION = 25, \
                CRUSHING = 10, \
                CUTTING = 10, \
                PIERCING = 25, \
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
	custom_materials = list(/datum/material/iron = 1000, \
							/datum/material/titanium = 100)

/obj/item/clothing/head/helmet/bobby/constable/desc_chaser(mob/user)
	. = list()
	var/image_src = image2html('modular_septic/images/southwalespolice.png', user, format = "png", sourceonly = TRUE)
	. += "<img src='[image_src]' width=96 height=96>"
	. += ..()
