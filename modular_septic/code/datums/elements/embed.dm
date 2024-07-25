/datum/element/embed/tryForceEmbed(obj/item/embedder, atom/target, hit_zone, forced = FALSE, silent = FALSE)
	var/obj/item/bodypart/limb
	var/mob/living/carbon/limb_owner

	if(!prob(embed_chance))
		return COMPONENT_EMBED_FAILURE

	if(iscarbon(target))
		limb_owner = target
		if(!hit_zone)
			limb = pick(limb_owner.bodyparts)
			hit_zone = limb.body_zone
	else if(isbodypart(target))
		limb = target
		hit_zone = limb.body_zone
		limb_owner = limb.owner

	return checkEmbed(embedder, limb_owner, hit_zone, forced = TRUE, silent = TRUE)

/datum/element/embed/checkEmbed(obj/item/weapon, \
							mob/living/carbon/victim, \
							hit_zone, \
							datum/thrownthing/throwingdatum, \
							forced = FALSE, \
							silent = FALSE)
	if(!istype(victim) || HAS_TRAIT(victim, TRAIT_PIERCEIMMUNE))
		return COMPONENT_EMBED_FAILURE

	var/flying_speed = throwingdatum?.speed || weapon.throw_speed

	if(!forced && (flying_speed < EMBED_THROWSPEED_THRESHOLD) && !ignore_throwspeed_threshold) // check if it's a forced embed, and if not, if it's going fast enough to proc embedding
		return COMPONENT_EMBED_FAILURE

	var/actual_chance = embed_chance
	if(throwingdatum?.speed > weapon.throw_speed)
		actual_chance += (throwingdatum.speed - weapon.throw_speed) * EMBED_CHANCE_SPEED_BONUS

	if(actual_chance <= 0)
		return COMPONENT_EMBED_FAILURE

	var/harmless = weapon.isEmbedHarmless()
	var/edge_protection = 0
	if(!harmless)
		edge_protection = victim.get_edge_protection(hit_zone)
		edge_protection = max(0, edge_protection - weapon.edge_protection_penetration)
		if(edge_protection)
			actual_chance -= edge_protection
			if(!forced && actual_chance <= 0)
				if(!silent)
					victim.visible_message(span_danger("[weapon] bounces off <b>[victim]</b> armor!"), \
										span_notice("[weapon] bounces off my armor!"), \
										vision_distance = COMBAT_MESSAGE_RANGE)
				return (COMPONENT_EMBED_FAILURE | COMPONENT_EMBED_STOPPED_BY_ARMOR)

	if(!forced && !prob(actual_chance))
		return (!harmless && edge_protection ? (COMPONENT_EMBED_FAILURE | COMPONENT_EMBED_STOPPED_BY_ARMOR) : COMPONENT_EMBED_FAILURE)

	var/obj/item/bodypart/limb = victim.get_bodypart(hit_zone)
	if(!limb)
		limb = pick(victim.bodyparts)
	var/datum/injury/supply_injury = limb.last_injury
	if(!harmless && (!limb.last_injury || !(limb.last_injury.damage_type in list(WOUND_SLASH, WOUND_PIERCE))) )
		return COMPONENT_EMBED_FAILURE

/*
	if(!harmless && (!limb.last_injury || !(limb.last_injury.damage_type in list(WOUND_SLASH, WOUND_PIERCE))) )
		supply_injury = limb.create_injury((weapon.get_sharpness() & SHARP_POINTY ? WOUND_PIERCE : WOUND_SLASH), \
											throwingdatum ? weapon.get_throwforce(throwingdatum.thrower, GET_MOB_ATTRIBUTE_VALUE(throwingdatum.thrower, STAT_STRENGTH)) : \
															weapon.get_force(), \
											wound_messages = FALSE)
		if(!limb.last_injury || !(limb.last_injury.damage_type in list(WOUND_SLASH, WOUND_PIERCE)))
			return COMPONENT_EMBED_FAILURE
*/

	victim.AddComponent(/datum/component/embedded,\
						weapon,\
						throwingdatum,\
						part = limb,\
						embed_chance = embed_chance,\
						fall_chance = fall_chance,\
						pain_chance = pain_chance,\
						pain_mult = pain_mult,\
						remove_pain_mult = remove_pain_mult,\
						rip_time = rip_time,\
						ignore_throwspeed_threshold = ignore_throwspeed_threshold,\
						jostle_chance = jostle_chance,\
						jostle_pain_mult = jostle_pain_mult,\
						pain_stam_pct = pain_stam_pct,\
						supplied_injury = supply_injury,\
						silence_message = silent, \
						)

	return COMPONENT_EMBED_SUCCESS

/datum/element/embed/proc/projectile_try_embed(obj/projectile/projectile, atom/movable/firer, atom/hit, result, mode)
	SIGNAL_HANDLER

	if(!iscarbon(hit) || (result != BULLET_ACT_HIT) || (mode != PROJECTILE_PIERCE_NONE))
		SEND_SIGNAL(projectile, COMSIG_PELLET_CLOUD_WENT_THROUGH)
		return COMPONENT_EMBED_FAILURE

	var/mob/living/carbon/carbon_hit = hit
	var/obj/item/bodypart/limb = carbon_hit.get_bodypart(projectile.def_zone)
	//Oh no
	if(!limb)
		SEND_SIGNAL(projectile, COMSIG_PELLET_CLOUD_WENT_THROUGH, limb)
		return COMPONENT_EMBED_FAILURE

	var/obj/item/payload = new payload_type(get_turf(hit))
	if(istype(payload, /obj/item/shrapnel/bullet))
		payload.name = "[projectile.name] shrapnel"
	payload.embedding = projectile.embedding
	payload.embedding["embed_chance"] = 100 //if we got this far, we passed projectile embed checks
	payload.updateEmbedding()

	// at this point we've created our shrapnel baby and set them up to embed in the target, we can now die in peace as they handle their embed try on their own
	var/embed_attempt = payload.tryEmbed(limb, FALSE, TRUE)
	if(embed_attempt & COMPONENT_EMBED_SUCCESS)
		SEND_SIGNAL(projectile, COMSIG_PELLET_CLOUD_EMBEDDED, limb)
	else if(embed_attempt & COMPONENT_EMBED_FAILURE)
		if(embed_attempt & COMPONENT_EMBED_STOPPED_BY_ARMOR)
			SEND_SIGNAL(projectile, COMSIG_PELLET_CLOUD_STOPPED_BY_ARMOR, limb)
			if(projectile.shrapnel_type)
				new projectile.shrapnel_type(get_turf(hit))
		else if(embed_attempt & COMPONENT_EMBED_WENT_THROUGH)
			SEND_SIGNAL(projectile, COMSIG_PELLET_CLOUD_WENT_THROUGH, limb)
	Detach(projectile)
	return embed_attempt
