// SAIGA 12
/obj/item/ammo_box/magazine/abyss_shotgun_drum
	name = "\improper Abyss Shotgun magazine"
	desc = "A 20-shell capacity magazine for the AN-12 shotgun."
	icon = 'modular_septic/icons/obj/items/ammo/shotgun.dmi'
	icon_state = "saiga_drum"
	base_icon_state = "saiga_drum"
	ammo_type = /obj/item/ammo_casing/shotgun/buckshot
	caliber = CALIBER_SHOTGUN
	max_ammo = 20
	multiple_sprites = AMMO_BOX_ONE_SPRITE
	tetris_width = 64
	tetris_height = 64

/obj/item/ammo_box/magazine/abyss_shotgun_drum/update_icon_state()
	. = ..()
	icon_state = "[base_icon_state]-[ammo_count() ? 20 : 0]"

// BULLDOG
/obj/item/ammo_box/magazine/m12g
	icon = 'modular_septic/icons/obj/items/ammo/shotgun.dmi'
	icon_state = "m12"
	base_icon_state = "m12"
	tetris_width = 64
	tetris_height = 64

/obj/item/ammo_box/magazine/m12g/update_icon_state()
	. = ..()
	icon_state = "[base_icon_state]-[ammo_count() ? 8 : 0]"

/obj/item/ammo_box/magazine/m12g/stun
	icon_state = "m12"
	base_icon_state = "m12"

/obj/item/ammo_box/magazine/m12g/slug
	icon_state = "m12"
	base_icon_state = "m12"

/obj/item/ammo_box/magazine/m12g/dragon
	icon_state = "m12"
	base_icon_state = "m12"

/obj/item/ammo_box/magazine/m12g/bioterror
	icon_state = "m12"
	base_icon_state = "m12"

/obj/item/ammo_box/magazine/m12g/meteor
	icon_state = "m12"
	base_icon_state = "m12"
