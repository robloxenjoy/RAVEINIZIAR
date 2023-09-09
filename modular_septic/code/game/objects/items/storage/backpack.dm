/obj/item/storage/backpack
	slot_flags = ITEM_SLOT_BACK | ITEM_SLOT_SUITSTORE
	slowdown = 0
	storage_flags = STORAGE_NO_WORN_ACCESS
	carry_weight = 3 KILOGRAMS
	pickup_sound = 'modular_septic/sound/armor/equip/backpack_pickup.ogg'
	drop_sound = 'modular_septic/sound/armor/equip/backpack_drop.ogg'
	equip_sound = 'modular_septic/sound/armor/equip/backpack_wear.ogg'

/obj/item/storage/backpack/Initialize()
	. = ..()
	var/datum/component/storage/STR = GetComponent(/datum/component/storage)
	if(STR)
		STR.rustle_sound = 'modular_septic/sound/armor/equip/backpack_use.ogg'

/obj/item/storage/backpack/satchel
	slowdown = 0
	slot_flags = ITEM_SLOT_BACK|ITEM_SLOT_SUITSTORE
	storage_flags = NONE
	carry_weight = 1.5 KILOGRAMS

/obj/item/storage/backpack/satchel/Initialize()
	. = ..()
	var/datum/component/storage/STR = GetComponent(/datum/component/storage)
	if(STR)
		STR.max_combined_w_class = 12

/obj/item/storage/backpack/duffelbag
	slowdown = 0
	storage_flags = STORAGE_NO_WORN_ACCESS|STORAGE_NO_EQUIPPED_ACCESS
	carry_weight = 3 KILOGRAMS

/obj/item/storage/backpack/duffelbag/Initialize()
	. = ..()
	var/datum/component/storage/STR = GetComponent(/datum/component/storage)
	STR.max_combined_w_class = 32

/obj/item/storage/backpack/satchel/flat/Initialize(mapload)
	. = ..()
	var/datum/component/storage/STR = GetComponent(/datum/component/storage)
	STR.max_combined_w_class = 10

/obj/item/storage/backpack/holding/Initialize()
	. = ..()
	var/datum/component/storage/STR = GetComponent(/datum/component/storage)
	STR.max_combined_w_class = 38

/obj/item/storage/backpack/leather
	icon = 'modular_septic/icons/obj/clothing/back.dmi'
	icon_state = "leather_backpack"
	worn_icon = 'modular_septic/icons/mob/clothing/back.dmi'
	worn_icon_state = "leather_backpack"

/obj/item/storage/backpack/satchel/leather
	icon = 'modular_septic/icons/obj/clothing/back.dmi'
	icon_state = "leather_satchel"
	worn_icon = 'modular_septic/icons/mob/clothing/back.dmi'
	worn_icon_state = "leather_satchel"

/obj/item/storage/backpack/satchel/itobe
	name = "darkened satchel"
	desc = "A satchel used exclusively for storing tactical equipment, grenades, medical equipment, and small firearms."
	icon = 'modular_septic/icons/obj/clothing/back.dmi'
	icon_state = "itobe_satchel"
	worn_icon = 'modular_septic/icons/mob/clothing/back.dmi'
	worn_icon_state = "itobe_satchel"
	lefthand_file = 'modular_septic/icons/mob/inhands/clothing/clothing_lefthand.dmi'
	righthand_file = 'modular_septic/icons/mob/inhands/clothing/clothing_righthand.dmi'
	inhand_icon_state = "itobe_satchel"

/obj/item/storage/backpack/basket
	name = "Blue Basket"
	desc = "A basket made from a pieces of midnightberry thickets."
	icon = 'modular_septic/icons/obj/clothing/back.dmi'
	icon_state = "basketblue"
	worn_icon = 'modular_septic/icons/mob/clothing/back.dmi'
	worn_icon_state = "itobe_satchel"
	lefthand_file = 'modular_septic/icons/mob/inhands/clothing/clothing_lefthand.dmi'
	righthand_file = 'modular_septic/icons/mob/inhands/clothing/clothing_righthand.dmi'
	inhand_icon_state = "basketblue"
	slot_flags = null
	storage_flags = NONE
	carry_weight = 1 KILOGRAMS

/obj/item/storage/backpack/basket/Initialize(mapload)
	. = ..()
	var/datum/component/storage/STR = GetComponent(/datum/component/storage)
	STR.max_combined_w_class = 30
	STR.max_items = 60

/obj/item/storage/backpack/baggy
	name = "Dark Bag"
	desc = "What's in it?"
	icon = 'modular_pod/icons/obj/items/otherobjects.dmi'
	icon_state = "darkbag"
	worn_icon = 'modular_septic/icons/mob/clothing/back.dmi'
	worn_icon_state = "itobe_satchel"
	lefthand_file = 'modular_septic/icons/mob/inhands/remis_lefthand.dmi'
	righthand_file = 'modular_septic/icons/mob/inhands/remis_righthand.dmi'
	inhand_icon_state = "darkbag"
	slot_flags = null
	storage_flags = NONE
	carry_weight = 1 KILOGRAMS

/obj/item/storage/backpack/baggy/Initialize(mapload)
	. = ..()
	var/datum/component/storage/STR = GetComponent(/datum/component/storage)
	STR.max_combined_w_class = 30
	STR.max_items = 60

/obj/item/storage/backpack/baggy/update_icon_state()
	switch(contents.len)
		if(1 to INFINITY)
			icon_state = "[initial(icon_state)]_full"
		else
			icon_state = "[initial(icon_state)]"
	return ..()

/obj/item/storage/backpack/pouch
	name = "Pouch"
	desc = "What's in it?"
	icon = 'modular_pod/icons/obj/items/otherobjects.dmi'
	icon_state = "bag"
	worn_icon = null
	worn_icon_state = null
	lefthand_file = 'modular_septic/icons/mob/inhands/remis_lefthand.dmi'
	righthand_file = 'modular_septic/icons/mob/inhands/remis_righthand.dmi'
	inhand_icon_state = "darkbag"
	slot_flags = ITEM_SLOT_BELT | ITEM_SLOT_POCKETS | ITEM_SLOT_ID
	storage_flags = NONE
	carry_weight = 1 KILOGRAMS

/obj/item/storage/backpack/pouch/Initialize(mapload)
	. = ..()
	var/datum/component/storage/STR = GetComponent(/datum/component/storage)
	STR.max_combined_w_class = 10
	STR.max_items = 3
	STR.max_w_class = WEIGHT_CLASS_NORMAL
	STR.set_holdable(list(
		/obj/item/stack/eviljewel,
		))


/obj/item/storage/backpack/pouch/update_icon_state()
	switch(contents.len)
		if(1 to INFINITY)
			icon_state = "[initial(icon_state)]_full"
		else
			icon_state = "[initial(icon_state)]"
	return ..()

/obj/item/storage/backpack/pouch/submerc

/obj/item/storage/backpack/pouch/venturer

/obj/item/storage/backpack/pouch/venturer/noble

/obj/item/storage/backpack/pouch/submerc/PopulateContents()
	if(empty)
		return
	var/static/items_inside = list(
		/obj/item/stack/eviljewel = 1,
		/obj/item/stack/eviljewel/max = 2)
	generate_items_inside(items_inside,src)

/obj/item/storage/backpack/pouch/venturer/PopulateContents()
	if(empty)
		return
	var/static/items_inside = list(
		/obj/item/stack/eviljewel/twenty = 1)
	generate_items_inside(items_inside,src)

/obj/item/storage/backpack/pouch/venturer/noble/PopulateContents()
	if(empty)
		return
	var/static/items_inside = list(
		/obj/item/stack/eviljewel/max = 1)
	generate_items_inside(items_inside,src)

/obj/item/storage/backpack/itobe
	name = "darkened backpack"
	desc = "A sleek blackpack that wraps around using four straps around the user, allows the user to move light, and fast while carrying a medium or large-sized firearm."
	icon = 'modular_septic/icons/obj/clothing/back.dmi'
	icon_state = "itobe_backpack"
	worn_icon = 'modular_septic/icons/mob/clothing/back.dmi'
	worn_icon_state = "itobe_backpack"
	lefthand_file = 'modular_septic/icons/mob/inhands/clothing/clothing_lefthand.dmi'
	righthand_file = 'modular_septic/icons/mob/inhands/clothing/clothing_righthand.dmi'
	inhand_icon_state = "itobe_backpack"
