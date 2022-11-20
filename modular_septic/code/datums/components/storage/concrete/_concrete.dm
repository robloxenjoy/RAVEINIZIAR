/datum/component/storage/concrete/slave_can_insert_object(datum/component/storage/slave, obj/item/storing, stop_messages = FALSE, mob/user, params, storage_click = FALSE)
	//This is where the pain begins
	if(tetris)
		var/list/modifiers = params2list(params)
		var/coordinates = LAZYACCESS(modifiers, SCREEN_LOC)
		var/tetris_box_ratio = (world.icon_size/tetris_box_size)

		//if it's not a storage click, find the first cell that happens to be valid
		if(!storage_click)
			var/final_x = 0
			var/final_y = 0
			var/final_coordinates = ""
			var/tetris_location_found = FALSE
			for(var/current_x in 0 to ((screen_max_rows*tetris_box_ratio)-1))
				for(var/current_y in 0 to ((screen_max_columns*tetris_box_ratio)-1))
					final_y = current_y
					final_x = current_x
					final_coordinates = "[final_x],[final_y]"
					if(validate_tetris_coordinates(final_coordinates, storing.tetris_width, storing.tetris_height, storing))
						coordinates = final_coordinates
						tetris_location_found = TRUE
						break
				if(tetris_location_found)
					break
			if(!tetris_location_found)
				return FALSE
		else
			coordinates = screen_loc_to_tetris_coordinates(coordinates)

		if(!validate_tetris_coordinates(coordinates, storing.tetris_width, storing.tetris_height, storing))
			return FALSE
	return TRUE

//Remote is null or the slave datum
/datum/component/storage/concrete/handle_item_insertion(obj/item/storing, prevent_warning = FALSE, mob/user, datum/component/storage/remote, params, storage_click = FALSE)
	var/datum/component/storage/concrete/master = master()
	var/atom/parent = src.parent
	var/moved = FALSE
	if(!istype(storing))
		return FALSE
	if(user)
		if(!worn_check(parent, user))
			return FALSE
		if(!user.temporarilyRemoveItemFromInventory(storing))
			return FALSE
		else
			//At this point if the proc fails we need to manually move the object back to the turf/mob/whatever.
			moved = TRUE
	if(storing.pulledby)
		storing.pulledby.stop_pulling()
	if(silent)
		prevent_warning = TRUE
	if(!_insert_physical_item(storing))
		if(moved)
			if(user)
				if(!user.put_in_active_hand(storing))
					storing.forceMove(parent.drop_location())
			else
				storing.forceMove(parent.drop_location())
		return FALSE
	storing.on_enter_storage(master)
	storing.item_flags |= IN_STORAGE
	storing.mouse_opacity = MOUSE_OPACITY_OPAQUE //So you can click on the area around the item to equip it, instead of having to pixel hunt
	if(user)
		if(user.client && (user.active_storage != src))
			user.client.screen -= storing
		if(LAZYLEN(user.observers))
			for(var/mob/dead/observe as anything in user.observers)
				if(observe.client && (observe.active_storage != src))
					observe.client.screen -= storing
		if(!remote)
			parent.add_fingerprint(user)
			if(!prevent_warning)
				mob_item_insertion_feedback(usr, user, storing)
	if(tetris)
		var/list/modifiers = params2list(params)
		var/coordinates = LAZYACCESS(modifiers, SCREEN_LOC)
		var/tetris_box_ratio = (world.icon_size/tetris_box_size)

		//if it's not a storage click, find the first cell that happens to be valid
		if(!storage_click)
			var/final_x = 0
			var/final_y = 0
			var/final_coordinates = ""
			var/tetris_location_found = FALSE
			for(var/current_x = 0;current_x <= ((screen_max_rows*tetris_box_ratio)-1);current_x++)
				for(var/current_y = ((screen_max_columns*tetris_box_ratio)-1);current_y >= 0;current_y--)
					final_y = current_y
					final_x = current_x
					final_coordinates = "[final_x],[final_y]"
					if(validate_tetris_coordinates(final_coordinates, storing.tetris_width, storing.tetris_height, storing))
						coordinates = final_coordinates
						tetris_location_found = TRUE
						break
				if(tetris_location_found)
					break
			if(!tetris_location_found)
				return FALSE
		else
			coordinates = screen_loc_to_tetris_coordinates(coordinates)
		tetris_add_item(storing, coordinates)
	update_icon()
	refresh_mob_views()
	return TRUE

/datum/component/storage/concrete/handle_item_insertion_from_slave(datum/component/storage/slave, obj/item/storing, prevent_warning = FALSE, mob/user, params, storage_click = FALSE)
	. = handle_item_insertion(storing, prevent_warning, user, slave, params = params, storage_click = storage_click)
	if(. && !prevent_warning)
		slave.mob_item_insertion_feedback(usr, user, storing)

/datum/component/storage/concrete/remove_from_storage(atom/movable/removed, atom/new_location)
	//This loops through all cells in the inventory box that we overlap and removes the item from them
	tetris_remove_item(removed)
	//Cache this as it should be reusable down the bottom, will not apply if anyone adds a sleep to dropped or moving objects, things that should never happen
	var/atom/parent = src.parent
	var/list/seeing_mobs = can_see_contents()
	for(var/mob/seeing_mob as anything in seeing_mobs)
		seeing_mob.client.screen -= removed
	if(isitem(removed))
		var/obj/item/removed_item = removed
		removed_item.item_flags &= ~IN_STORAGE
		if(ismob(parent.loc))
			var/mob/carrying_mob = parent.loc
			removed_item.dropped(carrying_mob, TRUE)
	if(new_location)
		//Reset the items values
		_removal_reset(removed)
		removed.forceMove(new_location)
		//We don't want to call this if the item is being destroyed
		removed.on_exit_storage(src)
	else
		//Being destroyed, just move to nullspace now (so it's not in contents for the icon update)
		removed.moveToNullspace()
	removed.update_appearance()
	update_icon()
	refresh_mob_views()
	return TRUE
