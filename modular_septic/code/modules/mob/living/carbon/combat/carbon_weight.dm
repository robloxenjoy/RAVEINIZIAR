/mob/living/carbon/proc/get_basic_lift()
	if(!istype(attributes))
		//10 st = 10 kg basic lift
		return 10
	return round_to_nearest((GET_MOB_ATTRIBUTE_VALUE(src, STAT_STRENGTH)**2)/10, 1)

/mob/living/carbon/proc/update_maximum_carry_weight()
	maximum_carry_weight = get_basic_lift() * 10

/mob/living/carbon/proc/update_carry_weight()
	. = 0
	var/list/inventory_items = list(back, wear_mask, wear_neck, head, gloves, shoes, glasses, wrists)
	//we do need a typecheck here to avoid nulls
	for(var/obj/item/thing in inventory_items)
		. += thing.get_carry_weight()
	for(var/obj/item/thing in held_items)
		. += thing.get_carry_weight()
	carry_weight = .
	update_encumbrance()

/mob/living/carbon/proc/update_encumbrance()
	var/basic_lift = maximum_carry_weight/10
	if(carry_weight >= (basic_lift*10))
		encumbrance = ENCUMBRANCE_EXTREME
		add_or_update_variable_fatigue_modifier(/datum/fatigue_modifier/weight, TRUE, -50)
	else if(carry_weight >= (basic_lift*6))
		encumbrance = ENCUMBRANCE_HEAVY
		add_or_update_variable_fatigue_modifier(/datum/fatigue_modifier/weight, TRUE, -25)
	else if(carry_weight >= (basic_lift*3))
		encumbrance = ENCUMBRANCE_MEDIUM
		add_or_update_variable_fatigue_modifier(/datum/fatigue_modifier/weight, TRUE, 0)
	else if(carry_weight >= (basic_lift*2))
		encumbrance = ENCUMBRANCE_LIGHT
		add_or_update_variable_fatigue_modifier(/datum/fatigue_modifier/weight, TRUE, 0)
	else
		encumbrance = ENCUMBRANCE_NONE
		add_or_update_variable_movespeed_modifier(/datum/movespeed_modifier/carry_weight, TRUE, 0)
	update_encumbrance_movespeed_modifier()

/mob/living/carbon/proc/update_encumbrance_movespeed_modifier()
	switch(encumbrance)
		if(ENCUMBRANCE_EXTREME)
			add_or_update_variable_movespeed_modifier(/datum/movespeed_modifier/carry_weight, TRUE, get_basic_slowdown()*0.8)
		if(ENCUMBRANCE_HEAVY)
			add_or_update_variable_movespeed_modifier(/datum/movespeed_modifier/carry_weight, TRUE, get_basic_slowdown()*0.6)
		if(ENCUMBRANCE_MEDIUM)
			add_or_update_variable_movespeed_modifier(/datum/movespeed_modifier/carry_weight, TRUE, get_basic_slowdown()*0.4)
		if(ENCUMBRANCE_LIGHT)
			add_or_update_variable_movespeed_modifier(/datum/movespeed_modifier/carry_weight, TRUE, get_basic_slowdown()*0.2)
		if(ENCUMBRANCE_NONE)
			add_or_update_variable_movespeed_modifier(/datum/movespeed_modifier/carry_weight, TRUE, 0)

/mob/living/carbon/proc/encumbrance_text()
	switch(encumbrance)
		if(ENCUMBRANCE_EXTREME)
			return span_flashinguserdanger(span_big("EXTRA-HEAVY!!"))
		if(ENCUMBRANCE_HEAVY)
			return span_userdanger("Heavy!")
		if(ENCUMBRANCE_MEDIUM)
			return span_boldnotice("Medium.")
		if(ENCUMBRANCE_LIGHT)
			return span_notice("Light.")
		if(ENCUMBRANCE_NONE)
			return span_tinynotice("None.")
