// Update the screentip to reflect what we're hovering over
/atom
	var/screentip_flags = DEFAULT_SCREENTIP_FLAGS

/atom/Click(location, control, params)
	. = ..()
	// Screentips
	if((screentip_flags & SCREENTIP_ON_MOUSE_CLICK) && (usr.hud_used?.screentips_enabled))
		// This is VERY dumb
		addtimer(CALLBACK(src, .proc/update_screentip, usr, params, SCREENTIP_ON_MOUSE_CLICK), 1)

/atom/MouseEntered(location, control, params)
	. = ..()
	// Screentips
	if((screentip_flags & SCREENTIP_ON_MOUSE_ENTERED) && (usr.hud_used?.screentips_enabled))
		update_screentip(usr, params, SCREENTIP_ON_MOUSE_ENTERED)

/atom/MouseMove(location, control, params)
	. = ..()
	// Screentips
	if((screentip_flags & SCREENTIP_ON_MOUSE_MOVE) && (usr.hud_used?.screentips_enabled))
		update_screentip(usr, params, SCREENTIP_ON_MOUSE_MOVE)

/atom/proc/return_screentip(mob/user, params)
	if(flags_1 & NO_SCREENTIPS_1)
		return ""
	return SCREENTIP_OBJ(uppertext(name))

/atom/proc/update_screentip(mob/user, params, mode = DEFAULT_SCREENTIP_FLAGS)
	user?.hud_used?.screentip_text?.maptext = return_screentip(user, params)
