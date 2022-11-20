/obj/item/ammo_casing
	icon = 'modular_septic/icons/obj/items/ammo/casings.dmi'
	icon_state = "c9mm"
	base_icon_state = "c9mm"
	carry_weight = 20 GRAMS
	/// World icon for this bullet
	var/world_icon = 'modular_septic/icons/obj/items/ammo/casings_world.dmi'
	/// World icon state
	var/world_icon_state = "s-casing"
	/// Add this to the projectile diceroll modifiers of whatever we fire
	var/diceroll_modifier = 0
	/// Add this to the projectile diceroll modifiers of whatever we fire, but ONLY against a specified target
	var/list/target_specific_diceroll
	/// The funny sound we make when we bounce on floors
	var/bounce_sound = list('modular_septic/sound/bullet/casing_bounce1.wav', 'modular_septic/sound/bullet/casing_bounce2.wav', 'modular_septic/sound/bullet/casing_bounce3.wav')
	/// The volume of the bouncing
	var/bounce_volume = 40
	/// Should bouncing vary
	var/bounce_vary = FALSE

/obj/item/ammo_casing/Initialize(mapload)
	. = ..()
	if(world_icon)
		AddElement(/datum/element/world_icon, .proc/update_icon_world)

/obj/item/ammo_casing/update_icon(updates)
	icon = initial(icon)
	return ..()

/obj/item/ammo_casing/update_icon_state()
	. = ..()
	icon_state = "[base_icon_state][loaded_projectile ? "-live" : ""]"

/obj/item/ammo_casing/bounce_away(still_warm = FALSE, bounce_delay = 0)
	if(!heavy_metal)
		return
	update_appearance()
	undo_messy()
	do_messy()
	SpinAnimation(10, 1)
	var/turf/bouncer = drop_location()
	if(still_warm && bouncer?.bullet_sizzle)
		addtimer(CALLBACK(GLOBAL_PROC, .proc/playsound, src, 'sound/items/welder.ogg', 20, 1), bounce_delay) //If the turf is made of water and the shell casing is still hot, make a sizzling sound when it's ejected.
	else
		addtimer(CALLBACK(GLOBAL_PROC, .proc/playsound, src, pick(bounce_sound), bounce_volume, bounce_vary), bounce_delay) //Soft / non-solid turfs that shouldn't make a sound when a shell casing is ejected over them.

/obj/item/ammo_casing/add_notes_ammo()
	var/list/readout = list()
	readout += span_notice("<b>Caliber:</b> [caliber]")

	// Try to get a projectile to derive stats from
	var/obj/projectile/exam_proj = GLOB.proj_by_path_key[projectile_type]
	if(!istype(exam_proj) || (pellets == 0))
		return readout
	readout += span_notice("<b>Projectile Minimum Force:</b> [exam_proj.damage]")
	readout += span_notice("<b>Projectile Maximum Force:</b> [exam_proj.damage]")
	if(exam_proj.wound_bonus)
		readout += span_notice("<b>Projectile Wound Bonus:</b> [exam_proj.wound_bonus]")
	if(exam_proj.bare_wound_bonus)
		readout += span_notice("<b>Projectile Bare Wound Bonus:</b> [exam_proj.bare_wound_bonus]")
	if(exam_proj.organ_bonus)
		readout += span_notice("<b>Projectile Organ Bonus:</b> [exam_proj.organ_bonus]")
	if(exam_proj.bare_organ_bonus)
		readout += span_notice("<b>Projectile Bare Organ Bonus:</b> [exam_proj.bare_organ_bonus]")
	readout += span_notice("<b>Projectile Sharpness:</b> [capitalize_like_old_man(translate_sharpness(exam_proj.get_sharpness()))]")
	return readout.Join("\n")

/obj/item/ammo_casing/proc/update_icon_world()
	icon = world_icon
	icon_state = "[world_icon_state][loaded_projectile ? "-live" : ""]"
	return UPDATE_ICON_STATE | UPDATE_OVERLAYS
