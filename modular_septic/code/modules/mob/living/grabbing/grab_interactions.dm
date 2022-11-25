/obj/item/grab/proc/strangle()
	//Wtf?
	if(!grasped_part)
		return FALSE
	//You can't strangle yourself!
	if(owner == victim)
		return FALSE
	for(var/obj/item/grab/other_grab in owner.held_items)
		if(other_grab == src)
			continue
		//You can't double strangle, sorry!
		else if(other_grab.active && (other_grab.grab_mode == GM_STRANGLE))
			to_chat(owner, span_danger("I'm already strangling [victim.p_them()]!"))
			return FALSE
		//Due to shitcode reasons, i cannot support strangling and taking down simultaneously
		else if(other_grab.active && (other_grab.grab_mode == GM_TAKEDOWN))
			to_chat(owner, span_danger("I'm too focused on taking [victim.p_them()] down!"))
			return FALSE
	active = !active
	if(!active)
		owner.setGrabState(GRAB_AGGRESSIVE)
		owner.set_pull_offsets(victim, owner.grab_state)
		victim.sound_hint()
		victim.visible_message(span_danger("<b>[owner]</b> stops strangling <b>[victim]</b>!"), \
						span_userdanger("<b>[owner]</b> stops strangling me!"), \
						vision_distance = COMBAT_MESSAGE_RANGE, \
						ignored_mobs = owner)
	else
		to_chat(owner, span_danger("I stop strangling <b>[victim]</b>!"))
		owner.setGrabState(GRAB_KILL)
		owner.set_pull_offsets(victim, owner.grab_state)
		victim.visible_message(span_danger("<b>[owner]</b> starts strangling <b>[victim]</b>!"), \
						span_userdanger("<b>[owner]</b> starts strangling me!"), \
						vision_distance = COMBAT_MESSAGE_RANGE, \
						ignored_mobs = owner)
		to_chat(owner, span_userdanger("I start strangling <b>[victim]</b>!"))
		victim.adjustOxyLoss(GET_MOB_ATTRIBUTE_VALUE(owner, STAT_STRENGTH))
		actions_done++
	grab_hud?.update_appearance()
	owner.changeNext_move(CLICK_CD_STRANGLE)
	owner.sound_hint()
	owner.adjustFatigueLoss(5)
	playsound(victim, 'modular_septic/sound/attack/twist.wav', 75, FALSE)
	return TRUE

/obj/item/grab/proc/takedown()
	//Wtf?
	if(!grasped_part)
		return FALSE
	//You can't takedown yourself!
	if(owner == victim)
		return FALSE
	for(var/obj/item/grab/other_grab in owner.held_items)
		if(other_grab == src)
			continue
		//Only one hand can be the master of puppets!
		else if(other_grab.active  && (other_grab.grab_mode == GM_TAKEDOWN) )
			to_chat(owner, span_danger("I'm already taking [victim.p_them()] down!"))
			return FALSE
		//Due to shitcode reasons, i cannot support strangling and taking down simultaneously
		else if(other_grab.active && (other_grab.grab_mode == GM_STRANGLE))
			to_chat(owner, span_danger("I'm too focused on strangling [victim.p_them()]!"))
			return FALSE
	if(active)
		active = FALSE
		owner.setGrabState(GRAB_AGGRESSIVE)
		owner.set_pull_offsets(victim, owner.grab_state)
		victim.visible_message(span_danger("<b>[owner]</b> stops pinning <b>[victim]</b> down!"), \
						span_userdanger("<b>[owner]</b> stops pinning me down!"), \
						vision_distance = COMBAT_MESSAGE_RANGE, \
						ignored_mobs = owner)
		to_chat(owner, span_userdanger("I stop pinning <b>[victim]</b> down!"))
	else
		var/valid_takedown = (victim.body_position == LYING_DOWN)
		for(var/obj/item/grab/other_grab in owner.held_items)
			if(other_grab == src)
				continue
			if((other_grab.grab_mode in list(GM_TEAROFF, GM_WRENCH)) && other_grab.actions_done)
				valid_takedown = TRUE
		//We need to do a lil' wrenching first! (Or the guy must be lying down)
		if(!valid_takedown)
			to_chat(owner, span_danger("I need to subdue them more first!"))
			return FALSE
		active = TRUE
		owner.setGrabState(GRAB_NECK) //don't take GRAB_NECK literally
		owner.set_pull_offsets(victim, owner.grab_state)
		victim.visible_message(span_danger("<b>[owner]</b> starts pinning <b>[victim]</b> down!"), \
						span_userdanger("<b>[owner]</b> starts pinning me down!"), \
						vision_distance = COMBAT_MESSAGE_RANGE, \
						ignored_mobs = owner)
		to_chat(owner, span_userdanger("I start pinning <b>[victim]</b> down!"))
		victim.CombatKnockdown((GET_MOB_ATTRIBUTE_VALUE(owner, STAT_STRENGTH)/2) SECONDS)
		victim.sound_hint()
		actions_done++
	grab_hud?.update_appearance()
	owner.changeNext_move(CLICK_CD_TAKEDOWN)
	owner.sound_hint()
	owner.adjustFatigueLoss(5)
	playsound(victim, 'modular_septic/sound/attack/twist.wav', 75, FALSE)
	return TRUE

/obj/item/grab/proc/wrench_limb()
	//God damn fucking simple mobs
	if(!grasped_part)
		return FALSE
	if(IS_HELP_INTENT(owner, null) && grasped_part.is_dislocated())
		if(DOING_INTERACTION_WITH_TARGET(owner, victim))
			return FALSE
		return relocate_limb()
	var/mob/living/carbon/carbon_victim = victim
	var/nonlethal = (!owner.combat_mode && (actions_done <= 0))
	var/epic_success = DICE_FAILURE
	var/modifier = 0
	if(victim.combat_mode && (GET_MOB_ATTRIBUTE_VALUE(victim, STAT_STRENGTH) > GET_MOB_ATTRIBUTE_VALUE(owner, STAT_STRENGTH)))
		modifier -= 2
	epic_success = owner.diceroll(GET_MOB_SKILL_VALUE(owner, SKILL_WRESTLING)+modifier, context = DICE_CONTEXT_PHYSICAL)
	if(owner == victim)
		epic_success = max(epic_success, DICE_SUCCESS)
	if(epic_success >= DICE_SUCCESS)
		var/wrench_verb_singular = "wrench"
		var/wrench_verb = "wrenches"
		if(nonlethal)
			wrench_verb_singular = "twist"
			wrench_verb = "twists"
		var/damage = GET_MOB_ATTRIBUTE_VALUE(owner, STAT_STRENGTH)
		var/deal_wound_bonus = 10
		if(epic_success >= DICE_CRIT_SUCCESS)
			deal_wound_bonus += 10
		if(!nonlethal)
			grasped_part.receive_damage(brute = damage, wound_bonus = deal_wound_bonus, sharpness = NONE)
			if(prob(15 + (GET_MOB_ATTRIBUTE_VALUE(owner, STAT_STRENGTH) - GET_MOB_ATTRIBUTE_VALUE(victim, STAT_ENDURANCE))))
				for(var/obj/item/organ/bone/bonee as anything in grasped_part.getorganslotlist(ORGAN_SLOT_BONE))
					if(!bonee.is_broken())
						bonee.compound_fracture()
		if(owner != victim)
			victim.visible_message(span_danger("<b>[owner]</b> [wrench_verb] <b>[victim]</b>'s [grasped_part.name]![carbon_victim.wound_message]"), \
							span_userdanger("<b>[owner]</b> [wrench_verb] my [grasped_part.name]![carbon_victim.wound_message]"), \
							vision_distance = COMBAT_MESSAGE_RANGE, \
							ignored_mobs = owner)
			to_chat(owner, span_userdanger("I [wrench_verb_singular] <b>[victim]</b>'s [grasped_part.name]![carbon_victim.wound_message]"))
		else
			victim.visible_message(span_danger("<b>[owner]</b> [wrench_verb] [owner.p_their()] [grasped_part.name]![carbon_victim.wound_message]"), \
							span_userdanger("I [wrench_verb_singular] my [grasped_part.name]![carbon_victim.wound_message]"), \
							vision_distance = COMBAT_MESSAGE_RANGE)
		SEND_SIGNAL(carbon_victim, COMSIG_CARBON_CLEAR_WOUND_MESSAGE)
		actions_done++
	else
		var/wrench_verb_singular = "wrench"
		if(nonlethal)
			wrench_verb_singular = "twist"
		if(owner != victim)
			victim.visible_message(span_danger("<b>[owner]</b> tries to [wrench_verb_singular] <b>[victim]</b>'s [grasped_part.name]!"), \
							span_userdanger("<b>[owner]</b> tries to [wrench_verb_singular] my [grasped_part.name]!"), \
							vision_distance = COMBAT_MESSAGE_RANGE, \
							ignored_mobs = owner)
			to_chat(owner, span_userdanger("I try to [wrench_verb_singular] <b>[victim]</b>'s [grasped_part.name]!"))
		else
			victim.visible_message(span_danger("<b>[owner]</b> tries to [wrench_verb_singular] [owner.p_their()] [grasped_part.name]!"), \
							span_userdanger("I try to [wrench_verb_singular] my [grasped_part.name]!"), \
							vision_distance = COMBAT_MESSAGE_RANGE)
	if(victim != owner)
		victim.sound_hint()
	owner.sound_hint()
	owner.changeNext_move(CLICK_CD_WRENCH)
	owner.adjustFatigueLoss(5)
	playsound(victim, 'modular_septic/sound/attack/twist.wav', 75, FALSE)
	return TRUE

/obj/item/grab/proc/relocate_limb()
	var/mob/living/carbon/carbon_victim = victim
	if(owner != victim)
		victim.visible_message(span_danger("<b>[owner]</b> tries to relocate <b>[victim]</b>'s [grasped_part.name]!"), \
						span_userdanger("<b>[owner]</b> tries to relocate my [grasped_part.name]!"), \
						vision_distance = COMBAT_MESSAGE_RANGE, \
						ignored_mobs = owner)
		to_chat(owner, span_userdanger("I try to relocate <b>[victim]</b>'s [grasped_part.name]!"))
	else
		victim.visible_message(span_danger("<b>[owner]</b> tries to relocate [owner.p_their()] [grasped_part.name]!"), \
						span_userdanger("I try to relocate my [grasped_part.name]!"), \
						vision_distance = COMBAT_MESSAGE_RANGE)
	var/time = 12 SECONDS //Worst case scenario
	time -= (GET_MOB_SKILL_VALUE(owner, SKILL_MEDICINE) * 0.75 SECONDS)
	if(!do_mob(owner, carbon_victim, time))
		to_chat(owner, span_userdanger("I must stand still!"))
		return
	var/epic_success = DICE_FAILURE
	if(grasped_part.status == BODYPART_ORGANIC)
		epic_success = owner.diceroll(GET_MOB_SKILL_VALUE(owner, SKILL_MEDICINE), context = DICE_CONTEXT_PHYSICAL)
	else
		epic_success = owner.diceroll(GET_MOB_SKILL_VALUE(owner, SKILL_ELECTRONICS), context = DICE_CONTEXT_PHYSICAL)
	if(epic_success >= DICE_SUCCESS)
		var/damage = GET_MOB_ATTRIBUTE_VALUE(owner, STAT_STRENGTH)/2
		grasped_part.receive_damage(brute = damage, sharpness = NONE)
		for(var/obj/item/organ/bone/bone as anything in grasped_part.getorganslotlist(ORGAN_SLOT_BONE))
			if(bone.bone_flags & BONE_JOINTED)
				bone.relocate()
		victim.agony_scream()
		if(owner != victim)
			victim.visible_message(span_danger("<b>[owner]</b> relocates <b>[victim]</b>'s [grasped_part.name]![carbon_victim.wound_message]"), \
							span_userdanger("<b>[owner]</b> relocates my [grasped_part.name]![carbon_victim.wound_message]"), \
							vision_distance = COMBAT_MESSAGE_RANGE, \
							ignored_mobs = owner)
			to_chat(owner, span_userdanger("I relocate <b>[victim]</b>'s [grasped_part.name]![carbon_victim.wound_message]"))
		else
			victim.visible_message(span_danger("<b>[owner]</b> relocates [owner.p_their()] [grasped_part.name]![carbon_victim.wound_message]"), \
							span_userdanger("I relocate my [grasped_part.name]![carbon_victim.wound_message]"), \
							vision_distance = COMBAT_MESSAGE_RANGE)
		SEND_SIGNAL(carbon_victim, COMSIG_CARBON_CLEAR_WOUND_MESSAGE)
	else
		var/damage = GET_MOB_ATTRIBUTE_VALUE(owner, STAT_STRENGTH)
		var/deal_wound_bonus = 5
		if(epic_success <= DICE_CRIT_FAILURE)
			deal_wound_bonus += 5
		grasped_part.receive_damage(brute = damage, wound_bonus = deal_wound_bonus, sharpness = NONE)
		if(owner != victim)
			victim.visible_message(span_danger("<b>[owner]</b> painfully twists <b>[victim]</b>'s [grasped_part.name]![carbon_victim.wound_message]"), \
							span_userdanger("<b>[owner]</b> painfully twists my [grasped_part.name]![carbon_victim.wound_message]"), \
							vision_distance = COMBAT_MESSAGE_RANGE, \
							ignored_mobs = owner)
			to_chat(owner, span_userdanger("I painfully twist <b>[victim]</b>'s [grasped_part.name]![carbon_victim.wound_message]"))
		else
			victim.visible_message(span_danger("<b>[owner]</b> painfully twists [owner.p_their()] [grasped_part.name]![carbon_victim.wound_message]"), \
							span_userdanger("I painfully twist my [grasped_part.name]![carbon_victim.wound_message]"), \
							vision_distance = COMBAT_MESSAGE_RANGE)
		SEND_SIGNAL(carbon_victim, COMSIG_CARBON_CLEAR_WOUND_MESSAGE)
	if(owner != victim)
		victim.sound_hint()
	owner.sound_hint()
	owner.changeNext_move(CLICK_CD_WRENCH)
	owner.adjustFatigueLoss(5)
	playsound(victim, 'modular_septic/sound/attack/twist.wav', 75, FALSE)
	return TRUE

/obj/item/grab/proc/tear_off_limb()
	//God damn fucking simple mobs
	if(!grasped_part)
		return FALSE
	for(var/obj/item/organ/bone/bone in grasped_part)
		if(!(bone.damage >= bone.medium_threshold))
			return FALSE
	var/epic_success = owner.diceroll(GET_MOB_ATTRIBUTE_VALUE(owner, STAT_STRENGTH), context = DICE_CONTEXT_PHYSICAL)
	if(epic_success >= DICE_SUCCESS)
		if(owner != victim)
			victim.visible_message(span_danger("<b>[owner]</b> tears <b>[victim]</b>'s [grasped_part.name] off!"), \
							span_userdanger("<b>[owner]</b> tears my [grasped_part.name] off!"), \
							span_hear("I hear a disgusting sound of flesh being torn apart."), \
							vision_distance = COMBAT_MESSAGE_RANGE, \
							ignored_mobs = owner)
			to_chat(owner, span_userdanger("I tear <b>[victim]</b>'s [grasped_part.name] off!"))
		else
			victim.visible_message(span_danger("<b>[owner]</b> tears [owner.p_their()] [grasped_part.name] off!"), \
							span_userdanger("I tear my [grasped_part.name] off!"), \
							span_hear("I hear a disgusting sound of flesh being torn apart."), \
							vision_distance = COMBAT_MESSAGE_RANGE)
		var/mob/living/victim_will_get_nulled = victim
		var/mob/living/carbon/owner_will_get_nulled = owner
		var/obj/item/bodypart/part_will_get_nulled = grasped_part
		grasped_part.drop_limb(FALSE, TRUE, FALSE, FALSE, WOUND_SLASH)
		//If nothing went bad, we should be qdeleted by now
		owner_will_get_nulled.adjustFatigueLoss(5)
		owner_will_get_nulled.changeNext_move(CLICK_CD_WRENCH)
		playsound(victim_will_get_nulled, 'modular_septic/sound/gore/tear.ogg', 100, FALSE)
		if(QDELETED(part_will_get_nulled))
			return TRUE
		owner_will_get_nulled.put_in_hands(part_will_get_nulled)
		return TRUE
	return wrench_limb()

/obj/item/grab/proc/tear_off_gut()
	//God damn fucking simple mobs
	if(!grasped_part)
		return FALSE
	var/datum/component/rope/gut_rope
	var/obj/item/organ/roped_organ
	for(var/datum/component/rope/possible_rope as anything in victim.GetComponents(/datum/component/rope))
		roped_organ = possible_rope.roped
		if(istype(roped_organ) && (ORGAN_SLOT_INTESTINES in roped_organ.organ_efficiency))
			gut_rope = possible_rope
			break
	//No guts?
	if(!gut_rope)
		update_grab_mode()
		return FALSE
	if(owner != victim)
		victim.visible_message(span_danger("<b>[owner]</b> tears <b>[victim]</b>'s [roped_organ.name] off!"), \
						span_userdanger("<b>[owner]</b> tears my [roped_organ.name] off!"), \
						span_hear("I hear a disgusting sound of flesh being torn apart."), \
						vision_distance = COMBAT_MESSAGE_RANGE, \
						ignored_mobs = owner)
		to_chat(owner, span_userdanger("I tear <b>[victim]</b>'s [roped_organ.name] off!"))
	else
		victim.visible_message(span_danger("<b>[owner]</b> tears [owner.p_their()] [roped_organ.name] off!"), \
						span_userdanger("I tear my [roped_organ.name] off!"), \
						span_hear("I hear a disgusting sound of flesh being torn apart."), \
						vision_distance = COMBAT_MESSAGE_RANGE)
	var/mob/living/carbon/carbon_victim = victim
	owner.adjustFatigueLoss(5)
	owner.changeNext_move(CLICK_CD_WRENCH)
	carbon_victim.gut_cut()
	update_grab_mode()
	return TRUE

/obj/item/grab/proc/bite_limb()
	//God damn fucking simple mobs
	if(!grasped_part)
		return FALSE
	var/mob/living/carbon/carbon_victim = victim
	var/epic_success = DICE_FAILURE
	var/modifier = 0
	if(victim.combat_mode && (GET_MOB_ATTRIBUTE_VALUE(victim, STAT_STRENGTH) > GET_MOB_ATTRIBUTE_VALUE(owner, STAT_STRENGTH)))
		modifier -= 2
	epic_success = owner.diceroll(GET_MOB_SKILL_VALUE(owner, SKILL_WRESTLING)+modifier, context = DICE_CONTEXT_PHYSICAL)
	if(owner == victim)
		epic_success = max(epic_success, DICE_SUCCESS)
	if(epic_success >= DICE_SUCCESS)
		var/damage = GET_MOB_ATTRIBUTE_VALUE(owner, STAT_STRENGTH)
		var/deal_wound_bonus = 5
		if(epic_success >= DICE_CRIT_SUCCESS)
			deal_wound_bonus += 5
		grasped_part.receive_damage(brute = damage, wound_bonus = deal_wound_bonus, sharpness = owner.dna.species.bite_sharpness)
		if(owner != victim)
			victim.visible_message(span_danger("<b>[owner]</b> bites <b>[victim]</b>'s [grasped_part.name]![carbon_victim.wound_message]"), \
							span_userdanger("<b>[owner]</b> bites my [grasped_part.name]![carbon_victim.wound_message]"), \
							vision_distance = COMBAT_MESSAGE_RANGE, \
							ignored_mobs = owner)
			to_chat(owner, span_userdanger("I bite <b>[victim]</b>'s [grasped_part.name]![carbon_victim.wound_message]"))
		else
			victim.visible_message(span_danger("<b>[owner]</b> bites [victim.p_their()] [grasped_part.name]![carbon_victim.wound_message]"), \
							span_userdanger("I bite my [grasped_part.name]![carbon_victim.wound_message]"), \
							vision_distance = COMBAT_MESSAGE_RANGE)
		SEND_SIGNAL(carbon_victim, COMSIG_CARBON_CLEAR_WOUND_MESSAGE)
		actions_done++
	else
		if(owner != victim)
			victim.visible_message(span_danger("<b>[owner]</b> tries to bite <b>[victim]</b>'s [grasped_part.name]!"), \
							span_userdanger("<b>[owner]</b> tries to bite my [grasped_part.name]!"), \
							vision_distance = COMBAT_MESSAGE_RANGE, \
							ignored_mobs = owner)
			to_chat(owner, span_userdanger("I try to bite <b>[victim]</b>'s [grasped_part.name]!"))
		else
			victim.visible_message(span_danger("<b>[owner]</b> tries to bite [owner.p_their()] [grasped_part.name]!"), \
							span_userdanger("I try to bite my [grasped_part.name]!"), \
							vision_distance = COMBAT_MESSAGE_RANGE)
	owner.changeNext_move(CLICK_CD_BITE)
	owner.adjustFatigueLoss(5)
	playsound(victim, owner.dna.species.bite_sound, 75, FALSE)
	return TRUE

/obj/item/grab/proc/twist_embedded(obj/item/weapon)
	//Wtf?
	if(!grasped_part || !LAZYACCESS(grasped_part.embedded_objects, 1))
		return FALSE
	var/mob/living/carbon/carbon_victim = victim
	var/epic_success = DICE_FAILURE
	var/modifier = 0
	if(victim.combat_mode && (GET_MOB_ATTRIBUTE_VALUE(victim, STAT_ENDURANCE) > GET_MOB_ATTRIBUTE_VALUE(owner, STAT_STRENGTH)))
		modifier -= 2
	epic_success = owner.diceroll(GET_MOB_SKILL_VALUE(owner, SKILL_WRESTLING)+modifier, context = DICE_CONTEXT_PHYSICAL)
	if(owner == victim)
		epic_success = max(epic_success, DICE_SUCCESS)
	if(epic_success >= DICE_SUCCESS)
		var/damage = weapon.get_twist_damage(owner, GET_MOB_ATTRIBUTE_VALUE(owner, STAT_STRENGTH))
		var/deal_wound_bonus = 5
		if(epic_success >= DICE_SUCCESS)
			deal_wound_bonus += 5
		grasped_part.receive_damage(brute = damage, wound_bonus = deal_wound_bonus, sharpness = weapon.get_sharpness())
		if(owner != victim)
			victim.visible_message(span_pinkdang("[owner] twists [grasped_part.embedded_objects[1]] in [victim]'s [grasped_part.name]![carbon_victim.wound_message]"), \
							span_pinkdang("[owner] twists [grasped_part.embedded_objects[1]] in my [grasped_part.name]![carbon_victim.wound_message]"), \
							vision_distance = COMBAT_MESSAGE_RANGE, \
							ignored_mobs = owner)
			to_chat(owner, span_pinkdang("I twist [grasped_part.embedded_objects[1]] in <b>[victim]</b>'s [grasped_part.name]![carbon_victim.wound_message]"))
		else
			victim.visible_message(span_pinkdang("[owner] twists [grasped_part.embedded_objects[1]] in [victim.p_their()] [grasped_part.name]![carbon_victim.wound_message]"), \
							span_pinkdang("I twist [grasped_part.embedded_objects[1]] in my [grasped_part.name]![carbon_victim.wound_message]"), \
							vision_distance = COMBAT_MESSAGE_RANGE)
		SEND_SIGNAL(carbon_victim, COMSIG_CARBON_CLEAR_WOUND_MESSAGE)
		actions_done++
	else
		if(owner != victim)
			victim.visible_message(span_pinkdang("[owner] tries to twist [grasped_part.embedded_objects[1]] in [victim]'s [grasped_part.name]!"), \
							span_pinkdang("[owner] tries to twist [grasped_part.embedded_objects[1]] in my [grasped_part.name]!"), \
							vision_distance = COMBAT_MESSAGE_RANGE, \
							ignored_mobs = owner)
			to_chat(owner, span_pinkdang("I try to twist [grasped_part.embedded_objects[1]] in [victim]'s [grasped_part.name]!"))
		else
			victim.visible_message(span_pinkdang("[owner] tries to twist [grasped_part.embedded_objects[1]] in [owner.p_their()] [grasped_part.name]!"), \
							span_pinkdang("I try to twist [grasped_part.embedded_objects[1]] in my [grasped_part.name]!"), \
							vision_distance = COMBAT_MESSAGE_RANGE)
	owner.changeNext_move(weapon.attack_delay)
	owner.adjustFatigueLoss(weapon.attack_fatigue_cost)
	weapon.damageItem("SOFT")
	playsound(victim, 'modular_septic/sound/gore/twisting.ogg', 80, FALSE)
	sound_hint()
	return TRUE

/obj/item/grab/proc/pull_embedded()
	//Wtf?
	if(!grasped_part || !LAZYACCESS(grasped_part.embedded_objects, 1))
		return FALSE
	SEND_SIGNAL(victim, COMSIG_CARBON_EMBED_RIP, grasped_part.embedded_objects[1], grasped_part, owner)
//	var/mob/living/carbon/carbon_victim = victim
//	playsound(carbon_victim, 'modular_septic/sound/gore/pullout.ogg', 80, 0)
	return TRUE
