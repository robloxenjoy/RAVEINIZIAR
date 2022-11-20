/obj/item/clothing
	/** This is basically translating body_parts_covered into a readable list.
	 *  List updates on examine because it's currently only used to print coverage to chat in Topic().
	 */
	var/list/body_parts_list = list()
	// ~DAMAGE SYSTEM VARIABLES (see _global_vars/lists/armor_sounds.dm)
	/// If this is set, then repairing this thing requires this item on the offhand
	var/repairable_by_offhand
	/// Sounds we do when a zone is damaged
	var/armor_damaged_sound = "heavy"
	/// Volume of the aforementioned sound
	var/armor_damaged_sound_volume = 100
	/// Sound we do when a zone is damaged, to the wearer
	var/armor_damaged_sound_local
	/// Volume of the aforementioned sound
	var/armor_damaged_sound_local_volume = 100
	/// Sound we do when a zone is broken
	var/armor_broken_sound = "heavy"
	/// Volume of the aforementioned sound
	var/armor_broken_sound_volume = 100
	/// Sound we do when a zone is broken, to the wearer
	var/armor_broken_sound_local
	/// Volume of the aforementioned sound
	var/armor_broken_sound_local_volume = 100
	/// Damage modifier that gets applied for normal integrity damage when a zone is damaged
	var/integrity_zone_damage_modifier = 0.1
	/// Total integrity of the armor
	max_integrity = 200
	/// Point at which armor is fuckoff useless
	integrity_failure = 0.5
	/// How much integrity to give each limb
	limb_integrity = 0
	// Assume that clothing isn't too weighty by default
	carry_weight = 2 KILOGRAMS

/obj/item/clothing/update_overlays()
	. = ..()
	if(!damaged_clothes)
		return

	var/index = "[REF(icon)]-[icon_state]"
	var/static/list/damaged_clothes_icons = list()
	var/icon/damaged_clothes_icon = damaged_clothes_icons[index]
	if(!damaged_clothes_icon)
		damaged_clothes_icon = icon(icon, icon_state, , 1)
		//fills the icon_state with white (except where it's transparent)
		damaged_clothes_icon.Blend("#ffffff", ICON_ADD)
		//adds damage effect and the remaining white areas become transparant
		damaged_clothes_icon.Blend(icon('modular_septic/icons/effects/item_damage.dmi', "itemdamaged"), ICON_MULTIPLY)
		//makes it black because remis is a stupid nigger kys
		damaged_clothes_icon.Blend("#000000", ICON_MULTIPLY)
		damaged_clothes_icon = fcopy_rsc(damaged_clothes_icon)
		damaged_clothes_icons[index] = damaged_clothes_icon
	. += damaged_clothes_icon

/obj/item/clothing/attackby(obj/item/attacking_item, mob/user, params)
	if(!istype(attacking_item, repairable_by))
		return ..()

	if(!LAZYACCESS(damage_by_parts, user.zone_selected))
		to_chat(user, span_warning("[src]'s [capitalize(parse_zone(user.zone_selected))] is not broken."))
		return TRUE
	var/obj/item/stack/stack = attacking_item
	if(stack.amount < 1)
		to_chat(user, span_warning("Not enough [stack.name] to repair [src]."))
		return TRUE
	var/obj/item/stack/offhand_stack
	if(repairable_by_offhand)
		offhand_stack = user.get_inactive_held_item()
		var/obj/item/stack/ghost_stack = repairable_by_offhand
		if(!istype(offhand_stack, repairable_by_offhand))
			to_chat(user, span_warning("I also need [initial(ghost_stack.name)] to repair [src]."))
			return TRUE
		if(offhand_stack.amount < 1)
			to_chat(user, span_warning("Not enough [offhand_stack.name] to repair [src]."))
			return TRUE
	to_chat(user, span_notice("I begin fixing the damage on [src] with [stack]..."))
	if(!do_after(user, 5 SECONDS, src) || !stack.use(1) || (offhand_stack && !offhand_stack.use(1)))
		to_chat(user, span_warning(fail_msg()))
		return TRUE

	repair_zone(user, user.zone_selected, params)
	return TRUE

/obj/item/clothing/take_damage_zone(def_zone = BODY_ZONE_CHEST, \
									damage_amount = 0, \
									damage_flag = MELEE, \
									damage_type = BRUTE, \
									sharpness = NONE, \
									armour_penetration = 100)
	// the second check sees if we only cover one bodypart anyway and don't need to bother with this
	if(!def_zone || !limb_integrity)
		return FALSE
	// what do we actually cover?
	var/list/covered_limbs = body_parts_covered2organ_names(body_parts_covered)
	if(!(def_zone in covered_limbs))
		return FALSE

	// only deal 10% of the damage to the general integrity damage, then multiply it by 10 so we know how much to deal to limb
	var/damage_dealt = take_damage(damage_amount * integrity_zone_damage_modifier, damage_type, damage_flag, sound_effect = FALSE, armour_penetration = armour_penetration) * 10
	LAZYINITLIST(damage_by_parts)
	if(isnull(damage_by_parts[def_zone]))
		damage_by_parts[def_zone] = 0
	var/real_damage_flag = damage_flag
	var/static/list/conversion_table = list(MELEE, BULLET)
	if(real_damage_flag in conversion_table)
		real_damage_flag = CRUSHING
		if(sharpness & SHARP_IMPALING)
			real_damage_flag = IMPALING
		else if(sharpness & SHARP_POINTY)
			real_damage_flag = PIERCING
		else if(sharpness & SHARP_EDGED)
			real_damage_flag = CUTTING
	var/prev_damage = damage_by_parts[def_zone]
	damage_by_parts[def_zone] += damage_dealt
	if(damage_by_parts[def_zone] >= limb_integrity)
		disable_zone(def_zone, damage_type)
		if(prev_damage < limb_integrity)
			var/sounding = pick(LAZYACCESS(GLOB.armor_sounds_break, armor_broken_sound))
			if(sounding)
				playsound(src, sounding, armor_broken_sound_volume, FALSE)
			if(iscarbon(loc))
				var/mob/loc_as_mob = loc
				sounding = pick(LAZYACCESS(GLOB.armor_sounds_break_local, armor_broken_sound_local))
				if(sounding)
					loc_as_mob.playsound_local(src, sounding, armor_broken_sound_local_volume, FALSE)
	else if(damage_dealt)
		var/list/damage_sounds = LAZYACCESS(GLOB.armor_sounds_damage, armor_damaged_sound)
		var/sounding
		if(LAZYLEN(damage_sounds))
			sounding = pick(LAZYACCESS(damage_sounds, real_damage_flag))
		if(sounding)
			playsound(src, sounding, armor_damaged_sound_volume, FALSE)
		if(iscarbon(loc))
			var/mob/loc_as_mob = loc
			damage_sounds = LAZYACCESS(GLOB.armor_sounds_damage_local, armor_damaged_sound_local)
			if(LAZYLEN(damage_sounds))
				sounding = pick(LAZYACCESS(damage_sounds, real_damage_flag))
			if(sounding)
				loc_as_mob.playsound_local(src, sounding, armor_damaged_sound_local_volume, FALSE)

	return TRUE

/obj/item/clothing/disable_zone(def_zone, damage_type)
	var/list/covered_limbs = body_parts_covered2organ_names(body_parts_covered)
	if(!(def_zone in covered_limbs))
		return

	var/zone_name = parse_zone(def_zone)
	var/break_verb = ((damage_type == BRUTE) ? "torn" : "burnt")

	if(iscarbon(loc))
		var/mob/living/carbon/carbon = loc
		carbon.visible_message(span_danger("The [zone_name] on [carbon]'s [src.name] is [break_verb] away!"), \
							span_userdanger("The [zone_name] on my [src.name] is [break_verb] away!"), \
							vision_distance = COMBAT_MESSAGE_RANGE)
		RegisterSignal(carbon, COMSIG_MOVABLE_MOVED, .proc/bristle, override = TRUE)

	zones_disabled++
	for(var/bitflag in zone2body_parts_covered(def_zone))
		body_parts_covered &= ~bitflag

	// if there are no more parts to break then the whole thing is kaput
	if(body_parts_covered == NONE)
		// melee/laser is good enough since this only procs from direct attacks anyway and not from fire/bombs
		atom_destruction(damage_type == BRUTE ? MELEE : LASER)
		return

	switch(zones_disabled)
		if(1)
			name = "damaged [initial(name)]"
		if(2)
			name = "mangy [initial(name)]"
		// take better care of your shit, dude
		if(3 to INFINITY)
			name = "battered [initial(name)]"

	update_clothes_damaged_state(CLOTHING_DAMAGED)
	update_appearance()

// this FULLY repairs the clothing
/obj/item/clothing/repair(mob/user, params)
	update_clothes_damaged_state(CLOTHING_PRISTINE)
	atom_integrity = max_integrity
	name = initial(name) // remove "tattered" or "shredded" if there's a prefix
	body_parts_covered = initial(body_parts_covered)
	slot_flags = initial(slot_flags)
	damage_by_parts = null
	if(user)
		UnregisterSignal(user, COMSIG_MOVABLE_MOVED)
		to_chat(user, span_notice("I fix the damage on [src]."))
	update_appearance()

/obj/item/clothing/bristle(mob/living/wearer)
	if(prob(0.2))
		if(!istype(wearer))
			return
		to_chat(wearer, span_warning("The damaged threads on my [src.name] chafe!"))

/obj/item/clothing/take_damage(damage_amount, damage_type, damage_flag, sound_effect, attack_dir, armour_penetration)
	if(atom_integrity <= 0)
		return 0
	return ..()

// this FULLY repairs the clothing
/obj/item/clothing/proc/repair_zone(mob/user, def_zone, params)
	if(!def_zone)
		return
	repair_damage(limb_integrity*integrity_zone_damage_modifier)
	zones_disabled = max(0, zones_disabled - 1)
	for(var/bitflag in zone2body_parts_covered(def_zone))
		if(initial(body_parts_covered) & bitflag)
			body_parts_covered |= bitflag
	damage_by_parts -= def_zone
	name = initial(name) // remove "tattered" or "shredded" if there's a prefix
	slot_flags = initial(slot_flags)
	if(user)
		UnregisterSignal(user, COMSIG_MOVABLE_MOVED)
		to_chat(user, span_notice("I fix the damage on [src]'s [parse_zone(def_zone)]."))
	switch(zones_disabled)
		if(1)
			name = "damaged [initial(name)]"
		if(2)
			name = "mangy [initial(name)]"
		// take better care of your shit, dude
		if(3 to INFINITY)
			name = "battered [initial(name)]"
	if(zones_disabled <= 0)
		repair_damage(max_integrity)
		update_clothes_damaged_state(CLOTHING_PRISTINE)
	else
		update_clothes_damaged_state(CLOTHING_DAMAGED)
	update_appearance()
