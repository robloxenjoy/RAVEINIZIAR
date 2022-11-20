/mob/living/carbon/steal_this(mob/living/carbon/target, proximity_flag, list/modifiers, hit_zone)
	//We can't jump if it's the same damn tile
	//TODO: Multi-z jumping when certain requirements are met
/*
	if(get_dist(src, target) < 1)
		return FALSE
*/
	//Not while thrown/jumping



//	if(throwing)
//		return FALSE
	//Not while knocked down

	if(!target)
		return FALSE
/*
	if(body_position != STANDING_UP)
		to_chat(span_warning("I need to stand up."))
		return FALSE
*/
	//Not while buckled
/*
	if(buckled)
		to_chat(span_warning("I need to unbuckle."))
		return FALSE
*/
/*
	var/range = FLOOR(GET_MOB_ATTRIBUTE_VALUE(src, STAT_STRENGTH)/(ATTRIBUTE_MIDDLING/2), 1)
	if(range < 1)
		to_chat(src, span_warning("I'm too weak to do this..."))
		return FALSE
	if(ismob(jump_target))
		visible_message(span_warning("<b>[src]</b> jumps at <b>[jump_target]</b>!"), \
					span_userdanger("I jump at <b>[jump_target]</b>!"), \
					ignored_mobs = jump_target)
		to_chat(jump_target, span_userdanger("<b>[src]</b> jumps at me!"))
	else
		visible_message(span_warning("<b>[src]</b> jumps at [jump_target]!"), \
					span_userdanger("I jump at [jump_target]!"))
*/
//	jump_grunt()
//	sound_hint()
//	safe_throw_at(jump_target, range, throw_speed, src, FALSE, callback = CALLBACK(src, .proc/jump_callback))

	if(src.get_active_hand() != null)
		return

	if(target.combat_mode)
		to_chat(src, "<span class='danger'>Intimidates...</span>")
		return

//	var/mob/living/carbon/human/L = user
	var/mob/living/carbon/human/C = target
//	var/hit_zone = L.zone_selected

	if(C == src)
		to_chat(src, span_warning("I can't steal anything from myself."))
		return

//	var/obj/item/bodypart/BP = C.get_bodypart(check_zone(user.zone_selected))
//	var/obj/item/bodypart/affecting = C.get_bodypart(hit_zone)
	var/obj/item/bodypart/affecting = C.get_bodypart(check_zone(src.zone_selected))
	if(!affecting || affecting == ORGAN_DESTROYED)
		to_chat(src, "<span class='necrosis'>They are missing that limb!</span>")
		return
/*
	if(user.vice == "Kleptomaniac")
		user.clear_event("vice")
		user.viceneed = 0

		SKILL_PICKPOCKET
*/
//	var/list/rolled = roll3d6(user,SKILL_STEAL,null)
	var/diceroll = diceroll(GET_MOB_SKILL_VALUE(src, SKILL_PICKPOCKET), context = DICE_CONTEXT_PHYSICAL)
	var/obj/whatwillitsteal = null
	var/slot_it_will_go = null
	if(diceroll == DICE_CRIT_FAILURE)
		src.visible_message(span_steal("[src] caught stealing!"),span_steal("You got caught stealing! Very bad!"), span_hear("You hear the sound of tripping."))
		src.Immobilize(2 SECONDS)
		src.changeNext_move(CLICK_CD_MELEE)
		sound_hint()
		return

	if(diceroll == DICE_FAILURE)
		src.visible_message(span_steal("[src] caught stealing."),span_steal("You got caught stealing, bad."), span_hear("You hear the sound of turmoil."))
		src.changeNext_move(CLICK_CD_MELEE)
		sound_hint()
		return

//	var/hit_zone = L.zone_selected
	if(diceroll >= DICE_SUCCESS)
		switch(hit_zone)
			if(BODY_ZONE_CHEST)
				if(C.r_store)
					whatwillitsteal = C.r_store
					slot_it_will_go = C.r_store
				else
					if(C.l_store)
						whatwillitsteal = C.l_store
						slot_it_will_go = C.l_store
					else
						to_chat(src, span_steal("There is nothing left in the pockets!"))
						return
			if(BODY_ZONE_PRECISE_VITALS)
				if(C.wear_id)
					whatwillitsteal = C.wear_id
					slot_it_will_go = C.wear_id
				else
					if(C.s_store)
						whatwillitsteal = C.s_store
						slot_it_will_go = C.s_store
					else
						to_chat(src, span_steal("There is nothing left in here!"))
						return
			if(BODY_ZONE_PRECISE_GROIN)
				if(C.belt)
					whatwillitsteal = C.belt
					slot_it_will_go = C.belt
				else
					to_chat(src, span_steal("There is nothing left in the belt!"))
					return
			if(BODY_ZONE_PRECISE_R_HAND || BODY_ZONE_PRECISE_L_HAND)
				if(C.wrist_l)
					whatwillitsteal = C.wrist_l
					slot_it_will_go = C.wrist_l
				else
					if(C.wrist_r)
						whatwillitsteal = C.wrist_r
						slot_it_will_go = C.wrist_r
					else
						to_chat(src, span_steal("There is nothing on wrists!"))
						return

		if(whatwillitsteal)
			var/obj/item/stolen/S = new(src)
			S.icon = whatwillitsteal.icon
			S.icon_state = whatwillitsteal.icon_state
			S.name = whatwillitsteal.name
			S.desc = whatwillitsteal.desc
//			C.doUnEquip(whatwillitsteal)
//		target.u_equip(whatwillitsteal)
			C.dropItemToGround(whatwillitsteal, force = TRUE, silent = TRUE)
			src.put_in_active_hand(whatwillitsteal)
			C.equip_to_slot(S, slot_it_will_go)
			to_chat(src, span_steal("I stealed the [S.name] from [C]!"))

/obj/item/stolen
	name = "none"
	desc = "none"

/obj/item/stolen/attack_hand(mob/user as mob)
	. = ..()
	to_chat(user, "<span class='danger'>Wait, where is...</span>")
//	user << 'sound/lfwbsounds/stolen.ogg'
	qdel(src)
/*
/mob/living/carbon/proc/jump_callback()
	sound_hint()
	switch(diceroll(GET_MOB_ATTRIBUTE_VALUE(src, STAT_DEXTERITY), context = DICE_CONTEXT_MENTAL))
		if(DICE_CRIT_SUCCESS)
			adjustFatigueLoss(15)
		if(DICE_SUCCESS)
			adjustFatigueLoss(30)
			Immobilize(1 SECONDS)
		if(DICE_FAILURE)
			adjustFatigueLoss(50)
			Immobilize(2 SECONDS)
		if(DICE_CRIT_FAILURE)
			adjustFatigueLoss(65)
			CombatKnockdown(75, 2 SECONDS)
*/
/mob/living/carbon/attempt_jump(atom/jump_target, proximity_flag, list/modifiers)
	//We can't jump if it's the same damn tile
	//TODO: Multi-z jumping when certain requirements are met
	if(get_dist(src, jump_target) < 1)
		return FALSE
	//Not while thrown/jumping
	if(throwing)
		return FALSE
	//Not while knocked down
	if(body_position != STANDING_UP)
		to_chat(span_warning("I need to stand up."))
		return FALSE
	//Not while buckled
	if(buckled)
		to_chat(span_warning("I need to unbuckle."))
		return FALSE
	var/range = FLOOR(GET_MOB_ATTRIBUTE_VALUE(src, STAT_STRENGTH)/(ATTRIBUTE_MIDDLING/2), 1)
	if(range < 1)
		to_chat(src, span_warning("I'm too weak to do this..."))
		return FALSE
	if(ismob(jump_target))
		visible_message(span_warning("<b>[src]</b> jumps at <b>[jump_target]</b>!"), \
					span_userdanger("I jump at <b>[jump_target]</b>!"), \
					ignored_mobs = jump_target)
		to_chat(jump_target, span_userdanger("<b>[src]</b> jumps at me!"))
	else
		visible_message(span_warning("<b>[src]</b> jumps at [jump_target]!"), \
					span_userdanger("I jump at [jump_target]!"))
	jump_grunt()
	sound_hint()
	safe_throw_at(jump_target, range, throw_speed, src, FALSE, callback = CALLBACK(src, .proc/jump_callback))

/mob/living/carbon/proc/jump_callback()
	sound_hint()
	switch(diceroll(GET_MOB_ATTRIBUTE_VALUE(src, STAT_DEXTERITY), context = DICE_CONTEXT_MENTAL))
		if(DICE_CRIT_SUCCESS)
			adjustFatigueLoss(15)
		if(DICE_SUCCESS)
			adjustFatigueLoss(30)
			Immobilize(1 SECONDS)
		if(DICE_FAILURE)
			adjustFatigueLoss(50)
			Immobilize(2 SECONDS)
		if(DICE_CRIT_FAILURE)
			adjustFatigueLoss(65)
			CombatKnockdown(75, 2 SECONDS)
