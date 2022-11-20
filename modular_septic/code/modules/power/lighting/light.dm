/obj/machinery/light
	icon = 'modular_septic/icons/obj/machinery/lighting.dmi'
	overlay_icon = 'modular_septic/icons/obj/machinery/lighting_overlays.dmi'
	plane = GAME_PLANE_UPPER
	layer = WALL_OBJ_LAYER
	var/wall_mounted = TRUE
	var/random_flickering = FALSE

/obj/machinery/light/Initialize(mapload)
	. = ..()
	setDir(dir)

/obj/machinery/light/Destroy()
	. = ..()
	SSlight_flickering.active_lights -= src

/obj/machinery/light/update_icon(updates)
	. = ..()
	if(!wall_mounted)
		return
	switch(status)
		if(LIGHT_BROKEN,LIGHT_BURNED,LIGHT_EMPTY)
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
		else
			switch(dir)
				if(NORTH)
					plane = GAME_PLANE_UPPER_BLOOM
					pixel_y = 35
				if(SOUTH)
					plane = ABOVE_FRILL_PLANE_BLOOM
					pixel_y = -2
				if(EAST)
					plane = GAME_PLANE_UPPER_BLOOM
					pixel_x = 16
					pixel_y = 16
				if(WEST)
					plane = GAME_PLANE_UPPER_BLOOM
					pixel_x = -16
					pixel_y = 16
				else
					plane = ABOVE_FRILL_PLANE_BLOOM
					pixel_y = -2

/obj/machinery/light/setDir(newdir)
	. = ..()
	if(!wall_mounted)
		return
	update_appearance(UPDATE_ICON)

/obj/machinery/light/update(trigger)
	. = ..()
	if(!random_flickering)
		SSlight_flickering.active_lights -= src
		return
	switch(status)
		if(LIGHT_BROKEN,LIGHT_BURNED,LIGHT_EMPTY)
			SSlight_flickering.active_lights |= src
		else
			SSlight_flickering.active_lights -= src

/obj/machinery/light/floor
	plane = FLOOR_PLANE
	layer = LOW_OBJ_LAYER
	wall_mounted = FALSE
