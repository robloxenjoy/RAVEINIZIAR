/atom/movable/blocker
	name = "blocker"
	icon = 'modular_septic/icons/effects/blockers.dmi'
	icon_state = "blocker1"
	vis_flags = VIS_INHERIT_DIR
	mouse_opacity = MOUSE_OPACITY_TRANSPARENT
	var/center_icon = TRUE

/atom/movable/blocker/Initialize(mapload)
	. = ..()
	if(center_icon)
		var/icon/final_icon = icon(icon, icon_state)
		var/width = final_icon.Width()
		var/height = final_icon.Height()
		pixel_x = -width/2 + world.icon_size/2
		pixel_y = -height/2
