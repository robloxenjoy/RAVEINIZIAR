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

/obj/item/clothing/neck/bear_cloak
	name = "Bear Cloak"
	desc = "Cloak made from the leather of a bear."
	icon = 'modular_pod/icons/obj/clothing/neck.dmi'
	icon_state = "bear_cloak"
	worn_icon = 'modular_pod/icons/mob/clothing/neck.dmi'
	worn_icon_state = "bear_cloak"
	lefthand_file = 'modular_septic/icons/mob/inhands/clothing/clothing_lefthand.dmi'
	righthand_file = 'modular_septic/icons/mob/inhands/clothing/clothing_righthand.dmi'
	inhand_icon_state = "ordinator_cloak"
	strip_delay = 20
	body_parts_covered = NECK|CHEST|ARMS
	cold_protection = NECK|CHEST|ARMS
	heat_protection = NECK|CHEST|ARMS
	slot_flags = ITEM_SLOT_NECK|ITEM_SLOT_OVERSUIT
	armor = list(MELEE = 4, \
				BULLET = 4, \
				LASER = 0, \
				ENERGY = 10, \
				BOMB = 0, \
				BIO = 0, \
				FIRE = 25, \
				ACID = 50, \
				WOUND = 1)
/*
/obj/item/clothing/neck/bear_cloak/equipped(datum/source, mob/equipper, slot)
	. = ..()

	if(slot == ITEM_SLOT_OVERSUIT)
		icon = 'modular_pod/icons/obj/clothing/oversuit.dmi'
		icon_state = "bear_cloak"
		worn_icon = 'modular_pod/icons/mob/clothing/oversuit.dmi'
		worn_icon_state = "bear_cloak"
	else
		icon = 'modular_pod/icons/obj/clothing/neck.dmi'
		icon_state = "bear_cloak"
		worn_icon = 'modular_pod/icons/mob/clothing/neck.dmi'
		worn_icon_state = "bear_cloak"
*/
/obj/item/clothing/neck/darkproject
	name = "Dark Cloak"
	desc = "Black, slightly torn cloak. Wearing this, people will definitely avoid you."
	icon = 'modular_pod/icons/obj/clothing/neck.dmi'
	icon_state = "darkproject"
	worn_icon = 'modular_pod/icons/mob/clothing/neck.dmi'
	worn_icon_state = "darkproject"
	lefthand_file = 'modular_septic/icons/mob/inhands/clothing/clothing_lefthand.dmi'
	righthand_file = 'modular_septic/icons/mob/inhands/clothing/clothing_righthand.dmi'
	inhand_icon_state = "ordinator_cloak"
	strip_delay = 20
	body_parts_covered = CHEST|ARMS
	cold_protection = CHEST|ARMS
	heat_protection = CHEST|ARMS
	slot_flags = ITEM_SLOT_NECK|ITEM_SLOT_OVERSUIT
	armor = list(MELEE = 4, \
				BULLET = 4, \
				LASER = 0, \
				ENERGY = 5, \
				BOMB = 0, \
				BIO = 0, \
				FIRE = 10, \
				ACID = 5, \
				WOUND = 1)

/obj/item/clothing/neck/leather_cloak
	name = "Leather Cloak"
	desc = "Cloak made from the leather of a humanoid."
	icon = 'modular_pod/icons/obj/clothing/neck.dmi'
	icon_state = "leather_cloak"
	worn_icon = 'modular_pod/icons/mob/clothing/neck.dmi'
	worn_icon_state = "leather_cloak"
	lefthand_file = 'modular_septic/icons/mob/inhands/clothing/clothing_lefthand.dmi'
	righthand_file = 'modular_septic/icons/mob/inhands/clothing/clothing_righthand.dmi'
	inhand_icon_state = "ordinator_cloak"
	strip_delay = 20
	body_parts_covered = NECK|CHEST|ARMS
	cold_protection = NECK|CHEST|ARMS
	heat_protection = NECK|CHEST|ARMS
	slot_flags = ITEM_SLOT_NECK|ITEM_SLOT_OVERSUIT
	armor = list(MELEE = 3, \
				BULLET = 3, \
				LASER = 0, \
				ENERGY = 10, \
				BOMB = 0, \
				BIO = 0, \
				FIRE = 25, \
				ACID = 50, \
				WOUND = 1)

/obj/item/clothing/neck/noble_cloak
	name = "Noble Cloak"
	desc = "Nice expensive cloak."
	icon = 'modular_pod/icons/obj/clothing/neck.dmi'
	icon_state = "noble_cloak"
	worn_icon = 'modular_pod/icons/mob/clothing/neck.dmi'
	worn_icon_state = "noble_cloak"
	lefthand_file = 'modular_septic/icons/mob/inhands/clothing/clothing_lefthand.dmi'
	righthand_file = 'modular_septic/icons/mob/inhands/clothing/clothing_righthand.dmi'
	inhand_icon_state = "ordinator_cloak"
	strip_delay = 20
	body_parts_covered = NECK|CHEST|ARMS
	cold_protection = NECK|CHEST|ARMS
	heat_protection = NECK|CHEST|ARMS
	slot_flags = ITEM_SLOT_NECK|ITEM_SLOT_OVERSUIT
	armor = list(MELEE = 2, \
				BULLET = 2, \
				LASER = 0, \
				ENERGY = 10, \
				BOMB = 0, \
				BIO = 0, \
				FIRE = 25, \
				ACID = 50, \
				WOUND = 1)

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
