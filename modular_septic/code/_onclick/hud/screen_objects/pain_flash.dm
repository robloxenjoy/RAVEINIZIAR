//Pain flashy
/atom/movable/screen/fullscreen/pain_flash
	name = "pain flash"
	icon = 'modular_septic/icons/hud/screen_gen.dmi'
	icon_state = "blank"
	screen_loc = "WEST,SOUTH to EAST,NORTH"
	plane = FULLSCREEN_PLANE
	layer = PAIN_FLASH_LAYER
	mouse_opacity = MOUSE_OPACITY_TRANSPARENT
	show_when_dead = FALSE

/atom/movable/screen/fullscreen/pain_flash/update_for_view(client_view)
	screen_loc = "WEST,SOUTH to EAST,NORTH"
	update_appearance()
