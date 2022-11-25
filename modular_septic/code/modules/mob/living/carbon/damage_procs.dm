//Pain stuff
/mob/living/carbon/getPainLoss()
	var/amount = 0
	for(var/X in bodyparts)
		var/obj/item/bodypart/bodypart = X
		amount += bodypart.pain_dam * bodypart.pain_damage_coeff
	return amount

/mob/living/carbon/adjustPainLoss(amount, updating_health = TRUE, forced = FALSE, required_status = null)
	if(!forced && (status_flags & GODMODE))
		return FALSE
	var/old_amount = amount
	var/list/obj/item/bodypart/parts
	if(amount > 0)
		parts = get_painable_bodyparts()
	else
		parts = get_pained_bodyparts()
	var/update = FALSE
	while(parts.len && amount)
		var/obj/item/bodypart/picked = pick(parts)
		var/pain_per_part
		if(amount < 0)
			pain_per_part = FLOOR(amount/parts.len, DAMAGE_PRECISION)
		else
			pain_per_part = CEILING(amount/parts.len, DAMAGE_PRECISION)

		var/pain_was = picked.pain_dam
		if(amount < 0)
			update |= picked.remove_pain(abs(pain_per_part))
		else
			update |= picked.add_pain(abs(pain_per_part))

		if(pain_per_part < 0)
			pain_per_part = FLOOR(amount - (picked.pain_dam - pain_was), DAMAGE_PRECISION)
		else
			pain_per_part = CEILING(amount - (picked.pain_dam - pain_was), DAMAGE_PRECISION)

		parts -= picked
	if(updating_health)
		updatehealth()
	if(update)
		update_damage_overlays()
	return old_amount

/mob/living/carbon/setPainLoss(amount, updating_health = TRUE, forced = FALSE)
	var/current = getPainLoss()
	var/diff = amount - current
	if(!diff)
		return
	adjustPainLoss(diff, updating_health, forced)

/mob/living/carbon/apply_damage(damage, \
								damagetype = BRUTE, \
								def_zone = null, \
								blocked = FALSE, \
								forced = FALSE, \
								spread_damage = FALSE, \
								wound_bonus = 0, \
								bare_wound_bonus = 0, \
								sharpness = NONE, \
								organ_bonus = 0, \
								bare_organ_bonus = 0, \
								reduced = 0, \
								edge_protection = 0, \
								subarmor_flags = NONE, \
								attack_direction = null, \
								wound_messages = TRUE)
	SEND_SIGNAL(src, COMSIG_MOB_APPLY_DAMAGE, damage, \
											damagetype, \
											def_zone, \
											blocked, \
											forced, \
											spread_damage, \
											wound_bonus, \
											bare_wound_bonus, \
											sharpness, \
											organ_bonus, \
											bare_organ_bonus, \
											reduced, \
											edge_protection, \
											subarmor_flags, \
											attack_direction, \
											wound_messages)
	var/hit_percent = (100-blocked)/100
	if(!damage || (!forced && (hit_percent <= 0)) )
		return 0

	var/obj/item/bodypart/BP = null
	if(!spread_damage)
		if(isbodypart(def_zone)) //we specified a bodypart object
			BP = def_zone
		else
			if(!def_zone)
				if(length(bodyparts))
					BP = pick(bodyparts)
			else
				BP = get_bodypart(check_zone(def_zone))

	var/damage_amount = forced ? damage : max(0, (damage * hit_percent) - reduced)
	switch(damagetype)
		if(BRUTE)
			if(BP)
				if(BP.receive_damage(brute = damage, \
									wound_bonus = wound_bonus, \
									bare_wound_bonus = bare_wound_bonus, \
									sharpness = sharpness, \
									organ_bonus = organ_bonus, \
									bare_organ_bonus = bare_organ_bonus, \
									blocked = blocked, \
									reduced = reduced, \
									edge_protection = edge_protection, \
									subarmor_flags = subarmor_flags, \
									attack_direction = attack_direction, \
									wound_messages = wound_messages))
					update_damage_overlays()
			else //no bodypart, we deal damage with a more general method.
				adjustBruteLoss(damage_amount, forced = forced)
		if(BURN)
			if(BP)
				if(BP.receive_damage(burn = damage, \
									wound_bonus = wound_bonus, \
									bare_wound_bonus = bare_wound_bonus, \
									sharpness = sharpness, \
									organ_bonus = organ_bonus, \
									bare_organ_bonus = bare_organ_bonus, \
									blocked = blocked, \
									reduced = reduced, \
									edge_protection = edge_protection, \
									subarmor_flags = subarmor_flags, \
									attack_direction = attack_direction, \
									wound_messages = wound_messages))
					update_damage_overlays()
			else
				adjustFireLoss(damage_amount, forced = forced)
		if(TOX)
			adjustToxLoss(damage_amount, forced = forced)
		if(OXY)
			adjustOxyLoss(damage_amount, forced = forced)
		if(CLONE)
			adjustCloneLoss(damage_amount, forced = forced)
		if(STAMINA)
			if(BP)
				if(BP.receive_damage(stamina = damage, \
									wound_bonus = wound_bonus, \
									bare_wound_bonus = bare_wound_bonus, \
									sharpness = sharpness, \
									organ_bonus = organ_bonus, \
									bare_organ_bonus = bare_organ_bonus, \
									blocked = blocked, \
									reduced = reduced, \
									edge_protection = edge_protection, \
									subarmor_flags = subarmor_flags, \
									attack_direction = attack_direction, \
									wound_messages = wound_messages))
					update_damage_overlays()
			else
				adjustStaminaLoss(damage_amount, forced = forced)
		if(PAIN, SHOCK_PAIN)
			if(BP)
				BP.add_pain(damage_amount)
			else
				adjustPainLoss(damage_amount, forced = forced)
	return TRUE

/mob/living/carbon/getShock(painkiller_included = TRUE)
	if(!can_feel_pain())
		return 0

	var/shock = 0
	shock += SHOCK_MOD_CLONE * getCloneLoss()
	for(var/X in bodyparts)
		var/obj/item/bodypart/bodypart = X
		shock += bodypart.get_shock(FALSE, TRUE)

	if(painkiller_included)
		shock = max(0, shock - get_chem_effect(CE_PAINKILLER))

	return max(0, shock)

/mob/living/carbon/getToxLoss()
	. = 0
	if(HAS_TRAIT(src, TRAIT_TOXIMMUNE) || HAS_TRAIT(src, TRAIT_NOMETABOLISM))
		return
	var/list/livers = getorganslotlist(ORGAN_SLOT_LIVER)
	var/lacking_livers = max(1 - length(livers), 0)
	if(lacking_livers)
		. += LIVER_MAX_TOXIN * lacking_livers
	for(var/thing in livers)
		var/obj/item/organ/liver/liver = thing
		. += liver.get_toxins()

	var/list/kidneys = getorganslotlist(ORGAN_SLOT_KIDNEYS)
	var/lacking_kidneys = max(2 - length(kidneys), 0)
	if(lacking_kidneys)
		. += KIDNEY_MAX_TOXIN * lacking_kidneys
	for(var/thing in kidneys)
		var/obj/item/organ/kidneys/kidney = thing
		. += kidney.get_toxins()

/mob/living/carbon/adjustToxLoss(amount, updating_health = TRUE, forced = FALSE)
	. = 0
	if(!forced && (status_flags & GODMODE))
		return FALSE
	if(!forced && HAS_TRAIT(src, TRAIT_TOXINLOVER)) //damage becomes healing and healing becomes damage
		amount = -amount
		if(HAS_TRAIT(src, TRAIT_TOXIMMUNE)) //Prevents toxin damage, but not healing
			amount = min(amount, 0)
		if(amount > 0)
			adjust_bloodvolume(-5*amount)
		else
			adjust_bloodvolume(-amount)
	else if(HAS_TRAIT(src, TRAIT_TOXIMMUNE)) //Prevents toxin damage, but not healing
		amount = min(amount, 0)
	var/list/obj/item/organ/organs_to_affect = list()
	organs_to_affect |= getorganslotlist(ORGAN_SLOT_KIDNEYS)
	organs_to_affect |= getorganslotlist(ORGAN_SLOT_LIVER)
	organs_to_affect = shuffle(organs_to_affect)
	// still have healing or damage to give out? keep looping
	while(LAZYLEN(organs_to_affect) && amount)
		for(var/thing in organs_to_affect)
			var/obj/item/organ/organ = thing
			if(amount > 0)
				if(!organ.can_add_toxins())
					organs_to_affect -= organ
			else if(amount < 0)
				if(!organ.can_remove_toxins())
					organs_to_affect -= organ
		for(var/thing in organs_to_affect)
			var/obj/item/organ/organ = thing
			if(amount < 0)
				if(organ.can_remove_toxins())
					amount = round(amount - organ.remove_toxins(abs(amount)), DAMAGE_PRECISION)
			else if(amount > 0)
				if(organ.can_add_toxins())
					amount = round(amount - organ.add_toxins(abs(amount)), DAMAGE_PRECISION)
			else
				break
	//Fuck, no toxin damage... abort mission
	if(amount > 0)
		organs_to_affect = list()
		organs_to_affect |= getorganslotlist(ORGAN_SLOT_KIDNEYS)
		organs_to_affect = shuffle(organs_to_affect)
		amount *= 0.5
		while(LAZYLEN(organs_to_affect) && amount)
			for(var/thing in organs_to_affect)
				var/obj/item/organ/organ = thing
				if(organ.damage >= organ.maxHealth)
					organs_to_affect -= organ
			for(var/thing in organs_to_affect)
				if(!amount)
					break
				var/obj/item/organ/organ = thing
				organ.applyOrganDamage(amount)
				var/damage_diff = organ.damage - organ.prev_damage
				amount = max(0, round(amount - damage_diff, DAMAGE_PRECISION))
	if(updating_health)
		updatehealth()
		update_health_hud()

/mob/living/carbon/setToxLoss(amount, updating, forced)
	if(!needs_lungs() || (amount < 0))
		return
	var/delta = amount - getToxLoss()
	if(delta)
		adjustToxLoss(delta, updating, forced)

//Oxyloss stuff
/mob/living/carbon/getOxyLoss()
	. = 0
	if(!needs_lungs())
		return
	var/list/lungs = getorganslotlist(ORGAN_SLOT_LUNGS)
	var/lacking_lungs = max(2 - length(lungs), 0)
	if(lacking_lungs)
		. += LUNG_MAX_OXYLOSS * lacking_lungs
	for(var/obj/item/organ/lungs/lung as anything in lungs)
		. += lung.get_oxygen_deprivation()

/mob/living/carbon/adjustOxyLoss(amount, updating_health = TRUE, forced = FALSE)
	. = 0
	if(!forced && ((status_flags & GODMODE) || !needs_lungs()))
		return FALSE
	var/list/lungs_to_affect = list()
	lungs_to_affect |= getorganslotlist(ORGAN_SLOT_LUNGS)
	// still have healing or damage to give out? keep looping
	while(LAZYLEN(lungs_to_affect) && amount)
		var/futility_check_failed = TRUE
		for(var/thing in lungs_to_affect)
			var/obj/item/organ/lungs/lung = thing
			if(amount > 0)
				if(lung.can_oxy_deprive())
					futility_check_failed = FALSE
					break
			else if(amount < 0)
				if(lung.can_oxy_heal())
					futility_check_failed = FALSE
					break
		if(futility_check_failed)
			break
		for(var/thing in lungs_to_affect)
			var/obj/item/organ/lungs/lung = thing
			if(amount < 0)
				if(lung.can_oxy_heal())
					amount = round(amount - lung.remove_oxygen_deprivation(abs(amount)), DAMAGE_PRECISION)
			else if(amount > 0)
				if(lung.can_oxy_deprive())
					amount = round(amount - lung.add_oxygen_deprivation(abs(amount)), DAMAGE_PRECISION)
			else if(!amount)
				break
	if(getOxyLoss() > 50)
		ADD_TRAIT(src, TRAIT_KNOCKEDOUT, OXYLOSS_TRAIT)
	else
		REMOVE_TRAIT(src, TRAIT_KNOCKEDOUT, OXYLOSS_TRAIT)
	if(updating_health)
		updatehealth()
		update_health_hud()

/mob/living/carbon/setOxyLoss(amount, updating, forced)
	if(!needs_lungs() || (amount < 0))
		return
	var/delta = amount - getOxyLoss()
	if(delta)
		adjustOxyLoss(delta, updating, forced)

//Organ loss stuff
/mob/living/carbon/getOrganLoss(slot)
	. = 0
	var/list/organs = getorganslotlist(slot)
	for(var/thing in organs)
		var/obj/item/organ/organ = thing
		. += organ.damage

/mob/living/carbon/adjustOrganLoss(slot, amount, maximum)
	var/list/organs = getorganslotlist(slot)
	for(var/thing in organs)
		if(amount <= 0)
			break
		var/obj/item/organ/organ = thing
		organ.applyOrganDamage(amount)
		amount -= (organ.damage - organ.prev_damage)

/mob/living/carbon/setOrganLoss(slot, amount)
	var/list/organs = getorganslotlist(slot)
	var/num_organs = length(organs)
	for(var/thing in organs)
		var/obj/item/organ/organ = thing
		organ.setOrganDamage(amount/num_organs)
