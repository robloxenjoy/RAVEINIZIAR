/turf/open/openspace
	icon = 'modular_septic/icons/turf/floors.dmi'
	icon_state = "transparent"
//	mouse_opacity = MOUSE_OPACITY_TRANSPARENT
	light_range = 1
	light_power = 1
	light_color = COLOR_WHITE

/turf/open/openspace/return_screentip(mob/user, params)
	if(flags_1 & NO_SCREENTIPS_1)
		return ""
	return SCREENTIP_OPENSPACE(uppertext(name))
