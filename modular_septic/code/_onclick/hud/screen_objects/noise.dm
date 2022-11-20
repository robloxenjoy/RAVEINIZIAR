//Noise holder
/atom/movable/screen/fullscreen/noise
	icon = 'modular_septic/icons/hud/noise.dmi'
	icon_state = "blank"
	screen_loc = "WEST,SOUTH to EAST,NORTH"
	plane = NOISE_PLANE
	layer = NOISE_LAYER
	mouse_opacity = MOUSE_OPACITY_TRANSPARENT
	show_when_dead = TRUE
	var/poggers = 1
	var/loggers = "j"

/atom/movable/screen/fullscreen/noise/update_for_view(client_view)
	screen_loc = "WEST,SOUTH to EAST,NORTH"
	poggers = rand(1,9)
	update_appearance()

/atom/movable/screen/fullscreen/noise/update_icon_state()
	. = ..()
	icon_state = "[poggers][loggers]"
