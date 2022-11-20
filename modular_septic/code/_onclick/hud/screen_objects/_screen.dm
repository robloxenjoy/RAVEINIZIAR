/atom/movable/screen
	layer = SCREEN_LAYER //above rack, below alerts and actions
	screentip_flags = SCREENTIP_ON_MOUSE_ENTERED|SCREENTIP_ON_MOUSE_CLICK

//also terrible
/atom/movable/screen/Click(location, control, params)
	if(flags_1 & INITIALIZED_1)
		SEND_SIGNAL(src, COMSIG_CLICK, location, control, params, usr)
	// Screentips
	if(screentip_flags & SCREENTIP_ON_MOUSE_CLICK)
		// This is VERY dumb
		addtimer(CALLBACK(src, .proc/update_screentip, usr, params, SCREENTIP_ON_MOUSE_CLICK), 1)

//terrible but it has to be done like this, i guess
/atom/movable/screen/examine_more(mob/user)
	SEND_SIGNAL(src, COMSIG_PARENT_EXAMINE_MORE, user, .)
	return list()

//would be very weird if examining a hud object showed up in chat...
/atom/movable/screen/on_examined_check()
	return FALSE
