/obj/item/ammo_casing/shotgun
	icon_state = "12gauge_slug"
	base_icon_state = "12gauge_slug"
	world_icon_state = "gshells"
	bounce_sound = list('modular_septic/sound/weapons/guns/shotgun/12cal1.wav', 'modular_septic/sound/weapons/guns/shotgun/12cal2.wav', 'modular_septic/sound/weapons/guns/shotgun/12cal3.wav')
	bounce_volume = 45
	stack_type = /obj/item/ammo_box/magazine/ammo_stack/shotgun

/obj/item/ammo_casing/shotgun/Initialize(mapload)
	if((type == /obj/item/ammo_casing/shotgun) && prob(0.1))
		playsound(src, 'modular_septic/sound/weapons/faggot.ogg', 70, FALSE)
		name = "reggie slug"
		desc = "Hi, my name is Reggie, I like penetrating IIIA body armor."
	return ..()

/obj/item/ammo_casing/shotgun/rubbershot
	icon_state = "12gauge"
	base_icon_state = "12gauge"
	world_icon_state = "gshell"
	pellets = 12
	variance = 4

/obj/item/ammo_casing/shotgun/buckshot
	icon_state = "12gauge"
	base_icon_state = "12gauge"
	world_icon_state = "gshell"
	pellets = 8
	variance = 4.5

/obj/item/ammo_casing/shotgun/beanbag
	icon_state = "12gauge"
	base_icon_state = "12gauge"
	world_icon_state = "gshell"

/obj/item/ammo_casing/shotgun/flechette
	name = "shotgun flechette"
	desc = "A 12 gauge steel flechette. Contains 20 indevidual projectiles"
	pellets = 20
	variance = 18.5
	projectile_type = /obj/projectile/bullet/pellet/shotgun_flechette

/obj/item/ammo_casing/shotgun/ap
	name = "shotgun armor-piercing slug"
	desc = "A 12 gauge solid steel armor-piercing slug. \
			There's a label on the shell itself, AP-20."
	projectile_type = /obj/projectile/bullet/shotgun_slug/ap

/obj/item/ammo_casing/shotgun/bolas
	name =	"Consumidor de Buceta 4 guage slug"
	desc = "A 4 guage destructive slug designed with the purpose of destroying armored structures at a range. \
			But It can destroy flesh, too."
	icon_state = "8gauge"
	base_icon_state = "8gauge"
	world_icon_state = "8gshell"
	caliber = CALIBER_KS23
	projectile_type = /obj/projectile/bullet/shotgun_bolas
	stack_type = /obj/item/ammo_box/magazine/ammo_stack/shotgun/bolas

/obj/item/ammo_casing/shotgun/bolas/buckshot
	name = "Estuprador-3 4 guage buckshot"
	desc = "A 4 guage anti-personel buckshot shell for the sole purpose of completely fucking obliterating soft tissue from close range."
	icon_state = "8gauge"
	base_icon_state = "8gauge"
	world_icon_state = "8gshell"
	caliber = CALIBER_KS23
	pellets = 10
	variance = 10
	projectile_type = /obj/projectile/bullet/pellet/shotgun_bolas/buckshot
