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
		visible_message(span_danger("<b>[src]</b> throws <b>[thrown_thing]</b> at [parsed_target][power_throw ? " really hard!" : "."]"), \
						span_userdanger("I throw <b>[thrown_thing]</b> at [parsed_target][power_throw ? " really hard!" : "."]"), \
						ignored_mobs = thrown_thing)
		to_chat(thrown_thing, span_userdanger("<b>[src]</b> throws me really hard!"))
	else
		visible_message(span_danger("<b>[src]</b> throws [thrown_thing] at [parsed_target][power_throw ? " really hard!" : "."]"), \
						span_userdanger("I throw [thrown_thing] at [parsed_target][power_throw ? " really hard!" : "."]"))
	log_message("has thrown [thrown_thing] at [parsed_target][power_throw ? " really hard" : ""]", LOG_ATTACK)
	sound_hint()
	newtonian_move(get_dir(target, src))
	var/final_throw_range = thrown_thing.throw_range
	thrown_thing.safe_throw_at(target, final_throw_range, thrown_thing.throw_speed + power_throw, src, force = move_force)
