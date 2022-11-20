/// Move a mob between z levels, if it's valid to move z's on this turf
/mob/zMove(dir, feedback = FALSE, ventcrawling = FALSE)
	if(dir != UP && dir != DOWN)
		return FALSE
	if(incapacitated())
		if(feedback)
			to_chat(src, span_warning("I can't do that right now!"))
		return FALSE
	var/turf/target = get_step_multiz(src, dir)
	if(!istype(target))
		if(feedback)
			to_chat(src, span_warning("There's nowhere to go in that direction!"))
		return FALSE
	if(!canZMove(dir, target) && !ventcrawling)
		if(feedback)
			to_chat(src, span_warning("I can't move there!"))
		return FALSE
	if(!ventcrawling) //let this be handled in atmosmachinery.dm
		forceMove(target)
	else
		var/obj/machinery/atmospherics/pipe = loc
		pipe.relaymove(src, dir)
	return TRUE

/// Moves a mob upwards in z level
/mob/verb/up()
	set name = "Move Upwards"
	set category = "IC.ZTravel"

	if(HAS_TRAIT_FROM(src, TRAIT_MOVE_FLOATING, CLINGING_TRAIT))
		to_chat(src, span_warning("Can't do that while climbing."))
		return

	var/turf/current_turf = get_turf(src)
	var/turf/above_turf = SSmapping.get_turf_above(current_turf)
	var/ventcrawling_mob = HAS_TRAIT(src, TRAIT_MOVE_VENTCRAWLING)

	if(above_turf && !ventcrawling_mob && (can_zFall(above_turf, 1, current_turf, DOWN) && (above_turf.can_zFall(src, 1, current_turf))))
		to_chat(src, span_warning("I can't. I will fall back down."))
		return

	if(zMove(UP, TRUE, ventcrawling_mob))
		to_chat(src, span_notice("I move upwards."))

/// Moves a mob down a z level
/mob/verb/down()
	set name = "Move Downwards"
	set category = "IC.ZTravel"

	if(HAS_TRAIT_FROM(src, TRAIT_MOVE_FLOATING, CLINGING_TRAIT))
		to_chat(src, span_warning("Can't do that while climbing."))
		return

	var/ventcrawling_mob = HAS_TRAIT(src, TRAIT_MOVE_VENTCRAWLING)

	if(zMove(DOWN, TRUE, ventcrawling_mob))
		to_chat(src, span_notice("I move downwards."))
