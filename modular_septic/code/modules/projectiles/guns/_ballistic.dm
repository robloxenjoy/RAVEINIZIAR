/obj/item/gun/ballistic
	client_recoil_animation_information = list(
		"strength" = 0.35,
		"duration" = 2,
	)
	/// Why is this not already a variable?
	var/bolt_drop_sound_vary = FALSE
	/// Wording for the cylinder, for break action guns
	var/cylinder_wording = "cylinder"
	/// If this is a break action bolt gun, is the cylinder open?
	var/cylinder_open = FALSE
	/// Do we have a unique open cylinder icon_state?
	var/cylinder_shows_open = FALSE
	/// Does the cylinder open sprite get updated depending on ammo count?
	var/cylinder_shows_ammo_count = FALSE
	/// Gives us an unique icon_state with an uncocked hammer, if we are a break action or revovler
	var/uncocked_icon_state = FALSE
	/// Unracking sound
	var/unrack_sound = 'modular_septic/sound/weapons/guns/decock_generic.wav'
	/// Volume of unracking sound
	var/unrack_sound_volume = 40
	/// Whether unracking sound should vary
	var/unrack_sound_vary = TRUE

/obj/item/suppressor
	name = "suppressor"
	desc = "A multi-caliber suppressor for the discerete massacre of homeless, children, and homeless children."
	icon = 'modular_septic/icons/obj/items/gun_mods/mods.dmi'
	icon_state = "suppressor"

/obj/item/gun/ballistic/update_icon_state()
	. = ..()
	if((bolt_type == BOLT_TYPE_BREAK_ACTION) && uncocked_icon_state && bolt_locked)
		icon_state = "[icon_state]_uncocked"
	if(cylinder_open && cylinder_shows_open)
		icon_state = "[icon_state]_open"

/obj/item/gun/ballistic/update_overlays()
	. = ..()
	if(suppressed)
		var/image/suppressor_overlay = image(icon, "[base_icon_state]_suppressor")
		if(suppressor_x_offset)
			suppressor_overlay.pixel_x = suppressor_x_offset
		if(suppressor_y_offset)
			suppressor_overlay.pixel_y = suppressor_y_offset
		. += suppressor_overlay

	if(show_bolt_icon)
		if(bolt_type == BOLT_TYPE_LOCKING || bolt_type == BOLT_TYPE_OPEN || bolt_type == BOLT_TYPE_STANDARD)
			. += "[base_icon_state]_bolt[bolt_locked ? "_locked" : ""]"

	//this is duplicated in c20's update_overlayss due to a layering issue with the select fire icon
	if(!chambered && empty_indicator)
		. += "[base_icon_state]_empty"

	if(gun_flags & TOY_FIREARM_OVERLAY)
		. += "[base_icon_state]_toy"

	if(cylinder_open && cylinder_shows_open)
		. += "[base_icon_state]_cylinder[cylinder_shows_ammo_count ? "-[magazine ? magazine.ammo_count() : 0]" : ""]"

	if(!magazine || internal_magazine || !mag_display)
		return

	if(special_mags)
		. += "[base_icon_state]_mag_[initial(magazine.icon_state)]"
		if(mag_display_ammo && !magazine.ammo_count())
			. += "[base_icon_state]_mag_empty"
		return

	. += "[base_icon_state]_mag"
	if(!mag_display_ammo)
		return

	var/capacity_number
	switch(get_ammo() / magazine.max_ammo)
		if(1 to INFINITY) //cause we can have one in the chamber.
			capacity_number = 100
		if(0.8 to 1)
			capacity_number = 80
		if(0.6 to 0.8)
			capacity_number = 60
		if(0.4 to 0.6)
			capacity_number = 40
		if(0.2 to 0.4)
			capacity_number = 20
	if(capacity_number)
		. += "[base_icon_state]_mag_[capacity_number]"

/obj/item/gun/ballistic/add_weapon_description()
	AddElement(/datum/element/weapon_description, .proc/add_notes_gun)

/obj/item/gun/ballistic/get_carry_weight()
	. = ..()
	if(istype(magazine))
		. += magazine.get_carry_weight()

/obj/item/gun/ballistic/wrench_act(mob/living/user, obj/item/tool)
	return

/obj/item/gun/ballistic/screwdriver_act(mob/living/user, obj/item/tool)
	if(!user.is_holding(src))
		to_chat(user, span_warning("I need to hold [src] to modify it."))
		return TRUE

	if(!can_modify_ammo)
		return

	if(bolt_type == BOLT_TYPE_STANDARD)
		if(get_ammo())
			to_chat(user, span_warning("I can't get at the internals while the gun has a bullet in it!"))
			return

		else if(!bolt_locked)
			to_chat(user, span_warning("I can't get at the internals while the bolt is down!"))
			return

	to_chat(user, span_notice("I begin to tinker with [src]..."))
	tool.play_tool_sound(src)
	if(!tool.use_tool(src, user, 3 SECONDS))
		return TRUE

	if(blow_up(user))
		user.visible_message(span_danger("[src] goes off!"), \
							span_userdanger("[src] goes off in my face!"))
		return

	if(magazine.caliber == initial_caliber)
		magazine.caliber = alternative_caliber
		if(alternative_ammo_misfires)
			can_misfire = TRUE
		fire_sound = alternative_fire_sound
		to_chat(user, span_notice("I modify [src]. Now it will fire [alternative_caliber] rounds."))
	else
		magazine.caliber = initial_caliber
		if(alternative_ammo_misfires)
			can_misfire = FALSE
		fire_sound = initial_fire_sound
		to_chat(user, span_notice("I reset [src]. Now it will fire [initial_caliber] rounds."))

/obj/item/gun/ballistic/install_suppressor(obj/item/suppressor/suppressor)
	suppressed = suppressor
	w_class += suppressor.w_class //so pistols do not fit in pockets when suppressed
	for(var/variable in gunshot_animation_information)
		var/associated_value = gunshot_animation_information[variable]
		gunshot_animation_information -= variable
		gunshot_animation_information["old_[variable]"] = associated_value
	update_appearance()

/obj/item/gun/ballistic/clear_suppressor()
	if(!can_unsuppress)
		return
	if(isitem(suppressed))
		var/obj/item/suppressor = suppressed
		w_class -= suppressor.w_class
	for(var/variable in gunshot_animation_information)
		var/associated_value = gunshot_animation_information[variable]
		gunshot_animation_information -= variable
		if(findtext(variable, "old_", 1, 5))
			gunshot_animation_information[copytext(variable, 5)] = associated_value
		else
			gunshot_animation_information[variable] = associated_value
	suppressed = null
	update_appearance()

/obj/item/gun/ballistic/sawoff(mob/user, obj/item/saw)
	. = ..()
	if(.)
		if(LAZYACCESS(gunshot_animation_information, "add_pixel_x_sawn") && !isnull(LAZYACCESS(gunshot_animation_information, "pixel_x")))
			gunshot_animation_information["pixel_x"] += gunshot_animation_information["add_pixel_x_sawn"]

/obj/item/gun/ballistic/AltClick(mob/user)
	if(can_unsuppress && suppressed && user.is_holding(src))
		var/obj/item/suppressor/suppressor = suppressed
		playsound(user, 'modular_septic/sound/weapons/guns/silencer_start.ogg', 60, TRUE)
		to_chat(user, span_notice("I start unscrewing."))
		if(!do_after(user, 3 SECONDS, src))
			return
		to_chat(user, span_notice("I unscrew [suppressor] from [src]."))
		playsound(user, 'modular_septic/sound/weapons/guns/silencer_off.wav', 75, TRUE)
		user.put_in_hands(suppressor)
		clear_suppressor()
	else
		return ..()

/obj/item/gun/ballistic/attackby(obj/item/A, mob/user, params)
	. = ..()
	if(.)
		return
	if(!internal_magazine && istype(A, /obj/item/ammo_box/magazine))
		var/obj/item/ammo_box/magazine/new_magazine = A
		if(!magazine)
			insert_magazine(user, new_magazine)
		else
			if(tac_reloads)
				eject_magazine(user, FALSE, new_magazine)
			else
				to_chat(user, span_notice("There's already a [magazine_wording] in [src]."))
		return
	if(istype(A, /obj/item/ammo_casing) || istype(A, /obj/item/ammo_box))
		if(bolt_type == BOLT_TYPE_NO_BOLT || internal_magazine)
			if((bolt_type == BOLT_TYPE_BREAK_ACTION) && !cylinder_open)
				return
			if(chambered && !chambered.loaded_projectile)
				chambered.forceMove(drop_location())
				chambered = null
			var/num_loaded = magazine?.attackby(A, user, params, TRUE)
			if(num_loaded)
				to_chat(user, span_notice("I load [num_loaded] [cartridge_wording]\s into [src]."))
				playsound(src, load_sound, load_sound_volume, load_sound_vary)
				if(isnull(chambered) && (bolt_type == BOLT_TYPE_NO_BOLT))
					chamber_round()
				A.update_appearance()
				update_appearance()
			return
	if(istype(A, /obj/item/suppressor))
		var/obj/item/suppressor/suppressor = A
		if(!can_suppress)
			to_chat(user, span_warning("I can't figure out how to fit [suppressor] on [src]!"))
			return
		if(!user.is_holding(src))
			to_chat(user, span_warning("I need be holding [src] to fit [suppressor] to it!"))
			return
		if(suppressed)
			to_chat(user, span_warning("[src] already has a suppressor!"))
			return
		if(user.transferItemToLoc(suppressor, src))
			install_suppressor(suppressor)
			playsound(user, 'modular_septic/sound/weapons/guns/silencer_start.ogg', 60, TRUE)
			to_chat(user, span_notice("I start screwing."))
			if(!do_after(user, 3 SECONDS, src))
				user.put_in_hands(suppressor)
				playsound(user, 'modular_septic/sound/weapons/guns/silencer_fumble.ogg', 25, TRUE)
				clear_suppressor()
				return
			to_chat(user, span_notice("I screw [suppressor] onto [src]."))
			playsound(user, 'modular_septic/sound/weapons/guns/silencer_on.wav', 75, TRUE)
			return

	if(can_be_sawn_off)
		if(sawoff(user, A))
			return

	if(can_misfire && istype(A, /obj/item/stack/sheet/cloth))
		if(guncleaning(user, A))
			return

	return FALSE

/obj/item/gun/ballistic/attack_hand(mob/user, list/modifiers)
	if(cylinder_open && user.is_holding(src))
		add_fingerprint(user)
		var/obj/item/casing = magazine?.get_round(FALSE)
		if(casing)
			casing.forceMove(drop_location())
			user.put_in_hands(casing)
			update_appearance()
			return
	return ..()

/obj/item/gun/ballistic/MouseDrop(atom/over, src_location, over_location, src_control, over_control, params)
	. = ..()
	if(!isliving(usr) || !usr.Adjacent(src) || usr.incapacitated())
		return
	var/mob/living/user = usr
	if(istype(over, /atom/movable/screen/inventory/hand))
		if(bolt_type == BOLT_TYPE_BREAK_ACTION)
			toggle_cylinder_open(user)
		else if(!internal_magazine && magazine)
			var/atom/movable/screen/inventory/hand/hand_slot = over
			eject_magazine(user, hand_index = hand_slot.held_index)

/obj/item/gun/ballistic/before_can_shoot_checks(mob/living/user, autofire_start = FALSE)
	. = ..()
	//double action revolvers should automatically get cocked when firing
	if((bolt_type == BOLT_TYPE_BREAK_ACTION) && !cylinder_open && semi_auto && bolt_locked)
		bolt_locked = FALSE
		if(!autofire_start)
			chamber_round()
		update_appearance()

/obj/item/gun/ballistic/can_shoot()
	. = chambered
	if(cylinder_open)
		return FALSE
	if((bolt_type == BOLT_TYPE_BREAK_ACTION) && bolt_locked)
		return FALSE

/obj/item/gun/ballistic/drop_bolt(mob/user)
	playsound(src, bolt_drop_sound, bolt_drop_sound_volume, bolt_drop_sound_vary)
	if(user)
		to_chat(user, span_notice("I drop the [bolt_wording] of [src]."))
	chamber_round()
	bolt_locked = FALSE
	update_appearance()

/obj/item/gun/ballistic/rack(mob/user)
	switch(bolt_type)
		//If there's no bolt, nothing to rack
		if(BOLT_TYPE_NO_BOLT)
			return
		if(BOLT_TYPE_OPEN)
			//If it's an open bolt, racking again would do nothing
			if(!bolt_locked)
				if(user)
					to_chat(user, span_notice("[src]'s [bolt_wording] is already racked!"))
				return
			bolt_locked = FALSE
			chamber_round(TRUE)
			if(user)
				to_chat(user, span_notice("I rack the [bolt_wording] of [src]."))
			sound_hint()
			update_appearance()
		//Break actions only need racking if they are well, single action revolvers
		if(BOLT_TYPE_BREAK_ACTION)
			if(bolt_locked)
				if(user)
					to_chat(user, span_notice("I cock the [bolt_wording] of [src]."))
				chamber_round()
			else if(user)
				to_chat(user, span_notice("I decock the [bolt_wording] of [src]."))
			sound_hint()
			if(bolt_locked)
				playsound(src, rack_sound, rack_sound_volume, rack_sound_vary)
			else
				playsound(src, unrack_sound, unrack_sound_volume, unrack_sound_vary)
			bolt_locked = !bolt_locked
			update_appearance()
		else
			if(user)
				to_chat(user, span_notice("I rack the [bolt_wording] of [src]."))
			process_chamber(!chambered, FALSE)
			sound_hint()
			if(bolt_type == BOLT_TYPE_LOCKING && !chambered)
				bolt_locked = TRUE
				playsound(src, lock_back_sound, lock_back_sound_volume, lock_back_sound_vary)
			else
				playsound(src, rack_sound, rack_sound_volume, rack_sound_vary)
			update_appearance()

/obj/item/gun/ballistic/eject_magazine(mob/user, \
									display_message = TRUE, \
									obj/item/ammo_box/magazine/tac_load = null, \
									hand_index = null)
	if(bolt_type == BOLT_TYPE_OPEN)
		chambered = null
	sound_hint()
	if(magazine.ammo_count())
		playsound(src, eject_sound, eject_sound_volume, eject_sound_vary)
	else
		playsound(src, eject_empty_sound, eject_sound_volume, eject_sound_vary)
	magazine.forceMove(drop_location())
	var/obj/item/ammo_box/magazine/old_mag = magazine
	if(tac_load)
		if(insert_magazine(user, tac_load, FALSE))
			to_chat(user, span_notice("I perform a tactical reload on [src]."))
		else
			to_chat(user, span_warning("I drop the old [magazine_wording], but the new one doesn't fit."))
			magazine = null
	else
		magazine = null
	if(!hand_index)
		user.put_in_hands(old_mag)
	else
		user.put_in_hand(old_mag, hand_index)
	old_mag.update_appearance()
	if(display_message && !tac_load)
		to_chat(user, span_notice("I pull the [magazine_wording] out of [src]."))
	update_appearance()

/obj/item/gun/ballistic/fire_gun(atom/target, mob/living/user, flag, params)
	prefire_empty_checks()
	return ..()

/obj/item/gun/ballistic/on_autofire_start(mob/living/shooter)
	prefire_empty_checks()
	return ..()

/obj/item/gun/ballistic/do_autofire(datum/source, atom/target, mob/living/shooter, params)
	prefire_empty_checks()
	return ..()

/obj/item/gun/ballistic/process_fire(atom/target, mob/living/user, message, params, zone_override, bonus_spread)
	. = ..()
	postfire_empty_checks(.)

/obj/item/gun/ballistic/process_burst(mob/living/user, atom/target, message, params, zone_override, sprd, randomized_gun_spread, randomized_bonus_spread, rand_spr, iteration)
	. = ..()
	postfire_empty_checks(.)

/obj/item/gun/ballistic/shoot_with_empty_chamber(mob/living/user as mob|obj)
	if(ismob(user) && dry_fire_message)
		to_chat(user, dry_fire_message)
	sound_hint()
	if(dry_fire_sound)
		playsound(src, dry_fire_sound, 30, TRUE)
	update_appearance()

/obj/item/gun/ballistic/handle_chamber(empty_chamber = FALSE, from_firing = FALSE, chamber_next_round = FALSE)
	if((!semi_auto && from_firing) || (bolt_type == BOLT_TYPE_BREAK_ACTION))
		return
	var/obj/item/ammo_casing/casing = chambered //Get chambered round
	//there's a chambered round
	if(istype(casing))
		if(QDELING(casing))
			stack_trace("Trying to move a qdeleted casing of type [casing.type]!")
			chambered = null
		else if(casing_ejector || !from_firing)
			casing.forceMove(drop_location()) //Eject casing onto ground.
			casing.bounce_away(TRUE)
			SEND_SIGNAL(casing, COMSIG_CASING_EJECTED)
			chambered = null
		else if(empty_chamber)
			chambered = null
	if(chamber_next_round)
		chamber_round()

/obj/item/gun/ballistic/chamber_round(keep_bullet = FALSE, spin_cylinder = TRUE, replace_new_round = FALSE)
	if(!magazine)
		stack_trace("[src] ([type]) tried to chamber a round without a magazine!")
		return
	if(bolt_type == BOLT_TYPE_BREAK_ACTION)
		if(spin_cylinder)
			chambered = magazine.get_round(TRUE)
		else
			chambered = magazine.stored_ammo[1]
	else if(magazine.ammo_count())
		chambered = magazine.get_round(keep_bullet || bolt_type == BOLT_TYPE_NO_BOLT)
		if(bolt_type != BOLT_TYPE_OPEN)
			chambered.forceMove(src)
		if(replace_new_round)
			magazine.give_round(new chambered.type)

/obj/item/gun/ballistic/prefire_empty_checks()
	var/needs_update = FALSE
	if(!chambered && !get_ammo())
		if((bolt_type == BOLT_TYPE_OPEN) && !bolt_locked)
			playsound(src, bolt_drop_sound, bolt_drop_sound_volume)
			bolt_locked = TRUE
			needs_update = TRUE
	if(needs_update)
		update_appearance()

/obj/item/gun/ballistic/postfire_empty_checks(last_shot_succeeded = FALSE)
	var/needs_update = FALSE
	if(!chambered && !get_ammo() && last_shot_succeeded)
		if(empty_alarm)
			playsound(src, empty_alarm_sound, empty_alarm_volume, empty_alarm_vary)
		if(bolt_type == BOLT_TYPE_LOCKING)
			bolt_locked = TRUE
			needs_update = TRUE
	if(bolt_type == BOLT_TYPE_BREAK_ACTION)
		bolt_locked = TRUE
		needs_update = TRUE
	if(needs_update)
		update_appearance()

///Toggles between open cylinder and closed cylinder
/obj/item/gun/ballistic/proc/toggle_cylinder_open(mob/user)
	cylinder_open = !cylinder_open
	sound_hint()
	if(cylinder_open)
		playsound(src, bolt_drop_sound, lock_back_sound_volume, lock_back_sound_vary)
		chambered = null
	else
		playsound(src, lock_back_sound, bolt_drop_sound_volume, bolt_drop_sound_vary)
		chamber_round()
	if(user)
		to_chat(user, span_notice("I [cylinder_open ? "open" : "close"] [src]'s [cylinder_wording]"))
	update_appearance()

///Gives us info about ammo count, open cylinder, etc
/obj/item/gun/ballistic/proc/chamber_examine(mob/user)
	. = list()
	var/p_They = p_they(TRUE)
	var/p_Their = p_their(TRUE)
	var/p_are = p_are()
	var/p_have = p_have()
	if(!chambered)
		. += "[p_They] [span_green("[p_do()] not [p_have()]")] a round chambered."
	else
		. += "[p_They] [span_red("[p_have()]")] a round chambered."
	if(bolt_type == BOLT_TYPE_BREAK_ACTION)
		. += "[p_Their] [cylinder_wording] is [cylinder_open ? span_green("open") : span_red("closed")]."
	if(bolt_locked)
		switch(bolt_wording)
			if("pump")
				. += "[p_They] [p_are] [span_green("not pumped")]."
			if("hammer")
				. += "[p_Their] [bolt_wording] is [span_green("uncocked")]."
			if("bolt")
				. += "[p_Their] [bolt_wording] is [span_green("open.")]"
			else
				. += "[p_Their] [bolt_wording] is [span_green("locked")]."
	else
		switch(bolt_wording)
			if("pump")
				. += "[p_Their] [p_are] [span_red("pumped")]."
			if("hammer")
				. += "[p_Their] [bolt_wording] is [span_red("cocked")]."
			if("bolt")
				. += "[p_Their] [bolt_wording] is [span_red("closed")]."
			else
				. += "[p_Their] [bolt_wording] is [span_red("unlocked")]."
	if(cylinder_open)
		var/all_ammo = get_ammo(FALSE, FALSE)
		. += "[p_they(TRUE)] [p_have] [all_ammo ? all_ammo : "no"] round\s remaining."
		if(all_ammo)
			var/live_ammo = get_ammo(TRUE, FALSE)
			. += "[live_ammo ? live_ammo : "None"] of those are live rounds."
