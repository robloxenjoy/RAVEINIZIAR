/obj/item/ammo_casing/ready_proj(atom/target, mob/living/user, quiet, zone_override = "", atom/fired_from)
	if(!loaded_projectile)
		return
	loaded_projectile.original = target
	loaded_projectile.firer = user
	loaded_projectile.fired_from = fired_from
	loaded_projectile.suppressed = quiet
	if(isitem(loaded_projectile.suppressed))
		loaded_projectile.suppressed = SUPPRESSED_NONE
	loaded_projectile.diceroll_modifier += diceroll_modifier
	if(target_specific_diceroll)
		LAZYOR(loaded_projectile.target_specific_diceroll, target_specific_diceroll)
	if(isgun(fired_from))
		var/obj/item/gun/gun = fired_from
		loaded_projectile.damage *= gun.projectile_damage_multiplier
		loaded_projectile.stamina *= gun.projectile_damage_multiplier
		loaded_projectile.diceroll_modifier += gun.diceroll_modifier
		loaded_projectile.skill_ranged = gun.skill_ranged
		loaded_projectile.ranged_modifier = gun.ranged_modifier
		loaded_projectile.ranged_zone_modifier = gun.ranged_zone_modifier

	//For chemical darts/bullets
	if(reagents && loaded_projectile.reagents)
		reagents.trans_to(loaded_projectile, reagents.total_volume, transfered_by = user)
		qdel(reagents)

	if(zone_override)
		loaded_projectile.def_zone = zone_override
	else
		loaded_projectile.def_zone = user.zone_selected
		if(istype(user) && user.attributes && (target != user))
			var/zone_modifier = 0
			var/skill_modifier = 0
			if(loaded_projectile.skill_ranged)
				skill_modifier += GET_MOB_SKILL_VALUE(user, loaded_projectile.skill_ranged)
			var/obj/item/bodypart/stock_bodypart = GLOB.bodyparts_by_zone[loaded_projectile.def_zone]
			if(stock_bodypart)
				zone_modifier += stock_bodypart.ranged_hit_zone_modifier
			var/diceroll = user.diceroll(skill_modifier+zone_modifier, context = DICE_CONTEXT_PHYSICAL)
			//Change zone on fails
			if(diceroll <= DICE_FAILURE)
				loaded_projectile.def_zone = ran_zone(user.zone_selected, 0)
	if(ishuman(user))
		var/distance = get_dist(user, target)
		loaded_projectile.decayedRange = min(loaded_projectile.range, distance)
		loaded_projectile.range = min(loaded_projectile.range, distance)

/obj/item/ammo_casing/throw_proj(atom/target, turf/targloc, mob/living/user, params, spread)
	var/turf/curloc = get_turf(user)
	if(!istype(targloc) || !istype(curloc) || !loaded_projectile)
		return FALSE

	var/firing_dir
	if(loaded_projectile.firer)
		firing_dir = loaded_projectile.firer.dir
	if(!loaded_projectile.suppressed && firing_effect_type)
		new firing_effect_type(get_turf(src), firing_dir)

	var/direct_target
	if((targloc == curloc) && target)
		direct_target = target
	if(!direct_target)
		var/modifiers = params2list(params)
		loaded_projectile.preparePixelProjectile(target, user, modifiers, spread)
	var/obj/projectile/loaded_projectile_cache = loaded_projectile
	loaded_projectile = null
	loaded_projectile_cache.fire(null, direct_target)
	return TRUE
