/obj/structure/light_construct
	icon = 'modular_septic/icons/obj/machinery/lighting.dmi'

/obj/structure/light_construct/Initialize(mapload, ndir, building)
	. = ..()
	setDir(dir)

/obj/structure/light_construct/update_icon(updates)
	. = ..()
	switch(dir)
		if(NORTH)
			plane = GAME_PLANE_UPPER
			pixel_y = 35
		if(SOUTH)
			plane = ABOVE_FRILL_PLANE
			pixel_y = -2
		if(EAST)
			plane = GAME_PLANE_UPPER
			pixel_x = 16
			pixel_y = 16
		if(WEST)
			plane = GAME_PLANE_UPPER
			pixel_x = -16
			pixel_y = 16
		else
			plane = ABOVE_FRILL_PLANE
			pixel_y = -2
