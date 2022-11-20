/datum/component/storage/proc/screen_loc_to_tetris_coordinates(screen_loc = "")
	if(!tetris)
		return FALSE
	var/screen_x = copytext(screen_loc, 1, findtext(screen_loc, ","))
	var/screen_pixel_x = text2num(copytext(screen_x, findtext(screen_x, ":") + 1))
	screen_x = text2num(copytext(screen_x, 1, findtext(screen_x, ":")))

	var/screen_y = copytext(screen_loc, findtext(screen_loc, ",") + 1)
	var/screen_pixel_y = text2num(copytext(screen_y, findtext(screen_y, ":") + 1))
	screen_y = text2num(copytext(screen_y, 1, findtext(screen_y, ":")))

	var/screen_x_pixels = (screen_x * world.icon_size) + screen_pixel_x
	screen_x_pixels -= (src.screen_start_x * world.icon_size) + src.screen_pixel_x
	screen_x_pixels = FLOOR(screen_x_pixels/tetris_box_size, 1)
	var/screen_y_pixels = (screen_y * world.icon_size) + screen_pixel_y
	screen_y_pixels -= ((src.screen_start_y - src.screen_max_rows + 1) * world.icon_size) + src.screen_pixel_y
	screen_y_pixels = FLOOR(screen_y_pixels/tetris_box_size, 1)

	return "[screen_x_pixels],[screen_y_pixels]"

/datum/component/storage/proc/tetris_coordinates_to_screen_loc(coordinates = "")
	if(!tetris)
		return FALSE

	var/coordinate_x = copytext(coordinates, 1, findtext(coordinates, ","))
	coordinate_x = text2num(copytext(coordinate_x, 1, findtext(coordinate_x, ":")))

	var/coordinate_y = copytext(coordinates, findtext(coordinates, ",") + 1)
	coordinate_y = text2num(copytext(coordinate_y, 1, findtext(coordinate_y, ":")))

	var/screen_x_pixels = coordinate_x * tetris_box_size
	screen_x_pixels += (src.screen_start_x * world.icon_size) + src.screen_pixel_x
	var/screen_y_pixels = coordinate_y * tetris_box_size
	screen_y_pixels += ((src.screen_start_y - src.screen_max_rows + 1) * world.icon_size) + src.screen_pixel_y

	var/screen_x = FLOOR(screen_x_pixels/world.icon_size, 1)
	var/screen_pixel_x = FLOOR(screen_x_pixels - FLOOR(screen_x_pixels, world.icon_size), 1)
	var/screen_y = FLOOR(screen_y_pixels/world.icon_size, 1)
	var/screen_pixel_y = FLOOR(screen_y_pixels - FLOOR(screen_y_pixels, world.icon_size), 1)

	return "[screen_x]:[screen_pixel_x],[screen_y]:[screen_pixel_y]"

/datum/component/storage/proc/validate_tetris_coordinates(coordinates = "", tetris_width = 1, tetris_height = 1, obj/item/dragged_item)
	if(!tetris)
		return FALSE
	var/tetris_box_ratio = (world.icon_size/tetris_box_size)
	var/screen_x = copytext(coordinates, 1, findtext(coordinates, ","))
	screen_x = text2num(copytext(screen_x, 1, findtext(screen_x, ":")))
	var/screen_y = copytext(coordinates, findtext(coordinates, ",") + 1)
	screen_y = text2num(copytext(screen_y, 1, findtext(screen_y, ":")))
	var/validate_x = FLOOR((tetris_width/tetris_box_size)-1, 1)
	var/validate_y = FLOOR((tetris_height/tetris_box_size)-1, 1)
	var/final_x = 0
	var/final_y = 0
	var/final_coordinates = ""
	//this loops through all possible cells in the inventory box that we could overlap when given this screen_x and screen_y
	//and returns false on any failure
	for(var/current_x in 0 to validate_x)
		for(var/current_y in 0 to validate_y)
			final_x = screen_x+current_x
			final_y = screen_y+current_y
			final_coordinates = "[final_x],[final_y]"
			if(final_x >= (screen_max_columns*tetris_box_ratio))
				testing("validate_tetris_coordinates FAILED, final_x >= screen_max_columns, final_coordinates: ([final_coordinates])")
				return FALSE
			if(final_y >= (screen_max_rows*tetris_box_ratio))
				testing("validate_tetris_coordinates FAILED, final_y >= screen_max_rows, final_coordinates: ([final_coordinates])")
				return FALSE
			var/existing_item = LAZYACCESS(tetris_coordinates_to_item, final_coordinates)
			if(existing_item && (!dragged_item || (existing_item != dragged_item)))
				testing("validate_tetris_coordinates FAILED, coordinates already occupied, final_coordinates: ([final_coordinates])")
				return FALSE
	return TRUE

/datum/component/storage/proc/generate_bound_underlay(tetris_width = 32, tetris_height = 32)
	var/mutable_appearance/bound_underlay = mutable_appearance(icon = 'modular_septic/icons/hud/quake/storage.dmi', appearance_flags = RESET_ALPHA|RESET_COLOR|RESET_TRANSFORM|KEEP_APART)
	var/static/list/scale_both = list("block_under")
	var/static/list/scale_x_states = list("up", "down")
	var/static/list/scale_y_states = list("left", "right")

	var/scale_x = tetris_width/world.icon_size
	var/scale_y = tetris_height/world.icon_size
	var/width_constant = (world.icon_size/2)*((tetris_width/world.icon_size)-1)
	var/height_constant = (world.icon_size/2)*((tetris_height/world.icon_size)-1)
	for(var/scaled_both in scale_both)
		var/image/scaled_image = image(bound_underlay.icon, scaled_both)
		scaled_image.transform = scaled_image.transform.Scale(scale_x, scale_y)
		bound_underlay.add_overlay(scaled_image)
	var/caralho_louco = -1
	for(var/scaled_x in scale_x_states)
		caralho_louco = -caralho_louco
		var/image/scaled_image = image(bound_underlay.icon, scaled_x)
		scaled_image.transform = scaled_image.transform.Scale(scale_x, 1)
		scaled_image.transform = scaled_image.transform.Translate(1, height_constant * caralho_louco)
		bound_underlay.add_overlay(scaled_image)
	caralho_louco = 1
	for(var/scaled_y in scale_y_states)
		caralho_louco = -caralho_louco
		var/image/scaled_image = image(bound_underlay.icon, scaled_y)
		scaled_image.transform = scaled_image.transform.Scale(1, scale_y)
		scaled_image.transform = scaled_image.transform.Translate(width_constant * caralho_louco, 1)
		bound_underlay.add_overlay(scaled_image)
	var/image/corner_left_down = image(bound_underlay.icon, "corner_left_down")
	corner_left_down.transform = corner_left_down.transform.Translate(-width_constant, -height_constant)
	bound_underlay.add_overlay(corner_left_down)
	var/image/corner_right_down = image(bound_underlay.icon, "corner_right_down")
	corner_right_down.transform = corner_right_down.transform.Translate(width_constant, -height_constant)
	bound_underlay.add_overlay(corner_right_down)
	var/image/corner_left_up = image(bound_underlay.icon, "corner_left_up")
	corner_left_up.transform = corner_left_up.transform.Translate(-width_constant, height_constant)
	bound_underlay.add_overlay(corner_left_up)
	var/image/corner_right_up = image(bound_underlay.icon, "corner_right_up")
	corner_right_up.transform = corner_right_up.transform.Translate(width_constant, height_constant)
	bound_underlay.add_overlay(corner_right_up)

	return bound_underlay

/datum/component/storage/proc/tetris_add_item(obj/item/storing, coordinates)
	var/coordinate_x = text2num(copytext(coordinates, 1, findtext(coordinates, ",")))
	var/coordinate_y = text2num(copytext(coordinates, findtext(coordinates, ",") + 1))
	var/calculated_coordinates = ""
	var/final_x
	var/final_y
	var/validate_x = (storing.tetris_width/tetris_box_size)-1
	var/validate_y = (storing.tetris_height/tetris_box_size)-1
	//this loops through all cells we overlap given these coordinates
	for(var/current_x in 0 to validate_x)
		for(var/current_y in 0 to validate_y)
			final_x = coordinate_x+current_x
			final_y = coordinate_y+current_y
			calculated_coordinates = "[final_x],[final_y]"
			testing("handle_item_insertion SUCCESS calculated_coordinates: ([calculated_coordinates])")
			LAZYADDASSOC(tetris_coordinates_to_item, calculated_coordinates, storing)
			LAZYINITLIST(item_to_tetris_coordinates)
			LAZYINITLIST(item_to_tetris_coordinates[storing])
			LAZYADD(item_to_tetris_coordinates[storing], calculated_coordinates)
	return TRUE

/datum/component/storage/proc/tetris_remove_item(obj/item/removed)
	if(tetris && LAZYACCESS(item_to_tetris_coordinates, removed))
		for(var/location in LAZYACCESS(item_to_tetris_coordinates, removed))
			LAZYREMOVE(tetris_coordinates_to_item, location)
		LAZYREMOVE(item_to_tetris_coordinates, removed)
		removed.underlays = null
		return TRUE
	return FALSE
