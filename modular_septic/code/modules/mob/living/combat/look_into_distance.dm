/mob/proc/look_into_distance(atom/A, params)
	if(!client)
		to_chat(src, span_warning("[fail_msg(TRUE)] I can't do that."))
		return
	if(HAS_TRAIT_FROM(src, TRAIT_LOOKING_INTO_DISTANCE, VERB_TRAIT))
		unperform_zoom(A, params)
		to_chat(src, span_notice("I stop looking into the distance."))
	else if((A in fov_view(world.view, src)) && (get_dist(src, A) <= world.view))
		perform_zoom(A, params)
		to_chat(src, span_notice("I start looking into the distance."))

/mob/proc/perform_zoom(atom/A, params, silent = FALSE)
	if(!client)
		return
	ADD_TRAIT(src, TRAIT_LOOKING_INTO_DISTANCE, VERB_TRAIT)
	SEND_SIGNAL(src, COMSIG_FIXEYE_UNLOCK)
	SEND_SIGNAL(src, COMSIG_FIXEYE_ENABLE, TRUE, TRUE)
	SEND_SIGNAL(src, COMSIG_FIXEYE_LOCK)
	RegisterSignal(src, COMSIG_MOB_LOGOUT, .proc/kill_zoom, override = TRUE)
	var/distance = min(get_dist(src, A), 7)
	var/direction = get_dir(src, A)
	var/x_offset = 0
	var/y_offset = 0
	if(direction & NORTH)
		y_offset = distance*world.icon_size
	if(direction & SOUTH)
		y_offset = -distance*world.icon_size
	if(direction & EAST)
		x_offset = distance*world.icon_size
	if(direction & WEST)
		x_offset = -distance*world.icon_size
	client.pixel_x += x_offset
	client.pixel_y += y_offset
	hud_used?.fov_holder?.screen_loc = "WEST+4:[-x_offset],SOUTH+1:[-y_offset]"
	if(!silent)
		playsound_local(src, 'modular_septic/sound/interface/zoom_in.wav', 25, FALSE, pressure_affected = FALSE)

/mob/proc/unperform_zoom(atom/A, params, silent = FALSE)
	REMOVE_TRAIT(src, TRAIT_LOOKING_INTO_DISTANCE, VERB_TRAIT)
	SEND_SIGNAL(src, COMSIG_FIXEYE_UNLOCK)
	SEND_SIGNAL(src, COMSIG_FIXEYE_DISABLE, TRUE, TRUE)
	UnregisterSignal(src, COMSIG_MOB_LOGOUT)
	if(client)
		client.pixel_x = initial(client.pixel_x)
		client.pixel_y = initial(client.pixel_y)
	hud_used?.fov_holder?.screen_loc = ui_fov
	if(!silent)
		playsound_local(src, 'modular_septic/sound/interface/zoom_out.wav', 25, FALSE, pressure_affected = FALSE)

/mob/proc/kill_zoom(mob/living/source)
	SIGNAL_HANDLER

	INVOKE_ASYNC(src, .proc/unperform_zoom)
