/** BURNS **/
/datum/injury/burn
	damage_type = WOUND_BURN
	autoheal_cutoff = 3
	max_bleeding_stage = 0
	infection_rate = 2.5

/datum/injury/burn/infection_check()
	//anything less than a FUCK burn isn't infectable if treated properly
	if(is_treated() && damage < 25)
		return FALSE
	if(is_disinfected())
		return FALSE
	//Robotic injury
	if(required_status == BODYPART_ROBOTIC)
		return FALSE

	switch(damage_type)
		if(WOUND_BLUNT)
			return prob(damage/2)
		if(WOUND_BURN)
			return prob(damage*2)
		if(WOUND_SLASH)
			return prob(damage)
		if(WOUND_PIERCE)
			return prob(damage*1.25)

	return FALSE

/datum/injury/burn/is_bleeding()
	return FALSE //burns cannot bleed

/datum/injury/burn/apply_injury(our_damage, obj/item/bodypart/limb)
	. = ..()
	//Burn damage can cause fluid loss due to blistering and cook-off
	if(limb.owner && (damage_per_injury() >= 5 || damage + limb.burn_dam >= 20))
		limb.owner.adjust_bloodvolume(-CEILING(BLOOD_VOLUME_SURVIVE * damage/100, 1))

/datum/injury/burn/receive_damage(damage_received = 0, pain_received = 0, wounding_type = WOUND_BLUNT)
	. = ..()
	if((wounding_type == WOUND_BURN) && (damage + damage_received >= 50) && parent_bodypart)
		if(!parent_bodypart.is_dead())
			if(parent_bodypart.is_organic_limb())
				if(parent_mob)
					SEND_SIGNAL(parent_mob, COMSIG_CARBON_ADD_TO_WOUND_MESSAGE, span_bolddanger(" [span_big("The [parent_bodypart.name] partially melts away!")]"))
				parent_bodypart.kill_limb()
			else
				if(parent_bodypart.can_dismember())
					if(parent_mob)
						SEND_SIGNAL(parent_mob, COMSIG_CARBON_ADD_TO_WOUND_MESSAGE, span_bolddanger(" [span_big("The [parent_bodypart.name] fully melts away!")]"))
					parent_bodypart.apply_dismember(WOUND_BURN, TRUE, FALSE)
		else if(parent_bodypart.can_dismember())
			if(parent_mob)
				if(parent_bodypart.is_organic_limb())
					SEND_SIGNAL(parent_mob, COMSIG_CARBON_ADD_TO_WOUND_MESSAGE, span_bolddanger(" [span_big("The [parent_bodypart.name] fully melts away!")]"))
				else
					SEND_SIGNAL(parent_mob, COMSIG_CARBON_ADD_TO_WOUND_MESSAGE, span_bolddanger(" [span_big("The [parent_bodypart.name] fully melts away!")]"))
			parent_bodypart.apply_dismember(WOUND_BURN, TRUE, FALSE)

/datum/injury/burn/moderate
	stages = list(
		"serious burn" = 10,
		"burn" = 5,
		"not big burn" = 2,
		"redness" = 0
		)

/datum/injury/burn/large
	stages = list(
		"big serious burn" = 20,
		"big burn" = 15,
		"burn" = 5,
		"not big burn" = 0
		)
	fade_away_time = INFINITY

/datum/injury/burn/severe
	stages = list(
		"big damaged burn" = 35,
		"damaged burn" = 30,
		"serious burn" = 10,
		"redness" = 0
		)
	fade_away_time = INFINITY

/datum/injury/burn/deep
	stages = list(
		"deep damaged burn" = 45,
		"deep burn" = 40,
		"big damaged burn" = 15,
		"big burn" = 0
		)
	fade_away_time = INFINITY

/datum/injury/burn/carbonised
	stages = list(
		"deep charred zone" = 50,
		"charred zone" = 20,
		"tiny charred zone" = 0
		)
	fade_away_time = INFINITY
