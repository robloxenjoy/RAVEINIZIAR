/mob/proc/look_into_distance(atom/A, params)
	if(!client)
		to_chat(src, span_warning("[fail_msg(TRUE)] Я не могу это сделать."))
		return
	if(HAS_TRAIT_FROM(src, TRAIT_LOOKING_INTO_DISTANCE, VERB_TRAIT))
		unperform_zoom(A, params)
		to_chat(src, span_notice("Я перестаю смотреть вдаль."))
	else if((A in fov_view(world.view, src)) && (get_dist(src, A) <= world.view))
		perform_zoom(A, params)
		to_chat(src, span_notice("Я смотрю вдаль."))

/mob/proc/perform_zoom(atom/A, params, silent = FALSE)
	if(!client)
		return
	ADD_TRAIT(src, TRAIT_LOOKING_INTO_DISTANCE, VERB_TRAIT)
	SEND_SIGNAL(src, COMSIG_FIXEYE_UNLOCK)
	SEND_SIGNAL(src, COMSIG_FIXEYE_ENABLE, TRUE, TRUE)
	SEND_SIGNAL(src, COMSIG_FIXEYE_LOCK)
	RegisterSignal(src, COMSIG_MOB_LOGOUT, PROC_REF(kill_zoom), override = TRUE)
/*
	var/distance = min(get_dist(src, A), 11)
	var/direction = get_dir(src, A)
	var/x_offset = 0
	var/y_offset = 0
*/
	var/_x = A.x-loc.x
	var/_y = A.y-loc.y
	if(_x > 7 || _x < -7)
		return
	if(_y > 7 || _y < -7)
		return
/*
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
*/
	animate(client, pixel_x = world.icon_size*_x, pixel_y = world.icon_size*_y, 1 SECONDS)
	hud_used?.fov_holder?.screen_loc = "WEST+4:[-x_offset],SOUTH+1:[-y_offset]"
	if(!silent)
		playsound_local(src, 'modular_septic/sound/interface/zoom_in.ogg', 25, FALSE, pressure_affected = FALSE)

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
		playsound_local(src, 'modular_septic/sound/interface/zoom_out.ogg', 25, FALSE, pressure_affected = FALSE)

/mob/proc/kill_zoom(mob/living/source)
	SIGNAL_HANDLER

	INVOKE_ASYNC(src, PROC_REF(unperform_zoom))
