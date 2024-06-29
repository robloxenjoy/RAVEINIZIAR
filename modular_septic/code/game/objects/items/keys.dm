/*
/obj/item/key/examine(mob/user)
	. = ..()
	if(id_tag)
		. += span_notice("[p_theyre(TRUE)] tagged with \"[id_tag]\".")
*/
/obj/item/key/proc/door_allowed(obj/machinery/door/door)
	if(id_tag == door.id_tag)
		return TRUE
	return FALSE

/obj/item/key/dorm
	name = "dorm key"
	desc = "A key to one of the dorm rooms."
	icon = 'modular_septic/icons/obj/items/keys.dmi'
	icon_state = "key_dorm"
	base_icon_state = "key_dorm"
	pickup_sound = 'modular_septic/sound/effects/keys_pickup.ogg'
	drop_sound = 'modular_septic/sound/effects/keys_drop.ogg'

/obj/item/key/podpol/woody
	name = "Wooden Key"
	desc = "A key to one of the homes."
	icon = 'modular_septic/icons/obj/items/keys.dmi'
	icon_state = "key_wooden"
	base_icon_state = "key_wooden"
	pickup_sound = 'modular_septic/sound/effects/keys_pickup.ogg'
	drop_sound = 'modular_septic/sound/effects/keys_drop.ogg'
	slot_flags = ITEM_SLOT_POCKETS|ITEM_SLOT_ID|ITEM_SLOT_BELT

/obj/item/key/podpol/woody/lair
	name = "Wooden Key"
	desc = "A key to one of the homes. Lair!"
	icon = 'modular_septic/icons/obj/items/keys.dmi'
	icon_state = "key_wooden"
	base_icon_state = "key_wooden"
	pickup_sound = 'modular_septic/sound/effects/keys_pickup.ogg'
	drop_sound = 'modular_septic/sound/effects/keys_drop.ogg'
	id_tag = "lair"

/obj/item/key/podpol/woody/hut
	name = "Wooden Key"
	desc = "A key to one of the homes. Hut!"
	icon = 'modular_septic/icons/obj/items/keys.dmi'
	icon_state = "key_wooden"
	base_icon_state = "key_wooden"
	pickup_sound = 'modular_septic/sound/effects/keys_pickup.ogg'
	drop_sound = 'modular_septic/sound/effects/keys_drop.ogg'
	id_tag = "hut"

/obj/item/key/podpol/woody/infirmary
	name = "Wooden Key"
	desc = "A key to one of the homes. Infirmary!"
	icon = 'modular_septic/icons/obj/items/keys.dmi'
	icon_state = "key_wooden"
	base_icon_state = "key_wooden"
	pickup_sound = 'modular_septic/sound/effects/keys_pickup.ogg'
	drop_sound = 'modular_septic/sound/effects/keys_drop.ogg'
	id_tag = "infirmary"

/obj/item/key/podpol/woody/controller
	name = "Wooden Key"
	desc = "A key to one of the homes. Palace!"
	icon = 'modular_septic/icons/obj/items/keys.dmi'
	icon_state = "key_wooden"
	base_icon_state = "key_wooden"
	pickup_sound = 'modular_septic/sound/effects/keys_pickup.ogg'
	drop_sound = 'modular_septic/sound/effects/keys_drop.ogg'
	id_tag = "palace"

/obj/item/key/podpol/woody/nailer
	name = "Wooden Key"
	desc = "A key to one of the homes. Nailer House!"
	icon = 'modular_septic/icons/obj/items/keys.dmi'
	icon_state = "key_wooden"
	base_icon_state = "key_wooden"
	pickup_sound = 'modular_septic/sound/effects/keys_pickup.ogg'
	drop_sound = 'modular_septic/sound/effects/keys_drop.ogg'
	id_tag = "nailer"

/obj/item/key/podpol/woody/granger
	name = "Wooden Key"
	desc = "A key to one of the homes. Granger Farm!"
	icon = 'modular_septic/icons/obj/items/keys.dmi'
	icon_state = "key_wooden"
	base_icon_state = "key_wooden"
	pickup_sound = 'modular_septic/sound/effects/keys_pickup.ogg'
	drop_sound = 'modular_septic/sound/effects/keys_drop.ogg'
	id_tag = "granger"

/obj/item/key/podpol/woody/accepter
	name = "Wooden Key"
	desc = "A key to one of the homes. Store!"
	icon = 'modular_septic/icons/obj/items/keys.dmi'
	icon_state = "key_wooden"
	base_icon_state = "key_wooden"
	pickup_sound = 'modular_septic/sound/effects/keys_pickup.ogg'
	drop_sound = 'modular_septic/sound/effects/keys_drop.ogg'
	id_tag = "store"

/obj/item/key/podpol/woody/alchemist
	name = "Wooden Key"
	desc = "A key to one of the homes. Al-Chemist Location!"
	icon = 'modular_septic/icons/obj/items/keys.dmi'
	icon_state = "key_wooden"
	base_icon_state = "key_wooden"
	pickup_sound = 'modular_septic/sound/effects/keys_pickup.ogg'
	drop_sound = 'modular_septic/sound/effects/keys_drop.ogg'
	id_tag = "alchemist"

/obj/item/key/podpol/woody/carehouse
	name = "Wooden Key"
	desc = "A key to one of the homes. Carehouse!"
	icon = 'modular_septic/icons/obj/items/keys.dmi'
	icon_state = "key_wooden"
	base_icon_state = "key_wooden"
	pickup_sound = 'modular_septic/sound/effects/keys_pickup.ogg'
	drop_sound = 'modular_septic/sound/effects/keys_drop.ogg'
	id_tag = "carehouse"
