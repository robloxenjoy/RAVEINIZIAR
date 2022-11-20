/obj/structure/window/reinforced
	desc = "A window that is reinforced with metal rods. Flimsier than you would expect."
	icon = 'modular_septic/icons/obj/structures/tall/structures_tall.dmi'
	icon_state = "reinforced_window"
	base_icon_state = "reinforced_window"
	armor = list(MELEE = 75, BULLET = 0, LASER = 0, ENERGY = 0, BOMB = 25, BIO = 100, FIRE = 80, ACID = 100)
	damage_deflection = 7.6

/obj/structure/window/reinforced/tinted
	icon = 'modular_septic/icons/obj/structures/tall/structures_tall.dmi'
	icon_state = "twindow"
	base_icon_state = "twindow"

/obj/structure/window/reinforced/fulltile
	icon = 'modular_septic/icons/obj/structures/smooth_structures/tall/reinforced_window.dmi'
	frill_icon = 'modular_septic/icons/obj/structures/smooth_structures/tall/reinforced_window_frill.dmi'
	icon_state = "reinforced_window-0"
	base_icon_state = "reinforced_window"
	plane = GAME_PLANE_WINDOW
	layer = WINDOW_FULLTILE_LAYER
	smoothing_flags = SMOOTH_BITMASK
	smoothing_groups = list(SMOOTH_GROUP_WINDOW_FULLTILE)
	canSmoothWith = list(SMOOTH_GROUP_WALLS, SMOOTH_GROUP_WINDOW_FULLTILE)
	pixel_y = WINDOW_OFF_FRAME_Y_OFFSET
	obj_flags = CAN_BE_HIT|BLOCK_Z_OUT_DOWN|BLOCK_Z_OUT_UP|BLOCK_Z_IN_DOWN|BLOCK_Z_IN_UP

/obj/structure/window/reinforced/examine(mob/user)
	. = ..()
	switch(state)
		if(RWINDOW_BOLTS_HEATED, RWINDOW_SECURE)
			. += span_notice("The screws are tight, but you'll likely be able to <b>unscrew them</b>.")
		if(RWINDOW_BOLTS_OUT)
			. += span_notice("The screws have been removed, revealing a small gap you could fit a <b>prying tool</b> in.")
		if(RWINDOW_POPPED)
			. += span_notice("The main plate of the window has popped out of the frame, exposing some bars that look like they can be <b>cut</b>.")
		if(RWINDOW_BARS_CUT)
			. += span_notice("The main pane can be easily moved out of the way to reveal some <b>bolts</b> holding the frame in.")

/obj/structure/window/reinforced/attackby_secondary(obj/item/tool, mob/user, params)
	switch(state)
		if(RWINDOW_BOLTS_HEATED, RWINDOW_SECURE)
			if(tool.tool_behaviour == TOOL_SCREWDRIVER)
				user.visible_message(span_notice("[user] digs into the security screws and starts removing them..."),
									span_notice("I dig into the screws hard and they start turning..."))
				if(tool.use_tool(src, user, 50, volume = 50))
					state = RWINDOW_BOLTS_OUT
					to_chat(user, span_notice("The screws come out, and a gap forms around the edge of the pane."))
			else if(tool.tool_behaviour)
				to_chat(user, span_warning("The security screws need to be removed first!"))

		if(RWINDOW_BOLTS_OUT)
			if(tool.tool_behaviour == TOOL_CROWBAR)
				user.visible_message(span_notice("[user] wedges \the [tool] into the gap in the frame and starts prying..."),
									span_notice("U wedge \the [tool] into the gap in the frame and start prying..."))
				if(tool.use_tool(src, user, 40, volume = 50))
					state = RWINDOW_POPPED
					to_chat(user, span_notice("The panel pops out of the frame, exposing some thin metal bars that looks like they can be cut."))
			else if (tool.tool_behaviour)
				to_chat(user, span_warning("The gap needs to be pried first!"))

		if(RWINDOW_POPPED)
			if(tool.tool_behaviour == TOOL_WIRECUTTER)
				user.visible_message(span_notice("[user] starts cutting the exposed bars on \the [src]..."),
									span_notice("U start cutting the exposed bars on \the [src]"))
				if(tool.use_tool(src, user, 20, volume = 50))
					state = RWINDOW_BARS_CUT
					to_chat(user, span_notice("The panels falls out of the way exposing the frame bolts."))
			else if(tool.tool_behaviour)
				to_chat(user, span_warning("The bars need to be cut first!"))

		if(RWINDOW_BARS_CUT)
			if(tool.tool_behaviour == TOOL_WRENCH)
				user.visible_message(span_notice("[user] starts unfastening \the [src] from the frame..."),
					span_notice("I start unfastening the bolts from the frame..."))
				if(tool.use_tool(src, user, 40, volume = 50))
					to_chat(user, span_notice("I unscrew the bolts from the frame and the window pops loose."))
					state = WINDOW_OUT_OF_FRAME
					set_anchored(FALSE)
			else if(tool.tool_behaviour)
				to_chat(user, span_warning("The bolts need to be loosened first!"))

	if(tool.tool_behaviour)
		return SECONDARY_ATTACK_CANCEL_ATTACK_CHAIN

	return ..()
