/mob/living/carbon/send_item_attack_message(obj/item/I, mob/living/user, hit_area, obj/item/bodypart/hit_bodypart)
	if(!I.force && !length(I.attack_verb_simple) && !length(I.attack_verb_continuous))
		return
	var/intended_zone = check_zone(user.zone_selected)
	if(intended_zone == hit_bodypart.body_zone)
		var/message_verb_continuous = length(I.attack_verb_continuous) ? "[pick(I.attack_verb_continuous)]" : "атакует"
		var/message_verb_simple = length(I.attack_verb_simple) ? "[pick(I.attack_verb_simple)]" : "атаковать"

		var/extra_wound_details = ""
		var/message_hit_area = ""
		if(hit_area)
			message_hit_area = " в [hit_area]"
		var/attack_message_spectator = "<b>[user]</b> [message_verb_continuous] <b>[src]</b>[message_hit_area] с помощью [I][extra_wound_details]![wound_message]"
		var/attack_message_victim = "Кто-то [message_verb_continuous][message_hit_area][extra_wound_details]![wound_message]"
		var/attack_message_attacker = "Я [message_verb_simple] кого-то с помощью [I]!"
		if(user in fov_viewers(2, src))
			attack_message_attacker = "Я [message_verb_simple] <b>[src]</b>[message_hit_area] с помощью [I]![wound_message]"
		if(src in fov_viewers(2, user))
			attack_message_victim = "<b>[user]</b> [message_verb_continuous] меня[message_hit_area] с помощью [I][extra_wound_details]![wound_message]"
		if(user == src)
			attack_message_victim = "Я [message_verb_simple] самого себя[message_hit_area] с помощью [I][extra_wound_details]![wound_message]"
		visible_message(span_danger("[attack_message_spectator]"),\
			span_userdanger("[attack_message_victim]"),
			span_hear("Я слышу свист и стук!"), \
			vision_distance = COMBAT_MESSAGE_RANGE, \
			ignored_mobs = user)
		if(user != src)
			to_chat(user, span_userdanger("[attack_message_attacker]"))
	else
		var/parsed_intended_zone = parse_zone(intended_zone)
		var/message_verb_continuous = length(I.attack_verb_continuous) ? "[pick(I.attack_verb_continuous)]" : "атакует"
		var/message_verb_simple = length(I.attack_verb_simple) ? "[pick(I.attack_verb_simple)]" : "атаковать"
		var/message_verb_simple_two = length(I.attack_verb_simple) ? "[pick(I.attack_verb_simple)]" : "атакую"
		var/message_verb_simple_three = length(I.attack_verb_simple) ? "[pick(I.attack_verb_simple)]" : "атакует"

		var/extra_wound_details = ""
		var/message_hit_area = ""
		if(hit_area)
			message_hit_area = " в [hit_area]"
		var/attack_message_spectator = "<b>[user]</b> пытается [message_verb_simple] <b>[src]</b> в [parsed_intended_zone] с помощью [I], но вместо этого, [message_verb_simple_three][message_hit_area][extra_wound_details]![wound_message]"
		var/attack_message_victim = "Кто-то[message_verb_continuous][message_hit_area][extra_wound_details]![wound_message]"
		var/attack_message_attacker = "Я [message_verb_simple] кого-то с помощью [I]!"
		if(user in fov_viewers(2, src))
			attack_message_attacker = "Я пытаюсь [message_verb_simple] <b>[src]</b> в [parsed_intended_zone] с помощью [I], но вместо этого, [message_verb_simple_two][message_hit_area][extra_wound_details]![wound_message]"
		if(src in fov_viewers(2, user))
			attack_message_victim = "<b>[user]</b> пытается [message_verb_simple] меня в [parsed_intended_zone] с помощью [I], но вместо этого, [message_verb_simple][message_hit_area][extra_wound_details]![wound_message]"
		if(user == src)
			attack_message_victim = "Я пытаюсь [message_verb_simple] самого себя в [parsed_intended_zone] с помощью [I], но вместо этого, [message_verb_simple][message_hit_area][extra_wound_details]![wound_message]"
		visible_message(span_danger("[attack_message_spectator]"),\
			span_userdanger("[attack_message_victim]"),
			span_hear("Я слышу свист и стук!"), \
			vision_distance = COMBAT_MESSAGE_RANGE, \
			ignored_mobs = user)
		if(user != src)
			to_chat(user, span_userdanger("[attack_message_attacker]"))
	SEND_SIGNAL(src, COMSIG_CARBON_CLEAR_WOUND_MESSAGE)
	return TRUE

//ATTACK HAND IGNORING PARENT RETURN VALUE
/mob/living/carbon/attack_hand(mob/living/carbon/human/user, list/modifiers)
	if(SEND_SIGNAL(src, COMSIG_ATOM_ATTACK_HAND, user) & COMPONENT_CANCEL_ATTACK_CHAIN)
		. = TRUE
	for(var/thing in diseases)
		var/datum/disease/D = thing
		if(D.spread_flags & DISEASE_SPREAD_CONTACT_SKIN)
			user.ContactContractDisease(D)
	for(var/thing in user.diseases)
		var/datum/disease/D = thing
		if(D.spread_flags & DISEASE_SPREAD_CONTACT_SKIN)
			ContactContractDisease(D)
	for(var/datum/wound/wound as anything in all_wounds)
		if(wound.try_handling(user))
			return TRUE

	return FALSE

/mob/living/carbon/attack_foot(mob/living/carbon/human/user, list/modifiers)
	if(SEND_SIGNAL(src, COMSIG_ATOM_ATTACK_FOOT, user) & COMPONENT_CANCEL_ATTACK_CHAIN)
		. = TRUE
	for(var/thing in diseases)
		var/datum/disease/D = thing
		if(D.spread_flags & DISEASE_SPREAD_CONTACT_SKIN)
			user.ContactContractDisease(D)
	for(var/thing in user.diseases)
		var/datum/disease/D = thing
		if(D.spread_flags & DISEASE_SPREAD_CONTACT_SKIN)
			ContactContractDisease(D)

	return FALSE

/mob/living/carbon/attack_jaw(mob/living/carbon/human/user, list/modifiers)
	if(SEND_SIGNAL(src, COMSIG_ATOM_ATTACK_FOOT, user) & COMPONENT_CANCEL_ATTACK_CHAIN)
		. = TRUE
	for(var/thing in diseases)
		var/datum/disease/D = thing
		if(D.spread_flags & DISEASE_SPREAD_CONTACT_SKIN)
			user.ContactContractDisease(D)
	for(var/thing in user.diseases)
		var/datum/disease/D = thing
		if(D.spread_flags & DISEASE_SPREAD_CONTACT_SKIN)
			ContactContractDisease(D)

	return FALSE

/mob/living/carbon/disarm(mob/living/carbon/target, list/modifiers)
	if(HAS_TRAIT(src, TRAIT_PACIFISM))
		to_chat(src, span_warning("Not possible."))
		return
	var/aiming_for_hand = (zone_selected in list(BODY_ZONE_PRECISE_L_HAND, BODY_ZONE_PRECISE_R_HAND))
	var/obj/item/held_item = target.get_active_held_item()
	if(!aiming_for_hand || !held_item)
		return shove(target, modifiers)
	var/atk_delay = CLICK_CD_MELEE
	var/atk_cost = 6
	var/skill_modifier = GET_MOB_ATTRIBUTE_VALUE(src, STAT_DEXTERITY)
	var/modifier = 0
	//Target cannot view us = unaware
	//Target has no combat mode = unaware
	if(!(target in fov_viewers(2, src)) || !target.combat_mode)
		modifier += 5
	//Target took stimulants, harder to disarm
	var/stimulants = target.get_chem_effect(CE_STIMULANT)
	if(stimulants)
		modifier -= stimulants
	var/weapon_go_fwoosh = FALSE
	var/fwoosh_prob = 25
	var/obj/item/bodypart/disarming_part = get_active_hand()
	if(disarming_part)
		fwoosh_prob *= (LIMB_EFFICIENCY_OPTIMAL/disarming_part.limb_efficiency)
	if(prob(fwoosh_prob))
		weapon_go_fwoosh = TRUE
	var/direction = get_dir(src, target)
//	do_attack_animation(target, ATTACK_EFFECT_DISARM, no_effect = TRUE)
	sound_hint()
	playsound(target, 'sound/weapons/thudswoosh.ogg', 50, TRUE, -1)
	if(target.gloves)
		target.gloves.add_fingerprint(src)
	target.add_fingerprint(src)
	if(LAZYACCESS(modifiers, RIGHT_CLICK))
		switch(combat_style)
			if(CS_AIMED)
				skill_modifier += 4
				fwoosh_prob *= 0.5
				atk_delay *= 1.5
				if(ishuman(src))
					var/mob/living/carbon/human/human_source = src
					human_source.update_parrying_penalty(PARRYING_PENALTY, PARRYING_PENALTY_COOLDOWN_DURATION)
					human_source.update_blocking_cooldown(BLOCKING_COOLDOWN_DURATION)
					human_source.update_dodging_cooldown(DODGING_COOLDOWN_DURATION)
	else
		switch(combat_style)
			if(CS_DEFEND)
				skill_modifier -= 4
	var/diceroll = diceroll(skill_modifier+modifier, context = DICE_CONTEXT_PHYSICAL)
	if(HAS_TRAIT(held_item, TRAIT_NODROP))
		diceroll = DICE_FAILURE
	changeNext_move(atk_delay)
	adjustFatigueLoss(atk_cost)
	//disarm succesful
	if(diceroll >= DICE_SUCCESS)
		if(weapon_go_fwoosh)
			visible_message(span_danger("<b>[src]</b> tries to grab [held_item] from <b>[target]</b>, and it flies out of [target.p_their()] hands!"), \
						span_userdanger("I try to grab <b>[target]</b>'s [held_item], but it flies out of my reach!"), \
						span_danger("I hear some loud shuffling, and something dropping forcefully on the ground!"), \
						vision_distance = COMBAT_MESSAGE_RANGE, \
						ignored_mobs = target)
			to_chat(target, span_userdanger("<b>[src]</b> grabs my [held_item], and it flies out of my hands!"))
			if(target.dropItemToGround(held_item))
				var/turf/target_turf = get_edge_target_turf(held_item, direction)
				held_item.throw_at(target_turf, held_item.throw_range, held_item.throw_speed, src, FALSE)
		else
			visible_message(span_danger("<b>[src]</b> disarms \the [held_item] away from <b>[target]</b>!"), \
						span_userdanger("I disarm \the [held_item] away from <b>[target]</b>!"), \
						span_danger("I hear some loud shuffling!"), \
						vision_distance = COMBAT_MESSAGE_RANGE, \
						ignored_mobs = target)
			to_chat(target, span_userdanger("<b>[src]</b> diarms \the [held_item] away from me!"))
			if(target.dropItemToGround(held_item))
				put_in_active_hand(held_item)
		return
	//epic disarm fail
	else
		visible_message(span_danger("<b>[src]</b> tries to disarm \the [held_item] from <b>[target]</b>, but fumbles and misses!"),
					span_userdanger("I try to disarm \the [held_item] from <b>[target]</b>'s, but fumble and miss!"),
					span_danger("I hear some loud shuffling!"),
					vision_distance = COMBAT_MESSAGE_RANGE,
					ignored_mobs = target)
		to_chat(target, span_userdanger("<b>[src]</b> tries to disarm \the [held_item] from me, but fumbles and misses!"))
		return

/mob/living/carbon/attackby_tertiary(obj/item/weapon, mob/living/user, params)
	var/list/modifiers = params2list(params)
	if(IS_HELP_INTENT(user, modifiers) || IS_DISARM_INTENT(user, modifiers))
		for(var/datum/surgery_step/step as anything in GLOB.middleclick_surgery_steps)
			if(!step.middle_click_step)
				continue
			if(step.try_op(user, src, user.zone_selected, user.get_active_held_item()))
				return TERTIARY_ATTACK_CANCEL_ATTACK_CHAIN
	return ..()

/mob/living/carbon/on_hit(obj/projectile/P)
	. = ..()
	SEND_SIGNAL(src, COMSIG_CARBON_CLEAR_WOUND_MESSAGE)

/mob/living/carbon/get_organic_health()
	. = getMaxHealth()
	for(var/obj/item/bodypart/bodypart in bodyparts)
		if(bodypart.status == BODYPART_ORGANIC)
			. -= bodypart.get_damage(FALSE, FALSE)
	. -= getCloneLoss()
	. -= getOxyLoss()
	. -= getToxLoss()

/mob/living/carbon/help_shake_act(mob/living/carbon/M)
	if(on_fire)
		to_chat(M, span_warning("I can't put [p_them()] out with just my bare hands!"))
		return

	if(M == src && check_self_for_injuries())
		return

	//Shake them up
	if(body_position == LYING_DOWN)
		if(buckled)
			to_chat(M, span_warning("I need to unbuckle <b>[src]</b> first to do that!"))
			return
		M.visible_message(span_notice("<b>[M]</b> shakes <b>[src]</b> trying to get [p_them()] up!"), \
						span_notice("I shake <b>[src]</b> trying to get [p_them()] up!"), \
						span_hear("I hear the rustling of clothes."), \
						DEFAULT_MESSAGE_RANGE, \
						src)
		to_chat(src, span_notice("<b>[M]</b> shakes me to get me up!"))
		AdjustStun(-60)
		AdjustKnockdown(-60)
		AdjustUnconscious(-60)
		AdjustSleeping(-100)
		AdjustParalyzed(-60)
		AdjustImmobilized(-60)
		set_resting(FALSE)
		if(body_position != STANDING_UP && !resting && !buckled && !HAS_TRAIT(src, TRAIT_FLOORED))
			get_up(TRUE)
		playsound(loc, 'sound/weapons/thudswoosh.ogg', 50, TRUE, -1)
	//Headpat them
	else if(check_zone(M.zone_selected) == BODY_ZONE_HEAD)
		headpat_act(M)
	//Hug them
	else
		hug_act(M)

	// Shake animation
	if(incapacitated())
		var/direction = prob(50) ? -1 : 1
		animate(src, pixel_x = pixel_x + 4 * direction, time = 1, easing = QUAD_EASING | EASE_OUT, flags = ANIMATION_PARALLEL)
		animate(pixel_x = pixel_x - (4 * 2 * direction), time = 1)
		animate(pixel_x = pixel_x + 4 * direction, time = 1, easing = QUAD_EASING | EASE_IN)

/mob/living/carbon/proc/headpat_act(mob/living/carbon/patter)
	if(!get_bodypart_nostump(BODY_ZONE_HEAD))
		return
	SEND_SIGNAL(src, COMSIG_CARBON_HEADPAT, patter)
	patter.visible_message(span_notice("<b>[patter]</b> gives <b>[src]</b> a pat on the head to make [p_them()] feel better!"), \
				span_notice("I give <b>[src]</b> a pat on the head to make [p_them()] feel better!"),
				span_hear("I hear a soft patter."), \
				DEFAULT_MESSAGE_RANGE, \
				src)
	to_chat(src, span_notice("<b>[patter]</b> gives me a pat on the head to make me feel better! "))
	if(HAS_TRAIT(src, TRAIT_BADTOUCH))
		to_chat(patter, span_warning("<b>[src]</b> looks visibly upset as i pat [p_them()] on the head."))
	AdjustStun(-60)
	AdjustKnockdown(-60)
	AdjustUnconscious(-60)
	AdjustSleeping(-100)
	AdjustParalyzed(-60)
	AdjustImmobilized(-60)
	playsound(loc, 'sound/weapons/thudswoosh.ogg', 50, TRUE, -1)

/mob/living/carbon/proc/hug_act(mob/living/carbon/hugger)
	SEND_SIGNAL(src, COMSIG_CARBON_HUGGED, hugger)
	SEND_SIGNAL(hugger, COMSIG_CARBON_HUG, src)
	hugger.visible_message(span_notice("<b>[hugger]</b> hugs <b>[src]</b> to make [p_them()] feel better!"), \
				span_notice("I hug <b>[src]</b> to make [p_them()] feel better!"), \
				span_hear("I hear the rustling of clothes."), \
				DEFAULT_MESSAGE_RANGE, \
				src)
	to_chat(src, span_notice("<b>[hugger]</b> hugs me to make me feel better!"))

	// Warm them up with hugs
	share_bodytemperature(hugger)

	// No moodlets for people who hate touches
	if(!HAS_TRAIT(src, TRAIT_BADTOUCH))
		if(bodytemperature > hugger.bodytemperature)
			if(!HAS_TRAIT(hugger, TRAIT_BADTOUCH))
				SEND_SIGNAL(hugger, COMSIG_ADD_MOOD_EVENT, "hug", /datum/mood_event/warmhug, src) // Hugger got a warm hug (Unless they hate hugs)
			SEND_SIGNAL(src, COMSIG_ADD_MOOD_EVENT, "hug", /datum/mood_event/hug) // Reciver always gets a mood for being hugged
		else
			SEND_SIGNAL(src, COMSIG_ADD_MOOD_EVENT, "hug", /datum/mood_event/warmhug, hugger) // You got a warm hug

	// Let people know if they hugged someone really warm or really cold
	if(hugger.bodytemperature > BODYTEMP_HEAT_DAMAGE_LIMIT)
		to_chat(src, span_warning("It feels like [hugger] is over heating as [hugger.p_they()] hug[hugger.p_s()] me."))
	else if(hugger.bodytemperature < BODYTEMP_COLD_DAMAGE_LIMIT)
		to_chat(src, span_warning("It feels like [hugger] is freezing as [hugger.p_they()] hug[hugger.p_s()] me."))

	if(bodytemperature > BODYTEMP_HEAT_DAMAGE_LIMIT)
		to_chat(hugger, span_warning("It feels like <b>[src]</b> is over heating as i hug [p_them()]."))
	else if(bodytemperature < BODYTEMP_COLD_DAMAGE_LIMIT)
		to_chat(hugger, span_warning("It feels like <b>[src]</b> is freezing as i [p_them()]."))

	if(HAS_TRAIT(hugger, TRAIT_FRIENDLY))
		var/datum/component/mood/hugger_mood = hugger.GetComponent(/datum/component/mood)
		if(hugger_mood.sanity >= SANITY_GREAT)
			new /obj/effect/temp_visual/heart(loc)
			SEND_SIGNAL(src, COMSIG_ADD_MOOD_EVENT, "friendly_hug", /datum/mood_event/besthug, hugger)
		else if(hugger_mood.sanity >= SANITY_NEUTRAL)
			SEND_SIGNAL(src, COMSIG_ADD_MOOD_EVENT, "friendly_hug", /datum/mood_event/betterhug, hugger)

	if(HAS_TRAIT(src, TRAIT_BADTOUCH))
		to_chat(hugger, span_warning("<b>[src]</b> looks visibly upset as i hug [p_them()]."))
	AdjustStun(-60)
	AdjustKnockdown(-60)
	AdjustUnconscious(-60)
	AdjustSleeping(-100)
	AdjustParalyzed(-60)
	AdjustImmobilized(-60)
	playsound(loc, 'sound/weapons/thudswoosh.ogg', 50, TRUE, -1)

/mob/living/carbon/proc/shove(mob/living/carbon/target, list/modifiers)
	adjustFatigueLoss(10)
	changeNext_move(CLICK_CD_MELEE)
//	do_attack_animation(target, ATTACK_EFFECT_DISARM, no_effect = TRUE)
	sound_hint()
	playsound(target, 'sound/weapons/thudswoosh.ogg', 50, TRUE, -1)
	target.add_fingerprint(src)
	if(ishuman(target))
		var/mob/living/carbon/human/human_target = target
		if(human_target.wear_suit)
			human_target.wear_suit.add_fingerprint(src)
		else if(human_target.w_uniform)
			human_target.w_uniform.add_fingerprint(src)

	SEND_SIGNAL(target, COMSIG_HUMAN_DISARM_HIT, src, zone_selected)
	target.sound_hint()

	var/shove_power = (GET_MOB_ATTRIBUTE_VALUE(src, STAT_STRENGTH)-GET_MOB_ATTRIBUTE_VALUE(target, STAT_ENDURANCE))
	var/obj/item/bodypart/shover = get_active_hand()
	if(shover)
		shove_power *= (shover.limb_efficiency/LIMB_EFFICIENCY_OPTIMAL)

	if((shove_power <= 0) || (target.combat_mode && (target in fov_viewers(2, src)) && (shove_power < 3)))
		visible_message(span_danger("<b>[src]</b> tries to shove <b>[target]</b>, but [target.p_they()] regains balance!"),
					span_userdanger("I try to shove <b>[target]</b>, but [target.p_they()] regains balance!"),
					span_hear("I hear some shuffling."),
					vision_distance = COMBAT_MESSAGE_RANGE,
					ignored_mobs = target)
		to_chat(target, span_userdanger("<b>[src]</b> tries to shove me, but i regain my balance!"))
		return

	var/shovedir = get_dir(src, target)
	var/turf/shove_target = get_edge_target_turf(target, shovedir)
	var/shove_distance = max(FLOOR(shove_power/2, 1), 1)
	visible_message(span_danger("<b>[src]</b> shoves <b>[target]</b>!"), \
				span_userdanger("I shove <b>[target]</b>!"), \
				span_hear("I hear some shuffling!"), \
				vision_distance = COMBAT_MESSAGE_RANGE, \
				ignored_mobs = target)
	to_chat(target, span_userdanger("<b>[src]</b> shoves me!"))
	target.adjustFatigueLoss(3)
	target.safe_throw_at(shove_target, shove_distance, 3, src, callback = CALLBACK(target, /mob/living/carbon/proc/handle_knockback, get_turf(target)))

/mob/living/carbon/proc/pump_heart(mob/user, forced_pump)
	if(!forced_pump)
		var/heymedic = GET_MOB_SKILL_VALUE(user, SKILL_MEDICINE)/SKILL_MASTER
		recent_heart_pump = list("[world.time]" = (0.3 + CEILING(heymedic, 0.1)))
	else
		recent_heart_pump = list("[world.time]" = (0.3 + CEILING(forced_pump, 0.1)))
	return TRUE

/mob/living/carbon/proc/check_pulse(mob/living/carbon/user)
	. = TRUE
	var/self = FALSE
	if(user == src)
		self = TRUE

	var/obj/item/bodypart/pulsating_cock = get_bodypart(check_zone(user.zone_selected))
	if(!pulsating_cock)
		to_chat(user, span_warning("I cannot measure [self ? "my" : p_their()] pulse without \a [parse_zone(user.zone_selected)]."))
		return
	if(!user.canUseTopic(src, TRUE) || DOING_INTERACTION_WITH_TARGET(user, src))
		to_chat(user, span_warning("I'm unable to check [self ? "my" : "<b>[src]</b>'s"] pulse.</"))
		return

	add_fingerprint(user)
	if(!self)
		user.visible_message(span_notice("<b>[user]</b> puts \his hand on <b>[src]</b>'s wrist and begins counting their pulse."),\
		span_notice("I begin counting <b>[src]</b>'s pulse..."))
	else
		user.visible_message(span_notice("<b>[user]</b> begins counting their own pulse."),\
		span_notice("I begin counting my pulse..."))

	for(var/thing in diseases)
		var/datum/disease/disease = thing
		if(disease.spread_flags & DISEASE_SPREAD_CONTACT_SKIN)
			user.ContactContractDisease(disease)
	for(var/thing in user.diseases)
		var/datum/disease/disease = thing
		if(disease.spread_flags & DISEASE_SPREAD_CONTACT_SKIN)
			ContactContractDisease(disease)

	if(!do_mob(user, src, 0.5 SECONDS))
		to_chat(user, span_warning("I failed to check [self ? "my" : "<b>[src]</b>'s"] pulse."))
		return

	if(pulse)
		to_chat(user, span_notice("[self ? "I have a" : "<b>[src]</b> has a"] pulse! Counting..."))
	else
		to_chat(user, span_danger("[self ? "I have no" : "<b>[src]</b> has no"] pulse!"))
		return

	if(do_mob(user, src, 2.5 SECONDS))
		to_chat(user, span_notice("[self ? "My" : "<b>[src]</b>'s"] pulse is approximately <b>[src.get_pulse(GETPULSE_BASIC)] BPM</b>."))
	else
		to_chat(user, span_warning("I failed to check [self ? "my" : "<b>[src]</b>'s"] pulse."))

/mob/living/carbon/proc/handle_knockback(turf/starting_turf)
	var/distance = 0
	if(istype(starting_turf) && !QDELETED(starting_turf))
		distance = get_dist(starting_turf, src)
	var/skill_modifier = max(GET_MOB_ATTRIBUTE_VALUE(src, STAT_DEXTERITY), GET_MOB_SKILL_VALUE(src, SKILL_ACROBATICS))
	var/modifier = -distance
	if(diceroll(skill_modifier+modifier, context = DICE_CONTEXT_PHYSICAL) <= DICE_FAILURE)
		CombatKnockdown(15, 15)

/mob/living/carbon/proc/gut_cut()
	update_gore_overlays()
	if(get_chem_effect(CE_PAINKILLER) < 100)
		agony_scream()
		CombatKnockdown(30)
		var/obj/item/bodypart/vitals = get_bodypart(BODY_ZONE_PRECISE_VITALS)
		vitals?.add_pain(25)
