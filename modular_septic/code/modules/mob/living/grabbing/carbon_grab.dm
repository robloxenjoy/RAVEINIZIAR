/mob/living/carbon/attempt_self_grab(biting_grab = FALSE, forced = FALSE, grabsound = TRUE, silent = FALSE)
	if(!biting_grab)
		var/obj/item/bodypart/hand = get_active_hand()
		if(hand && (zone_selected in list(hand.body_zone, hand.parent_body_zone)))
			to_chat(src, span_warning("I can't grab [parse_zone(zone_selected)] with [hand.name]!"))
			return
	else
		var/obj/item/bodypart/jaw = get_bodypart(BODY_ZONE_PRECISE_MOUTH)
		if(jaw && !(zone_selected in LIMB_BODYPARTS))
			to_chat(src, span_warning("I can't bite [parse_zone(zone_selected)] with [jaw.name]!"))
			return
	return grippedby(src, TRUE, biting_grab, forced, TRUE, FALSE)

/mob/living/carbon/grippedby(mob/living/carbon/user, instant = FALSE, biting_grab = FALSE, forced = FALSE, grabsound = TRUE, silent = FALSE, forced_zone)
	// We need to be pulled
	if(src != user)
		if(!user.pulling || (user.pulling != src))
			return
	var/obj/item/grab/active_grab
	if(biting_grab)
		active_grab = user.get_item_by_slot(ITEM_SLOT_MASK)
		if(istype(active_grab))
			to_chat(user, span_warning("I'm already biting someone!"))
			return
		else if(user.is_mouth_covered())
			to_chat(user, span_warning("My mouth is covered!"))
			return
	else
		active_grab = user.get_active_held_item()
		if(istype(active_grab))
			to_chat(user, span_warning("I've already grabbed someone!"))
			return
		else if(active_grab)
			to_chat(user, span_warning("My hand is busy with [active_grab]!"))
			return
	var/obj/item/bodypart/affected = get_bodypart_nostump(check_zone(forced_zone ? forced_zone : user.zone_selected))
	if(!affected)
		to_chat(user, span_warning("He doesn't have [parse_zone(user.zone_selected)]!"))
		return
	if(HAS_TRAIT(user, TRAIT_PACIFISM))
		to_chat(user, span_warning("No!"))
		return
	var/hit_modifier = affected.grabbing_hit_modifier
	//very hard to miss when hidden by fov
	if(!(src in fov_viewers(2, user)))
		hit_modifier += 6
	//easy to kick people when they are down
	if((body_position == LYING_DOWN) && (user.body_position != LYING_DOWN))
		hit_modifier += 6
	if(user.combat_mode)
		hit_modifier += 2
//		hit_zone_modifier += 2
	//bro we dead :skull:
	if(stat >= UNCONSCIOUS)
		hit_modifier += 5
	//epic grab fail
	var/click_cooldown = (biting_grab ? CLICK_CD_BITING : CLICK_CD_GRABBING)
	var/grab_wording = (biting_grab ? "bite" : "grab")
	var/skill_modifier = GET_MOB_SKILL_VALUE(user, SKILL_WRESTLING)
	var/modifier = affected.grabbing_hit_modifier
	if(biting_grab)
		modifier -= 2
	if(forced)
		modifier += 999
	if((user != src) && (user.diceroll(skill_modifier+modifier, context = DICE_CONTEXT_PHYSICAL) == DICE_CRIT_FAILURE))
		user.visible_message(span_warning("<b>[user]</b> tries to [grab_wording] <b>[src]</b>!"), \
				span_userdanger("I could not [grab_wording] <b>[src]</b>!"), \
				blind_message = span_hear("I hear combat!"), \
				ignored_mobs = src)
		to_chat(src, span_userdanger("<b>[user]</b> tries to [grab_wording] me!"))
		user.changeNext_move(click_cooldown)
		return FALSE
	active_grab = new()
	if(biting_grab)
		user.equip_to_slot_or_del(active_grab, ITEM_SLOT_MASK)
	else
		if(!user.put_in_active_hand(active_grab, FALSE))
			qdel(active_grab)
	if(QDELETED(active_grab))
		return
	user.changeNext_move(click_cooldown)
	active_grab.registergrab(src, user, affected, instant, biting_grab, forced)
	for(var/obj/item/grab/grabber in (user.held_items | user.get_item_by_slot(ITEM_SLOT_MASK)))
		grabber.update_grab_mode()
	active_grab.display_grab_message(biting_grab, grabsound, silent)

/mob/living/carbon/resist_grab(moving_resist)
	. = TRUE
	if((pulledby.grab_state >= GRAB_AGGRESSIVE) || (body_position == LYING_DOWN) || HAS_TRAIT(src, TRAIT_GRABWEAKNESS))
		var/mob/living/pulling_mob = pulledby
		var/grabber_strength = 0
		if(istype(pulling_mob))
			grabber_strength = GET_MOB_ATTRIBUTE_VALUE(pulling_mob, STAT_STRENGTH)
		var/resist_diceroll = diceroll(CEILING(GET_MOB_ATTRIBUTE_VALUE(src, STAT_STRENGTH)*2, 1)-grabber_strength, context = DICE_CONTEXT_MENTAL)
		var/grip_wording = (HAS_TRAIT_FROM(src, TRAIT_BITTEN, WEAKREF(pulledby)) ? "bite" : "grab")
		if(resist_diceroll >= DICE_SUCCESS)
			adjustFatigueLoss(5)
			visible_message(span_danger("<b>[src]</b> escapes from <b>[pulledby]</b> [grip_wording]!"), \
							span_userdanger("I escape from <b>[pulledby]</b> [grip_wording]!"), \
							ignored_mobs = pulledby)
			to_chat(pulledby, span_danger("<b>[src]</b> escapes from my [grip_wording]!"))
			log_combat(pulledby, src, "broke grab")
			pulledby.stop_pulling()
			return FALSE
		else
			adjustFatigueLoss(5)//failure to escape still imparts a pretty serious penalty
			visible_message(span_danger("<b>[src]</b> tries to escape from [pulledby] [grip_wording]!"), \
							span_userdanger("I'm trying to escape from [pulledby] [grip_wording]!"), \
							ignored_mobs = pulledby)
			to_chat(pulledby, span_userdanger("<b>[src]</b> tries to escape from my [grip_wording]!"))
		if(moving_resist && client) //we resisted by trying to move
			client.move_delay = world.time + CLICK_CD_RESIST * 2
		return TRUE
	pulledby.stop_pulling()
	return FALSE
