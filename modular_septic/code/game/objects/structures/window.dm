/obj/structure/window
	icon = 'modular_septic/icons/obj/structures/tall/structures_tall.dmi'
	icon_state = "window"
	base_icon_state = "window"
	plane = GAME_PLANE_ABOVE_WINDOW
	layer = WINDOW_LOW_LAYER
	upper_frill_plane = FRILL_PLANE_WINDOW
	upper_frill_layer = WINDOW_FRILL_LAYER
	lower_frill_plane = GAME_PLANE_WINDOW
	lower_frill_layer = ABOVE_WINDOW_FULLTILE_LAYER
	var/has_top = TRUE

/obj/structure/window/Initialize()
	. = ..()
	AddElement(/datum/element/conditional_brittle, "fireaxe")
	if(!fulltile)
		AddElement(/datum/element/window_layering, has_top)

/obj/structure/window/update_icon(updates)
	. = ..()
	if(!fulltile)
		return

	if(islowwallturf(loc))
		pixel_y = WINDOW_ON_FRAME_Y_OFFSET
	else
		pixel_y = WINDOW_OFF_FRAME_Y_OFFSET

	if((updates & UPDATE_SMOOTHING) && (smoothing_flags & (SMOOTH_CORNERS|SMOOTH_BITMASK)))
		QUEUE_SMOOTH(src)

/obj/structure/window/update_overlays()
	. = ..()
	if(QDELETED(src) || !fulltile)
		return

	var/damage_percentage = clamp(FLOOR((1 - atom_integrity/max_integrity) * 100, 25), 0, 75)
	var/damage_state = ""
	if(damage_percentage >= 25)
		damage_state = "[damage_percentage]"
	crack_overlay = mutable_appearance('modular_septic/icons/obj/structures/smooth_structures/tall/window_damage.dmi', "damage[damage_state]-[smoothing_junction]")
	crack_overlay.layer = layer+0.001
	crack_overlay_frill = mutable_appearance('modular_septic/icons/obj/structures/smooth_structures/tall/window_damage_frill.dmi', "damage[damage_state]-[smoothing_junction]")
	crack_overlay_frill.pixel_y = 32
	if(smoothing_junction & NORTH)
		crack_overlay_frill.plane = FRILL_PLANE_LOW
		crack_overlay_frill.layer = upper_frill_layer+0.001
	else
		crack_overlay_frill.plane = GAME_PLANE_ABOVE_WINDOW
		crack_overlay_frill.layer = lower_frill_layer+0.001
	. += crack_overlay
	. += crack_overlay_frill

/obj/structure/window/set_smoothed_icon_state(new_junction)
	. = ..()
	update_appearance(UPDATE_OVERLAYS)

/obj/structure/window/Moved(atom/OldLoc, Dir)
	. = ..()
	update_nearby_icons()

/obj/structure/window/HandleTurfChange()
	. = ..()
	update_icon()

/obj/structure/window/fulltile
	icon = 'modular_septic/icons/obj/structures/smooth_structures/tall/window.dmi'
	frill_icon = 'modular_septic/icons/obj/structures/smooth_structures/tall/window_frill.dmi'
	icon_state = "window-0"
	base_icon_state = "window"
	plane = GAME_PLANE_WINDOW
	layer = WINDOW_FULLTILE_LAYER
	smoothing_flags = SMOOTH_BITMASK
	smoothing_groups = list(SMOOTH_GROUP_WINDOW_FULLTILE)
	canSmoothWith = list(SMOOTH_GROUP_WALLS, SMOOTH_GROUP_WINDOW_FULLTILE)
	pixel_y = WINDOW_OFF_FRAME_Y_OFFSET
	obj_flags = CAN_BE_HIT|BLOCK_Z_OUT_DOWN|BLOCK_Z_OUT_UP|BLOCK_Z_IN_DOWN|BLOCK_Z_IN_UP
