/atom/movable/screen/fullscreen
	icon = 'modular_septic/icons/hud/screen_full.dmi'
	screen_loc = ui_fullscreen

/atom/movable/screen/fullscreen/update_for_view(client_view)
	if(((screen_loc == "CENTER-7,CENTER-7") || (screen_loc == ui_fullscreen)) && (view != client_view))
		var/list/actualview = getviewsize(client_view)
		view = client_view
		if(client_view=="22x16")
			transform = matrix(23/FULLSCREEN_OVERLAY_RESOLUTION_X, 0, 0, 0, 15/FULLSCREEN_OVERLAY_RESOLUTION_Y, 0)
		else
			transform = matrix(actualview[1]/FULLSCREEN_OVERLAY_RESOLUTION_X, 0, 0, 0, actualview[2]/FULLSCREEN_OVERLAY_RESOLUTION_Y, 0)
