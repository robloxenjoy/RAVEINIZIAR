/mob/living/carbon/proc/update_basic_speed_modifier()
	var/datum/movespeed_modifier/base_speed
	switch(m_intent)
		if(MOVE_INTENT_RUN)
			base_speed = get_cached_movespeed_modifier(/datum/movespeed_modifier/config_walk_run/run)
		if(MOVE_INTENT_WALK)
			base_speed = get_cached_movespeed_modifier(/datum/movespeed_modifier/config_walk_run/walk)
	var/final_modifier = get_basic_slowdown()-base_speed.multiplicative_slowdown
	add_or_update_variable_movespeed_modifier(/datum/movespeed_modifier/basic_speed, TRUE, final_modifier)
	update_encumbrance_movespeed_modifier()

// Unlike GURPS, we use a slowdown system rather than speed, thus this is higher the more incompetent your character is
/mob/living/carbon/proc/get_basic_slowdown(force_m_intent = null)
	var/datum/movespeed_modifier/base_speed
	var/final_m_intent = (force_m_intent ? force_m_intent : m_intent)
	switch(final_m_intent)
		if(MOVE_INTENT_RUN)
			base_speed = get_cached_movespeed_modifier(/datum/movespeed_modifier/config_walk_run/run)
		if(MOVE_INTENT_WALK)
			base_speed = get_cached_movespeed_modifier(/datum/movespeed_modifier/config_walk_run/walk)
	var/stance_efficiency = get_stance_efficiency()
	if(!istype(attributes))
		return base_speed.multiplicative_slowdown * LIMB_EFFICIENCY_OPTIMAL/max(20, stance_efficiency)
	var/dex = GET_MOB_ATTRIBUTE_VALUE(src, STAT_DEXTERITY)
	var/speed_modifier = (base_speed.multiplicative_slowdown/ATTRIBUTE_MIDDLING*(dex-ATTRIBUTE_MIDDLING))
	// We are faster than average, decrease the speed modifier
	if(speed_modifier >= 0)
		speed_modifier *= stance_efficiency/LIMB_EFFICIENCY_OPTIMAL
	// We are slower than average, increase the speed modifier
	else
		speed_modifier *= LIMB_EFFICIENCY_OPTIMAL/max(20, stance_efficiency)
	// This trait basically completely buttfucks basic
	if(HAS_TRAIT(src, TRAIT_BASIC_SPEED_HALVED))
		if(speed_modifier >= 0)
			speed_modifier *= 0.5
		else
			speed_modifier *= 2
	return max(base_speed.multiplicative_slowdown-speed_modifier, 0.25)

/mob/living/carbon/proc/get_stance_efficiency()
	var/stance_efficiency = 0
	for(var/thing in bodyparts)
		var/obj/item/bodypart/leg = thing
		if(leg.stance_index)
			stance_efficiency += leg.limb_efficiency/default_num_legs
	return stance_efficiency
