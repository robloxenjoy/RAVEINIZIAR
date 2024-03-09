/mob/living/carbon/throw_item(atom/target)
	. = ..()
	if(!target || !isturf(loc))
		return
	if(istype(target, /atom/movable/screen))
		return
	throw_mode_off(THROW_MODE_TOGGLE)

	var/atom/movable/thrown_thing

	var/obj/item/item = get_active_held_item()
	if(!item)
		if(pulling && isliving(pulling) && grab_state >= GRAB_AGGRESSIVE)
			var/mob/living/throwable_mob = pulling
			if(!throwable_mob.buckled)
				thrown_thing = throwable_mob
				stop_pulling()
				if(HAS_TRAIT(src, TRAIT_PACIFISM))
					to_chat(src, span_notice("I gently let go of <b>[throwable_mob]</b>."))
					return
	else
		thrown_thing = item.on_thrown(src, target)

	if(!thrown_thing)
		return

	if(isliving(thrown_thing))
		stop_pulling()
		var/turf/start_T = get_turf(loc) //Get the start and target tile for the descriptors
		var/turf/end_T = get_turf(target)
		if(start_T && end_T)
			log_combat(src, thrown_thing, "thrown", addition="grab from tile in [AREACOORD(start_T)] towards tile at [AREACOORD(end_T)]")
	var/power_throw = 0
	if(HAS_TRAIT(src, TRAIT_HULK))
		power_throw++
	if(HAS_TRAIT(src, TRAIT_DWARF))
		power_throw--
	if(HAS_TRAIT(thrown_thing, TRAIT_DWARF))
		power_throw++
	var/parsed_target = target.name
	if(get_dist(src, target) > world.view)
		var/angle = get_angle(src, target)
		var/turf/new_target = get_turf_in_angle(angle, get_turf(src), world.view)
		parsed_target = new_target.name
	if(ismob(thrown_thing))
		visible_message(span_danger("<b>[src]</b> кидает <b>[thrown_thing]</b> в [parsed_target][power_throw ? " жёстко!" : "."]"), \
						span_userdanger("Я кидаю <b>[thrown_thing]</b> в [parsed_target][power_throw ? " жёстко!" : "."]"), \
						ignored_mobs = thrown_thing)
		to_chat(thrown_thing, span_userdanger("<b>[src]</b> жёстко кидает меня!"))
	else
		visible_message(span_danger("<b>[src]</b> кидает [thrown_thing] в [parsed_target][power_throw ? " жёстко!" : "."]"), \
						span_userdanger("Я кидаю [thrown_thing] в [parsed_target][power_throw ? " жёстко!" : "."]"))
	log_message("был кинут [thrown_thing] в [parsed_target][power_throw ? " жёстко" : ""]", LOG_ATTACK)
	sound_hint()
//	src.changeNext_move(CLICK_CD_CLING)
	src.adjustFatigueLoss(5)
	newtonian_move(get_dir(target, src))
	var/final_throw_range = thrown_thing.throw_range
	if(isitem(thrown_thing) || ishuman(thrown_thing))
		var/weight_result = 0
		if(isitem(thrown_thing))
			var/obj/item/thrown_item = thrown_thing
			weight_result = thrown_item.get_carry_weight()
		else
			var/mob/living/carbon/human/thrown_human = thrown_thing
			//average weight of a human
			weight_result += HUMAN_WEIGHT
			weight_result += thrown_human.carry_weight
		var/weight_ratio = CEILING(weight_result/get_basic_lift(), 0.01)
		var/distance_modifier = 0
		//NICE FUCKING TABLE, GURPS!
		switch(weight_ratio)
			if(0 to 0.05)
				distance_modifier = 3.5
			if(0.06 to 0.1)
				distance_modifier = 2.5
			if(0.11 to 0.15)
				distance_modifier = 2
			if(0.16 to 0.2)
				distance_modifier = 1.5
			if(0.21 to 0.25)
				distance_modifier = 1.2
			if(0.26 to 0.3)
				distance_modifier = 1.1
			if(0.31 to 0.4)
				distance_modifier = 1
			if(0.41 to 0.5)
				distance_modifier = 0.8
			if(0.51 to 0.75)
				distance_modifier = 0.7
			if(0.76 to 1)
				distance_modifier = 0.6
			if(1.01 to 1.5)
				distance_modifier = 0.4
			if(1.51 to 2)
				distance_modifier = 0.3
			if(2.01 to 2.5)
				distance_modifier = 0.25
			if(2.51 to 3)
				distance_modifier = 0.2
			if(3.01 to 4)
				distance_modifier = 0.15
			if(4.01 to 5)
				distance_modifier = 0.12
			if(5.01 to 6)
				distance_modifier = 0.10
			if(6.01 to 7)
				distance_modifier = 0.09
			if(7.01 to 8)
				distance_modifier = 0.08
			if(8.01 to 9)
				distance_modifier = 0.07
			if(9.01 to 10)
				distance_modifier = 0.06
			if(10.01 to INFINITY)
				distance_modifier = 0.05
		var/final_throw_strength = GET_MOB_SKILL_VALUE(src, SKILL_THROWING)
		final_throw_range = round_to_nearest(distance_modifier * final_throw_strength, 1)
	thrown_thing.safe_throw_at(target, final_throw_range, thrown_thing.throw_speed + power_throw, src, force = move_force)
