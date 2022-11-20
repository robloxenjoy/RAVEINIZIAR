/atom/movable/screen/close
	icon = 'modular_septic/icons/hud/quake/storage.dmi'
	icon_state = "close"
	var/locked = TRUE

/atom/movable/screen/close/Click(location, control, params)
	. = ..()
	var/datum/component/storage/storage_master = master
	var/list/modifiers = params2list(params)
	if(LAZYACCESS(modifiers, SHIFT_CLICK))
		if(!istype(storage_master))
			return
		storage_master.screen_start_x = initial(storage_master.screen_start_x)
		storage_master.screen_pixel_x = initial(storage_master.screen_pixel_x)
		storage_master.screen_start_y = initial(storage_master.screen_start_y)
		storage_master.screen_pixel_y = initial(storage_master.screen_pixel_y)
		storage_master.orient2hud()
		storage_master.show_to(usr)
		testing("storage screen variables reset [storage_master.screen_start_x]:[storage_master.screen_pixel_x],[storage_master.screen_start_y]:[storage_master.screen_pixel_y]")
		to_chat(usr, span_notice("Storage window position has been reset."))
	else if(LAZYACCESS(modifiers, CTRL_CLICK))
		locked = !locked
		to_chat(usr, span_notice("Storage window [locked ? "" : "un"]locked."))
	else
		if(!istype(storage_master))
			return
		storage_master.hide_from(usr)

/atom/movable/screen/close/MouseDrop(atom/over, src_location, over_location, src_control, over_control, params)
	. = ..()
	var/datum/component/storage/storage_master = master
	if(!istype(storage_master))
		return
	if(locked)
		to_chat(usr, span_warning("The storage window is locked, unlock it first."))
		return
	storage_master = storage_master.master()
	var/list/modifiers = params2list(params)
	var/maximum_x_pixels = (20 - (storage_master.screen_max_columns) + 1) * world.icon_size
	var/minimum_x_pixels = 0
	var/maximum_y_pixels = 16 * world.icon_size
	var/minimum_y_pixels = (16 - storage_master.screen_max_rows + 1) * world.icon_size

	var/screen_loc = LAZYACCESS(modifiers, SCREEN_LOC)
	testing("storage close button MouseDrop() screen_loc: ([screen_loc])")

	var/screen_x = copytext(screen_loc, 1, findtext(screen_loc, ","))
	var/screen_pixel_x = text2num(copytext(screen_x, findtext(screen_x, ":") + 1))
	screen_x = text2num(copytext(screen_x, 1, findtext(screen_x, ":")))

	var/screen_y = copytext(screen_loc, findtext(screen_loc, ",") + 1)
	var/screen_pixel_y = text2num(copytext(screen_y, findtext(screen_y, ":") + 1))
	screen_y = text2num(copytext(screen_y, 1, findtext(screen_y, ":")))

	var/screen_x_pixels = clamp((screen_x * world.icon_size) + screen_pixel_x, minimum_x_pixels, maximum_x_pixels)
	var/screen_y_pixels = clamp(((screen_y-1) * world.icon_size) + screen_pixel_y, minimum_y_pixels, maximum_y_pixels)

	screen_x = FLOOR(screen_x_pixels/world.icon_size, 1)
	screen_pixel_x = FLOOR((screen_x_pixels/world.icon_size - FLOOR(screen_x_pixels/world.icon_size, 1)) * world.icon_size, 1)
	screen_y = FLOOR(screen_y_pixels/world.icon_size, 1)
	screen_pixel_y = FLOOR((screen_y_pixels/world.icon_size - FLOOR(screen_y_pixels/world.icon_size, 1)) * world.icon_size, 1)

	storage_master.screen_start_x = screen_x
	storage_master.screen_pixel_x = screen_pixel_x
	storage_master.screen_start_y = screen_y
	storage_master.screen_pixel_y = screen_pixel_y
	storage_master.orient2hud()
	testing("[screen_x]:[screen_pixel_x],[screen_y]:[screen_pixel_y]")

/atom/movable/screen/storage
	icon = 'modular_septic/icons/hud/quake/storage.dmi'
	icon_state = "background"
	alpha = 128
	var/atom/movable/screen/storage_hover/hovering

/atom/movable/screen/storage/Initialize(mapload, new_master)
	. = ..()
	hovering = new()

/atom/movable/screen/storage/Destroy()
	. = ..()
	qdel(hovering)

/atom/movable/screen/storage/MouseEntered(location, control, params)
	. = ..()
	if(!usr.client)
		return
	MouseMove(location, control, params)

/atom/movable/screen/storage/MouseExited(location, control, params)
	. = ..()
	if(!usr.client)
		return
	usr.client.screen -= hovering

/atom/movable/screen/storage/MouseMove(location, control, params)
	. = ..()
	if(!usr.client)
		return
	usr.client.screen -= hovering
	var/datum/component/storage/storage_master = master
	if(!istype(storage_master) || !(usr in storage_master.is_using) || !isliving(usr) || usr.incapacitated())
		return
	var/obj/item/held_item = usr.get_active_held_item()
	if(!held_item)
		return
	storage_master = storage_master.master()
	if(!storage_master.tetris)
		return
	var/list/modifiers = params2list(params)
	var/screen_loc = LAZYACCESS(modifiers, SCREEN_LOC)
	var/coordinates = storage_master.screen_loc_to_tetris_coordinates(screen_loc)
	if(!coordinates)
		return
	// this looks shit and you can't create paradoxes
	if(held_item == storage_master.parent)
		return
	if(storage_master.can_be_inserted(held_item, stop_messages = TRUE, user = usr, worn_check = TRUE, params = params, storage_click = TRUE))
		hovering.color = COLOR_LIME
	else
		hovering.color = COLOR_RED_LIGHT
	hovering.transform = matrix()
	var/scale_x = held_item.tetris_width/world.icon_size
	var/scale_y = held_item.tetris_height/world.icon_size
	hovering.transform = hovering.transform.Scale(scale_x, scale_y)
	var/translate_x = (world.icon_size/2)*((held_item.tetris_width/world.icon_size)-1)
	var/translate_y = (world.icon_size/2)*((held_item.tetris_height/world.icon_size)-1)
	hovering.transform = hovering.transform.Translate(translate_x, translate_y)
	hovering.screen_loc = storage_master.tetris_coordinates_to_screen_loc(coordinates)

	usr.client.screen |= hovering

/atom/movable/screen/storage_hover
	icon = 'modular_septic/icons/hud/quake/storage.dmi'
	icon_state = "white"
	plane = ABOVE_HUD_PLANE
	layer = 10
	mouse_opacity = MOUSE_OPACITY_TRANSPARENT
	alpha = 96
