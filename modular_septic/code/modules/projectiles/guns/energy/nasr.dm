/obj/item/gun/energy/remis/nasr
	name = "Nasr"
	desc = "A handheld, industrial device meant to melt glue at low-voltages. It has been powered wirelessly by the hatred and blatent racism of a certain egyption indevidual with terroristic intentions."
	icon = 'modular_septic/icons/obj/items/guns/energy.dmi'
	lefthand_file = 'modular_septic/icons/obj/items/guns/inhands/pistol_lefthand.dmi'
	righthand_file = 'modular_septic/icons/obj/items/guns/inhands/pistol_righthand.dmi'
	equip_sound = 'modular_septic/sound/weapons/guns/pistol/pistol_holster.wav'
	pickup_sound = 'modular_septic/sound/weapons/guns/pistol/pistol_draw.wav'
	fire_sound = list('modular_septic/sound/weapons/guns/energy/nasr1.wav', 'modular_septic/sound/weapons/guns/energy/nasr2.wav', 'modular_septic/sound/weapons/guns/energy/nasr3.wav')
	safety_off_sound = 'modular_septic/sound/weapons/guns/energy/siren_safetyoff.wav'
	safety_on_sound = 'modular_septic/sound/weapons/guns/energy/siren_safetyon.wav'
	drop_sound = 'modular_septic/sound/weapons/guns/drop_lightgun.wav'
	dry_fire_sound_vary = TRUE
	dry_fire_message = span_danger("*BLRRT*")
	dry_fire_sound = list('modular_septic/sound/weapons/guns/energy/nasr_alarm1.wav', 'modular_septic/sound/weapons/guns/energy/nasr_alarm2.wav')
	vary_fire_sound = FALSE
	slot_flags = ITEM_SLOT_BELT
	weapon_weight = WEAPON_LIGHT
	wielded_inhand_state = FALSE
	empty_icon_state = FALSE
	inhand_icon_state = "nasr"
	icon_state = "nasr"
	base_icon_state = "nasr"
	cell_type = /obj/item/stock_parts/cell
	charge_delay = 15
	ammo_type = list(/obj/item/ammo_casing/energy/nasr)
	custom_materials = list(/datum/material/uranium=10000, \
						/datum/material/titanium=75000, \
						/datum/material/glass=5000)
	modifystate = FALSE
	automatic_charge_overlays = FALSE
	single_shot_type_overlay = FALSE
	display_empty = TRUE
	can_select = FALSE
	fire_delay = 2 SECONDS
	force = 17
	carry_weight = 5 KILOGRAMS
	w_class = WEIGHT_CLASS_NORMAL
	selfcharge = TRUE
	gunshot_animation_information = list("icon_state" = "energyshot", \
										"pixel_x" = 16, \
										"pixel_y" = 2)
	recoil_animation_information = list("recoil_angle_upper" = -15, \
										"recoil_angle_lower" = -30)
	custom_price = 100000
	skill_melee = SKILL_IMPACT_WEAPON_TWOHANDED
	skill_ranged = SKILL_LAW
	tetris_width = 64
	tetris_height = 64

/obj/item/gun/energy/remis/nasr/process(delta_time)
	if(selfcharge && cell && cell.percent() < 100)
		charge_timer += delta_time
		if(charge_timer < charge_delay)
			return
		charge_timer = 0
		cell.give(500)
		if(!chambered) //if empty chamber we try to charge a new shot
			recharge_newshot(TRUE)
		sound_hint()
		flick("nasr_reload", src)
		playsound(src, 'modular_septic/sound/weapons/guns/energy/nasrcharge.wav', 75, FALSE)
