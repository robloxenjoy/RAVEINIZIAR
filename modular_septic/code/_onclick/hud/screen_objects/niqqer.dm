//Fraggots
/atom/movable/screen/fullscreen/niqqer
	name = "NIQQER"
	icon = 'modular_septic/icons/hud/screen_chungus.dmi'
	icon_state = "niqqer"
	screen_loc = "WEST,SOUTH to EAST,NORTH"
	mouse_opacity = MOUSE_OPACITY_TRANSPARENT

/atom/movable/screen/fullscreen/niqqer/Initialize(mapload)
	. = ..()
	animate(src, alpha = 255, time = 0, loop = -1, flags = ANIMATION_PARALLEL)
	animate(src, alpha = 64, time = 1 SECONDS)

/atom/movable/screen/fullscreen/niqqer/update_for_view(client_view)
	screen_loc = "WEST,SOUTH to EAST,NORTH"
	update_appearance()

//Crazy mushroom
/atom/movable/screen/fullscreen/fuuuck
	name = "Oh fuck!"
	icon = 'modular_septic/icons/hud/screen_chungus.dmi'
	icon_state = "fuuuck"
	screen_loc = "WEST,SOUTH to EAST,NORTH"
	mouse_opacity = MOUSE_OPACITY_TRANSPARENT

/atom/movable/screen/fullscreen/fuuuck/Initialize(mapload)
	. = ..()
	animate(src, alpha = 255, time = 0, loop = -1, flags = ANIMATION_PARALLEL)
	animate(src, alpha = 100, time = 1 SECONDS)

/atom/movable/screen/fullscreen/fuuuck/update_for_view(client_view)
	screen_loc = "WEST,SOUTH to EAST,NORTH"
	update_appearance()

//chungus
/atom/movable/screen/fullscreen/chungus
	name = "Oh fuck!"
	icon = 'modular_septic/icons/hud/screen_chungus.dmi'
	icon_state = "chungus"
	screen_loc = "WEST,SOUTH to EAST,NORTH"
	mouse_opacity = MOUSE_OPACITY_TRANSPARENT

/atom/movable/screen/fullscreen/chungus/Initialize(mapload)
	. = ..()
	animate(src, alpha = 255, time = 0, loop = -1, flags = ANIMATION_PARALLEL)
	animate(src, alpha = 50, time = 1 SECONDS)

/atom/movable/screen/fullscreen/chungus/update_for_view(client_view)
	screen_loc = "WEST,SOUTH to EAST,NORTH"
	update_appearance()
