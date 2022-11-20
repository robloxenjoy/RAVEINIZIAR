/proc/get_mob_shadow(icon_state = NORMAL_MOB_SHADOW, plane = FLOOR_PLANE_FOV_HIDDEN, layer = SHADOW_LAYER, pixel_y = -4, vis_flags = VIS_INHERIT_DIR | VIS_UNDERLAY, appearance_flags = RESET_TRANSFORM)
	. = GLOB.shadow_movables["[icon_state]-[plane]-[layer]-[pixel_y]-[vis_flags]-[appearance_flags]"]
	if(.)
		return
	var/atom/movable/shadow/shadow = new()
	shadow.icon_state = icon_state
	shadow.plane = plane
	shadow.layer = layer
	shadow.pixel_y = pixel_y
	GLOB.shadow_movables["[icon_state]-[plane]-[layer]-[pixel_y]-[vis_flags]-[appearance_flags]"] = shadow
	return shadow
