/mob/living/carbon/steal_this(atom/target, proximity_flag, list/modifiers, hit_zone)
	if(!target)
		return FALSE
/*
	if(!iscarbon(target))
		return FALSE
*/
	if(!isliving(target))
		return FALSE

	var/mob/living/carbon/C = target
	if(!C)
		return FALSE

	if(body_position != STANDING_UP)
		to_chat(src, span_warning("Мне бы встать."))
		return FALSE
/*
	if(get_active_hand() != null)
		return
*/
	if(!get_empty_held_indexes())
		to_chat(src, span_warning("Мне бы руками!"))
		return FALSE

/*
	if(target.combat_mode)
		to_chat(src, "<span class='danger'>Intimidates...</span>")
		return
*/
//	var/mob/living/carbon/human/L = user
//	var/hit_zone = L.zone_selected
	if(C == src)
		to_chat(src, span_warning("Нахуя мне самого себя обкрадывать?"))
		return FALSE

//	var/obj/item/bodypart/BP = C.get_bodypart(check_zone(user.zone_selected))
//	var/obj/item/bodypart/affecting = C.get_bodypart(hit_zone)
/*
	if(user.vice == "Kleptomaniac")
		user.clear_event("vice")
		user.viceneed = 0

		SKILL_PICKPOCKET
*/
//	var/list/rolled = roll3d6(user,SKILL_STEAL,null)
	var/time = (5 SECONDS - ((GET_MOB_SKILL_VALUE(src, SKILL_PICKPOCKET)/2)) + 1 SECONDS)
//	var/obj/whatwillitsteal = null
	if(do_after(src, time, target=C))
		var/diceroll = diceroll(GET_MOB_SKILL_VALUE(src, SKILL_PICKPOCKET), context = DICE_CONTEXT_PHYSICAL)
		if(diceroll == DICE_CRIT_FAILURE)
			src.visible_message(span_steal("[src] пойман на краже!"),span_steal("Поймался я!"), span_hear("Слышу чё-то."))
			src.Immobilize(2 SECONDS)
			src.changeNext_move(CLICK_CD_MELEE)
			sound_hint()
			C.unequip_everything()
			return

		if(diceroll >= DICE_FAILURE)
			src.visible_message(span_steal("[src] обкрадывает [target]!"),span_steal("Я обкрадываю [target]!"), span_hear("Слышу чё-то."))
			src.changeNext_move(CLICK_CD_MELEE)
			sound_hint()
			C.unequip_everything()
	else
		to_chat(src, span_danger(xbox_rage_msg()))
		src.playsound_local(get_turf(src), 'modular_pod/sound/eff/difficult1.ogg', 15, FALSE)

/*
		switch(affecting)
			if(BODY_ZONE_CHEST)
				if(C.wear_suit)
					var/obj/shit = C.get_item_by_slot(ITEM_SLOT_OCLOTHING)
					C.dropItemToGround(shit, force = TRUE, silent = TRUE)
					put_in_active_hand(shit)

	if(diceroll >= DICE_SUCCESS)
		switch(affecting)
			if(BODY_ZONE_CHEST)
				if(C.wear_suit)
					var/obj/shit = C.get_item_by_slot(ITEM_SLOT_OCLOTHING)
					C.dropItemToGround(shit, force = TRUE, silent = TRUE)
					put_in_active_hand(shit)

				if(C.r_store)
					whatwillitsteal = C.r_store
				else
					if(C.l_store)
						whatwillitsteal = C.l_store
					else
						to_chat(src, span_steal("There is nothing left in the pockets!"))
						return
			if(BODY_ZONE_PRECISE_VITALS)
				if(C.wear_id)
					whatwillitsteal = C.wear_id
				else
					if(C.s_store)
						whatwillitsteal = C.s_store
					else
						to_chat(src, span_steal("There is nothing left in here!"))
						return
			if(BODY_ZONE_PRECISE_GROIN)
				if(C.belt)
					whatwillitsteal = C.belt
				else
					to_chat(src, span_steal("There is nothing!"))
					return
*/
/*
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
*/
//		if(whatwillitsteal)
//			var/obj/item/stolen/S = new(src)
//			S.icon = whatwillitsteal.icon
//			S.icon_state = whatwillitsteal.icon_state
//			S.name = whatwillitsteal.name
//			S.desc = whatwillitsteal.desc
//			C.doUnEquip(whatwillitsteal)
//		target.u_equip(whatwillitsteal)
//			C.equip_to_slot(S, slot_it_will_go)
//			to_chat(src, span_steal("I stealed the [S.name] from [C]!"))

/*
/obj/item/stolen
	name = "none"
	desc = "none"

/obj/item/stolen/attack_hand(mob/user as mob)
	. = ..()
	to_chat(user, "<span class='danger'>Подождите, а где...</span>")
//	user << 'sound/lfwbsounds/stolen.ogg'
	qdel(src)
*/
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
		to_chat(src, span_warning("Мне нужно встать."))
		return FALSE
	//Not while buckled
	if(buckled)
		to_chat(src, span_warning("Отстегнуться мне нужно."))
		return FALSE
	var/range = FLOOR(GET_MOB_ATTRIBUTE_VALUE(src, STAT_STRENGTH)/(ATTRIBUTE_MIDDLING/2), 1)
	if(range < 1)
		to_chat(src, span_warning("Я слишком слаб чтобы сделать такое..."))
		return FALSE
	if(next_move > world.time)
		to_chat(src, click_fail_msg())
		src.playsound_local(get_turf(src), 'modular_pod/sound/eff/difficult1.ogg', 15, FALSE)
		return FALSE
	if(ismob(jump_target))
		visible_message(span_warning("<b>[src]</b> прыгает в <b>[jump_target]</b>!"), \
					span_userdanger("Я прыгаю в <b>[jump_target]</b>!"), \
					ignored_mobs = jump_target)
		to_chat(jump_target, span_userdanger("<b>[src]</b> прыгает на меня!"))
	else
		visible_message(span_warning("<b>[src]</b> прыгает на [jump_target]!"), \
					span_userdanger("Я прыгаю на [jump_target]!"))
	jump_grunt()
	sound_hint()
	changeNext_move(CLICK_CD_MELEE)
	safe_throw_at(jump_target, range, throw_speed, src, FALSE, callback = CALLBACK(src, PROC_REF(jump_callback)))

/mob/living/carbon/proc/jump_callback()
	sound_hint()
	switch(diceroll(GET_MOB_ATTRIBUTE_VALUE(src, STAT_DEXTERITY), context = DICE_CONTEXT_MENTAL))
		if(DICE_CRIT_SUCCESS)
			adjustFatigueLoss(10)
		if(DICE_SUCCESS)
			adjustFatigueLoss(20)
//			Immobilize(1 SECONDS)
		if(DICE_FAILURE)
			adjustFatigueLoss(30)
			Immobilize(0.5 SECONDS)
		if(DICE_CRIT_FAILURE)
			adjustFatigueLoss(45)
			CombatKnockdown(75, 2 SECONDS)
