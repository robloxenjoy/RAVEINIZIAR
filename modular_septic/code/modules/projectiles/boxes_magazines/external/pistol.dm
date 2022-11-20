/obj/item/ammo_box/magazine/m9mm
	name = "pistol magazine (9mm)"
	icon = 'modular_septic/icons/obj/items/ammo/pistol.dmi'
	icon_state = "ruger9mm"
	base_icon_state = "ruger9mm"
	tetris_width = 32
	tetris_height = 32

/obj/item/ammo_box/magazine/m9mm_aps
	name = "pernetta 69r magazine (9mm)"
	icon = 'modular_septic/icons/obj/items/ammo/pistol.dmi'
	icon_state = "beretta9mm"
	base_icon_state = "beretta9mm"
	multiple_sprites = AMMO_BOX_FULL_EMPTY
	drop_sound = 'modular_septic/sound/weapons/plastic_drop.ogg'
	tetris_width = 32
	tetris_height = 32

/obj/item/ammo_box/magazine/m45
	name = "pistol magazine (.45)"
	icon = 'modular_septic/icons/obj/items/ammo/pistol.dmi'
	icon_state = "pistol45"
	base_icon_state = "pistol45"
	multiple_sprites = AMMO_BOX_FULL_EMPTY
	drop_sound = 'modular_septic/sound/weapons/plastic_drop.ogg'
	tetris_width = 32
	tetris_height = 32

/obj/item/ammo_box/magazine/m45/update_icon_state()
	. = ..()
	icon_state = "[base_icon_state]-[min(round(ammo_count(), 2), 8)]"

/obj/item/ammo_box/magazine/combatmaster9mm
	name = "frag master magazine (9mm)"
	icon = 'modular_septic/icons/obj/items/ammo/pistol.dmi'
	icon_state = "combat"
	base_icon_state = "combat"
	ammo_type = /obj/item/ammo_casing/c9mm
	caliber = CALIBER_9MM
	max_ammo = 20
	multiple_sprites = AMMO_BOX_FULL_EMPTY
	drop_sound = 'modular_septic/sound/weapons/plastic_drop.ogg'
	tetris_width = 32
	tetris_height = 32

/obj/item/ammo_box/magazine/combatmaster9mm/update_icon_state()
	. = ..()
	icon_state = "[base_icon_state]-[ammo_count() ? 20 : 0]"

/obj/item/ammo_box/magazine/glock9mm
	name = "Gosma-17 magazine (9mm)"
	icon = 'modular_septic/icons/obj/items/ammo/pistol.dmi'
	icon_state = "glock"
	base_icon_state = "glock"
	ammo_type = /obj/item/ammo_casing/c9mm
	caliber = CALIBER_9MM
	max_ammo = 17
	multiple_sprites = AMMO_BOX_ONE_SPRITE
	drop_sound = 'modular_septic/sound/weapons/plastic_drop.ogg'
	tetris_width = 32
	tetris_height = 32

/obj/item/ammo_box/magazine/glock9mm/update_icon_state()
	. = ..()
	icon_state = "[base_icon_state]-[ammo_count() ? 17 : 0]"

/obj/item/ammo_box/magazine/ppk22lr
	name = "walter bombeiro magazine (.22lr)"
	icon = 'modular_septic/icons/obj/items/ammo/pistol.dmi'
	icon_state = "ppk22lr"
	base_icon_state = "ppk22lr"
	ammo_type = /obj/item/ammo_casing/c22lr
	caliber = CALIBER_22LR
	max_ammo = 9
	multiple_sprites = AMMO_BOX_ONE_SPRITE
	drop_sound = 'modular_septic/sound/weapons/plastic_drop.ogg'
	tetris_width = 32
	tetris_height = 32

/obj/item/ammo_box/magazine/ppk22lr/update_icon_state()
	. = ..()
	icon_state = "[base_icon_state]-[min(round(ammo_count()), 9)]"

/obj/item/ammo_box/magazine/aniquilador
	name = "Anaquilador Magazine (.50 LE)"
	icon = 'modular_septic/icons/obj/items/ammo/pistol.dmi'
	icon_state = "one"
	base_icon_state = "one"
	ammo_type = /obj/item/ammo_casing/aniquilador
	caliber = CALIBER_ANIQUILADOR
	max_ammo = 10
	multiple_sprites = AMMO_BOX_ONE_SPRITE
	drop_sound = 'modular_septic/sound/weapons/plastic_drop.ogg'
	tetris_width = 32
	tetris_height = 32

/obj/item/ammo_box/magazine/aniquilador/update_icon_state()
	. = ..()
	icon_state = "[base_icon_state]-[ammo_count() ? 10 : 0]"

/obj/item/ammo_box/magazine/john
	name = "John Magazine (.50 AE)"
	icon = 'modular_septic/icons/obj/items/ammo/pistol.dmi'
	icon_state = "glockl"
	base_icon_state = "glockl"
	ammo_type = /obj/item/ammo_casing/a50ae
	caliber = CALIBER_50
	max_ammo = 8
	multiple_sprites = AMMO_BOX_ONE_SPRITE
	drop_sound = 'modular_septic/sound/weapons/plastic_drop.ogg'
	tetris_width = 32
	tetris_height = 32

/obj/item/ammo_box/magazine/john/update_icon_state()
	. = ..()
	icon_state = "[base_icon_state]-[ammo_count() ? 8 : 0]"

/obj/item/ammo_box/magazine/pm9
	name = "PM9 Evil Magazine (nine milie meter)"
	icon = 'modular_septic/icons/obj/items/ammo/pistol.dmi'
	icon_state = "cunny"
	base_icon_state = "cunny"
	ammo_type = /obj/item/ammo_casing/c9mm
	caliber = CALIBER_9MM
	max_ammo = 25
	multiple_sprites = AMMO_BOX_ONE_SPRITE
	drop_sound = 'modular_septic/sound/weapons/plastic_drop.ogg'
	tetris_width = 32
	tetris_height = 32

/obj/item/ammo_box/magazine/pm9/update_icon_state()
	. = ..()
	icon_state = "[base_icon_state]-[ammo_count() ? 25 : 0]"
