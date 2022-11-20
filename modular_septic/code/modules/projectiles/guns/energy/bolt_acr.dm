/obj/item/gun/energy/remis

/obj/item/gun/energy/remis/bolt_acr
	name = "\improper nuclear fission reactor"
	desc = "What the fuck is this shit?"
	icon = 'modular_septic/icons/obj/items/guns/48x32.dmi'
	lefthand_file = 'modular_septic/icons/obj/items/guns/inhands/rifle_lefthand.dmi'
	righthand_file = 'modular_septic/icons/obj/items/guns/inhands/rifle_righthand.dmi'
	worn_icon = 'modular_septic/icons/obj/items/guns/worn/back.dmi'
	equip_sound = 'modular_septic/sound/weapons/guns/weap_away.ogg'
	drop_sound = 'modular_septic/sound/weapons/guns/drop_heavygun.wav'
	slot_flags = ITEM_SLOT_BACK | ITEM_SLOT_SUITSTORE
	wielded_inhand_state = TRUE
	inhand_icon_state = "boltacr"
	icon_state = "boltacr"
	worn_icon_state = "boltacr"
	base_icon_state = "boltacr"
	safety_off_sound = 'modular_septic/sound/weapons/guns/energy/siren_safetyoff.wav'
	safety_on_sound = 'modular_septic/sound/weapons/guns/energy/siren_safetyon.wav'
	fire_sound = 'modular_septic/sound/weapons/guns/energy/bolt.wav'
	vary_fire_sound = FALSE
	cell_type = /obj/item/stock_parts/cell
	charge_delay = 5
	ammo_type = list(/obj/item/ammo_casing/energy/bolt_acr)
	custom_materials = list(/datum/material/uranium=10000, \
						/datum/material/titanium=75000, \
						/datum/material/glass=5000)
	modifystate = FALSE
	automatic_charge_overlays = FALSE
	single_shot_type_overlay = FALSE
	display_empty = FALSE
	can_select = FALSE
	fire_delay = 3 SECONDS
	force = 17
	carry_weight = 5 KILOGRAMS
	w_class = WEIGHT_CLASS_HUGE
	weapon_weight = WEAPON_HEAVY
	selfcharge = TRUE
	gunshot_animation_information = list("icon_state" = "boltshot", \
										"pixel_x" = 32, \
										"pixel_y" = 2)
	recoil_animation_information = list("recoil_angle_upper" = -15, \
										"recoil_angle_lower" = -30)
	custom_price = 100000
	skill_melee = SKILL_IMPACT_WEAPON_TWOHANDED
	skill_ranged = SKILL_LAW
	tetris_width = 128
	tetris_height = 96

/obj/item/gun/energy/remis/bolt_acr/gunshot_animation(mob/user, burst_fire)
	flick("boltacr_firing", src)
	return ..()

