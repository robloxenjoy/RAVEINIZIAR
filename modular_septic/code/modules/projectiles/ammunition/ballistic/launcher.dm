/obj/item/ammo_casing/l40mm
	name = "40mm HE shell"
	desc = "A cased high explosive grenade that can only be activated once fired out of a grenade launcher."
	caliber = CALIBER_40MM
	icon = 'modular_septic/icons/obj/items/ammo/casings.dmi'
	world_icon = 'modular_septic/icons/obj/items/ammo/casings.dmi'
	world_icon_state = "40mmHE"
	icon_state = "40mmHE"
	base_icon_state = "40mmHE"
	bounce_sound = list('modular_septic/sound/weapons/guns/launcher/heavy_shell1.wav', 'modular_septic/sound/weapons/guns/launcher/heavy_shell2.wav', 'modular_septic/sound/weapons/guns/launcher/heavy_shell3.wav')
	bounce_volume = 65
	projectile_type = /obj/projectile/bullet/l40mm
	stack_type = null

/obj/item/ammo_casing/l40mm/poop
	name = "40mm IG shell"
	desc = "An incredibly gassy grenade."
	world_icon_state = "40mmPOOP"
	icon_state = "40mmPOOP"
	base_icon_state = "40mmPOOP"
	projectile_type = /obj/projectile/bullet/gas40mm

/obj/item/ammo_casing/l40mm/smoke
	name = "40mm SMK shell"
	desc = "A cased grenade that deploys smoke in an area, can only be activated once fired out of a grenade launcher."
	world_icon_state = "40mmGAS"
	icon_state = "40mmGAS"
	base_icon_state = "40mmGAS"
	projectile_type = /obj/projectile/bullet/smoke40mm

/obj/item/ammo_casing/l40mm/inc
	name = "40mm INC shell"
	desc = "A cased incindary grenade that can only be activated once fired out of a grenade launcher."
	world_icon_state = "40mmINC"
	icon_state = "40mmINC"
	base_icon_state = "40mmINC"
	projectile_type = /obj/projectile/bullet/inc40mm
