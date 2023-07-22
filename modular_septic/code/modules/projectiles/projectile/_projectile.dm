/obj/projectile
	speed = 0.3
	icon = 'modular_septic/icons/obj/items/guns/projectiles/projectiles.dmi'
	icon_state = "bullet"
	/// Minimum damage this projectile can do
	var/min_damage
	/// Add this to the projectile diceroll modifiers
	var/diceroll_modifier = 0
	/// Add this to the projectile diceroll modifiers of whatever we hit, but ONLY against a specified target
	var/list/target_specific_diceroll
	/// How much to remove from edge_protection
	var/edge_protection_penetration = 0
	/// Amount of armour effectiveness to remove
	var/subtractible_armour_penetration = 0
	/// Whether or not our object is easily hindered by the presence of subtractible armor
	var/weak_against_subtractible_armour = FALSE
	/// This is NOT related to armor penetration, and simply works as a bonus for armor damage
	var/armor_damage_modifier = 0
	/// Pain damage caused to targets
	var/pain = 0
	/// Skill used in  ranged combat
	var/skill_ranged = SKILL_RIFLE
	/// Accuracy modifier for ranged combat
	var/ranged_modifier = 0
	/// Accuracy modifier for body zone in ranged combat
	var/ranged_zone_modifier = 0
	/// Volume of the hitsound
	var/hitsound_volume = 80
	/// Stored visible message
	var/hit_text = ""
	/// Stored target message
	var/target_hit_text = ""

/obj/projectile/Initialize(mapload)
	. = ..()
	if(isnull(min_damage))
		min_damage = damage
	damage = get_damage()

/obj/projectile/prehit_pierce(atom/A)
	if((projectile_phasing & A.pass_flags_self) && (!phasing_ignore_direct_target || original != A))
		return PROJECTILE_PIERCE_PHASE
	if(projectile_piercing & A.pass_flags_self)
		return PROJECTILE_PIERCE_HIT
	if(ismovable(A))
		var/atom/movable/AM = A
		if(AM.throwing)
			if(ismob(AM))
				var/pierced_through = prob(100-LAZYACCESS(embedding, "embed_chance"))
				return (projectile_phasing & LETPASSTHROW) ? PROJECTILE_PIERCE_PHASE : ((projectile_piercing & LETPASSTHROW) ? (pierced_through ? PROJECTILE_PIERCE_HIT : PROJECTILE_PIERCE_NONE) : PROJECTILE_PIERCE_NONE)
			else
				return (projectile_phasing & LETPASSTHROW) ? PROJECTILE_PIERCE_PHASE : ((projectile_piercing & LETPASSTHROW) ? PROJECTILE_PIERCE_HIT : PROJECTILE_PIERCE_NONE)
	if(ismob(A) && prob(100-LAZYACCESS(embedding, "embed_chance")))
		return PROJECTILE_PIERCE_HIT
	return PROJECTILE_PIERCE_NONE

/obj/projectile/process_hit(turf/T, atom/target, atom/bumped, hit_something = FALSE)
	// 1.
	if(QDELETED(src) || !T || !target)
		return
	// 2.
	impacted[target] = TRUE //hash lookup > in for performance in hit-checking
	// 3.
	var/mode = prehit_pierce(target)
	if(mode == PROJECTILE_DELETE_WITHOUT_HITTING)
		qdel(src)
		return hit_something
	else if(mode == PROJECTILE_PIERCE_PHASE)
		if(!(movement_type & PHASING))
			temporary_unstoppable_movement = TRUE
			movement_type |= PHASING
		return process_hit(T, select_target(T, target, bumped), bumped, hit_something) // try to hit something else
	// at this point we are going to hit the thing
	// in which case send signal to it
	SEND_SIGNAL(target, COMSIG_PROJECTILE_PREHIT, args)
	if(mode == PROJECTILE_PIERCE_HIT)
		pierces++
	hit_something = TRUE
	var/result = target.bullet_act(src, def_zone, mode == PROJECTILE_PIERCE_HIT)
	if(ismob(target) && (result == BULLET_ACT_HIT))
		var/embed_attempt = SEND_SIGNAL(src, COMSIG_PROJECTILE_TRY_EMBED, firer, target, result, mode)
		if(embed_attempt & COMPONENT_EMBED_SUCCESS)
			SEND_SIGNAL(target, COMSIG_CARBON_ADD_TO_WOUND_MESSAGE, span_danger(" <i>\The [name] embeds!</i>"))
		else if(embed_attempt & COMPONENT_EMBED_FAILURE)
			if(embed_attempt & COMPONENT_EMBED_STOPPED_BY_ARMOR)
				SEND_SIGNAL(target, COMSIG_CARBON_ADD_TO_WOUND_MESSAGE, span_danger(" <i>\The [name] [p_are()] stopped by armor!</i>"))
				mode = PROJECTILE_PIERCE_NONE
			else if(embed_attempt & COMPONENT_EMBED_WENT_THROUGH)
				SEND_SIGNAL(target, COMSIG_CARBON_ADD_TO_WOUND_MESSAGE, span_danger(" <i>\The [name] go[p_es()] through!</i>"))
	SEND_SIGNAL(target, COMSIG_CARBON_CLEAR_WOUND_MESSAGE)
	// EXPERIMENTAL: Removed wound messages for projectiles
	if(hit_text)
		target.visible_message("[hit_text]", \
			self_message = "[target_hit_text]", \
			blind_message = span_hear("I hear something piercing flesh!"), \
			vision_distance = COMBAT_MESSAGE_RANGE)
	if((result == BULLET_ACT_FORCE_PIERCE) || (mode == PROJECTILE_PIERCE_HIT))
		if(damage <= 0)
			return hit_something
		if(!(movement_type & PHASING))
			temporary_unstoppable_movement = TRUE
			movement_type |= PHASING
		return process_hit(T, select_target(T, target, bumped), bumped, TRUE)
	qdel(src)
	return hit_something

/obj/projectile/on_hit(atom/target, blocked = FALSE, pierce_hit = FALSE, reduced = FALSE, edge_protection = FALSE)
	if(fired_from)
		SEND_SIGNAL(fired_from, COMSIG_PROJECTILE_ON_HIT, firer, target, Angle)
	var/obj/item/bodypart/hit_limb
	if(isliving(target))
		var/mob/living/living_target = target
		hit_limb = living_target.get_bodypart(living_target.check_limb_hit(def_zone))
	var/zone_hit = hit_limb?.body_zone
	// i know that this is probably more with wands and gun mods in mind, but it's a bit silly that the projectile on_hit signal doesn't ping the projectile itself.
	// maybe we care what the projectile thinks! See about combining these via args some time when it's not 5AM
	SEND_SIGNAL(src, COMSIG_PROJECTILE_SELF_ON_HIT, firer, target, Angle, zone_hit)
	if(QDELETED(src)) // in case one of the above signals deleted the projectile for whatever reason
		return
	var/turf/target_location = get_turf(target)

	var/hitx
	var/hity
	if(target == original)
		hitx = target.pixel_x + p_x - 16
		hity = target.pixel_y + p_y - 16
	else
		hitx = target.pixel_x + rand(-8, 8)
		hity = target.pixel_y + rand(-8, 8)

	var/final_hitsound
	var/final_hitsound_volume = vol_by_damage()
	if(!nodamage && (damage_type == BRUTE || damage_type == BURN))
		if(iswallturf(target_location) && ((target == target_location) || prob(50)) )
			var/turf/closed/wall/wall = target_location
			if(impact_effect_type)
				new impact_effect_type(target_location, hitx, hity)

			wall.add_dent(WALL_DENT_SHOT, hitx, hity)

			wall.sound_hint()
			final_hitsound = wall.get_projectile_hitsound(src)
			if(final_hitsound)
				playsound(wall, final_hitsound, final_hitsound_volume, TRUE, -1)

			return BULLET_ACT_HIT
		else if(isfloorturf(target_location) && (target == target_location))
			var/turf/open/floor/floor = target_location
			if(impact_effect_type)
				new impact_effect_type(target_location, hitx, hity)

			floor.add_dent(WALL_DENT_SHOT, hitx, hity)

			floor.sound_hint()
			final_hitsound = floor.get_projectile_hitsound(src)
			if(final_hitsound)
				playsound(floor, final_hitsound, final_hitsound_volume, TRUE, -1)

			return BULLET_ACT_HIT

	final_hitsound = target.get_projectile_hitsound(src)
	//awful snowfake
	if(istype(src, /obj/projectile/blood))
		final_hitsound = null
	if(!isliving(target))
		if(impact_effect_type)
			new impact_effect_type(target_location, hitx, hity)
		target.sound_hint()
		if(final_hitsound)
			playsound(target, final_hitsound, final_hitsound_volume, TRUE, -1)
		return BULLET_ACT_HIT

	var/mob/living/living_target = target
	if(blocked != 100) // not completely blocked
		var/damage_dealt = damage - (damage * (blocked/100)) - reduced
		if((damage_dealt > edge_protection) && (damage_type == BRUTE) && sharpness && living_target.blood_volume && (living_target.mob_biotypes & MOB_ORGANIC))
			var/splatter_dir = dir
			if(starting)
				splatter_dir = get_dir(starting, target_location)
			if(isalien(living_target))
				new /obj/effect/temp_visual/dir_setting/bloodsplatter/xenosplatter(target_location, splatter_dir)
			else
				new /obj/effect/temp_visual/dir_setting/bloodsplatter(target_location, splatter_dir)
		if(impact_effect_type && !hitscan)
			new impact_effect_type(target_location, hitx, hity)

		var/organ_hit_text = ""
		if(zone_hit)
			organ_hit_text = " in \the [parse_zone(zone_hit)]"
		if(suppressed == SUPPRESSED_VERY)
			if(final_hitsound)
				playsound(target, final_hitsound, 5, TRUE, -1)
		else if(suppressed)
			sound_hint()
			if(final_hitsound)
				playsound(target, final_hitsound, 5, TRUE, -1)
			target_hit_text = span_userdanger("I'm hit by \the [src][organ_hit_text]!")
		else
			sound_hint()
			if(final_hitsound)
				playsound(target, final_hitsound, final_hitsound_volume, TRUE, -1)
			hit_text = span_danger("<b>[living_target]</b> is hit by \the [src][organ_hit_text]!")
			target_hit_text = span_userdanger("I'm hit by \the [src][organ_hit_text]!")
		living_target.on_hit(src)

	var/reagent_note
	if(reagents?.reagent_list)
		reagent_note = " REAGENTS:"
		for(var/datum/reagent/reagent as anything in reagents.reagent_list)
			reagent_note += "[reagent.name] ([num2text(reagent.volume)])"

	if(ismob(firer))
		log_combat(firer, living_target, "shot", src, reagent_note)
	else
		living_target.log_message("has been shot by [firer] with [src]", LOG_ATTACK, color="orange")

	return BULLET_ACT_HIT

/obj/projectile/Range()
	range--
	if(wound_bonus != CANT_WOUND)
		wound_bonus += wound_falloff_tile
		bare_wound_bonus = max(0, bare_wound_bonus + wound_falloff_tile)
	if(embedding)
		embedding["embed_chance"] += embed_falloff_tile
	if(range <= 0)
		on_range()

/obj/projectile/on_range()
	SEND_SIGNAL(src, COMSIG_PROJECTILE_RANGE_OUT)
	if(suppressed < SUPPRESSED_QUIET)
		var/turf/turf_loc = get_turf(src)
		if(istype(turf_loc))
			visible_message(span_danger("[src] hits [turf_loc]!"))
	if(isturf(loc))
		process_hit(loc, loc, loc)
	if(!QDELETED(src))
		qdel(src)

/obj/projectile/can_hit_target(atom/target, direct_target = FALSE, ignore_loc = FALSE, cross_failed = FALSE)
	if(QDELETED(target) || impacted[target])
		return FALSE
	if(!ignore_loc && (loc != target.loc))
		return FALSE
	// if pass_flags match, pass through entirely - unless direct target is set.
	if((target.pass_flags_self & pass_flags) && !direct_target)
		return FALSE
	if(!ignore_source_check && firer)
		var/mob/M = firer
		if((target == firer) || ((target == firer.loc) && ismecha(firer.loc)) || (target in firer.buckled_mobs) || (istype(M) && (M.buckled == target)))
			return FALSE
	if(target.density || cross_failed) //This thing blocks projectiles, hit it regardless of layer/mob stuns/etc.
		return TRUE
	if(!isliving(target))
		if(target.layer < PROJECTILE_HIT_THRESHHOLD_LAYER)
			return FALSE
		else if(!direct_target) // non dense objects do not get hit unless specifically clicked
			return FALSE
	else
		var/mob/living/L = target
		if(direct_target)
			return TRUE
		if(L.stat == DEAD)
			return FALSE
		if(HAS_TRAIT(L, TRAIT_IMMOBILIZED) && HAS_TRAIT(L, TRAIT_FLOORED) && HAS_TRAIT(L, TRAIT_HANDS_BLOCKED))
			return FALSE
		if(!hit_prone_targets)
			if(!L.density)
				return FALSE
			if(L.body_position != LYING_DOWN)
				return TRUE
	return TRUE

/obj/projectile/vol_by_damage()
	/// By default returns hitsound_volume
	return hitsound_volume

/obj/projectile/proc/get_sharpness()
	return sharpness

/obj/projectile/proc/get_damage()
	return FLOOR(rand(min_damage*10, damage*10)/10, DAMAGE_PRECISION)

/// I had to unfuck this due to the wack way our hud works
/proc/calculate_projectile_angle_and_pixel_offsets(mob/user, modifiers)
	var/p_x = 0
	var/p_y = 0
	var/angle = 0
	if(LAZYACCESS(modifiers, ICON_X))
		p_x = text2num(LAZYACCESS(modifiers, ICON_X))
	if(LAZYACCESS(modifiers, ICON_Y))
		p_y = text2num(LAZYACCESS(modifiers, ICON_Y))
	if(LAZYACCESS(modifiers, SCREEN_LOC))
		//Split screen-loc up into X+Pixel_X and Y+Pixel_Y
		var/list/screen_loc_params = splittext(LAZYACCESS(modifiers, SCREEN_LOC), ",")

		//Split X+Pixel_X up into list(X, Pixel_X)
		var/list/screen_loc_X = splittext(screen_loc_params[1],":")

		//Split Y+Pixel_Y up into list(Y, Pixel_Y)
		var/list/screen_loc_Y = splittext(screen_loc_params[2],":")
		var/x = text2num(screen_loc_X[1]) * 32 + text2num(screen_loc_X[2]) - 32
		var/y = text2num(screen_loc_Y[1]) * 32 + text2num(screen_loc_Y[2]) - 32

		//Calculate the "resolution" of screen based on client's view and world's icon size. This will work if the user can view more tiles than average.
		var/list/screenview = getviewsize(user.client.view)
		var/screenviewX = screenview[1] * world.icon_size
		var/screenviewY = screenview[2] * world.icon_size
		var/ox = round(screenviewX/2) - user.client.pixel_x //"origin" x
		var/oy = round(screenviewY/2) - user.client.pixel_y //"origin" y
		if(screenview[1] == 22)
			ox += world.icon_size/2
			oy += world.icon_size/2
		angle = ATAN2(y - oy, x - ox)
	return list(angle, p_x, p_y)
