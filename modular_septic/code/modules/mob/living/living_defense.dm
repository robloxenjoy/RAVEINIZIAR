/mob/living/hitby(atom/movable/AM, skipcatch, hitpush = TRUE, blocked = FALSE, datum/thrownthing/throwingdatum)
	if(isitem(AM))
		var/obj/item/thrown_item = AM
		var/def_zone = ran_zone(BODY_ZONE_CHEST, 65)//Hits a random part of the body, geared towards the chest
		var/nosell_hit = SEND_SIGNAL(thrown_item, COMSIG_MOVABLE_IMPACT_ZONE, src, def_zone, throwingdatum) // TODO: find a better way to handle hitpush and skipcatch for humans
		if(nosell_hit)
			skipcatch = TRUE
			hitpush = FALSE

		if(blocked)
			return TRUE

		var/mob/thrown_by = thrown_item.thrownby?.resolve()
		if(thrown_by)
			log_combat(thrown_by, src, "threw and hit", thrown_item)
		if(nosell_hit)
			return ..()
		visible_message(span_danger("<b>[src]</b> is hit by [thrown_item]!"), \
						span_userdanger("I'm hit by [thrown_item]!"))
		if(!thrown_item.throwforce)
			return
		var/sharpness = thrown_item.get_sharpness()
		var/armor = run_armor_check(def_zone, \
									MELEE, \
									"", \
									"", \
									thrown_item.armour_penetration, \
									"", \
									FALSE, \
									thrown_item.weak_against_armour, \
									sharpness)
		var/subarmor = run_subarmor_check(def_zone, \
									MELEE, \
									"", \
									"", \
									thrown_item.subtractible_armour_penetration, \
									"", \
									FALSE, \
									thrown_item.weak_against_subtractible_armour, \
									sharpness)
		var/edge_protection = get_edge_protection(def_zone)
		edge_protection = max(0, edge_protection - thrown_item.edge_protection_penetration)
		var/subarmor_flags = get_subarmor_flags(def_zone)
		var/damage = thrown_item.get_throwforce(throwingdatum.thrower, GET_MOB_ATTRIBUTE_VALUE(throwingdatum.thrower, STAT_STRENGTH))
		apply_damage(damage, \
					thrown_item.damtype, \
					def_zone, \
					blocked = armor, \
					wound_bonus = thrown_item.wound_bonus, \
					bare_wound_bonus = thrown_item.bare_wound_bonus, \
					sharpness = sharpness, \
					organ_bonus = thrown_item.organ_bonus, \
					bare_organ_bonus = thrown_item.bare_organ_bonus, \
					reduced = subarmor, \
					edge_protection = edge_protection, \
					subarmor_flags = subarmor_flags)
		//Damage can delete the mob
		if(QDELETED(src))
			return
		//physics says it's significantly harder to push someone by constantly chucking random furniture at them if they are down on the floor
		if(body_position == LYING_DOWN)
			hitpush = FALSE
		return ..()

	playsound(loc, 'sound/weapons/genhit.ogg', 50, TRUE, -1) //Item sounds are handled in the item itself
	return ..()

/mob/living/bullet_act(obj/projectile/hitting_projectile, def_zone, piercing_hit = FALSE)
	var/sharpness = hitting_projectile.get_sharpness()
	var/armor = run_armor_check(def_zone, \
								hitting_projectile.flag,
								"", \
								"", \
								hitting_projectile.armour_penetration, \
								"", \
								FALSE, \
								hitting_projectile.weak_against_armour, \
								sharpness)
	var/subarmor = run_subarmor_check(def_zone, \
								hitting_projectile.flag,
								"", \
								"", \
								hitting_projectile.subtractible_armour_penetration, \
								"", \
								FALSE, \
								hitting_projectile.weak_against_subtractible_armour, \
								sharpness)
	var/edge_protection = get_edge_protection(def_zone)
	edge_protection = max(0, edge_protection - hitting_projectile.edge_protection_penetration)
	var/subarmor_flags = get_subarmor_flags(def_zone)
	var/on_hit_state = hitting_projectile.on_hit(src, armor, piercing_hit, subarmor, edge_protection)
	if(!hitting_projectile.nodamage && (on_hit_state != BULLET_ACT_BLOCK))
		apply_damage(hitting_projectile.damage, \
					hitting_projectile.damage_type, \
					def_zone, \
					blocked = armor, \
					wound_bonus = hitting_projectile.wound_bonus, \
					bare_wound_bonus = hitting_projectile.bare_wound_bonus, \
					sharpness = hitting_projectile.sharpness, \
					organ_bonus = hitting_projectile.organ_bonus, \
					bare_organ_bonus = hitting_projectile.bare_organ_bonus, \
					reduced = subarmor, \
					edge_protection = edge_protection, \
					subarmor_flags = subarmor_flags)
		if(hitting_projectile.pain)
			apply_damage(hitting_projectile.pain,
						PAIN,
						blocked = armor, \
						reduced = subarmor, \
						edge_protection = edge_protection, \
						subarmor_flags = subarmor_flags)
		apply_effects(stun = hitting_projectile.stun, \
					knockdown = hitting_projectile.knockdown, \
					unconscious = hitting_projectile.unconscious, \
					slur = hitting_projectile.slur, \
					stutter = hitting_projectile.stutter, \
					eyeblur = hitting_projectile.eyeblur, \
					drowsy = hitting_projectile.drowsy, \
					stamina = hitting_projectile.stamina, \
					jitter = hitting_projectile.jitter, \
					paralyze = hitting_projectile.paralyze, \
					immobilize = hitting_projectile.immobilize, \
					blocked = armor)
		damage_armor(hitting_projectile.damage+hitting_projectile.armor_damage_modifier, \
					hitting_projectile.flag, \
					hitting_projectile.damage_type, \
					sharpness, \
					def_zone)
		if(hitting_projectile.dismemberment)
			check_projectile_dismemberment(hitting_projectile, def_zone)
		hitting_projectile.damage = max(0,  hitting_projectile.damage - (initial(hitting_projectile.damage) * PROJECTILE_DAMAGE_REDUCTION_ON_HIT))
	return on_hit_state ? BULLET_ACT_HIT : BULLET_ACT_BLOCK

/mob/living/IgniteMob()
	if(fire_stacks > 0 && !on_fire)
		on_fire = TRUE
		src.visible_message(span_warning("<b>[src]</b> catches fire!"), \
						span_userdanger("I've caught on fire!"))
		new /obj/effect/dummy/lighting_obj/moblight/fire(src)
		throw_alert("fire", /atom/movable/screen/alert/fire)
		update_fire()
		SEND_SIGNAL(src, COMSIG_LIVING_IGNITED,src)
		return TRUE
	return FALSE

/mob/living/unarmed_hand(atom/attack_target, proximity_flag, list/modifiers)
	if(HAS_TRAIT(src, TRAIT_HANDS_BLOCKED) \
	|| (SEND_SIGNAL(src, COMSIG_LIVING_UNARMED_ATTACK, attack_target, proximity_flag, modifiers) & COMPONENT_CANCEL_ATTACK_CHAIN))
		return
	attack_target.attack_hand(src, modifiers)

/mob/living/unarmed_foot(atom/attack_target, proximity_flag, list/modifiers)
	if(SEND_SIGNAL(src, COMSIG_LIVING_UNARMED_ATTACK, attack_target, proximity_flag, modifiers) & COMPONENT_CANCEL_ATTACK_CHAIN)
		return
	attack_target.attack_foot(src, modifiers)

/mob/living/unarmed_jaw(atom/attack_target, proximity_flag, list/modifiers)
	if(SEND_SIGNAL(src, COMSIG_LIVING_UNARMED_ATTACK, attack_target, proximity_flag, modifiers) & COMPONENT_CANCEL_ATTACK_CHAIN)
		return
	attack_target.attack_jaw(src, modifiers)
