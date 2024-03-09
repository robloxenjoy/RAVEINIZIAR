/datum/species
	punchdamagelow = 8
	punchdamagehigh = 12
	punchstunthreshold = 16
	attack_sound = list('modular_septic/sound/attack/punch1.ogg',
						'modular_septic/sound/attack/punch2.ogg',
						'modular_septic/sound/attack/punch3.ogg')
	miss_sound = list('modular_septic/sound/attack/punchmiss.ogg')
	attack_effect = ATTACK_EFFECT_PUNCH
	attack_verb = "ударить"
	var/attack_verb_continuous = "ударяет"
	var/attack_sharpness = NONE
	var/attack_armor_damage_modifier = 0
	var/kick_effect = ATTACK_EFFECT_KICK
	var/kick_verb = "пинать"
	var/kick_verb_continuous = "пинает"
	var/kick_sharpness = NONE
	var/kick_armor_damage_modifier = 0
	var/kick_sound = 'modular_septic/sound/attack/kick.ogg'
	var/bite_effect = ATTACK_EFFECT_BITE
	var/bite_verb = "кусать"
	var/bite_verb_continuous = "кусает"
	var/bite_sharpness = NONE
	var/bite_sound = list('modular_septic/sound/attack/bite1.ogg')
	var/bite_armor_damage_modifier = 0

/datum/species/handle_fire(mob/living/carbon/human/burned, delta_time, times_fired, no_protection = FALSE)
	if(!CanIgniteMob(burned))
		return TRUE
	if(burned.on_fire)
		SEND_SIGNAL(burned, COMSIG_HUMAN_BURNING)
		//the fire tries to damage the exposed clothes and items
		var/list/burning_items = list()
		var/obscured = burned.check_obscured_slots(TRUE)
		//HEAD//
		if(burned.glasses && !(obscured & ITEM_SLOT_EYES))
			burning_items += burned.glasses
		if(burned.wear_mask && !(obscured & ITEM_SLOT_MASK))
			burning_items += burned.wear_mask
		if(burned.wear_neck && !(obscured & ITEM_SLOT_NECK))
			burning_items += burned.wear_neck
		if(burned.ears && !(obscured & ITEM_SLOT_LEAR))
			burning_items += burned.ears
		if(burned.ears_extra && !(obscured & ITEM_SLOT_REAR))
			burning_items += burned.ears_extra
		if(burned.head)
			burning_items += burned.head

		//CHEST//
		if(burned.w_uniform && !(obscured & ITEM_SLOT_ICLOTHING))
			burning_items += burned.w_uniform
		if(burned.wear_suit)
			burning_items += burned.wear_suit
		if(burned.oversuit)
			burning_items += burned.oversuit

		//ARMS & HANDS//
		var/obj/item/clothing/arm_clothes = null
		if(burned.gloves && !(obscured & ITEM_SLOT_GLOVES))
			arm_clothes = burned.gloves
		else if(burned.wear_suit && ((burned.wear_suit.body_parts_covered & HANDS) || (burned.wear_suit.body_parts_covered & ARMS)))
			arm_clothes = burned.wear_suit
		else if(burned.w_uniform && ((burned.w_uniform.body_parts_covered & HANDS) || (burned.w_uniform.body_parts_covered & ARMS)))
			arm_clothes = burned.w_uniform
		if(arm_clothes)
			burning_items |= arm_clothes
		if(burned.wrists && !(obscured & ITEM_SLOT_WRISTS))
			burning_items += burned.wrists

		//LEGS & FEET//
		var/obj/item/clothing/leg_clothes = null
		if(burned.shoes && !(obscured & ITEM_SLOT_FEET))
			leg_clothes = burned.shoes
		else if(burned.wear_suit && ((burned.wear_suit.body_parts_covered & FEET) || (burned.wear_suit.body_parts_covered & LEGS)))
			leg_clothes = burned.wear_suit
		else if(burned.w_uniform && ((burned.w_uniform.body_parts_covered & FEET) || (burned.w_uniform.body_parts_covered & LEGS)))
			leg_clothes = burned.w_uniform
		if(burned.pants)
			burning_items += burned.pants
		if(leg_clothes)
			burning_items |= leg_clothes

		for(var/obj/item/burned_item in burning_items)
			burned_item.fire_act(burned.fire_stacks * 50) //damage taken is reduced to 2% of this value by fire_act()

		var/thermal_protection = burned.get_thermal_protection()

		if(thermal_protection >= FIRE_IMMUNITY_MAX_TEMP_PROTECT && !no_protection)
			return
		if(thermal_protection >= FIRE_SUIT_MAX_TEMP_PROTECT && !no_protection)
			burned.adjust_bodytemperature(5.5 * delta_time)
		else
			burned.adjust_bodytemperature((BODYTEMP_HEATING_MAX + (burned.fire_stacks * 12)) * 0.5 * delta_time)
			SEND_SIGNAL(burned, COMSIG_ADD_MOOD_EVENT, "on_fire", /datum/mood_event/on_fire)

/datum/species/spec_stun(mob/living/carbon/human/stunned, amount = 0)
	if(stunned.movement_type & FLYING)
		var/list/wings = stunned.getorganslotlist(ORGAN_SLOT_EXTERNAL_WINGS)
		for(var/obj/item/organ/external/wings/wing in wings)
			wing.toggle_flight(stunned)
			wing.fly_slip(stunned)
	if(is_wagging_tail(stunned))
		stop_wagging_tail(stunned)
	return stunmod * stunned.physiology.stun_mod * amount

/datum/species/spec_attacked_by(obj/item/weapon, \
								mob/living/user, \
								obj/item/bodypart/affecting, \
								mob/living/carbon/human/victim, \
								list/modifiers)
	var/damage = weapon.get_force(user, GET_MOB_ATTRIBUTE_VALUE(user, STAT_STRENGTH))
	// Allows you to put in item-specific reactions based on species
	damage = FLOOR(damage * check_species_weakness(weapon, user), DAMAGE_PRECISION)
	var/sharpness = weapon.get_sharpness()
	var/attack_delay = weapon.attack_delay
	var/attack_fatigue_cost = weapon.attack_fatigue_cost
	var/attack_skill_modifier = 0
	var/mob/living/carbon/human/human_user
	if(ishuman(user))
		human_user = user
		if(LAZYACCESS(modifiers, RIGHT_CLICK))
			switch(user.combat_style)
				if(CS_WEAK)
					damage *= 0.2
					attack_fatigue_cost *= 0.25
				if(CS_AIMED)
					attack_skill_modifier += 5
					attack_delay *= 1.25
					human_user.update_parrying_penalty(PARRYING_PENALTY, PARRYING_PENALTY_COOLDOWN_DURATION)
					human_user.update_blocking_cooldown(BLOCKING_COOLDOWN_DURATION)
					human_user.update_dodging_cooldown(DODGING_COOLDOWN_DURATION)
				if(CS_FURY)
					attack_skill_modifier -= 3
					attack_delay *= 0.8
				if(CS_STRONG)
					damage *= 1.5
					attack_fatigue_cost *= 1.5
					human_user.update_parrying_penalty(PARRYING_PENALTY, PARRYING_PENALTY_COOLDOWN_DURATION)
					human_user.update_blocking_cooldown(BLOCKING_COOLDOWN_DURATION)
					human_user.update_dodging_cooldown(DODGING_COOLDOWN_DURATION)
				if(CS_FEINT)
					human_user.update_parrying_penalty(PARRYING_PENALTY, PARRYING_PENALTY_COOLDOWN_DURATION)
					human_user.update_blocking_cooldown(BLOCKING_COOLDOWN_DURATION)
					human_user.update_dodging_cooldown(DODGING_COOLDOWN_DURATION)
		else
			switch(user.combat_style)
				if(CS_DEFEND)
					damage *= 0.75
	if(user != victim)
//		if(!victim.lying_attack_check(user, weapon))
//			return FALSE
		var/hit_modifier = weapon.melee_modifier+attack_skill_modifier+attack_skill_modifier
		var/hit_zone_modifier = weapon.melee_zone_modifier
		if(affecting)
			hit_modifier = affecting.melee_hit_modifier
			hit_zone_modifier = affecting.melee_hit_zone_modifier
			//very hard to miss when hidden by fov
			if(!(victim in fov_viewers(2, user)))
				hit_modifier += 10
				hit_zone_modifier += 10
				damage *= 1.1
			//easy to kick people when they are down
			if((victim.body_position == LYING_DOWN) && (user.body_position != LYING_DOWN))
				hit_modifier += 5
				hit_zone_modifier += 5
			//bad damage!
			if(user.body_position == LYING_DOWN)
				damage *= 0.5
			//bro we dead :skull:
			if(victim.stat >= UNCONSCIOUS)
				hit_modifier += 15
		var/diceroll = DICE_FAILURE
		var/skill_modifier = 0
		if(weapon.skill_melee)
			skill_modifier += GET_MOB_SKILL_VALUE(user, weapon.skill_melee)
		var/strength_difference = max(0, weapon.minimum_strength-GET_MOB_ATTRIBUTE_VALUE(user, STAT_STRENGTH))
		diceroll = user.diceroll(skill_modifier+hit_modifier-strength_difference, context = DICE_CONTEXT_PHYSICAL)
		if(diceroll == DICE_FAILURE)
			damage *= 0.5
		if(diceroll == DICE_CRIT_FAILURE)
			affecting = null
		if(diceroll >= DICE_SUCCESS)
			diceroll = user.diceroll(skill_modifier+hit_zone_modifier-strength_difference, context = DICE_CONTEXT_PHYSICAL)
			if(diceroll <= DICE_FAILURE)
				affecting = victim.get_bodypart(ran_zone(user.zone_selected, 0))
		if(victim.check_block())
//			user.do_attack_animation(victim, used_item = weapon, no_effect = TRUE)
			user.changeNext_move(attack_delay)
			user.adjustFatigueLoss(attack_fatigue_cost)
			var/attack_message = "attack"
			if(length(weapon.attack_verb_simple))
				attack_message = pick(weapon.attack_verb_simple)
			victim.visible_message(span_warning("<b>[victim]</b> блокирует <b>[user]</b>'s [attack_message] с помощью [weapon]!"), \
							span_userdanger("Я блокирую <b>[user]</b>'s [attack_message] с помощью [weapon]!"), \
							span_hear("Я слышу стук!"), \
							COMBAT_MESSAGE_RANGE, \
							user)
			to_chat(user, span_userdanger("<b>[victim]</b> блокирует мою [attack_message] моим [weapon]!"))
			user.sound_hint()
			if(weapon.durability)
				weapon.damageItem("MEDIUM")
			return FALSE
		if(victim.check_shields(user, damage, "<b>[user]</b>'s [weapon.name]", "my [weapon.name]", attacking_flags = BLOCK_FLAG_MELEE) & COMPONENT_HIT_REACTION_BLOCK)
//			user.do_attack_animation(victim, used_item = weapon, no_effect = TRUE)
			user.changeNext_move(attack_delay)
			user.adjustFatigueLoss(attack_fatigue_cost)
			user.sound_hint()
			victim.adjustFatigueLoss(5)
			if(weapon.durability)
				weapon.damageItem("MEDIUM")
			return FALSE
		if(victim.check_parry(user, damage, "<b>[user]</b>'s [weapon.name]", "my [weapon.name]", attacking_flags = BLOCK_FLAG_MELEE) & COMPONENT_HIT_REACTION_BLOCK)
//			user.do_attack_animation(victim, used_item = weapon, no_effect = TRUE)
			user.changeNext_move(attack_delay)
			user.adjustFatigueLoss(attack_fatigue_cost)
			user.sound_hint()
			victim.adjustFatigueLoss(5)
			if(weapon.durability)
				weapon.damageItem("MEDIUM")
			return FALSE
		if(victim.check_dodge(user, damage, "<b>[user]</b>'s [weapon.name]", "my [weapon.name]", attacking_flags = BLOCK_FLAG_MELEE) & COMPONENT_HIT_REACTION_BLOCK)
//			user.do_attack_animation(victim, used_item = weapon, no_effect = TRUE)
			user.changeNext_move(attack_delay)
			user.adjustFatigueLoss(attack_fatigue_cost)
			playsound(user, weapon.miss_sound, weapon.get_clamped_volume(), extrarange = weapon.stealthy_audio ? SILENCED_SOUND_EXTRARANGE : -1, falloff_distance = 0)
			user.sound_hint()
			victim.adjustFatigueLoss(5)
			return FALSE
	//No bodypart? That means we missed - Theoretically, we should never miss attacking ourselves
	if(!affecting)
		SSblackbox.record_feedback("amount", "item_attack_missed", 1, "[weapon.type]")
		var/attack_message = "attack"
		if(LAZYLEN(weapon.attack_verb_simple))
			attack_message = pick(weapon.attack_verb_simple)
		user.sound_hint()
		var/target_area = parse_zone(check_zone(user.zone_selected))
		playsound(user, weapon.miss_sound, weapon.get_clamped_volume(), extrarange = weapon.stealthy_audio ? SILENCED_SOUND_EXTRARANGE : -1, falloff_distance = 0)
		user.visible_message(span_danger("<b>[user]</b> tries to [attack_message] <b>[src]</b>'s [target_area] with [weapon], but misses!"), \
				span_userdanger("I try to [attack_message] <b>[src]</b>'s [target_area] with my [weapon], but miss!"), \
				span_hear("I hear a swoosh!"), \
				vision_distance = COMBAT_MESSAGE_RANGE, \
				ignored_mobs = victim)
		to_chat(victim, span_userdanger("<b>[user]</b> tries to [attack_message] my [target_area] with [weapon], but misses!"))
		user.changeNext_move(attack_delay)
		user.adjustFatigueLoss(attack_fatigue_cost)
		return FALSE

	SEND_SIGNAL(weapon, COMSIG_ITEM_ATTACK_ZONE, src, user, affecting)

	var/hit_area = affecting?.name
	var/def_zone = affecting?.body_zone
	var/intended_zone = user.zone_selected

	var/armor_block = victim.run_armor_check(affecting, \
					MELEE, \
					span_notice("My armor has protected my [hit_area]!"), \
					span_warning("My armor has softened a hit to my [hit_area]!"), \
					weapon.armour_penetration, \
					weak_against_armour = weapon.weak_against_armour, \
					sharpness = sharpness)
	var/armor_reduce = victim.run_subarmor_check(affecting, \
					MELEE, \
					span_notice("My armor has protected my [hit_area]!"), \
					span_warning("My armor has softened a hit to my [hit_area]!"), \
					weapon.subtractible_armour_penetration, \
					weak_against_armour = weapon.weak_against_subtractible_armour, \
					sharpness = sharpness)
	var/edge_protection = victim.get_edge_protection(affecting)
	edge_protection = max(0, edge_protection - weapon.edge_protection_penetration)
	var/subarmor_flags = victim.get_subarmor_flags(affecting)

	user.changeNext_move(attack_delay)
	user.adjustFatigueLoss(attack_fatigue_cost)
	weapon.damageItem("MEDIUM")
	playsound(user, weapon.hitsound, weapon.get_clamped_volume(), TRUE, extrarange = weapon.stealthy_audio ? SILENCED_SOUND_EXTRARANGE : -1, falloff_distance = 0)
	if(damage && !(weapon.item_flags & NOBLUDGEON))
		apply_damage(victim, \
					damage, \
					weapon.damtype, \
					def_zone, \
					armor_block, \
					wound_bonus = weapon.wound_bonus, \
					bare_wound_bonus = weapon.bare_wound_bonus, \
					sharpness = sharpness, \
					organ_bonus = weapon.organ_bonus, \
					bare_organ_bonus = weapon.bare_organ_bonus, \
					reduced = armor_reduce, \
					edge_protection = edge_protection, \
					subarmor_flags = subarmor_flags)
		victim.damage_armor(damage+weapon.armor_damage_modifier, MELEE, weapon.damtype, sharpness, def_zone)
		post_hit_effects(victim, user, affecting, weapon, damage, MELEE, weapon.damtype, sharpness, def_zone, intended_zone, modifiers)

	victim.sound_hint()
	victim.send_item_attack_message(weapon, user, hit_area, affecting)
	SEND_SIGNAL(victim, COMSIG_CARBON_CLEAR_WOUND_MESSAGE)
	if(!(weapon.item_flags & NOBLUDGEON))
		if((weapon.damtype == BRUTE) && damage && prob(25 + (damage * 2)) && affecting.is_organic_limb())
			//Makes the weapon bloody, not the person
			weapon.add_mob_blood(victim)
			//blood spatter!
			if(prob(damage * 2))
				var/turf/location = victim.loc
				if(istype(location))
					victim.do_hitsplatter(get_dir(user, victim), min_range = 0, max_range = 2, splatter_loc = pick(FALSE, TRUE))
				//people with TK won't get smeared with blood
				if(get_dist(user, victim) <= 1)
					user.add_mob_blood(victim)
				//now this is what makes the person bloody
				switch(def_zone)
					if(BODY_ZONE_HEAD, BODY_ZONE_PRECISE_FACE, BODY_ZONE_PRECISE_NECK, BODY_ZONE_PRECISE_MOUTH, BODY_ZONE_PRECISE_L_EYE, BODY_ZONE_PRECISE_R_EYE)
						if(victim.head)
							victim.head.add_mob_blood(victim)
							victim.update_inv_head()
						if(victim.wear_mask)
							victim.wear_mask.add_mob_blood(victim)
							victim.update_inv_wear_mask()
						if(victim.glasses)
							victim.glasses.add_mob_blood(victim)
							victim.update_inv_glasses()
						if(victim.wear_neck)
							victim.wear_neck.add_mob_blood(victim)
							victim.update_inv_neck()
					if(BODY_ZONE_PRECISE_L_FOOT, BODY_ZONE_PRECISE_R_FOOT)
						if(victim.shoes)
							victim.shoes.add_mob_blood(victim)
							victim.update_inv_shoes()
					if(BODY_ZONE_L_ARM, BODY_ZONE_PRECISE_L_HAND, BODY_ZONE_R_ARM, BODY_ZONE_PRECISE_R_HAND)
						if(victim.gloves)
							victim.gloves.add_mob_blood(victim)
						else
							victim.add_mob_blood(victim)
					else
						if(victim.wear_suit)
							victim.wear_suit.add_mob_blood(victim)
							victim.update_inv_wear_suit()
						if(victim.oversuit)
							victim.oversuit.add_mob_blood(victim)
							victim.update_inv_oversuit()
						if(victim.pants)
							victim.pants.add_mob_blood(victim)
							victim.update_inv_pants()

						if(victim.w_uniform)
							victim.w_uniform.add_mob_blood(victim)
							victim.update_inv_w_uniform()
	return TRUE

/datum/species/spec_attack_hand(mob/living/carbon/human/user, \
								mob/living/carbon/human/victim, \
								datum/martial_art/attacker_style, \
								list/modifiers)
	if(!istype(user))
		return
//	if(!victim.lying_attack_check(user))
//		return FALSE
	CHECK_DNA_AND_SPECIES(user)
	CHECK_DNA_AND_SPECIES(victim)

	if(!attacker_style && user.mind)
		attacker_style = user.mind.martial_art

	SEND_SIGNAL(user, COMSIG_MOB_ATTACK_HAND, user, victim, attacker_style)

	switch(user.a_intent)
		if(INTENT_HELP)
			help(user, victim, attacker_style, modifiers)
		if(INTENT_DISARM)
			disarm(user, victim, attacker_style, modifiers)
		if(INTENT_GRAB)
			grab(user, victim, attacker_style, modifiers, biting_grab = FALSE, forced = FALSE, grabsound = TRUE, silent = FALSE)
		if(INTENT_HARM)
			harm(user, victim, attacker_style, modifiers, SPECIAL_ATK_NONE)
		else
			help(user, victim, attacker_style, modifiers, SPECIAL_ATK_NONE)

/datum/species/help(mob/living/carbon/human/user, \
					mob/living/carbon/human/target, \
					datum/martial_art/attacker_style, \
					list/modifiers)
	if((target.body_position == STANDING_UP) || (user.zone_selected in list(BODY_ZONE_PRECISE_L_HAND, BODY_ZONE_PRECISE_R_HAND, BODY_ZONE_L_ARM, BODY_ZONE_R_ARM)))
		target.help_shake_act(user)
		if(target != user)
			log_combat(user, target, "shaken")
		return TRUE
	else if(user.zone_selected in list(BODY_ZONE_CHEST, BODY_ZONE_PRECISE_MOUTH))
		user.do_cpr(target, user.zone_selected == BODY_ZONE_CHEST ? CPR_CHEST : CPR_MOUTH)
		return TRUE

/datum/species/disarm(mob/living/carbon/human/user, \
					mob/living/carbon/human/target, \
					datum/martial_art/attacker_style, \
					list/modifiers)
	var/attack_delay = CLICK_CD_MELEE
	var/attack_fatigue_cost = 6
	if(LAZYACCESS(modifiers, RIGHT_CLICK))
		switch(user.combat_style)
			if(CS_AIMED)
				attack_delay *= 1.25
				user.update_parrying_penalty(PARRYING_PENALTY, PARRYING_PENALTY_COOLDOWN_DURATION)
				user.update_blocking_cooldown(BLOCKING_COOLDOWN_DURATION)
				user.update_dodging_cooldown(DODGING_COOLDOWN_DURATION)
	if(user != target)
		if(target.check_block())
//			user.do_attack_animation(target, no_effect = TRUE)
			user.changeNext_move(attack_delay)
			user.adjustFatigueLoss(attack_fatigue_cost)
			user.sound_hint()
			target.visible_message(span_warning("<b>[user]</b>'s shove is blocked by [target]!"), \
							span_userdanger("I block <b>[user]</b>'s shove!"), \
							span_hear("I hear a swoosh!"), \
							COMBAT_MESSAGE_RANGE, \
							user)
			to_chat(user, span_userdanger("My shove at <b>[target]</b> was blocked!"))
			log_combat(user, target, "attempted to shove, was blocked by")
			return FALSE
		if(target.check_shields(user, 10, "<b>[user]</b>'s shove", "my shove", attacking_flags = BLOCK_FLAG_MELEE) & COMPONENT_HIT_REACTION_BLOCK)
//			user.do_attack_animation(target, no_effect = TRUE)
			user.changeNext_move(attack_delay)
			user.adjustFatigueLoss(attack_fatigue_cost)
			user.sound_hint()
			return FALSE
		if(target.check_parry(user, 10, "<b>[user]</b>'s shove", "my shove", attacking_flags = BLOCK_FLAG_MELEE) & COMPONENT_HIT_REACTION_BLOCK)
//			user.do_attack_animation(target, no_effect = TRUE)
			user.changeNext_move(attack_delay)
			user.adjustFatigueLoss(attack_fatigue_cost)
			user.sound_hint()
			target.adjustFatigueLoss(5)
			return FALSE
		if(target.check_dodge(user, 10, "<b>[user]</b>'s shove", "my shove", attacking_flags = BLOCK_FLAG_MELEE) & COMPONENT_HIT_REACTION_BLOCK)
//			user.do_attack_animation(target, no_effect = TRUE)
			user.changeNext_move(attack_delay)
			user.adjustFatigueLoss(attack_fatigue_cost)
			user.sound_hint()
			target.adjustFatigueLoss(5)
			playsound(target, 'modular_pod/sound/eff/dodged.ogg', 70, TRUE)
			return FALSE
	if(attacker_style?.disarm_act(user,target) == MARTIAL_ATTACK_SUCCESS)
		return TRUE
	if(user == target)
		return FALSE
	user.disarm(target, modifiers)
	return TRUE

/datum/species/harm(mob/living/carbon/human/user, \
					mob/living/carbon/human/target, \
					datum/martial_art/attacker_style, \
					list/modifiers, \
					special_attack = SPECIAL_ATK_NONE)
	//yes i have to do this here i'm sorry
	if(LAZYACCESS(modifiers, RIGHT_CLICK) && (user.combat_style == CS_FEINT))
		var/user_diceroll = user.diceroll(GET_MOB_SKILL_VALUE(user, SKILL_BRAWLING), context = DICE_CONTEXT_PHYSICAL, return_flags = RETURN_DICE_DIFFERENCE)
		var/most_efficient_skill = max(GET_MOB_SKILL_VALUE(target, SKILL_SHIELD), \
									GET_MOB_SKILL_VALUE(target, SKILL_BUCKLER), \
									GET_MOB_SKILL_VALUE(target, SKILL_FORCE_SHIELD), \
									GET_MOB_ATTRIBUTE_VALUE(target, STAT_DEXTERITY))
		var/target_diceroll = target.diceroll(most_efficient_skill, context = DICE_CONTEXT_MENTAL, return_flags = RETURN_DICE_DIFFERENCE)
		if(!target.combat_mode)
			target_diceroll -= 20
		var/feign_attack_verb = pick(user.dna.species.attack_verb)
		//successful feint
		if(user_diceroll >= target_diceroll)
			var/feint_message_spectator = "<b>[user]</b> successfully feigns [prefix_a_or_an(feign_attack_verb)] [feign_attack_verb] on <b>[target]</b>]!"
			var/feint_message_victim = "Something feigns an attack on me!"
			var/feint_message_attacker = "I feign [prefix_a_or_an(feign_attack_verb)] [feign_attack_verb] on something!"
			if(user in fov_viewers(2, target))
				feint_message_attacker = "I feign [prefix_a_or_an(feign_attack_verb)] [feign_attack_verb] on <b>[target]</b>!"
			if(target in fov_viewers(2, user))
				feint_message_victim = "<b>[user]</b> feigns [prefix_a_or_an(feign_attack_verb)] [feign_attack_verb] on me!"
			target.visible_message(span_danger("[feint_message_spectator]"),\
				span_userdanger("[feint_message_victim]"),
				span_hear("I hear a whoosh!"), \
				vision_distance = COMBAT_MESSAGE_RANGE, \
				ignored_mobs = user)
			to_chat(user, span_userdanger("[feint_message_attacker]"))
			target.update_parrying_penalty(PARRYING_PENALTY*3, PARRYING_PENALTY_COOLDOWN_DURATION*2)
			target.update_blocking_cooldown(BLOCKING_COOLDOWN_DURATION)
			target.update_dodging_cooldown(DODGING_COOLDOWN_DURATION)
		//failed feint
		else
			var/feint_message_spectator = "<b>[user]</b> fails to feign [prefix_a_or_an(feign_attack_verb)] [feign_attack_verb] on <b>[target]</b>!"
			var/feint_message_victim = "Something fails to feign [prefix_a_or_an(feign_attack_verb)] [feign_attack_verb] on me!"
			var/feint_message_attacker = "I fail to feign [prefix_a_or_an(feign_attack_verb)] [feign_attack_verb] on something!"
			if(user in fov_viewers(2, target))
				feint_message_attacker = "I fail to feign [prefix_a_or_an(feign_attack_verb)] [feign_attack_verb] on <b>[target]</b> with!"
			if(target in fov_viewers(2, user))
				feint_message_victim = "<b>[user]</b> fails to feign [prefix_a_or_an(feign_attack_verb)] [feign_attack_verb] on me!"
			target.visible_message(span_danger("[feint_message_spectator]"),\
				span_userdanger("[feint_message_victim]"),
				span_hear("I hear a whoosh!"), \
				vision_distance = COMBAT_MESSAGE_RANGE, \
				ignored_mobs = user)
			to_chat(user, span_userdanger("[feint_message_attacker]"))
	var/attack_damage = rand(user.dna.species.punchdamagelow, user.dna.species.punchdamagehigh)
	var/attack_armor_damage = 0
	var/attack_verb
	var/attack_verb_continuous
	var/attack_effect
	var/attack_sharpness
	var/attack_fatigue_cost = 4
	var/attack_delay = CLICK_CD_MELEE
	var/attack_skill_modifier = 0
	switch(special_attack)
		if(SPECIAL_ATK_BITE)
			attack_skill_modifier -= 2
			attack_armor_damage = user.dna.species.bite_armor_damage_modifier
			attack_verb = pick(user.dna.species.bite_verb)
			attack_verb_continuous = pick(user.dna.species.bite_verb_continuous)
			attack_effect = pick(user.dna.species.bite_effect)
			attack_sharpness = user.dna.species.bite_sharpness
			attack_fatigue_cost *= 1.5
			attack_delay *= 2
		if(SPECIAL_ATK_KICK)
			attack_skill_modifier -= 2
			attack_damage *= 2
			attack_armor_damage = user.dna.species.kick_armor_damage_modifier
			attack_verb = pick(user.dna.species.kick_verb)
			attack_verb_continuous = pick(user.dna.species.kick_verb_continuous)
			attack_effect = pick(user.dna.species.kick_effect)
			attack_sharpness = user.dna.species.kick_sharpness
			attack_fatigue_cost *= 2
			attack_delay *= 2
		else
			attack_armor_damage = user.dna.species.attack_armor_damage_modifier
			attack_verb = pick(user.dna.species.attack_verb)
			attack_verb_continuous = pick(user.dna.species.attack_verb_continuous)
			attack_effect = pick(user.dna.species.attack_effect)
			attack_sharpness = user.dna.species.attack_sharpness
	if(user.attributes)
		attack_damage *= (GET_MOB_ATTRIBUTE_VALUE(user, STAT_STRENGTH)/ATTRIBUTE_MIDDLING)
	if(HAS_TRAIT(user, TRAIT_PACIFISM))
		to_chat(user, span_warning("I don't want to harm <b>[target]</b>!"))
		user.changeNext_move(CLICK_CD_MELEE)
		return FALSE
	if(LAZYACCESS(modifiers, RIGHT_CLICK))
		switch(user.combat_style)
			if(CS_WEAK)
				attack_damage *= 0.35
				attack_fatigue_cost = 2
			if(CS_AIMED)
				attack_skill_modifier += 4
				attack_delay *= 1.25
				user.update_parrying_penalty(PARRYING_PENALTY, PARRYING_PENALTY_COOLDOWN_DURATION)
				user.update_blocking_cooldown(BLOCKING_COOLDOWN_DURATION)
				user.update_dodging_cooldown(DODGING_COOLDOWN_DURATION)
			if(CS_STRONG)
				attack_damage *= 1.5
				attack_fatigue_cost *= 1.5
				user.update_parrying_penalty(PARRYING_PENALTY, PARRYING_PENALTY_COOLDOWN_DURATION)
				user.update_blocking_cooldown(BLOCKING_COOLDOWN_DURATION)
				user.update_dodging_cooldown(DODGING_COOLDOWN_DURATION)
			if(CS_FEINT)
				user.update_parrying_penalty(PARRYING_PENALTY, PARRYING_PENALTY_COOLDOWN_DURATION)
				user.update_blocking_cooldown(BLOCKING_COOLDOWN_DURATION)
				user.update_dodging_cooldown(DODGING_COOLDOWN_DURATION)
	else
		switch(user.combat_style)
			if(CS_DEFEND)
				attack_damage *= 0.75
	if(user != target)
		if(target.check_block())
//			user.do_attack_animation(target, no_effect = TRUE)
			user.changeNext_move(attack_delay)
			user.adjustFatigueLoss(attack_fatigue_cost)
			user.sound_hint()
			target.visible_message(span_warning("<b>[target]</b> blocks <b>[user]</b>'s [attack_verb]!"), \
							span_userdanger("I block <b>[user]</b>'s [attack_verb]!"), \
							span_hear("I hear a swoosh!"), \
							COMBAT_MESSAGE_RANGE, \
							user)
			if(user != target)
				to_chat(user, span_userdanger("My [attack_verb] at <b>[target]</b> was blocked!"))
			log_combat(user, target, "attempted to [attack_verb], was blocked by")
			return FALSE
		if(target.check_shields(user, attack_damage, "<b>[user]</b>'s [attack_verb]", "my [attack_verb]", BLOCK_FLAG_UNARMED) & COMPONENT_HIT_REACTION_BLOCK)
//			user.do_attack_animation(target, no_effect = TRUE)
			user.changeNext_move(attack_delay)
			user.adjustFatigueLoss(attack_fatigue_cost)
			user.sound_hint()
			return FALSE
		if(target.check_parry(user, attack_damage, "<b>[user]</b>'s [attack_verb]", "my [attack_verb]", BLOCK_FLAG_UNARMED) & COMPONENT_HIT_REACTION_BLOCK)
//			user.do_attack_animation(target, no_effect = TRUE)
			user.changeNext_move(attack_delay)
			user.adjustFatigueLoss(attack_fatigue_cost)
			user.sound_hint()
			target.adjustFatigueLoss(5)
			return FALSE
		if(target.check_dodge(user, attack_damage, "<b>[user]</b>'s [attack_verb]", "my [attack_verb]", BLOCK_FLAG_UNARMED) & COMPONENT_HIT_REACTION_BLOCK)
//			user.do_attack_animation(target, no_effect = TRUE)
			user.changeNext_move(attack_delay)
			user.adjustFatigueLoss(attack_fatigue_cost)
			user.sound_hint()
			target.adjustFatigueLoss(5)
			playsound(target, 'modular_pod/sound/eff/dodged.ogg', 70, TRUE)
			return FALSE
	if(attacker_style?.harm_act(user,target) == MARTIAL_ATTACK_SUCCESS)
		return TRUE

//	user.do_attack_animation(target, attack_effect, no_effect = TRUE)
	user.sound_hint()

	var/obj/item/bodypart/attacking_part
	switch(attack_effect)
		if(ATTACK_EFFECT_BITE)
			attacking_part = user.get_bodypart_nostump(BODY_ZONE_PRECISE_MOUTH)
		if(ATTACK_EFFECT_KICK)
			attacking_part = user.get_active_foot()
		else
			attacking_part = user.get_active_hand()
	if(!attacking_part)
		attack_damage = 0
	else
		attack_damage = FLOOR(attack_damage * (attacking_part.limb_efficiency/LIMB_EFFICIENCY_OPTIMAL), DAMAGE_PRECISION)

	var/obj/item/bodypart/affecting = target.get_bodypart(check_zone(user.zone_selected))

	///melee skill
	var/skill_modifier = GET_MOB_SKILL_VALUE(user, SKILL_BRAWLING)
	///calculate the odds that a punch misses entirely
	var/hit_modifier = 0
	///chance to hit the wrong zone
	var/hit_zone_modifier = 0
	if(affecting)
		hit_modifier = affecting.melee_hit_modifier
		hit_zone_modifier = affecting.melee_hit_zone_modifier
		//very hard to miss when hidden by fov
		if(!(src in fov_viewers(2, user)))
			hit_modifier += 10
			hit_zone_modifier += 10
			attack_damage *= 1.1
		//easy to kick people when they are down
		if((target.body_position == LYING_DOWN) && (user.body_position != LYING_DOWN))
			hit_modifier += 5
			hit_zone_modifier += 5
		if(user.body_position == LYING_DOWN)
			attack_damage *= 0.5
		//bro we dead :skull:
		if(target.stat >= UNCONSCIOUS)
			hit_modifier += 15
		//perfection, man
		if(HAS_TRAIT(user, TRAIT_PERFECT_ATTACKER))
			hit_modifier = 20
			hit_zone_modifier = 20
		//hitting yourself is easy, almost impossible to miss
		else if(user == target)
			hit_modifier = 20
			hit_zone_modifier = 20

	var/hit_area = parse_zone(user.zone_selected)
	var/def_zone = user.zone_selected
	var/intended_zone = user.zone_selected
	if(affecting)
		hit_area = affecting.name
		def_zone = affecting.body_zone
	user.changeNext_move(attack_delay)
	user.adjustFatigueLoss(attack_fatigue_cost)
	//future-proofing for species that have 0 damage/weird cases where no zone is targeted
	var/diceroll = user.diceroll(skill_modifier+hit_modifier+attack_skill_modifier, context = DICE_CONTEXT_PHYSICAL)
	if(!affecting)
		playsound(target.loc, user.dna.species.miss_sound, 60, TRUE, -1)
		if(user != target)
			target.visible_message(span_danger("<b>[user]</b> tries to [attack_verb] <b>[target]</b>'s [hit_area], but that limb is missing!"), \
							span_userdanger("<b>[user]</b> tries to [attack_verb] my [hit_area], but that limb is missing!"), \
							span_hear("I hear a swoosh!"), \
							COMBAT_MESSAGE_RANGE, \
							user)
			to_chat(user, span_userdanger("I try to [attack_verb] <b>[target]</b>'s [hit_area], but that limb is missing!"))
		else
			target.visible_message(span_danger("<b>[user]</b> tries to [attack_verb] [user.p_themselves()] on \the [hit_area], but that limb is missing!"), \
							span_userdanger("I try to [attack_verb] my [hit_area], but that limb is missing!"), \
							span_hear("I hear a swoosh!"), \
							COMBAT_MESSAGE_RANGE)
		log_combat(user, target, "attempted to [attack_verb], limb missing")
		return FALSE

	else if(diceroll == DICE_CRIT_FAILURE)
		playsound(target.loc, user.dna.species.miss_sound, 60, TRUE, -1)
		if(user != target)
			target.visible_message(span_danger("<b>[user]</b> tries to [attack_verb] <b>[target]</b>'s [hit_area], but misses!"), \
							span_userdanger("<b>[user]</b> tries to [attack_verb] my [hit_area], but misses!"), \
							span_hear("I hear a swoosh!"), \
							COMBAT_MESSAGE_RANGE, \
							user)
			to_chat(user, span_userdanger("I try to [attack_verb] <b>[target]</b>'s [hit_area], but miss!"))
		else
			target.visible_message(span_danger("<b>[user]</b> tries to [attack_verb] [user.p_themselves()] on \the [hit_area], but misses!"), \
							span_userdanger("I try to [attack_verb] my [hit_area], but miss!"), \
							span_hear("I hear a swoosh!"), \
							COMBAT_MESSAGE_RANGE)
		log_combat(user, target, "attempted to [attack_verb], missed")
		return FALSE

	// hit the wrong body zone
	if(user.diceroll(skill_modifier+hit_zone_modifier, context = DICE_CONTEXT_PHYSICAL) <= DICE_FAILURE)
		affecting = target.get_bodypart(ran_zone(user.zone_selected, 0))

	var/armor_block = target.run_armor_check(affecting, MELEE, sharpness = attack_sharpness)
	var/armor_reduce = target.run_subarmor_check(affecting, MELEE, sharpness = attack_sharpness)
	var/subarmor_flags = target.get_subarmor_flags(affecting)
	var/edge_protection = target.get_edge_protection(affecting)

	var/real_attack_sound = user.dna.species.attack_sound
	switch(special_attack)
		if(SPECIAL_ATK_BITE)
			real_attack_sound = user.dna.species.bite_sound
		if(SPECIAL_ATK_KICK)
			real_attack_sound = user.dna.species.kick_sound

	playsound(target.loc, real_attack_sound, 60, TRUE, -1)
	target.sound_hint()
	if(attack_damage < 0)
		if(user != target)
			target.visible_message(span_danger("<b>[user]</b> tries to [attack_verb] <b>[target]</b>'s [hit_area], with no effect!"), \
							span_userdanger("<b>[user]</b> tries to [attack_verb] my [hit_area], with no effect!"), \
							span_hear("I hear a swoosh!"), \
							COMBAT_MESSAGE_RANGE, \
							user)
			to_chat(user, span_userdanger("I try to [attack_verb] <b>[target]</b>'s [hit_area], with no effect!"))
		else
			target.visible_message(span_danger("<b>[user]</b> tries to [attack_verb] [user.p_themselves()] on \the [hit_area], with no effect!"), \
							span_userdanger("I try to [attack_verb] my [hit_area], with no effect!"), \
							span_hear("I hear a swoosh!"), \
							COMBAT_MESSAGE_RANGE)
		log_combat(user, target, "attempted to [attack_verb], no effect")
		return FALSE

	if(target.stat == CONSCIOUS)
		if(target.combat_mode)
			if(target.dodge_parry == DP_PARRY)
				if(target.usable_hands >= target.default_num_hands)
					if(target.next_move < world.time)
						if(!target.pulledby)
							if(target != user)
								var/empty_indexes = target.get_empty_held_indexes()
								if(length(empty_indexes) >= 2)
									if(attack_damage <= (GET_MOB_ATTRIBUTE_VALUE(target, STAT_ENDURANCE)))
										var/dicerollll = target.diceroll(GET_MOB_SKILL_VALUE(target, SKILL_BRAWLING), context = DICE_CONTEXT_PHYSICAL)
										if(dicerollll >= DICE_SUCCESS)
											target.visible_message(span_danger("<b>[user]</b> пытается [attack_verb] <b>[target]</b> [hit_area], но [target] блокирует руками!"), \
														span_userdanger("<b>[user]</b> пытается [attack_verb] в [hit_area], но я блокирую руками!"), \
														span_hear("Я слышу стук!"), \
														COMBAT_MESSAGE_RANGE, \
														user)
											to_chat(user, span_userdanger("Я пытаюсь [attack_verb] <b>[target]</b> [hit_area], но [target] блокирует руками!"))
											target.changeNext_move(CLICK_CD_GRABBING)
											target.update_parrying_penalty(PARRYING_PENALTY, PARRYING_PENALTY_COOLDOWN_DURATION)
											target.adjustFatigueLoss(5)
											playsound(target.loc, 'modular_pod/sound/eff/punch 2.ogg', 70, TRUE)
											return FALSE

	target.lastattacker = user.real_name
	target.lastattackerckey = user.ckey
	user.dna.species.spec_unarmedattacked(user, target)

	if(user.limb_destroyer)
		target.dismembering_strike(user, affecting.body_zone)

	target.apply_damage(attack_damage, \
						user.dna.species.attack_type, \
						affecting, \
						armor_block, \
						sharpness = attack_sharpness, \
						reduced = armor_reduce, \
						edge_protection = edge_protection, \
						subarmor_flags = subarmor_flags)
	target.damage_armor(attack_damage+attack_armor_damage, MELEE, user.dna.species.attack_type, attack_sharpness, affecting)
	post_hit_effects(target, user, affecting, attack_effect, attack_damage, MELEE, user.dna.species.attack_type, NONE, def_zone, intended_zone, modifiers)
	if(def_zone == intended_zone)
		if(user != target)
			target.visible_message(span_danger("<b>[user]</b> [attack_verb_continuous] <b>[target]</b> [hit_area]![target.wound_message]"), \
							span_userdanger("<b>[user]</b> [attack_verb_continuous] меня в [hit_area]![target.wound_message]"), \
							span_hear("Я слышу звук плоти!"), \
							vision_distance = COMBAT_MESSAGE_RANGE, \
							ignored_mobs = user)
			to_chat(user, span_userdanger("Я [attack_verb] <b>[target]</b> [hit_area]![target.wound_message]"))
		else
			target.visible_message(span_danger("<b>[user]</b> [attack_verb_continuous] себя в [hit_area]![target.wound_message]"), \
							span_userdanger("Я [attack_verb] себя в [hit_area]![target.wound_message]"), \
							span_hear("Я слышу звук плоти!"), \
							vision_distance = COMBAT_MESSAGE_RANGE)
	else
		var/parsed_intended_zone = parse_zone(intended_zone)
		if(user != target)
//			if(!lying_attack_check(user))
//				return
			target.visible_message(span_danger("<b>[user]</b> целит в \[parsed_intended_zone], но [attack_verb_continuous] <b>[target]</b> [hit_area]![target.wound_message]"), \
							span_userdanger("<b>[user]</b> целит в \[parsed_intended_zone], но [attack_verb_continuous] меня в [hit_area]![target.wound_message]"), \
							span_hear("Я слышу звук плоти!"), \
							vision_distance = COMBAT_MESSAGE_RANGE, \
							ignored_mobs = user)
			to_chat(user, span_userdanger("Я целю в [parsed_intended_zone], но [attack_verb] <b>[target]</b> [hit_area]![target.wound_message]"))
		else
			target.visible_message(span_danger("<b>[user]</b> целит в \[parsed_intended_zone], но [attack_verb_continuous] себя в [hit_area]![target.wound_message]"), \
							span_userdanger("Я целю в \[parsed_intended_zone], но [attack_verb] себя в [hit_area]![target.wound_message]"), \
							span_hear("Я слышу звук плоти!"), \
							vision_distance = COMBAT_MESSAGE_RANGE, \
							ignored_mobs = user)

	log_combat(user, target, "[attack_verb]")
	SEND_SIGNAL(target, COMSIG_CARBON_CLEAR_WOUND_MESSAGE)
	return TRUE

/datum/species/grab(mob/living/carbon/human/user, \
					mob/living/carbon/human/target, \
					datum/martial_art/attacker_style, \
					list/modifiers, \
					biting_grab = FALSE, \
					forced = FALSE, \
					grabsound = TRUE, \
					silent = FALSE)
	if(target.check_block())
		target.visible_message(span_warning("<b>[target]</b> blocks <b>[user]</b>'s [biting_grab ? "bite" : "grab"]!"), \
						span_userdanger("I block <b>[user]</b>'s [biting_grab ? "bite" : "grab"]!"), \
						span_hear("I hear a swoosh!"), \
						vision_distance = COMBAT_MESSAGE_RANGE, \
						ignored_mobs = user)
		to_chat(user, span_warning("My [biting_grab ? "bite" : "grab"] at [target] was blocked!"))
		log_combat(user, target, "attempted to [biting_grab ? "bite" : "grab"], was blocked by")
		return FALSE
	if(attacker_style?.grab_act(user, target) == MARTIAL_ATTACK_SUCCESS)
		return TRUE
	target.grabbedby(user, FALSE, biting_grab, forced, grabsound, silent)
	return TRUE

/datum/species/proc/spec_attack_foot(mob/living/carbon/human/user, \
									mob/living/carbon/human/victim, \
									datum/martial_art/attacker_style, \
									list/modifiers)
	if(!istype(user))
		return
//	if(!victim.lying_attack_check(user))
//		return FALSE
	CHECK_DNA_AND_SPECIES(user)
	CHECK_DNA_AND_SPECIES(victim)

	if(!attacker_style && user.mind)
		attacker_style = user.mind.martial_art

	SEND_SIGNAL(user, COMSIG_MOB_ATTACK_FOOT, user, victim, attacker_style)

	return harm(user, victim, attacker_style, modifiers, SPECIAL_ATK_KICK)

/datum/species/proc/spec_attack_jaw(mob/living/carbon/human/user, \
									mob/living/carbon/human/victim, \
									datum/martial_art/attacker_style, \
									list/modifiers)
	if(!istype(user))
		return
//	if(!victim.lying_attack_check(user))
//		return FALSE
	CHECK_DNA_AND_SPECIES(user)
	CHECK_DNA_AND_SPECIES(victim)

	if(!attacker_style && user.mind)
		attacker_style = user.mind.martial_art

	SEND_SIGNAL(user, COMSIG_MOB_ATTACK_JAW, user, victim, attacker_style)
	return grab(user, victim, attacker_style, modifiers, biting_grab = TRUE, forced = FALSE, grabsound = TRUE, silent = FALSE)

//Weapon can be an attack effect instead
/datum/species/proc/post_hit_effects(mob/living/carbon/human/victim, \
									mob/living/carbon/human/user, \
									obj/item/bodypart/affected, \
									obj/item/weapon, \
									damage = 0, \
									damage_flag = MELEE, \
									damage_type = BRUTE, \
									sharpness = NONE,
									def_zone = BODY_ZONE_CHEST, \
									intended_zone = BODY_ZONE_CHEST, \
									list/modifiers)
	var/victim_end = GET_MOB_ATTRIBUTE_VALUE(victim, STAT_ENDURANCE)
	if(istype(weapon))
		if(sharpness)
			if(weapon.poisoned_type)
				if(weapon.current_fucked_reagents > 0)
					var/edgee_protection = 0
					var/resultt = 0
					edgee_protection = victim.get_edge_protection(affected)
					resultt = (edgee_protection - weapon.edge_protection_penetration)
					if(resultt <= 0)
						victim.reagents?.add_reagent(weapon.poisoned_type, weapon.how_eats)
						weapon.current_fucked_reagents -= weapon.how_eats
/*
						victim.visible_message(span_green("[victim] got reagented by [user]!"), \
											span_green("I am got reagented by [user]!"), \
											span_hear("I hear the sound of combat."))
*/

	if(!sharpness)
		if(victim.body_position != LYING_DOWN)
			var/knockback_tiles = 0
			if(victim_end >= 3)
				knockback_tiles = FLOOR(damage/((victim_end - 2) * 2.5), 1)
			// I HATE DIVISION BY ZERO! I HATE DIVISION BY ZERO!
			else
				knockback_tiles = FLOOR(damage/2, 1)
			if(knockback_tiles >= 1)
				var/turf/edge_target_turf = get_edge_target_turf(victim, get_dir(user, victim))
				if(istype(edge_target_turf))
					victim.safe_throw_at(edge_target_turf, \
										knockback_tiles, \
										knockback_tiles, \
										user, \
										spin = FALSE, \
										force = victim.move_force, \
										callback = CALLBACK(victim, /mob/living/carbon/proc/handle_knockback, get_turf(victim)))
		else
			if(victim.diceroll(GET_MOB_ATTRIBUTE_VALUE(victim, STAT_LUCK), context = DICE_CONTEXT_PHYSICAL) <= DICE_FAILURE)
				var/turf/open/floor/plating/A = get_turf(victim)
				victim.apply_damage(A.powerfloor, BRUTE, affected, victim.run_armor_check(affected, MELEE), wound_bonus = A.dangerfloor, sharpness = NONE)
				victim.visible_message(span_pinkdang("[victim] [affected] ударяется об [A]!"), \
									span_pinkdang("Чёрт, [affected] ударяется об [A]!"), \
									span_hear("Я слышу звук плоти."))
				playsound(get_turf(victim), 'modular_pod/sound/eff/punch 1.ogg', 80, 0)
	stunning(victim, user, affected, weapon, damage, damage_flag, damage_type, sharpness, def_zone, intended_zone, modifiers)
	realstunning(victim, user, affected, weapon, damage, damage_flag, damage_type, sharpness, def_zone, intended_zone, modifiers)
	stumbling(victim, user, affected, weapon, damage, damage_flag, damage_type, sharpness, def_zone, intended_zone, modifiers)
//	staminy(victim, user, affected, weapon, damage, damage_flag, damage_type, sharpness, def_zone, intended_zone, modifiers)
	embedding(victim, user, affected, weapon, damage, damage_flag, damage_type, sharpness, def_zone, intended_zone, modifiers)
	incisioner(victim, user, affected, weapon, damage, damage_flag, damage_type, sharpness, def_zone, intended_zone, modifiers)
	goodhits(victim, user, affected, weapon, damage, damage_flag, damage_type, sharpness, def_zone, intended_zone, modifiers)
	if(damage > 5)
		if(victim.diceroll(GET_MOB_ATTRIBUTE_VALUE(victim, STAT_WILL), context = DICE_CONTEXT_MENTAL) <= DICE_FAILURE)
			shake_camera(victim, 1, 1)
	return TRUE

/datum/species/proc/stunning(mob/living/carbon/human/victim, \
							mob/living/carbon/human/user, \
							obj/item/bodypart/affected, \
							obj/item/weapon, \
							damage = 0, \
							damage_flag = MELEE, \
							damage_type = BRUTE, \
							sharpness = NONE,
							def_zone = BODY_ZONE_CHEST, \
							intended_zone = BODY_ZONE_CHEST, \
							list/modifiers)
	var/user_end = GET_MOB_ATTRIBUTE_VALUE(user, STAT_ENDURANCE)
	if(victim.diceroll(GET_MOB_ATTRIBUTE_VALUE(victim, STAT_STRENGTH)+1, context = DICE_CONTEXT_PHYSICAL) <= DICE_FAILURE)
		if(user_end >= 3)
			victim.Immobilize(2 SECONDS)
		else
			victim.Immobilize(1 SECONDS)
	return TRUE

/datum/species/proc/realstunning(mob/living/carbon/human/victim, \
							mob/living/carbon/human/user, \
							obj/item/bodypart/affected, \
							obj/item/weapon, \
							damage = 0, \
							damage_flag = MELEE, \
							damage_type = BRUTE, \
							sharpness = NONE,
							def_zone = BODY_ZONE_CHEST, \
							intended_zone = BODY_ZONE_CHEST, \
							list/modifiers)
	var/user_str = GET_MOB_ATTRIBUTE_VALUE(user, STAT_STRENGTH)
	if(victim.diceroll(GET_MOB_ATTRIBUTE_VALUE(victim, STAT_ENDURANCE), context = DICE_CONTEXT_PHYSICAL) <= DICE_FAILURE)
		var/protection = 0
		var/resultt = 0
		if(!istype(weapon))
			protection = victim.getarmor(affected, MELEE)
			resultt = (protection - damage)
		else
			protection = victim.getsubarmor(affected, CRUSHING)
			resultt = (protection - weapon.armour_penetration)
			if(resultt <= 0)
				if(user_str >= 3)
					victim.Stun(2 SECONDS)
				else
					victim.Stun(1 SECONDS)
	return TRUE

/datum/species/proc/stumbling(mob/living/carbon/human/victim, \
							mob/living/carbon/human/user, \
							obj/item/bodypart/affected, \
							obj/item/weapon, \
							damage = 0, \
							damage_flag = MELEE, \
							damage_type = BRUTE, \
							sharpness = NONE,
							def_zone = BODY_ZONE_CHEST, \
							intended_zone = BODY_ZONE_CHEST, \
							list/modifiers)
	var/user_end = GET_MOB_ATTRIBUTE_VALUE(user, STAT_STRENGTH)
	if(victim.diceroll(GET_MOB_ATTRIBUTE_VALUE(victim, STAT_DEXTERITY)+1, context = DICE_CONTEXT_PHYSICAL) <= DICE_FAILURE)
		if(user_end >= 3)
			victim.Stumble(3 SECONDS)
		else
			victim.Stumble(1 SECONDS)
	return TRUE

/datum/species/proc/goodhits(mob/living/carbon/human/victim, \
							mob/living/carbon/human/user, \
							obj/item/bodypart/affected, \
							obj/item/weapon, \
							damage = 0, \
							damage_flag = MELEE, \
							damage_type = BRUTE, \
							sharpness = NONE,
							def_zone = BODY_ZONE_CHEST, \
							intended_zone = BODY_ZONE_CHEST, \
							list/modifiers)
	if(user.diceroll(GET_MOB_ATTRIBUTE_VALUE(victim, STAT_STRENGTH), context = DICE_CONTEXT_PHYSICAL) >= DICE_SUCCESS)
		switch(def_zone)
			if(BODY_ZONE_PRECISE_GROIN)
				if((victim.getorganslotefficiency(ORGAN_SLOT_TESTICLES) > ORGAN_FAILING_EFFICIENCY) || (victim.getorganslotefficiency(ORGAN_SLOT_PENIS) > ORGAN_FAILING_EFFICIENCY))
					var/protection = 0
					var/resultt = 0
					if(!istype(weapon))
						protection = victim.getarmor(affected, MELEE)
						resultt = (protection - damage)
					else
						protection = victim.getsubarmor(affected, CRUSHING)
						resultt = (protection - weapon.armour_penetration)
						if(resultt <= 0)
							victim.Stumble(10 SECONDS)
							var/diceroll = victim.diceroll(GET_MOB_ATTRIBUTE_VALUE(victim, STAT_ENDURANCE), context = DICE_CONTEXT_MENTAL)
							if(diceroll == DICE_FAILURE)
								victim.Stun(1 SECONDS)
							if(diceroll == DICE_CRIT_FAILURE)
								victim.Stun(2 SECONDS)
							victim.visible_message(span_pinkdang("[victim] получает удар в пах от [user]!"), \
												span_pinkdang("Я получаю удар в пах от [user]!"), \
												span_hear("Я слышу звук плоти."))
							if(victim.stat >= UNCONSCIOUS)
								return
//							playsound(get_turf(victim), 'modular_pod/sound/voice/PAINBALLS.ogg', 80, 0)
			if(BODY_ZONE_PRECISE_VITALS)
				var/protection = 0
				var/resultt = 0
				if(!istype(weapon))
					protection = victim.getarmor(affected, MELEE)
					resultt = (protection - damage)
				else
					protection = victim.getsubarmor(affected, CRUSHING)
					resultt = (protection - weapon.armour_penetration)
					if(resultt <= 0)
						victim.emote("burp")
						var/diceroll = victim.diceroll(GET_MOB_ATTRIBUTE_VALUE(victim, STAT_ENDURANCE), context = DICE_CONTEXT_MENTAL)
						if(diceroll == DICE_FAILURE)
							victim.vomit(10, FALSE, FALSE)
						if(diceroll == DICE_CRIT_FAILURE)
							victim.vomit(10, TRUE, FALSE)
						victim.visible_message(span_pinkdang("[victim] получает удар по кишкам от [user]!"), \
											span_pinkdang("Получает удар по кишкам от [user]!"), \
											span_hear("Я слышу звук плоти."))
						if(victim.stat >= UNCONSCIOUS)
							return
						playsound(get_turf(victim), 'modular_septic/sound/effects/gutbusted.ogg', 80, 0)
	return TRUE

/*
/datum/species/proc/staminy(mob/living/carbon/human/victim, \
							mob/living/carbon/human/user, \
							obj/item/bodypart/affected, \
							obj/item/weapon, \
							damage = 0, \
							damage_flag = MELEE, \
							damage_type = BRUTE, \
							sharpness = NONE,
							def_zone = BODY_ZONE_CHEST, \
							intended_zone = BODY_ZONE_CHEST, \
							list/modifiers)
	var/user_end = GET_MOB_ATTRIBUTE_VALUE(user, STAT_STRENGTH)
	if(victim.diceroll(GET_MOB_ATTRIBUTE_VALUE(victim, STAT_ENDURANCE)+1, context = DICE_CONTEXT_PHYSICAL) <= DICE_FAILURE)
		var/armor_block = victim.run_armor_check(affected, MELEE)
		if(user_end >= 3)
			victim.apply_damage(damage*0.5, STAMINA, affected, armor_block)
		else
			victim.apply_damage(damage*0.2, STAMINA, affected, armor_block)
	return TRUE
*/

/datum/species/proc/incisioner(mob/living/carbon/human/victim, \
						mob/living/carbon/human/user, \
						obj/item/bodypart/affected, \
						obj/item/weapon, \
						damage = 0, \
						damage_flag = MELEE, \
						damage_type = BRUTE, \
						sharpness = NONE, \
						def_zone = BODY_ZONE_CHEST, \
						intended_zone = BODY_ZONE_CHEST, \
						wound_messages = TRUE, \
						list/modifiers)
	if(!istype(weapon) || (!sharpness))
		return FALSE
	var/user_result = user.diceroll(GET_MOB_ATTRIBUTE_VALUE(user, STAT_STRENGTH), context = DICE_CONTEXT_PHYSICAL)
	var/victim_result = victim.diceroll(GET_MOB_ATTRIBUTE_VALUE(victim, STAT_ENDURANCE), context = DICE_CONTEXT_PHYSICAL)
	if((user_result > DICE_FAILURE) && (victim_result <= DICE_FAILURE))
		if(!affected.get_incision(TRUE))
			var/edge_protection = 0
			var/resultt = 0
			edge_protection = victim.get_edge_protection(affected)
			resultt = (edge_protection - weapon.edge_protection_penetration)
			if(resultt <= 0)
				affected.open_incision()
				for(var/obj/item/organ/bone/bonee as anything in affected.getorganslotlist(ORGAN_SLOT_BONE))
					if(!bonee.is_broken())
						victim.visible_message(span_pinkdang("[user] [weapon] надрезает [victim] [affected]!"), \
											span_pinkdang("[user] [weapon] надрезает [affected]!"), \
											span_hear("Я слышу звук плоти."))
						playsound(get_turf(victim), 'modular_septic/sound/gore/flesh1.ogg', 80, 0)
					else
						victim.visible_message(span_pinkdang("[user] [weapon]  надрезает [victim] [affected]!"), \
											span_pinkdang("[user] [weapon] надрезает [affected]!"), \
											span_hear("Я слышу звук плоти."))
						playsound(get_turf(victim), 'modular_septic/sound/gore/dissection.ogg', 80, 0)
			return TRUE
		return FALSE
	return FALSE

/datum/species/proc/embedding(mob/living/carbon/human/victim, \
						mob/living/carbon/human/user, \
						obj/item/bodypart/affected, \
						obj/item/weapon, \
						damage = 0, \
						damage_flag = MELEE, \
						damage_type = BRUTE, \
						sharpness = NONE, \
						def_zone = BODY_ZONE_CHEST, \
						intended_zone = BODY_ZONE_CHEST, \
						wound_messages = TRUE, \
						list/modifiers)
	if(!istype(weapon) || !length(weapon.embedding))
		return FALSE
	var/user_result = user.diceroll(GET_MOB_ATTRIBUTE_VALUE(user, STAT_STRENGTH)+1, context = DICE_CONTEXT_PHYSICAL)
	var/victim_result = victim.diceroll(GET_MOB_ATTRIBUTE_VALUE(victim, STAT_ENDURANCE), context = DICE_CONTEXT_PHYSICAL)
	if((user_result > DICE_FAILURE) && (victim_result <= DICE_FAILURE))
		var/edge_protection = 0
		var/resultt = 0
		edge_protection = victim.get_edge_protection(affected)
		resultt = (edge_protection - weapon.edge_protection_penetration)
		if(resultt <= 5)
			var/embed_attempt = weapon.tryEmbed(target = affected, forced = FALSE, silent = FALSE)
			if(embed_attempt & COMPONENT_EMBED_SUCCESS)
				user.changeNext_move(0)
				victim.visible_message(span_pinkdang("[user] [weapon] застревает в [victim] [affected]!"), \
									span_pinkdang("[user] [weapon] застревает в [affected]!"), \
									span_hear("Я слышу звук плоти."))
				victim.grabbedby(user, instant = FALSE, biting_grab = FALSE, forced = TRUE, grabsound = FALSE, silent = TRUE, forced_zone = affected.body_zone)
				playsound(get_turf(victim), 'modular_septic/sound/gore/stuck2.ogg', 80, 0)
				return TRUE
			return FALSE
	return FALSE
