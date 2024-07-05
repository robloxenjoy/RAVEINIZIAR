/obj/item/storage/belt
	mutant_variants = NONE
	carry_weight = 1 KILOGRAMS

/obj/item/storage/belt/military/itobe
	name = "Плечевая Сумка"
	desc = "ОЧЕНЬ ПОЛЕЗНО."
	icon = 'modular_septic/icons/obj/clothing/belts.dmi'
	icon_state = "itobe_belt"
	worn_icon = 'modular_septic/icons/mob/clothing/belt.dmi'
	worn_icon_state = "itobe_belt"
	lefthand_file = 'modular_septic/icons/mob/inhands/clothing/clothing_lefthand.dmi'
	righthand_file = 'modular_septic/icons/mob/inhands/clothing/clothing_righthand.dmi'
	inhand_icon_state = "itobe_belt"
	slot_flags = ITEM_SLOT_BACK | ITEM_SLOT_SUITSTORE
	storage_flags = NONE
//	color = "#d2d2d2"

/obj/item/storage/belt/military/itobe/svo

/obj/item/storage/belt/military/itobe/svo/PopulateContents()
	var/static/items_inside = list(
		/obj/item/grenade/frag = 3,
		/obj/item/ammo_box/magazine/ammo_stack/a762svd/loaded = 2)
	generate_items_inside(items_inside,src)

/obj/item/storage/belt/military/itobe/agent
	name = "darkened belt rig"
	desc = "A set of pockets and zippers that store bullets, magazines and sometimes cigarettes for rapid-suicide."
	icon = 'modular_septic/icons/obj/clothing/belts.dmi'
	icon_state = "itobe_webbing"
	worn_icon = 'modular_septic/icons/mob/clothing/belt.dmi'
	worn_icon_state = "itobe_webbing"
	lefthand_file = 'modular_septic/icons/mob/inhands/clothing/clothing_lefthand.dmi'
	righthand_file = 'modular_septic/icons/mob/inhands/clothing/clothing_righthand.dmi'
	inhand_icon_state = "itobe_belt"
