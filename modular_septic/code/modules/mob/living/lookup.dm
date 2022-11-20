/// Hides FoV when perspective is changed
/mob/living/reset_perspective(atom/A)
	. = ..()
	if(client?.perspective != MOB_PERSPECTIVE)
		SEND_SIGNAL(src, COMSIG_FOV_HIDE)
	else
		SEND_SIGNAL(src, COMSIG_FOV_SHOW)

/// Checks if the user is incapacitated or on cooldown.
/mob/living/can_look_up()
	return !(incapacitated(ignore_restraints = TRUE) || HAS_TRAIT(src, TRAIT_LOOKING_INTO_DISTANCE))

/mob/living/look_up()
	if(client.perspective != MOB_PERSPECTIVE) //We are already looking up or down
		var/turf/eye = client.eye
		if(istype(eye) && (eye.z < src.z))
			end_look_down(FALSE)
		else
			end_look_up(FALSE)
		return
	if(!can_look_up())
		return
	changeNext_move(CLICK_CD_LOOK_UP)
	RegisterSignal(src, COMSIG_MOVABLE_PRE_MOVE, .proc/stop_look_up, TRUE) //We stop looking up if we move
	RegisterSignal(src, COMSIG_MOVABLE_MOVED, .proc/start_look_up, TRUE) //We start looking again after we move
	start_look_up(FALSE)

/mob/living/start_look_up(silent = TRUE)
	var/turf/ceiling = get_step_multiz(src, UP)
	if(!istype(ceiling)) //We are at the highest z-level
		if(!silent)
			to_chat(src, span_warning("I can't see through the ceiling above me."))
		end_look_up(TRUE)
		return
	else if(!istransparentturf(ceiling)) //There is no turf we can look through above us
		var/turf/front_hole = get_step(ceiling, dir)
		if(istransparentturf(front_hole))
			ceiling = front_hole
		else
			var/list/checkturfs = block(locate(x-1,y-1,ceiling.z),locate(x+1,y+1,ceiling.z))-ceiling-front_hole //Try find hole near of us
			for(var/turf/checkhole in checkturfs)
				if(istransparentturf(checkhole))
					ceiling = checkhole
					break
		if(!istransparentturf(ceiling))
			if(!silent)
				to_chat(src, span_warning("I can't see through \the [ceiling] above me."))
			return
	if(!silent)
		to_chat(src, span_notice("I start looking up."))
	reset_perspective(ceiling)
	hud_used?.lookup?.name = "stop looking up"

/mob/living/stop_look_up()
	reset_perspective()
	hud_used?.lookup?.name = "look up"

/mob/living/end_look_up(silent = TRUE)
	stop_look_up()
	UnregisterSignal(src, COMSIG_MOVABLE_PRE_MOVE)
	UnregisterSignal(src, COMSIG_MOVABLE_MOVED)
	if(!silent)
		to_chat(src, span_notice("I stop looking up."))

/mob/living/look_down()
	if(client.perspective != MOB_PERSPECTIVE) //We are already looking up or down
		if(hud_used?.lookup.name == "stop looking up")
			end_look_down(FALSE)
		else
			end_look_up(FALSE)
		return
	if(!can_look_up()) //if we cant look up, we cant look down.
		return
	changeNext_move(CLICK_CD_LOOK_UP)
	RegisterSignal(src, COMSIG_MOVABLE_PRE_MOVE, .proc/stop_look_down, TRUE) //We stop looking down if we move.
	RegisterSignal(src, COMSIG_MOVABLE_MOVED, .proc/start_look_down, TRUE) //We start looking again after we move.
	start_look_down()

/mob/living/start_look_down(silent = TRUE)
	var/turf/floor = get_turf(src)
	var/turf/lower_level = get_step_multiz(src, DOWN)
	if(!lower_level) //We are at the lowest z-level.
		if(!silent)
			to_chat(src, span_warning("I can't see through the floor below me."))
		end_look_down(TRUE)
		return
	else if(!istransparentturf(floor)) //There is no turf we can look through below us
		var/turf/front_hole = get_step(floor, dir)
		if(istransparentturf(front_hole))
			floor = front_hole
			lower_level = get_step_multiz(front_hole, DOWN)
		else
			var/list/checkturfs = block(locate(x-1,y-1,z),locate(x+1,y+1,z))-floor //Try find hole near of us
			for(var/turf/checkhole in checkturfs)
				if(istransparentturf(checkhole))
					floor = checkhole
					lower_level = get_step_multiz(checkhole, DOWN)
					break
		if(!istransparentturf(floor))
			if(!silent)
				to_chat(src, span_warning("I can't see through \the [floor] below me."))
			return
	if(!silent)
		to_chat(src, span_notice("I start looking down."))
	reset_perspective(lower_level)
	hud_used?.lookup?.name = "stop looking down"

/mob/living/stop_look_down()
	reset_perspective()
	hud_used?.lookup?.name = "look up"

/mob/living/end_look_down(silent = TRUE)
	stop_look_down()
	UnregisterSignal(src, COMSIG_MOVABLE_PRE_MOVE)
	UnregisterSignal(src, COMSIG_MOVABLE_MOVED)
	if(!silent)
		to_chat(src, span_notice("I stop looking down."))
