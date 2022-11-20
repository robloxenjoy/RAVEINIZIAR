/obj/item/ammo_box/magazine/a556winter
	name = "Inverno Genocídio universal magazine (5.56)"
	icon = 'modular_septic/icons/obj/items/ammo/rifle.dmi'
	icon_state = "inverno"
	base_icon_state = "inverno"
	ammo_type = /obj/item/ammo_casing/a556
	caliber = CALIBER_A556
	max_ammo = 35
	multiple_sprites = AMMO_BOX_ONE_SPRITE
	drop_sound = 'modular_septic/sound/weapons/plastic_drop.ogg'
	pickup_sound = 'modular_septic/sound/weapons/plastic_pickup.ogg'
	tetris_width = 32
	tetris_height = 64

/obj/item/ammo_box/magazine/a556winter/update_icon_state()
	. = ..()
	icon_state = "[base_icon_state]-[ammo_count() ? 35 : 0]"

/obj/item/ammo_box/magazine/a556g36
	name = "Perdedor magazine (5.56)"
	icon = 'modular_septic/icons/obj/items/ammo/rifle.dmi'
	icon_state = "g36"
	base_icon_state = "g36"
	ammo_type = /obj/item/ammo_casing/a556
	caliber = CALIBER_A556
	max_ammo = 30
	multiple_sprites = AMMO_BOX_ONE_SPRITE
	drop_sound = 'modular_septic/sound/weapons/plastic_drop.ogg'
	pickup_sound = 'modular_septic/sound/weapons/plastic_pickup.ogg'
	tetris_width = 32
	tetris_height = 64

/obj/item/ammo_box/magazine/a556g36/update_icon_state()
	. = ..()
	icon_state = "[base_icon_state]-[CEILING(ammo_count(), 5)]"

/obj/item/ammo_box/magazine/a545
	name = "Abyss-Platform universal magazine (5.45x39)"
	icon = 'modular_septic/icons/obj/items/ammo/rifle.dmi'
	icon_state = "abrifle"
	base_icon_state = "abrifle"
	ammo_type = /obj/item/ammo_casing/a545
	caliber = CALIBER_545
	max_ammo = 30
	multiple_sprites = AMMO_BOX_ONE_SPRITE
	drop_sound = 'modular_septic/sound/weapons/plastic_drop.ogg'
	pickup_sound = 'modular_septic/sound/weapons/plastic_pickup.ogg'
	tetris_width = 32
	tetris_height = 64

/obj/item/ammo_box/magazine/a545/update_icon_state()
	. = ..()
	icon_state = "[base_icon_state]-[ammo_count() ? 30 : 0]"

/obj/item/ammo_box/magazine/a545/donator
	name = "Abyss-Platform paypig magazine (5.45x39)"
	icon_state = "gabrifle"
	base_icon_state = "gabrifle"
	ammo_type = /obj/item/ammo_casing/a762
	caliber = CALIBER_A762

/obj/item/ammo_box/magazine/a545/donator/update_icon_state()
	. = ..()
	icon_state = "[base_icon_state]-[ammo_count() ? 30 : 0]"

/obj/item/ammo_box/magazine/a49234g11
	name = "Unwieldly O Guloseim magazine (4.92x34mm)"
	icon = 'modular_septic/icons/obj/items/ammo/rifle.dmi'
	icon_state = "grifle"
	base_icon_state = "grifle"
	ammo_type = /obj/item/ammo_casing/a49234g11
	caliber = CALIBER_UNCONVENTIONAL
	max_ammo = 55
	multiple_sprites = AMMO_BOX_ONE_SPRITE
	tetris_width = 64
	tetris_height = 32

/obj/item/ammo_box/magazine/a49234g11/update_icon_state()
	. = ..()
	icon_state = "[base_icon_state]-[ammo_count() ? 55 : 0]"

/obj/item/ammo_box/magazine/a556steyr
	name = "Advanced Combat Rifle annular-primed flechette magazine (5.56×45mm)"
	icon = 'modular_septic/icons/obj/items/ammo/rifle.dmi'
	icon_state = "urifle"
	base_icon_state = "urifle"
	ammo_type = /obj/item/ammo_casing/a556steyr
	caliber = CALIBER_FLECHETTE
	max_ammo = 24
	multiple_sprites = AMMO_BOX_ONE_SPRITE
	drop_sound = 'modular_septic/sound/weapons/plastic_drop.ogg'
	pickup_sound = 'modular_septic/sound/weapons/plastic_pickup.ogg'
	tetris_width = 32
	tetris_height = 64

/obj/item/ammo_box/magazine/a556f/update_icon_state()
	. = ..()
	icon_state = "[base_icon_state]-[ammo_count() ? 24 : 0]"

/obj/item/ammo_box/magazine/a762svd
	name = "Lampiao marksman rifle magazine (7.62x54R)"
	icon = 'modular_septic/icons/obj/items/ammo/rifle.dmi'
	icon_state = "svd"
	base_icon_state = "svd"
	ammo_type = /obj/item/ammo_casing/a762svd
	caliber = CALIBER_54R
	max_ammo = 15
	multiple_sprites = AMMO_BOX_ONE_SPRITE
	tetris_width = 32
	tetris_height = 32

/obj/item/ammo_box/magazine/a762svd/update_icon_state()
	. = ..()
	icon_state = "[base_icon_state]-[ammo_count() ? 15 : 0]"

/obj/item/ammo_box/magazine/a762svd/update_icon_state()
	. = ..()
	icon_state = "[base_icon_state]-[ammo_count() ? 15 : 0]"

/obj/item/ammo_box/magazine/a762g3
	name = "Arma marksman rifle magazine (7.62x51)"
	icon = 'modular_septic/icons/obj/items/ammo/rifle.dmi'
	icon_state = "g3"
	base_icon_state = "g3"
	ammo_type = /obj/item/ammo_casing/a762x51
	caliber = CALIBER_51
	max_ammo = 20
	multiple_sprites = AMMO_BOX_ONE_SPRITE

/obj/item/ammo_box/magazine/a762g3/update_icon_state()
	. = ..()
	icon_state = "[base_icon_state]-[ammo_count() ? 20 : 0]"
