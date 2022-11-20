/obj/item/gun
	skill_melee = SKILL_IMPACT_WEAPON
	skill_ranged = SKILL_PISTOL
	carry_weight = 2.5 KILOGRAMS
	pickup_sound = 'modular_septic/sound/weapons/guns/generic_draw.wav'
	dry_fire_sound = 'modular_septic/sound/weapons/guns/empty.wav'
	/// Message when we dry fire (applies both to dry firing and failing to fire for other reasons)
	var/dry_fire_message = span_danger("*click*")
	/// Volume of dry_fire_sound
	var/dry_fire_sound_volume = 30
	/// Whether to vary dry_fire_sound or not
	var/dry_fire_sound_vary = FALSE
	/// Sound for aiming at someone
	var/aim_stress_sound = 'modular_septic/sound/weapons/guns/aim_stress.wav'
	/// Volume for aiming sound
	var/aim_stress_sound_volume = 50
	/// Whether the aiming sound should vary on not
	var/aim_stress_sound_vary = FALSE
	/// Sound for stopping aiming at someone
	var/aim_spare_sound = 'modular_septic/sound/weapons/guns/aim_spare.wav'
	/// Volume for stopping aiming sound
	var/aim_spare_sound_volume = 50
	/// Whether the stopping aiming sound should vary on not
	var/aim_spare_sound_vary = FALSE
	/// Flags related to gun safety
	var/safety_flags = GUN_SAFETY_FLAGS_DEFAULT
	/// Sound when safety is toggled on
	var/safety_on_sound = 'modular_septic/sound/weapons/guns/safety1.ogg'
	/// Sound when safety is toggled off
	var/safety_off_sound = 'modular_septic/sound/weapons/guns/safety1.ogg'
	/// Volume of safety toggle sounds (both on and off)
	var/safety_sound_volume = 50
	/// Whether to vary safety toggle sounds or not
	var/safety_sound_vary = FALSE

	// ~ICON VARIABLES
	/// Mouse pointer icon when holding this gun while the safety is disabled
	var/mouse_pointer_icon = 'modular_septic/icons/effects/mouse_pointers/weapon_pointer.dmi'
	/// Does the gun have a unique icon_state when nothing is chambered?
	var/empty_icon_state = FALSE
	/// Does the gun have unique inhands when wielded?
	var/wielded_inhand_state = FALSE
	/// Does the inhand state get modifier when sawn?
	var/sawn_inhand_state = FALSE

	// ~ANIMATION VARIABLES
	/// If this gun has a gunshot animation, this stores info such as icon, icon_state, pixel_x and pixel_y
	var/list/gunshot_animation_information = null
	/// If this gun has a recoil animation, this stores info such as angle and duration
	var/list/recoil_animation_information = null
	/// If this gun has client recoil, this stores info such as amount and duration
	var/list/client_recoil_animation_information = null

	/// Add this to the projectile diceroll modifiers of whatever we fire
	var/diceroll_modifier = 0
	/// Add this to the projectile diceroll modifiers of whatever we fire, but ONLY against a specified target
	var/list/target_specific_diceroll = null

	/// Aiming bonus that gets added in target_specific_diceroll, on stage 0
	var/stage_zero_aim_bonus = 0
	/// Aiming bonus that gets added in target_specific_diceroll, on stage 1
	var/stage_one_aim_bonus = 0
	/// Aiming bonus that gets added in target_specific_diceroll, on stage 2
	var/stage_two_aim_bonus = 0
	/// Aiming bonus that gets added in target_specific_diceroll, on stage 3
	var/stage_three_aim_bonus = 0

	/// NO FULL AUTO IN BUILDINGS!
	var/full_auto = FALSE

	// Folding stock variables
	/// Allows the gun's stock to be folded and unfolded.
	var/foldable = FALSE
	/// Whether the stock is folded or not.
	var/folded = TRUE
	/// The sound it makes when you fold a stock
	var/fold_open_sound = 'modular_septic/sound/weapons/guns/stock_open.wav'
	/// The sound it makes when you unfold a stock.
	var/fold_close_sound = 'modular_septic/sound/weapons/guns/stock_close.wav'
	/// Every time you fiddle with the stock
	var/fiddle = 'modular_septic/sound/effects/fiddle.wav'

/obj/item/gun/Initialize(mapload)
	. = ..()
	if(foldable)
		new /datum/action/item_action/toggle_stock(src)
	if(full_auto)
		AddComponent(/datum/component/automatic_fire)

/obj/item/gun/update_icon(updates)
	. = ..()
	if(wielded_inhand_state)
		if(SEND_SIGNAL(src, COMSIG_TWOHANDED_WIELD_CHECK))
			inhand_icon_state = "[initial(inhand_icon_state)][(sawn_off && sawn_inhand_state) ? "_sawn" : ""]_wielded"
		else
			inhand_icon_state = "[initial(inhand_icon_state)][(sawn_off && sawn_inhand_state) ? "_sawn" : ""]"
	else if(sawn_inhand_state)
		inhand_icon_state = "[initial(inhand_icon_state)][sawn_off ? "_sawn" : ""]"

/obj/item/gun/update_icon_state()
	. = ..()
	if(empty_icon_state && !chambered)
		icon_state = "[icon_state]_empty"

/obj/item/gun/update_overlays()
	. = ..()
	if(foldable)
		//generally, the stock should be below everything else, otherwise it will look very fucked
		var/image/folding_image = image(icon, src, "[base_icon_state]_[folded ? "folded" : "unfolded"]")
		folding_image.layer = layer - 1
		. += folding_image
	if(gun_light)
		var/image/flashlight_overlay
		var/state = "[gunlight_state][gun_light.on? "_on":""]" //Generic state.
		if(gun_light.icon_state in icon_states('icons/obj/guns/flashlights.dmi')) //Snowflake state?
			state = gun_light.icon_state
		flashlight_overlay = image('icons/obj/guns/flashlights.dmi', state)
		flashlight_overlay.pixel_x = flight_x_offset
		flashlight_overlay.pixel_y = flight_y_offset
		. += flashlight_overlay
	if(bayonet)
		var/image/knife_overlay
		var/state = "bayonet" //Generic state.
		if(bayonet.icon_state in icon_states('icons/obj/guns/bayonets.dmi')) //Snowflake state?
			state = bayonet.icon_state
		knife_overlay = image('icons/obj/guns/bayonets.dmi', state)
		knife_overlay.pixel_x = knife_x_offset
		knife_overlay.pixel_y = knife_y_offset
		. += knife_overlay
	if(safety_flags & GUN_SAFETY_HAS_SAFETY)
		var/image/safety_overlay
		if((safety_flags & GUN_SAFETY_ENABLED) && (safety_flags & GUN_SAFETY_OVERLAY_ENABLED))
			safety_overlay = image(icon, src, "[base_icon_state]_safe")
		else if(!(safety_flags & GUN_SAFETY_ENABLED) && (safety_flags & GUN_SAFETY_OVERLAY_DISABLED))
			safety_overlay = image(icon, src, "[base_icon_state]_unsafe")
		if(safety_overlay)
			. += safety_overlay

/obj/item/gun/examine(mob/user)
	. = ..()
	var/safety_examine = safety_examine(user)
	if(LAZYLEN(safety_examine))
		. += safety_examine

/obj/item/gun/add_weapon_description()
	AddElement(/datum/element/weapon_description, .proc/add_notes_gun)

/obj/item/gun/get_carry_weight()
	. = ..()
	if(istype(pin))
		. += pin.get_carry_weight()

/obj/item/gun/equipped(mob/living/user, slot)
	. = ..()
	if(slot == ITEM_SLOT_HANDS)
		user.update_mouse_pointer()

/obj/item/gun/dropped(mob/user)
	. = ..()
	user.update_mouse_pointer()

/obj/item/gun/MouseDrop(atom/over, src_location, over_location, src_control, over_control, params)
	. = ..()
	if(!foldable)
		return
	if(!isliving(usr) || !usr.Adjacent(src) || usr.incapacitated())
		return
	var/mob/living/user = usr
	if(isopenturf(over))
		toggle_stock(user)

/obj/item/gun/attackby(obj/item/I, mob/living/user, params)
	var/list/modifiers = params2list(params)
	if(IS_HARM_INTENT(user, modifiers))
		return ..()
	else if(istype(I, /obj/item/flashlight/seclite))
		if(!can_flashlight)
			return ..()
		var/obj/item/flashlight/seclite/seclite = I
		if(!gun_light)
			if(!user.transferItemToLoc(I, src))
				return
			to_chat(user, span_notice("I click [seclite] into place on [src]."))
			set_gun_light(seclite)
			update_gunlight()
			playsound(src, 'modular_septic/sound/weapons/guns/mod_use.wav', 75, TRUE, vary = FALSE)
			alight = new(src)
			if(loc == user)
				alight.Grant(user)
	else if(istype(I, /obj/item/knife))
		var/obj/item/knife/knife = I
		if(!can_bayonet || !knife.bayonet || bayonet) //ensure the gun has an attachment point available, and that the knife is compatible with it.
			return ..()
		if(!user.transferItemToLoc(I, src))
			return
		to_chat(user, span_notice("I attach [knife] to [src]'s bayonet lug."))
		bayonet = knife
		playsound(src, 'modular_septic/sound/weapons/guns/mod_use.wav', 75, TRUE, vary = FALSE)
		update_appearance()
	else
		return ..()

/obj/item/gun/attack_self_secondary(mob/user, modifiers)
	. = ..()
	if(safety_flags & GUN_SAFETY_HAS_SAFETY)
		toggle_safety(user)

/obj/item/gun/attack_secondary(mob/living/victim, mob/living/user, params)
	if(user == victim)
		to_chat(user, span_warning("I can't hold myself up!"))
		return SECONDARY_ATTACK_CANCEL_ATTACK_CHAIN
	var/datum/component/gunpoint/existing_gunpoint = user.GetComponent(/datum/component/gunpoint)
	if(user.GetComponent(/datum/component/gunpoint))
		existing_gunpoint.cancel()
		return SECONDARY_ATTACK_CANCEL_ATTACK_CHAIN

	user.AddComponent(/datum/component/gunpoint, victim, src)
	return SECONDARY_ATTACK_CANCEL_ATTACK_CHAIN

/obj/item/gun/afterattack(atom/target, mob/living/user, flag, params)
	attack_fatigue_cost = 0
	return ..()

/obj/item/gun/afterattack_secondary(atom/target, mob/user, proximity_flag, click_parameters)
	var/datum/component/gunpoint/existing_gunpoint = user.GetComponent(/datum/component/gunpoint)
	if(user.GetComponent(/datum/component/gunpoint))
		existing_gunpoint.cancel()
		return SECONDARY_ATTACK_CANCEL_ATTACK_CHAIN
	if(!isliving(target))
		return SECONDARY_ATTACK_CANCEL_ATTACK_CHAIN
	if(user == target)
		to_chat(user, span_warning("I can't hold myself up!"))
		return SECONDARY_ATTACK_CANCEL_ATTACK_CHAIN

	user.AddComponent(/datum/component/gunpoint, target, src)
	return SECONDARY_ATTACK_CANCEL_ATTACK_CHAIN

/obj/item/gun/fire_gun(atom/target, mob/living/user, flag, params)
	if(QDELETED(target))
		return
	if(firing_burst)
		return
	//It's adjacent, is the user, or is on the user's person
	if(flag)
		//Can't shoot stuff inside us.
		if(target in user.contents)
			return
		var/list/modifiers = params2list(params)
		//Gun does not fire when flogging
		if((safety_flags & GUN_SAFETY_NO_FLOGGING) && IS_HARM_INTENT(user, modifiers))
			return
		if(iscarbon(target) && !IS_HARM_INTENT(user, modifiers))
			var/mob/living/carbon/carbon_target = target
			for(var/datum/wound/wound as anything in carbon_target.all_wounds)
				if(wound.try_treating(src, user))
					return

	//Check if the user can use the gun, if the user isn't alive (turrets) assume it can.
	if(istype(user))
		if(!can_trigger_gun(user))
			shoot_with_empty_chamber(user)
			return

	//Just because you can pull the trigger doesn't mean it can shoot.
	before_can_shoot_checks(user, FALSE)
	if(!can_shoot())
		shoot_with_empty_chamber(user)
		return

	if(check_botched(user, target))
		return

	//DUAL (or more!) WIELDING
	var/bonus_spread = 0
	var/loop_counter = 0
	var/list/modifiers = params2list(params)
	if(ishuman(user) && IS_HARM_INTENT(user, modifiers))
		var/mob/living/carbon/human/human_user = user
		for(var/obj/item/gun/other_gun in human_user.held_items)
			if((other_gun == src) || (other_gun.weapon_weight >= WEAPON_MEDIUM))
				continue
			else if(other_gun.can_trigger_gun(user))
				bonus_spread += dual_wield_spread
				loop_counter++
				addtimer(CALLBACK(other_gun, /obj/item/gun.proc/process_fire, target, user, TRUE, params, null, bonus_spread), loop_counter)

	return process_fire(target, user, TRUE, params, null, bonus_spread)

/obj/item/gun/can_trigger_gun(mob/living/user)
	. = ..()
	// Safety checks are handled here so as not to break turrets
	if(CHECK_MULTIPLE_BITFIELDS(safety_flags, GUN_SAFETY_HAS_SAFETY | GUN_SAFETY_ENABLED))
		return FALSE

/obj/item/gun/check_botched(mob/living/user, params)
	if(clumsy_check)
		if(istype(user))
			if(HAS_TRAIT(user, TRAIT_CLUMSY) && prob(40))
				to_chat(user, span_userdanger("I shoot myself in the foot with [src]!"))
				var/shot_foot = pick(BODY_ZONE_PRECISE_R_FOOT, BODY_ZONE_PRECISE_L_FOOT)
				process_fire(user, user, FALSE, params, shot_foot)
				SEND_SIGNAL(user, COMSIG_MOB_CLUMSY_SHOOT_FOOT)
				user.dropItemToGround(src, TRUE)
				return TRUE

/obj/item/gun/shoot_live_shot(mob/living/user, pointblank = FALSE, atom/target, message = TRUE)
	if(LAZYLEN(client_recoil_animation_information))
		var/duration = client_recoil_animation_information["duration"]
		var/strength = client_recoil_animation_information["strength"]
		var/easing = client_recoil_animation_information["easing"] || CUBIC_EASING|EASE_OUT
		var/angle_to_target = SIMPLIFY_DEGREES(get_angle(user, target) + 90)
		var/recoil_angle = SIMPLIFY_DEGREES(angle_to_target + 180)
		recoil_camera(user, duration, recoil_angle, strength, easing)

	sound_hint()

	if(suppressed)
		playsound(user, suppressed_sound, suppressed_volume, vary_fire_sound, ignore_walls = FALSE, extrarange = SILENCED_SOUND_EXTRARANGE, falloff_distance = 0)
	else
		playsound(user, fire_sound, fire_sound_volume, vary_fire_sound)
		if(message)
			if(pointblank)
				if(ismob(target))
					user.visible_message(span_danger("<b>[user]</b> fires [src] point blank at <b>[target]</b>!"), \
									span_danger("I fire [src] point blank at <b>[target]</b>!"), \
									span_hear("I hear a gunshot!"), COMBAT_MESSAGE_RANGE, target)
					to_chat(target, span_userdanger("<b>[user]</b> fires [src] point blank at me!"))
				else
					user.visible_message(span_danger("<b>[user]</b> fires [src] point blank at [target]!"), \
									span_danger("I fire [src] point blank at [target]!"), \
									span_hear("I hear a gunshot!"), COMBAT_MESSAGE_RANGE, target)
				if(pb_knockback > 0 && ismob(target))
					var/mob/mob_target = target
					var/atom/throw_target = get_edge_target_turf(mob_target, user.dir)
					mob_target.throw_at(throw_target, pb_knockback, 2)
			else
				if(ismob(target))
					user.visible_message(span_danger("<b>[user]</b> fires [src] at <b>[target]</b>!"), \
									span_danger("I fire [src] at <b>[target]</b>!"), \
									span_hear("I hear a gunshot!"), COMBAT_MESSAGE_RANGE, target)
				else
					user.visible_message(span_danger("<b>[user]</b> fires [src] at [target]!"), \
									span_danger("I fire [src] at [target]!"), \
									span_hear("I hear a gunshot!"), COMBAT_MESSAGE_RANGE, target)

	if(weapon_weight >= WEAPON_HEAVY)
		if(!SEND_SIGNAL(src, COMSIG_TWOHANDED_WIELD_CHECK) && (GET_MOB_ATTRIBUTE_VALUE(user, STAT_STRENGTH) < 20))
			user.dropItemToGround(src)
			to_chat(user, span_userdanger(uppertext(fail_msg(TRUE))))
	else if(weapon_weight >= WEAPON_MEDIUM)
		if(!SEND_SIGNAL(src, COMSIG_TWOHANDED_WIELD_CHECK) && (GET_MOB_ATTRIBUTE_VALUE(user, STAT_STRENGTH) < 14))
			user.dropItemToGround(src)
			to_chat(user, span_userdanger(uppertext(fail_msg(TRUE))))

/obj/item/gun/on_autofire_start(mob/living/shooter)
	if(semicd || shooter.stat)
		return NONE
	if(istype(src, /obj/item/gun/ballistic/automatic))
		var/obj/item/gun/ballistic/automatic/automatic_source = src
		//Not on full auto select
		if(automatic_source.select != 3)
			return NONE
	//Check if the user can use the gun, if the user isn't alive (turrets) assume it can
	if(istype(shooter))
		if(!can_trigger_gun(shooter))
			shoot_with_empty_chamber(shooter)
			return NONE
	//Just because you can pull the trigger doesn't mean it can shoot
	before_can_shoot_checks(shooter, TRUE)
	if(!can_shoot())
		shoot_with_empty_chamber(shooter)
		return NONE
	return TRUE

/obj/item/gun/do_autofire(datum/source, atom/target, mob/living/shooter, params)
	if(semicd || shooter.stat)
		return NONE
	if(istype(src, /obj/item/gun/ballistic/automatic))
		var/obj/item/gun/ballistic/automatic/automatic_source = src
		//Not on full auto select
		if(automatic_source.select != 3)
			return NONE
	//Check if the user can use the gun, if the user isn't alive (turrets) assume it can
	if(istype(shooter))
		if(!can_trigger_gun(shooter))
			shoot_with_empty_chamber(shooter)
			return NONE
	//Just because you can pull the trigger doesn't mean it can shoot
	before_can_shoot_checks(shooter, FALSE)
	if(!can_shoot())
		shoot_with_empty_chamber(shooter)
		return NONE
	INVOKE_ASYNC(src, .proc/do_autofire_shot, source, target, shooter, params)
	return COMPONENT_AUTOFIRE_SHOT_SUCCESS //All is well, we can continue shooting

/obj/item/gun/shoot_with_empty_chamber(mob/living/user as mob|obj)
	if(ismob(user) && dry_fire_message)
		to_chat(user, dry_fire_message)
	if(dry_fire_sound)
		playsound(src, dry_fire_sound, dry_fire_sound_volume, dry_fire_sound_vary)
	sound_hint()

/obj/item/gun/proc/initialize_full_auto()
	if(!full_auto)
		return FALSE
	AddComponent(/datum/component/automatic_fire)

/obj/item/gun/proc/add_notes_gun(mob/user)
	. = list()
	switch(weapon_weight)
		if(WEAPON_HEAVY)
			. += span_notice("<b>Weapon Weight:</b> Heavy")
		if(WEAPON_MEDIUM)
			. += span_notice("<b>Weapon Weight:</b> Medium")
		if(WEAPON_LIGHT)
			. += span_notice("<b>Weapon Weight:</b> Light")
		else
			. += span_notice("<b>Weapon Weight:</b> Invalid")

/obj/item/gun/proc/before_can_shoot_checks(mob/living/user, autofire_start = FALSE)
	return TRUE

/obj/item/gun/proc/safety_examine(mob/user)
	. = list()
	if(safety_flags & GUN_SAFETY_HAS_SAFETY)
		var/safety_text = span_red("OFF")
		if(safety_flags & GUN_SAFETY_ENABLED)
			safety_text = span_green("ON")
		. += "[p_their(TRUE)] safety is [safety_text]."

/obj/item/gun/proc/toggle_safety(mob/user)
	if(!(safety_flags & GUN_SAFETY_HAS_SAFETY))
		return
	if(safety_flags & GUN_SAFETY_ENABLED)
		safety_flags &= ~GUN_SAFETY_ENABLED
		if(safety_off_sound)
			playsound(src, safety_off_sound, safety_sound_volume, safety_sound_vary)
	else
		safety_flags |= GUN_SAFETY_ENABLED
		if(safety_on_sound)
			playsound(src, safety_on_sound, safety_sound_volume, safety_sound_vary)
	if(user)
		to_chat(user, span_notice("I [safety_flags & GUN_SAFETY_ENABLED ? "enable" : "disable"] [src]'s safety."))
	sound_hint()
	update_appearance()
	user.update_mouse_pointer()

/obj/item/gun/proc/firing_animation(mob/user, burst_fire = FALSE)
	if(gunshot_animation_information)
		INVOKE_ASYNC(src, .proc/gunshot_animation, user, burst_fire)
	if(recoil_animation_information)
		INVOKE_ASYNC(src, .proc/recoil_animation, user, burst_fire)

// wARNING: For some god forsaken reason, the recoil animation conflicts pretty badly with the gunshot, as the gunshot refuses to get angled
/obj/item/gun/proc/gunshot_animation(mob/user, burst_fire = FALSE)
	if(suppressed && LAZYACCESS(gunshot_animation_information, "inactive_wben_silenced"))
		return
	var/shot_icon = gunshot_animation_information["icon"] || 'modular_septic/icons/effects/gunshot.dmi'
	var/shot_icon_state = gunshot_animation_information["icon_state"] || "gunshot"
	var/shot_duration = gunshot_animation_information["duration"] || 2
	var/shot_pixel_x = gunshot_animation_information["pixel_x"] || 0
	var/shot_pixel_y = gunshot_animation_information["pixel_y"] || 0
	var/image/shots_fired = image(shot_icon, shot_icon_state, src.layer-0.01)
	shots_fired.pixel_x = shot_pixel_x
	shots_fired.pixel_y = shot_pixel_y
	add_overlay(shots_fired)
	sleep(shot_duration)
	cut_overlay(shots_fired)

/obj/item/gun/proc/recoil_animation(mob/user, burst_fire = FALSE)
	if(recoil_animation_information["doing_recoil_burst_animation"])
		return
	if(burst_fire)
		return recoil_animation_burst(user, burst_fire)

	var/recoil_angle_upper = recoil_animation_information["recoil_angle_upper"] || -20
	var/recoil_angle_lower = recoil_animation_information["recoil_angle_lower"] || -40
	var/recoil_speed = recoil_animation_information["recoil_speed"] || 2
	var/return_speed = recoil_animation_information["return_speed"] || 2
	var/recoil_easing = recoil_animation_information["recoil_easing"] || ELASTIC_EASING
	var/return_easing = recoil_animation_information["return_easing"] || ELASTIC_EASING

	var/matrix/return_matrix = matrix(transform)
	var/matrix/recoil_matrix = matrix(transform)
	recoil_matrix = recoil_matrix.Turn(rand(recoil_angle_lower, recoil_angle_upper))

	animate(src, transform = recoil_matrix, time = recoil_speed, easing = recoil_easing)
	sleep(recoil_speed)
	animate(src, transform = return_matrix, time = return_speed, easing = return_easing)

/obj/item/gun/proc/recoil_animation_burst(mob/user, burst_fire = FALSE)
	var/recoil_burst_angle_upper = recoil_animation_information["recoil_burst_angle_upper"] || -5
	var/recoil_burst_angle_lower = recoil_animation_information["recoil_burst_angle_upper"] || -10
	var/recoil_burst_speed = recoil_animation_information["recoil_burst_speed"] || 0.5
	var/return_burst_speed = recoil_animation_information["return_burst_speed"] || 0.5
	var/recoil_burst_easing = recoil_animation_information["recoil_burst_easing"] || ELASTIC_EASING
	var/return_burst_easing = recoil_animation_information["return_burst_easing"] || ELASTIC_EASING
	var/recoil_burst_pixel_x = recoil_animation_information["recoil_burst_pixel_x"] || -5
	var/recoil_burst_pixel_y = recoil_animation_information["recoil_burst_pixel_y"] || 0

	var/old_pixel_x = pixel_x
	var/new_pixel_x = pixel_x+recoil_burst_pixel_x
	var/old_pixel_y = pixel_y
	var/new_pixel_y = pixel_y+recoil_burst_pixel_y
	var/matrix/return_matrix = matrix(transform)
	var/matrix/recoil_matrix = matrix(transform)
	recoil_matrix = recoil_matrix.Turn(rand(recoil_burst_angle_lower, recoil_burst_angle_upper))

	recoil_animation_information["doing_recoil_burst_animation"] = TRUE
	for(var/i in 1 to burst_size)
		animate(src, transform = recoil_matrix, time = recoil_burst_speed, easing = recoil_burst_easing, flags = ANIMATION_PARALLEL)
		animate(src, pixel_x = new_pixel_x, time = recoil_burst_speed, easing = recoil_burst_easing, flags = ANIMATION_PARALLEL)
		animate(src, pixel_y = new_pixel_y, time = recoil_burst_speed, easing = recoil_burst_easing, flags = ANIMATION_PARALLEL)
		sleep(recoil_burst_speed)
		animate(src, transform = return_matrix, pixel_x = old_pixel_x, pixel_y = old_pixel_y, time = return_burst_speed, easing = return_burst_easing, flags = ANIMATION_PARALLEL)
		animate(src, pixel_x = old_pixel_x, time = return_burst_speed, easing = recoil_burst_easing, flags = ANIMATION_PARALLEL)
		animate(src, pixel_y = old_pixel_y, time = return_burst_speed, easing = recoil_burst_easing, flags = ANIMATION_PARALLEL)
		sleep(return_burst_speed)
	recoil_animation_information["doing_recoil_burst_animation"] = FALSE

/obj/item/gun/ui_action_click(mob/user, actiontype) /// Allows users to spew facts
	if(istype(actiontype, /datum/action/item_action/toggle_stock))
		toggle_stock(user)
	else
		return ..()

/obj/item/gun/proc/toggle_stock(mob/user)
	if(!foldable)
		return
	playsound(src, fiddle, 68, FALSE)
	if(!do_after(user, 0.5 SECONDS, src))
		return
	if(!folded)
		w_class--
		folded = TRUE
		playsound(src, fold_close_sound, 80, FALSE)
		to_chat(user, span_notice("I fold [src]'s stock."))
	else
		w_class++
		folded = FALSE
		playsound(src, fold_open_sound, 80, FALSE)
		to_chat(user, span_notice("I unfold [src]'s stock."))
	update_appearance()

/datum/action/item_action/toggle_stock
	name = "Toggle Stock"
	icon_icon = 'modular_septic/icons/hud/quake/actions.dmi'
	button_icon_state = "stock"
