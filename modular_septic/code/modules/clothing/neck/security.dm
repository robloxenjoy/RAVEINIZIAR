/obj/item/clothing/neck/ordinator
	name = "\proper ordinator's cloak"
	desc = "A dark cloak. One could argue that it's style over substance."
	icon = 'modular_septic/icons/obj/clothing/neck.dmi'
	icon_state = "ordinator_cloak"
	worn_icon = 'modular_septic/icons/mob/clothing/neck.dmi'
	worn_icon_state = "ordinator_cloak"
	lefthand_file = 'modular_septic/icons/mob/inhands/clothing/clothing_lefthand.dmi'
	righthand_file = 'modular_septic/icons/mob/inhands/clothing/clothing_righthand.dmi'
	inhand_icon_state = "ordinator_cloak"
	strip_delay = 20
	body_parts_covered = NECK|CHEST|ARMS
	cold_protection = NECK|CHEST|ARMS
	heat_protection = NECK|CHEST|ARMS
	armor = list(MELEE = 0, \
				BULLET = 0, \
				LASER = 0, \
				ENERGY = 10, \
				BOMB = 0, \
				BIO = 0, \
				FIRE = 25, \
				ACID = 50, \
				WOUND = 0)
	custom_materials = list(/datum/material/iron = 500, \
						/datum/material/plastic = 1000)

/obj/item/clothing/neck/ordinator/coordinator
	name = "\proper coordinator's cloak"
	desc = "A dark cloak with gold trimmings. Truly, attire worthy of a dictator."
	icon = 'modular_septic/icons/obj/clothing/neck.dmi'
	icon_state = "coordinator_cloak"
	worn_icon = 'modular_septic/icons/mob/clothing/neck.dmi'
	worn_icon_state = "coordinator_cloak"
	lefthand_file = 'modular_septic/icons/mob/inhands/clothing/clothing_lefthand.dmi'
	righthand_file = 'modular_septic/icons/mob/inhands/clothing/clothing_righthand.dmi'
	inhand_icon_state = "coordinator_cloak"
	strip_delay = 25
	armor = list(MELEE = 0, \
				BULLET = 0, \
				LASER = 0, \
				ENERGY = 10, \
				BOMB = 0, \
				BIO = 0, \
				FIRE = 25, \
				ACID = 50, \
				WOUND = 0)
	custom_materials = list(/datum/material/gold = 500, \
						/datum/material/iron = 500, \
						/datum/material/plastic = 1000)
