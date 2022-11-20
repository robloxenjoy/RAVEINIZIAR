// Nice examine stuff
/obj/item/examine_chaser(mob/user)
	. = list()
	var/p_They = p_they(TRUE)
	var/p_they = p_they()
	var/p_Theyre = p_theyre(TRUE)
	var/p_are = p_are()
	var/p_s = p_s()

	switch(germ_level)
		if(0 to GERM_LEVEL_DIRTY)
			. += "[p_They] [p_are] is clean."
		if(GERM_LEVEL_DIRTY to GERM_LEVEL_FILTHY)
			. += "[p_They] [p_are] a bit dirty."
		if(GERM_LEVEL_FILTHY to GERM_LEVEL_SMASHPLAYER)
			. += span_warning("[p_They] [p_are] filthy.")
		if(GERM_LEVEL_SMASHPLAYER to INFINITY)
			. += span_warning("[p_They] [p_are] <b>foul</b>.")

	var/weight_text = weight_class_to_text(w_class)
	. += "[p_Theyre] [prefix_a_or_an(weight_text)] [weight_text] item."
	if(isobserver(user))
		. += "[p_They] weigh[p_s] exactly <b>[get_carry_weight()]kg</b>."
	else if(user.is_holding(src))
		. += "[p_They] weigh[p_s] around <b>[round_to_nearest(get_carry_weight(), 1)]kg</b>."

	if(resistance_flags & INDESTRUCTIBLE)
		. += "[p_They] seem[p_s] extremely robust! It'll probably withstand anything that could happen to it!"
	else
		if(resistance_flags & LAVA_PROOF)
			. += "[p_They] [p_are] made of an extremely heat-resistant material, [p_they] would probably be able to withstand lava!"
		if(resistance_flags & (ACID_PROOF | UNACIDABLE))
			. += "[p_They] look[p_s] pretty robust! [p_they] would probably be able to withstand acid!"
		if(resistance_flags & FREEZE_PROOF)
			. += "[p_They] [p_are] made of cold-resistant materials."
		if(resistance_flags & FIRE_PROOF)
			. += "[p_They] [p_are] made of fire-retardant materials."

	. += ..()
