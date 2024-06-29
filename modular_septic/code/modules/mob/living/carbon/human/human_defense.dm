/mob/living/carbon/human/attacked_by(obj/item/weapon, mob/living/user, list/modifiers)
	if(!weapon || !user)
		return FALSE

	//feinting an attack before attacking
	if((user != src) && LAZYACCESS(modifiers, RIGHT_CLICK) && (user.combat_style == CS_FEINT))
		var/user_diceroll = user.diceroll(GET_MOB_SKILL_VALUE(user, weapon.skill_melee), context = DICE_CONTEXT_PHYSICAL, return_flags = RETURN_DICE_DIFFERENCE)
		var/most_efficient_skill = max(GET_MOB_SKILL_VALUE(src, weapon.skill_melee), \
									GET_MOB_SKILL_VALUE(src, SKILL_SHIELD), \
									GET_MOB_SKILL_VALUE(src, SKILL_BUCKLER), \
									GET_MOB_SKILL_VALUE(src, SKILL_FORCE_SHIELD), \
									GET_MOB_ATTRIBUTE_VALUE(src, STAT_DEXTERITY))
		var/target_diceroll = diceroll(most_efficient_skill, context = DICE_CONTEXT_MENTAL, return_flags = RETURN_DICE_DIFFERENCE)
		if(!combat_mode)
			target_diceroll = -18
		//successful feint
		if(user_diceroll >= target_diceroll)
			var/feint_message_spectator = "<b>[user]</b> успешно финтует атаку на <b>[src]</b> с помощью [weapon]!"
			var/feint_message_victim = "Кто-то финтует атаку на мне!"
			var/feint_message_attacker = "Я финтую атаку на ком-то с помощью [weapon]!"
			if(user in fov_viewers(2, src))
				feint_message_attacker = "Я финтую атаку на <b>[src]</b> с помощью [weapon]!"
			if(src in fov_viewers(2, user))
				feint_message_victim = "<b>[user]</b> финтует атаку на мне с помощью [weapon]!"
			visible_message(span_danger("[feint_message_spectator]"),\
				span_userdanger("[feint_message_victim]"),
				span_hear("Я слышу свист!"), \
				vision_distance = COMBAT_MESSAGE_RANGE, \
				ignored_mobs = user)
			to_chat(user, span_userdanger("[feint_message_attacker]"))
			update_parrying_penalty(PARRYING_PENALTY*3, PARRYING_PENALTY_COOLDOWN_DURATION*2)
			update_blocking_cooldown(BLOCKING_COOLDOWN_DURATION)
			update_dodging_cooldown(DODGING_COOLDOWN_DURATION)
		//failed feint
		else
			var/feint_message_spectator = "<b>[user]</b> проваливает финт атаки на <b>[src]</b> с помощью [weapon]!"
			var/feint_message_victim = "Кто-то проваливает финт атаки на мне!"
			var/feint_message_attacker = "Я проваливаю финт атаки на ком-то с помощью [weapon]!"
			if(user in fov_viewers(2, src))
				feint_message_attacker = "Я проваливаю финт атаки на <b>[src]</b> с помощью [weapon]!"
			if(src in fov_viewers(2, user))
				feint_message_victim = "<b>[user]</b> проваливает финт атаки на мне с помощью [weapon]!"
			visible_message(span_danger("[feint_message_spectator]"),\
				span_userdanger("[feint_message_victim]"),
				span_hear("Я слышу свист!"), \
				vision_distance = COMBAT_MESSAGE_RANGE, \
				ignored_mobs = user)
			to_chat(user, span_userdanger("[feint_message_attacker]"))
	var/obj/item/bodypart/affecting
	//stabbing yourself always hits the right target
	if(user == src)
		affecting = get_bodypart(check_zone(user.zone_selected))
	else
		affecting = get_bodypart(check_zone(user.zone_selected))
		var/hit_modifier = weapon.melee_modifier
		var/hit_zone_modifier = weapon.melee_zone_modifier
		if(affecting)
			hit_modifier = affecting.melee_hit_modifier
			hit_zone_modifier = affecting.melee_hit_zone_modifier
			//very hard to miss when hidden by fov
			if(!(src in fov_viewers(2, user)))
				hit_modifier += 10
				hit_zone_modifier += 10
			//easy to kick people when they are down
			if((body_position == LYING_DOWN) && (user.body_position != LYING_DOWN))
				hit_modifier += 5
				hit_zone_modifier += 5
			//bro we dead :skull:
			if(stat >= UNCONSCIOUS)
				hit_modifier += 15
		var/diceroll = DICE_FAILURE
		var/skill_modifier = 0
		if(weapon.skill_melee)
			skill_modifier += GET_MOB_SKILL_VALUE(user, weapon.skill_melee)
		var/strength_difference = max(0, weapon.minimum_strength-GET_MOB_ATTRIBUTE_VALUE(user, STAT_STRENGTH))
		var/damage = weapon.get_force(user, GET_MOB_ATTRIBUTE_VALUE(user, STAT_STRENGTH))
		diceroll = user.diceroll(skill_modifier+hit_modifier-strength_difference, context = DICE_CONTEXT_PHYSICAL)
		if(diceroll == DICE_FAILURE)
			damage *= 0.8
		if(diceroll == DICE_CRIT_FAILURE)
			affecting = null
		if(diceroll >= DICE_SUCCESS)
			diceroll = user.diceroll(skill_modifier+hit_zone_modifier, context = DICE_CONTEXT_PHYSICAL)
			if(diceroll <= DICE_FAILURE)
				affecting = get_bodypart(ran_zone(user.zone_selected, 0))
			else
				affecting = get_bodypart(check_zone(user.zone_selected))
	//our intended target
	var/target_area = parse_zone(check_zone(user.zone_selected))

	SEND_SIGNAL(weapon, COMSIG_ITEM_ATTACK_ZONE, src, user, affecting)

	SSblackbox.record_feedback("nested tally", "item_used_for_combat", 1, list("[weapon.force]", "[weapon.type]"))
	SSblackbox.record_feedback("tally", "zone_targeted", 1, target_area)

	// the attacked_by code varies among species
	return dna.species.spec_attacked_by(weapon, user, affecting, src)

/mob/living/carbon/human/do_cpr(mob/living/carbon/target, cpr_type = CPR_CHEST)
	if(target == src)
		return

	CHECK_DNA_AND_SPECIES(target)

	var/obj/item/bodypart/mouth/jaw = target.get_bodypart_nostump(BODY_ZONE_PRECISE_MOUTH)
	var/obj/item/bodypart/chest/chest = target.get_bodypart(BODY_ZONE_CHEST)
	var/medical_skill = GET_MOB_SKILL_VALUE(src, SKILL_MEDICINE)
	switch(cpr_type)
		if(CPR_CHEST)
			if(chest?.is_robotic_limb())
				medical_skill = GET_MOB_SKILL_VALUE(src, SKILL_ELECTRONICS)
		if(CPR_MOUTH)
			if(jaw?.is_robotic_limb())
				medical_skill = GET_MOB_SKILL_VALUE(src, SKILL_ELECTRONICS)

	if(DOING_INTERACTION_WITH_TARGET(src, target))
		return FALSE

	target.add_fingerprint(src)
	switch(cpr_type)
		if(CPR_MOUTH)
			if(is_mouth_covered())
				to_chat(src, span_warning("Сначала мне нужен открытый рот!"))
				return FALSE

			if(target.is_mouth_covered())
				to_chat(src, span_warning("Мне нужно сначала раскрыть его рот!"))
				return FALSE

			if(!jaw)
				to_chat(src, span_warning("У меня нет рта!"))
				return FALSE

			if(HAS_TRAIT(src, TRAIT_NOBREATH))
				to_chat(src, span_warning("Я не могу дышать!"))
				return FALSE

			if(!getorganslot(ORGAN_SLOT_LUNGS))
				to_chat(src, span_warning("У меня нет лёгких!"))
				return FALSE

			if(world.time >= target.last_mtom + M2M_COOLDOWN)
				var/they_breathe = !HAS_TRAIT(target, TRAIT_NOBREATH)
				var/obj/item/organ/lungs/they_lung = target.getorganslot(ORGAN_SLOT_LUNGS)
				visible_message(span_notice("<b>[src]</b> исполняет реанимацию <b>[target]</b>!"), \
								span_notice("Я исполняю реанимацию <b>[target]</b>."),
								span_hear("Я слышу чё-то."),
								vision_distance = COMBAT_MESSAGE_RANGE,
								ignored_mobs = target)
				target.last_mtom = world.time
				log_combat(src, target, "M2Med")
				if(they_breathe && they_lung)
					var/epinephrine_mod = 0
					if(target.reagents?.get_reagent_amount(/datum/reagent/medicine/epinephrine) >= 1)
						epinephrine_mod += 5
					target.adjustOxyLoss(-(medical_skill + epinephrine_mod))
					target.updatehealth()
					to_chat(target, span_unconscious("Я чувствую, как глоток свежего воздуха проникает в мои лёгкие... Это приятно..."))
				else if(they_breathe && !they_lung)
					to_chat(target, span_unconscious("Я чувствую глоток свежего воздуха... Но мне не легче..."))
				else
					to_chat(target, span_unconscious("Я чувствую глоток свежего воздуха... Это ощущение, которое я не особо распознаю..."))
		if(CPR_CHEST)
			var/mob/living/carbon/human/humie = target
			if(istype(humie))
				var/obj/item/clothing/suit = humie.wear_suit
				var/obj/item/clothing/under = humie.w_uniform
				if(istype(under) && CHECK_BITFIELD(under.clothing_flags, THICKMATERIAL))
					to_chat(src, span_warning("Мне нужно сначала снять его [under]!"))
					return
				else if(istype(suit) && CHECK_BITFIELD(suit.clothing_flags, THICKMATERIAL))
					to_chat(src, span_warning("Мне нужно снять его [suit]!"))
					return

			if(world.time >= target.last_cpr + CPR_COOLDOWN)
				var/they_beat = !HAS_TRAIT(target, TRAIT_STABLEHEART)
				var/obj/item/organ/heart/they_heart = target.getorganslot(ORGAN_SLOT_HEART)
				var/heart_exposed_mod = 0
				if(CHECK_MULTIPLE_BITFIELDS(chest.how_open(), SURGERY_INCISED|SURGERY_RETRACTED|SURGERY_BROKEN) && istype(they_heart))
					heart_exposed_mod += 5
					visible_message(span_notice("<b>[src]</b> массажирует <b>[target]</b> [they_heart]!"), \
								span_notice("Я массажирую <b>[target]</b> [they_heart]."), \
								vision_distance = COMBAT_MESSAGE_RANGE, \
								ignored_mobs = target)
				else
					visible_message(span_notice("<b>[src]</b> исполняет СЛР на <b>[target]</b>!"), \
								span_notice("Я исполняю СЛР на <b>[target]</b>."), \
								vision_distance = COMBAT_MESSAGE_RANGE, \
								ignored_mobs = target)
				if(target.stat >= DEAD || target.undergoing_cardiac_arrest())
					SEND_SIGNAL(src, COMSIG_ADD_MOOD_EVENT, "cpr", /datum/mood_event/saved_life)
				target.last_cpr = world.time
				log_combat(src, target, "CPRed")
				if(they_beat && they_heart)
					to_chat(target, span_unconscious("Я чувствую, как мое сердце колотится..."))
				else if(they_beat && !they_heart)
					to_chat(target, span_unconscious("Я чувствую, как у меня колотится в груди... Но мне не легче..."))
				else
					to_chat(target, span_unconscious("Я чувствую, как мне давят на грудь..."))
				var/epinephrine_mod = 0
				if(target.reagents?.get_reagent_amount(/datum/reagent/medicine/epinephrine) >= 1)
					epinephrine_mod +=  3

				var/diceroll = diceroll(medical_skill+heart_exposed_mod+epinephrine_mod, context = DICE_CONTEXT_PHYSICAL)
				if((diceroll >= DICE_SUCCESS) || !attributes)
					if(prob(35) || (diceroll >= DICE_CRIT_SUCCESS))
						target?.pump_heart(src)
						target.set_heartattack(FALSE)
						if(GETBRAINLOSS(target) >= 100)
							SETBRAINLOSS(target, 85)
						if(target.revive())
							target.grab_ghost(TRUE)
							target.visible_message(span_warning("<b>[target]</b> вяло спазмирует мышцами."), \
											span_userdanger("Мои мышцы спазмируются, когда меня возвращают к жизни!"))
/*
				else
					if(diceroll <= DICE_CRIT_FAILURE)
						var/obj/item/organ/bone/ribs = chest.getorganslot(ORGAN_SLOT_BONE)
						if(ribs)
							if(!ribs.fracture())
								ribs.compound_fracture()
								visible_message(span_danger("<b>[src]</b> botches the CPR, cracking <b>[target]</b>'s [ribs.name]!"), \
											span_danger("I botch the CPR, cracking <b>[target]</b>'s [ribs.name]!"),
											span_hear("I hear a loud crack!"),
											ignored_mobs = target)
								to_chat(target, span_userdanger("<b>[src]</b> botches the CPR and cracks my [ribs.name]!"))
								playsound(target, 'modular_septic/sound/gore/ouchie.ogg', 75, FALSE)
								SEND_SIGNAL(target, COMSIG_CARBON_CLEAR_WOUND_MESSAGE)
*/

/mob/living/carbon/human/damage_clothes(damage_amount, damage_type = BRUTE, damage_flag = 0, def_zone)
	if(damage_type != BRUTE && damage_type != BURN)
		return

	damage_amount *= 0.4 //0.5 multiplier for balance reason, we don't want clothes to be too easily destroyed
	var/list/torn_items = list()

	//HEAD//
	if(!def_zone || (def_zone in list(BODY_ZONE_HEAD, BODY_ZONE_PRECISE_FACE, BODY_ZONE_PRECISE_MOUTH)))
		var/obj/item/clothing/head_clothes = null
		if(wear_neck && (wear_neck.body_parts_covered & HEAD))
			head_clothes = wear_neck
		if(wear_mask && (wear_mask.body_parts_covered & HEAD))
			head_clothes = wear_mask
		if(head && (head.body_parts_covered & HEAD))
			head_clothes = head
		if(head_clothes)
			torn_items |= head_clothes
		else if(ears && (ears.body_parts_covered & HEAD))
			torn_items |= ears

	//NECK//
	if(!def_zone || (def_zone == BODY_ZONE_PRECISE_NECK))
		if(wear_neck && (wear_neck.body_parts_covered & NECK))
			torn_items |= wear_neck

	//EYES//
	if(!def_zone || (def_zone in list(BODY_ZONE_PRECISE_R_EYE, BODY_ZONE_PRECISE_L_EYE)))
		if(wear_mask && (wear_mask.body_parts_covered & EYES))
			torn_items |= wear_mask
		else if(glasses)
			torn_items |= glasses

	//CHEST//
	if(!def_zone || (def_zone == BODY_ZONE_CHEST))
		var/obj/item/clothing/chest_clothes = null
		if(oversuit && (oversuit.body_parts_covered & CHEST))
			chest_clothes = oversuit
		if(wear_suit && (wear_suit.body_parts_covered & CHEST))
			chest_clothes = wear_suit
		if(w_uniform && (w_uniform.body_parts_covered & CHEST))
			chest_clothes = w_uniform
		if(chest_clothes)
			torn_items |= chest_clothes

	//GROIN//
	if(!def_zone || (def_zone == BODY_ZONE_PRECISE_GROIN))
		var/obj/item/clothing/groin_clothes = null
		if(w_uniform && (w_uniform.body_parts_covered & GROIN))
			groin_clothes = w_uniform
		if(wear_suit && (wear_suit.body_parts_covered & GROIN))
			groin_clothes = wear_suit
		if(groin_clothes)
			torn_items |= groin_clothes

	//ARMS//
	if(!def_zone || (def_zone in list(BODY_ZONE_R_ARM, BODY_ZONE_L_ARM)))
		var/obj/item/clothing/arm_clothes = null
		if(w_uniform && (w_uniform.body_parts_covered & ARMS))
			arm_clothes = w_uniform
		if(gloves && (gloves.body_parts_covered & ARMS))
			arm_clothes = gloves
		if(wear_suit && (wear_suit.body_parts_covered & ARMS))
			arm_clothes = wear_suit
		if(arm_clothes)
			torn_items |= arm_clothes

	//HANDS//
	if(!def_zone || (def_zone in list(BODY_ZONE_PRECISE_R_HAND, BODY_ZONE_PRECISE_L_HAND)))
		var/obj/item/clothing/hand_clothes = null
		if(w_uniform && (w_uniform.body_parts_covered & HANDS))
			hand_clothes = w_uniform
		if(gloves && (gloves.body_parts_covered & HANDS))
			hand_clothes = gloves
		if(wrists && (wrists.body_parts_covered & HANDS))
			hand_clothes = wrists
		if(wear_suit && (wear_suit.body_parts_covered & HANDS))
			hand_clothes = wear_suit
		if(hand_clothes)
			torn_items |= hand_clothes

	//LEGS//
	if(!def_zone || (def_zone in list(BODY_ZONE_R_LEG, BODY_ZONE_L_LEG)))
		var/obj/item/clothing/leg_clothes = null
		if(shoes && (shoes.body_parts_covered & LEGS))
			leg_clothes = shoes
		if(w_uniform && (w_uniform.body_parts_covered & LEGS))
			leg_clothes = w_uniform
		if(wear_suit && (wear_suit.body_parts_covered & LEGS))
			leg_clothes = wear_suit
		if(pants && (pants.body_parts_covered & LEGS))
			leg_clothes = pants
		if(leg_clothes)
			torn_items |= leg_clothes

	//FEET//
	if(!def_zone || (def_zone in list(BODY_ZONE_R_LEG, BODY_ZONE_L_LEG)))
		var/obj/item/clothing/feet_clothes = null
		if(shoes && (shoes.body_parts_covered & FEET))
			feet_clothes = shoes
		if(w_uniform && (w_uniform.body_parts_covered & FEET))
			feet_clothes = w_uniform
		if(wear_suit && (wear_suit.body_parts_covered & FEET))
			feet_clothes = wear_suit
		if(feet_clothes)
			torn_items |= feet_clothes

	for(var/thing in torn_items)
		var/obj/item/item = thing
		item.take_damage(damage_amount, damage_type, damage_flag, 0)

/mob/living/carbon/human/acid_act(acidpwr, acid_volume, bodyzone_hit) //todo: update this to utilize check_obscured_slots() //and make sure it's check_obscured_slots(TRUE) to stop aciding through visors etc
	var/list/damaged_bodyparts = list()
	var/list/inventory_items_to_kill = list()
	var/acidity = acidpwr * min(acid_volume*0.005, 0.1)

	//HEAD//
	if(!bodyzone_hit || (bodyzone_hit in list(BODY_ZONE_HEAD, BODY_ZONE_PRECISE_FACE, BODY_ZONE_PRECISE_MOUTH)))
		var/obj/item/clothing/head_clothes = null
		if(wear_neck && (wear_neck.body_parts_covered & HEAD))
			head_clothes = wear_neck
		if(wear_mask && (wear_mask.body_parts_covered & HEAD))
			head_clothes = wear_mask
		if(head && (head.body_parts_covered & HEAD))
			head_clothes = head
		if(head_clothes)
			inventory_items_to_kill |= head_clothes
		else
			var/obj/item/bodypart/shoeonhead = get_bodypart(BODY_ZONE_PRECISE_FACE)
			if(!shoeonhead)
				shoeonhead = get_bodypart(BODY_ZONE_HEAD)
			if(shoeonhead)
				damaged_bodyparts |= shoeonhead
			if(ears && (ears.body_parts_covered & HEAD))
				inventory_items_to_kill |= ears

	//NECK//
	if(!bodyzone_hit || (bodyzone_hit == BODY_ZONE_PRECISE_NECK))
		if(wear_neck && (wear_neck.body_parts_covered & NECK))
			inventory_items_to_kill |= wear_neck
		else
			var/obj/item/bodypart/shoeonneck = get_bodypart(BODY_ZONE_PRECISE_NECK)
			if(shoeonneck)
				damaged_bodyparts |= shoeonneck

	//EYES//
	if(!bodyzone_hit || (bodyzone_hit in list(BODY_ZONE_PRECISE_R_EYE, BODY_ZONE_PRECISE_L_EYE)))
		if(wear_mask && (wear_mask.body_parts_covered & EYES))
			inventory_items_to_kill |= wear_mask
		else if(glasses)
			inventory_items_to_kill |= glasses
		else
			var/obj/item/bodypart/sightless = get_bodypart(BODY_ZONE_PRECISE_R_EYE)
			if(sightless)
				damaged_bodyparts |= sightless
			sightless = get_bodypart(BODY_ZONE_PRECISE_L_EYE)
			if(sightless)
				damaged_bodyparts |= sightless

	//CHEST//
	if(!bodyzone_hit || (bodyzone_hit == BODY_ZONE_CHEST))
		var/obj/item/clothing/chest_clothes = null
		if(w_uniform && (w_uniform.body_parts_covered & CHEST))
			chest_clothes = w_uniform
		if(wear_suit && (wear_suit.body_parts_covered & CHEST))
			chest_clothes = wear_suit
		if(chest_clothes)
			inventory_items_to_kill |= chest_clothes
		else
			var/obj/item/bodypart/chest = get_bodypart(BODY_ZONE_CHEST)
			if(chest)
				damaged_bodyparts |= chest

	//VITALS//
	if(!bodyzone_hit || (bodyzone_hit == BODY_ZONE_PRECISE_VITALS))
		var/obj/item/clothing/vitals_clothes = null
		if(w_uniform && (w_uniform.body_parts_covered & VITALS))
			vitals_clothes = w_uniform
		if(wear_suit && (wear_suit.body_parts_covered & VITALS))
			vitals_clothes = wear_suit
		if(vitals_clothes)
			inventory_items_to_kill |= vitals_clothes
		else
			var/obj/item/bodypart/vitals = get_bodypart(BODY_ZONE_PRECISE_VITALS)
			if(vitals)
				damaged_bodyparts |= vitals

	//WRISTS//
	if(!bodyzone_hit || (bodyzone_hit in list(BODY_ZONE_PRECISE_R_HAND, BODY_ZONE_PRECISE_L_HAND)))
		var/obj/item/clothing/wrists_clothes = null
		if(w_uniform && (w_uniform.body_parts_covered & HANDS))
			wrists_clothes = w_uniform
		if(wrists && (wrists.body_parts_covered & HANDS))
			wrists_clothes = wrists
		if(wear_suit && (wear_suit.body_parts_covered & HANDS))
			wrists_clothes = wear_suit
		if(wrists_clothes)
			inventory_items_to_kill |= wrists_clothes
		else
			var/obj/item/bodypart/hand = get_bodypart(BODY_ZONE_PRECISE_R_HAND)
			if(hand)
				damaged_bodyparts |= hand
			hand = get_bodypart(BODY_ZONE_PRECISE_L_HAND)
			if(hand)
				damaged_bodyparts |= hand

	//GROIN//
	if(!bodyzone_hit || (bodyzone_hit == BODY_ZONE_PRECISE_GROIN))
		var/obj/item/clothing/groin_clothes = null
		if(w_uniform && (w_uniform.body_parts_covered & GROIN))
			groin_clothes = w_uniform
		if(wear_suit && (wear_suit.body_parts_covered & GROIN))
			groin_clothes = wear_suit
		if(groin_clothes)
			inventory_items_to_kill |= groin_clothes
		else
			var/obj/item/bodypart/groin = get_bodypart(BODY_ZONE_PRECISE_GROIN)
			if(groin)
				damaged_bodyparts |= groin

	//ARMS//
	if(!bodyzone_hit || (bodyzone_hit in list(BODY_ZONE_R_ARM, BODY_ZONE_L_ARM)))
		var/obj/item/clothing/arm_clothes = null
		if(w_uniform && (w_uniform.body_parts_covered & ARMS))
			arm_clothes = w_uniform
		if(gloves && (gloves.body_parts_covered & ARMS))
			arm_clothes = gloves
		if(wear_suit && (wear_suit.body_parts_covered & ARMS))
			arm_clothes = wear_suit
		if(arm_clothes)
			inventory_items_to_kill |= arm_clothes
		else
			var/obj/item/bodypart/arm = get_bodypart(BODY_ZONE_R_ARM)
			if(arm)
				damaged_bodyparts |= arm
			arm = get_bodypart(BODY_ZONE_L_ARM)
			if(arm)
				damaged_bodyparts |= arm

	//HANDS//
	if(!bodyzone_hit || (bodyzone_hit in list(BODY_ZONE_PRECISE_R_HAND, BODY_ZONE_PRECISE_L_HAND)))
		var/obj/item/clothing/hand_clothes = null
		if(w_uniform && (w_uniform.body_parts_covered & HANDS))
			hand_clothes = w_uniform
		if(gloves && (gloves.body_parts_covered & HANDS))
			hand_clothes = gloves
		if(wear_suit && (wear_suit.body_parts_covered & HANDS))
			hand_clothes = wear_suit
		if(hand_clothes)
			inventory_items_to_kill |= hand_clothes
		else
			var/obj/item/bodypart/hand = get_bodypart(BODY_ZONE_PRECISE_R_HAND)
			if(hand)
				damaged_bodyparts |= hand
			hand = get_bodypart(BODY_ZONE_PRECISE_L_HAND)
			if(hand)
				damaged_bodyparts |= hand

	//LEGS//
	if(!bodyzone_hit || (bodyzone_hit in list(BODY_ZONE_R_LEG, BODY_ZONE_L_LEG)))
		var/obj/item/clothing/leg_clothes = null
		if(shoes && (shoes.body_parts_covered & LEGS))
			leg_clothes = shoes
		if(w_uniform && (w_uniform.body_parts_covered & LEGS))
			leg_clothes = w_uniform
		if(wear_suit && (wear_suit.body_parts_covered & LEGS))
			leg_clothes = wear_suit
		if(leg_clothes)
			inventory_items_to_kill |= leg_clothes
		else
			var/obj/item/bodypart/leg = get_bodypart(BODY_ZONE_R_LEG)
			if(leg)
				damaged_bodyparts |= leg
			leg = get_bodypart(BODY_ZONE_L_LEG)
			if(leg)
				damaged_bodyparts |= leg

	//FEET//
	if(!bodyzone_hit || (bodyzone_hit in list(BODY_ZONE_R_LEG, BODY_ZONE_L_LEG)))
		var/obj/item/clothing/feet_clothes = null
		if(shoes && (shoes.body_parts_covered & FEET))
			feet_clothes = shoes
		if(w_uniform && (w_uniform.body_parts_covered & FEET))
			feet_clothes = w_uniform
		if(wear_suit && (wear_suit.body_parts_covered & FEET))
			feet_clothes = wear_suit
		if(feet_clothes)
			inventory_items_to_kill |= feet_clothes
		else
			var/obj/item/bodypart/foot = get_bodypart(BODY_ZONE_PRECISE_R_EYE)
			if(foot)
				damaged_bodyparts |= foot
			foot = get_bodypart(BODY_ZONE_PRECISE_L_FOOT)
			if(foot)
				damaged_bodyparts |= foot

	//DAMAGE//
	for(var/obj/item/bodypart/affecting as anything in damaged_bodyparts)
		affecting.receive_damage(burn = 2*acidity)
		if(affecting.body_zone in list(BODY_ZONE_HEAD, BODY_ZONE_PRECISE_FACE, BODY_ZONE_PRECISE_MOUTH))
			if(prob(min(acidpwr*acid_volume/10, 90))) //Applies disfigurement
				affecting.receive_damage(burn = 2*acidity)
				death_scream()
				facial_hairstyle = "Shaved"
				hairstyle = "Bald"
				update_hair()
				ADD_TRAIT(src, TRAIT_DISFIGURED, ACID)

		update_damage_overlays()

	//MELTING INVENTORY ITEMS//
	//these items are all outside of armour visually, so melt regardless.
	if(!bodyzone_hit)
		if(back)
			inventory_items_to_kill |= back
		if(belt)
			inventory_items_to_kill |= belt

		for(var/thing in held_items)
			if(!thing)
				continue
			inventory_items_to_kill |= held_items
	for(var/obj/item/inventory_item in inventory_items_to_kill)
		inventory_item.acid_act(acidpwr, acid_volume)

	return TRUE

/mob/living/carbon/human/attack_hand(mob/user, list/modifiers)
	. = ..()
	if(.) //to allow surgery to return properly.
		return
	if(ishuman(user))
		var/mob/living/carbon/human/human_user = user
		dna.species.spec_attack_hand(human_user, src, user.mind?.martial_art, modifiers)

/mob/living/carbon/human/attack_foot(mob/user, list/modifiers)
	. = ..()
	if(.) //to allow surgery to return properly.
		return
	if(ishuman(user))
		var/mob/living/carbon/human/human_user = user
		dna.species.spec_attack_foot(human_user, src, user.mind?.martial_art, modifiers)

/mob/living/carbon/human/attack_jaw(mob/user, list/modifiers)
	. = ..()
	if(.) //to allow surgery to return properly.
		return
	if(ishuman(user))
		var/mob/living/carbon/human/human_user = user
		dna.species.spec_attack_jaw(human_user, src, user.mind?.martial_art, modifiers)

/mob/living/carbon/human/hitby(atom/movable/AM, skipcatch = FALSE, hitpush = TRUE, blocked = FALSE, datum/thrownthing/throwingdatum)
	if(dna?.species)
		var/spec_return = dna.species.spec_hitby(AM, src)
		if(spec_return)
			return spec_return
	var/obj/item/thrown_item
	if(isitem(AM))
		thrown_item = AM
		if(thrown_item.thrownby == WEAKREF(src)) //No throwing stuff at yourself to trigger hit reactions
			return ..()
	if(!throwingdatum.critical_hit && thrown_item)
		if(check_shields(thrown_item, thrown_item.throwforce, "\the [thrown_item]", BLOCK_FLAG_THROWN) & COMPONENT_HIT_REACTION_BLOCK)
			hitpush = FALSE
			skipcatch = TRUE
			blocked = TRUE
			if(thrown_item.durability)
				thrown_item.damageItem("MEDIUM")
		if(check_parry(thrown_item, thrown_item.throwforce, "\the [thrown_item]", BLOCK_FLAG_THROWN) & COMPONENT_HIT_REACTION_BLOCK)
			hitpush = FALSE
			skipcatch = TRUE
			blocked = TRUE
			if(thrown_item.durability)
				thrown_item.damageItem("MEDIUM")
		if(check_dodge(thrown_item, thrown_item.throwforce, "\the [thrown_item]", BLOCK_FLAG_THROWN) & COMPONENT_HIT_REACTION_BLOCK)
			hitpush = FALSE
			skipcatch = TRUE
			blocked = TRUE

	return ..()

/mob/living/carbon/human/bullet_act(obj/projectile/hitting_projectile, def_zone, piercing_hit = FALSE)
	//SPECIES STUFF
	if(dna?.species)
		var/spec_return = dna.species.bullet_act(hitting_projectile, src)
		if(spec_return)
			return spec_return

	//MARTIAL ART STUFF
	if(mind)
		if(mind.martial_art && mind.martial_art.can_use(src)) //Some martial arts users can deflect projectiles!
			var/martial_art_result = mind.martial_art.on_projectile_hit(src, hitting_projectile, def_zone)
			if(!(martial_art_result == BULLET_ACT_HIT))
				return martial_art_result

	//Can't shoot missing limbs or stumps
	var/obj/item/bodypart/affecting = get_bodypart_nostump(check_zone(def_zone))
	if(!affecting)
		return BULLET_ACT_FORCE_PIERCE

	//Can't block or reflect when shooting yourself
	if(!(hitting_projectile.original == src && hitting_projectile.firer == src))
		if(hitting_projectile.reflectable & REFLECT_NORMAL)
			if(check_reflect(def_zone)) // Checks if you've passed a reflection% check
				visible_message(span_danger("The [hitting_projectile.name] gets reflected by <b>[src]</b>!"), \
								span_userdanger("I deflect \the <b>[hitting_projectile.name]</b>!"))
				// Find a turf near or on the original location to bounce to
				if(!isturf(loc)) //Open canopy mech (ripley) check. if we're inside something and still got hit
					hitting_projectile.force_hit = TRUE //The thing we're in passed the bullet to us. Pass it back, and tell it to take the damage.
					loc.bullet_act(hitting_projectile, def_zone, piercing_hit)
					return BULLET_ACT_HIT
				if(hitting_projectile.starting)
					var/new_x = hitting_projectile.starting.x + pick(0, 0, 0, 0, 0, -1, 1, -2, 2)
					var/new_y = hitting_projectile.starting.y + pick(0, 0, 0, 0, 0, -1, 1, -2, 2)
					var/turf/curloc = get_turf(src)

					// redirect the projectile
					hitting_projectile.original = locate(new_x, new_y, hitting_projectile.z)
					hitting_projectile.starting = curloc
					hitting_projectile.firer = src
					hitting_projectile.yo = new_y - curloc.y
					hitting_projectile.xo = new_x - curloc.x
					var/new_angle_s = hitting_projectile.Angle + rand(120,240)
					while(new_angle_s > 180) // Translate to regular projectile degrees
						new_angle_s -= 360
					hitting_projectile.set_angle(new_angle_s)
				//Complete projectile permutation
				return BULLET_ACT_FORCE_PIERCE
		//Skill issue
		var/critical_hit = FALSE
		if(!QDELETED(hitting_projectile.firer) && ishuman(hitting_projectile.firer))
			var/mob/living/carbon/firer = hitting_projectile.firer
			var/obj/item/bodypart/bodypart_affected = get_bodypart(hitting_projectile.def_zone)
			var/hit_modifier = 0
			hit_modifier += bodypart_affected?.ranged_hit_modifier
			var/dist = get_dist(hitting_projectile.starting, src)
			var/skill_modifier = 0
			if(hitting_projectile.skill_ranged)
				skill_modifier += GET_MOB_SKILL_VALUE(firer, hitting_projectile.skill_ranged)
			var/modifier = 0
			modifier += hitting_projectile.diceroll_modifier
			if(LAZYACCESS(hitting_projectile.target_specific_diceroll, src))
				modifier += hitting_projectile.target_specific_diceroll[src]
			var/dist_modifier = 0
			//Point blank, very hard to miss
			if(dist <= 1)
				dist_modifier += 10
			if(firer.body_position == LYING_DOWN)
				dist_modifier += 5
			if(firer.combat_mode)
				dist_modifier += 5
/*
				if(body_position == STANDING_UP)
					if(stat != CONSCIOUS)
						return
					if(!combat_mode)
						return
					if(hitting_projectile.firer == src)
						return
					if(dodge_parry == DP_PARRY)
						var/dicerollll = src.diceroll(GET_MOB_ATTRIBUTE_VALUE(src, STAT_INTELLIGENCE), context = DICE_CONTEXT_MENTAL)
						if(dicerollll >= DICE_FAILURE)
							visible_message(span_pinkdang("[src] flips weapon of [hitting_projectile.firer] to [hitting_projectile.firer]!"))
							var/shot_foot = pick(BODY_ZONE_HEAD)
							process_fire(src, , FALSE, params, shot_foot)
*/
			//There is some distance between us
			else
				//Source for this calculation: I made it up
				dist_modifier -= FLOOR(max(0, dist-2) ** PROJECTILE_DICEROLL_DISTANCE_EXPONENT, 1)
			modifier = round_to_nearest(modifier, 1)
			var/diceroll = firer.diceroll((skill_modifier*PROJECTILE_DICEROLL_ATTRIBUTE_MULTIPLIER)+modifier+dist_modifier+hit_modifier, context = DICE_CONTEXT_PHYSICAL)
			if(diceroll <= DICE_FAILURE)
				return BULLET_ACT_FORCE_PIERCE
			else
				//critical projectile hits were too common, i had to change the maths here to be more reasonable
				dist_modifier = min(dist_modifier, 0)
				diceroll = firer.diceroll(skill_modifier+modifier+dist_modifier+hit_modifier)
				if(diceroll >= DICE_CRIT_SUCCESS)
					critical_hit = TRUE
//		if(critical_hit)
//			SEND_SIGNAL(src, COMSIG_CARBON_ADD_TO_WOUND_MESSAGE, span_bigdanger(" CRITICAL HIT!"))
		if(!critical_hit && (hitting_projectile.firer != src))
			if(check_shields(hitting_projectile, hitting_projectile.damage, "\the [hitting_projectile]", BLOCK_FLAG_PROJECTILE) & COMPONENT_HIT_REACTION_BLOCK)
				hitting_projectile.on_hit(src, 100, def_zone, piercing_hit)
//				if(hitting_projectile.durability)
//					hitting_projectile.damageItem("HARD")
				return BULLET_ACT_HIT
			if(check_parry(hitting_projectile, hitting_projectile.damage, "\the [hitting_projectile]", BLOCK_FLAG_PROJECTILE) & COMPONENT_HIT_REACTION_BLOCK)
				hitting_projectile.on_hit(src, 100, def_zone, piercing_hit)
//				if(hitting_projectile.durability)
//					hitting_projectile.damageItem("HARD")
				return BULLET_ACT_HIT
			if(check_dodge(hitting_projectile, hitting_projectile.damage, "\the [hitting_projectile]", BLOCK_FLAG_PROJECTILE) & COMPONENT_HIT_REACTION_BLOCK)
				hitting_projectile.on_hit(src, 100, def_zone, piercing_hit)
				return BULLET_ACT_HIT

	return ..()
