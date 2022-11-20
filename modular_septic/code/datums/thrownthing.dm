/datum/thrownthing
	var/critical_hit = FALSE

/datum/thrownthing/tick()
	var/atom/movable/AM = thrownthing
	if(!isturf(AM.loc) || !AM.throwing)
		finalize()
		return

	if(paused)
		delayed_time += world.time - last_move
		return

	var/atom/movable/actual_target = initial_target?.resolve()

	var/obj/item/thrown_item
	if(isitem(AM))
		thrown_item = AM
	var/mob/living/carbon/human/human_thrower
	if(ishuman(human_thrower))
		human_thrower = thrower
	var/mob/living/carbon/human/human_target
	if(ishuman(human_target))
		human_target = actual_target

	if(dist_travelled) //to catch sneaky things moving on our tile while we slept
		for(var/atom/movable/obstacle as anything in get_turf(thrownthing))
			if(obstacle == thrownthing || (obstacle == thrower && !ismob(thrownthing)))
				continue
			if(obstacle.pass_flags_self & LETPASSTHROW)
				continue
			var/diceroll_success = DICE_SUCCESS
			if(thrown_item && human_target && human_thrower)
				diceroll_success = human_thrower.diceroll(GET_MOB_SKILL_VALUE(human_thrower, SKILL_THROWING), context = DICE_CONTEXT_PHYSICAL)
			if((obstacle == actual_target) || (obstacle.density && !(obstacle.flags_1 & ON_BORDER_1)) && (diceroll_success >= DICE_SUCCESS))
				finalize(TRUE, obstacle)
				return

	var/atom/step

	last_move = world.time

	//calculate how many tiles to move, making up for any missed ticks.
	var/tilestomove = CEILING(min(((((world.time+world.tick_lag) - start_time + delayed_time) * speed) - (dist_travelled ? dist_travelled : -1)), speed*MAX_TICKS_TO_MAKE_UP) * (world.tick_lag * SSthrowing.wait), 1)
	while(tilestomove-- > 0)
		if((dist_travelled >= maxrange || AM.loc == target_turf) && AM.has_gravity(AM.loc))
			finalize()
			return

		if(dist_travelled <= max(dist_x, dist_y)) //if we haven't reached the target yet we home in on it, otherwise we use the initial direction
			step = get_step(AM, get_dir(AM, target_turf))
		else
			step = get_step(AM, init_dir)

		if(!pure_diagonal && !diagonals_first) // not a purely diagonal trajectory and we don't want all diagonal moves to be done first
			if(diagonal_error >= 0 && max(dist_x,dist_y) - dist_travelled != 1) //we do a step forward unless we're right before the target
				step = get_step(AM, dx)
			diagonal_error += (diagonal_error < 0) ? dist_x/2 : -dist_y

		if(!step) // going off the edge of the map makes get_step return null, don't let things go off the edge
			finalize()
			return

		if(!AM.Move(step, get_dir(AM, step), DELAY_TO_GLIDE_SIZE(1 / speed))) // we hit something during our move...
			if(AM.throwing) // ...but finalize() wasn't called on Bump() because of a higher level definition that doesn't always call parent.
				finalize()
			return

		dist_travelled++

		if(actual_target && !(actual_target.pass_flags_self & LETPASSTHROW) && (actual_target.loc == AM.loc)) // we crossed a movable with no density (e.g. a mouse or APC) we intend to hit anyway.
			var/diceroll_success = DICE_SUCCESS
			if(thrown_item && human_target && human_thrower)
				diceroll_success = human_thrower.diceroll(GET_MOB_SKILL_VALUE(human_thrower, SKILL_THROWING), context = DICE_CONTEXT_PHYSICAL)
			if(diceroll_success >= DICE_SUCCESS)
				if(diceroll_success >= DICE_CRIT_SUCCESS)
					critical_hit = TRUE
				finalize(TRUE, actual_target)
				return

		if(dist_travelled > MAX_THROWING_DIST)
			finalize()
			return
