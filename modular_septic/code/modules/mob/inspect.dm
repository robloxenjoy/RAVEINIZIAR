/mob/proc/inspect_front()
	if(!client || !COOLDOWN_FINISHED(src, next_move))
		return
	var/turf/infrontofus = get_step(src, dir)
	if(!infrontofus)
		return
	var/turf_to_us_dir = get_dir(infrontofus, src)
	var/atom/ghost_image_source = infrontofus
	for(var/atom/maybe_ghost in infrontofus)
		if(!maybe_ghost.inspect_icon_state || (maybe_ghost.invisibility > see_invisible) || maybe_ghost.CanPass(src, turf_to_us_dir))
			continue
		ghost_image_source = maybe_ghost
	/// how long it takes for the blind person to find the thing they're examining
	var/inspect_delay_length = 0.1 SECONDS
	if(client.recent_examines && client.recent_examines[ref(ghost_image_source)]) //easier to find things we just touched
		inspect_delay_length *= 0.5
	else if(isobj(ghost_image_source))
		inspect_delay_length *= 1.5
	else if(ismob(ghost_image_source) && (ghost_image_source != src))
		inspect_delay_length *= 2
	if(!do_after(src, inspect_delay_length, target = ghost_image_source))
		to_chat(src, span_warning("I can't get a good feel for whatever is there."))
		return FALSE
	return inspect_atom(ghost_image_source)

/mob/proc/inspect_atom(atom/inspected)
	if(!client || !inspected.inspect_icon_state || !COOLDOWN_FINISHED(src, next_move))
		return
	var/ghost_icon_state = inspected.inspect_icon_state
	if(isopenspaceturf(inspected))
		ghost_icon_state = "openspace"
	else if(isfloorturf(inspected))
		ghost_icon_state = "floor[rand(1, 11)]"
	else if(iswallturf(inspected))
		ghost_icon_state = "wall[rand(1, 2)]"
	var/image/ghost_image = image('modular_septic/icons/effects/blind.dmi', get_turf(inspected), ghost_icon_state)
	ghost_image.plane = SOUND_HINT_PLANE
	ghost_image.layer = INSPECTION_IMAGE_LAYER
	animate(ghost_image, alpha = 0, time = inspected.inspect_duration)
	client.images |= ghost_image
	addtimer(CALLBACK(src, .proc/remove_ghost_image, ghost_image), inspect_duration)
	changeNext_move(CLICK_CD_INSPECT)

/mob/proc/remove_ghost_image(image/ghost_image)
	client?.images -= ghost_image
