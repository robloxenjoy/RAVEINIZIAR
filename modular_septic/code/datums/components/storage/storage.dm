/datum/component/storage
	screen_max_columns = 8
	screen_max_rows = 8
	screen_pixel_x = 0
	screen_pixel_y = 0
	screen_start_x = 1
	screen_start_y = 11
	rustle_sound = list(
		'modular_septic/sound/effects/foley1.wav',
		'modular_septic/sound/effects/foley2.wav',
		'modular_septic/sound/effects/foley3.wav',
	)
	/// Exactly what it sounds like, this makes it use the new RE4-like inventory system
	var/tetris = FALSE
	var/static/tetris_box_size
	var/static/list/mutable_appearance/underlay_appearances_by_size = list()
	var/list/tetris_coordinates_to_item
	var/list/item_to_tetris_coordinates
	var/maximum_depth = 1
	var/storage_flags = NONE

/datum/component/storage/Initialize(datum/component/storage/concrete/master)
	if(!tetris_box_size)
		tetris_box_size = world.icon_size
	. = ..()
	if(.)
		return
	RegisterSignal(parent, COMSIG_STORAGE_BLOCK_USER_TAKE, .proc/should_block_user_take)

/datum/component/storage/orient2hud()
	var/atom/real_location = real_location()
	var/adjusted_contents = LAZYLEN(real_location.contents)

	//Numbered contents display
	var/list/datum/numbered_display/numbered_contents
	if(display_numerical_stacking)
		numbered_contents = _process_numerical_display()
		adjusted_contents = LAZYLEN(numbered_contents)

	var/rows = 0
	var/columns = 0
	var/datum/component/storage/master = master()
	if(!master.tetris)
		rows = clamp(max_items, 1, screen_max_rows)
		columns = clamp(CEILING(adjusted_contents / rows, 1), 1, screen_max_columns)
	else
		rows = screen_max_rows
		columns = screen_max_columns
	return standard_orient_objs(rows, columns, numbered_contents)

/datum/component/storage/standard_orient_objs(rows = 0, cols = 0, list/obj/item/numerical_display_contents)
	var/datum/component/storage/master = master()
	boxes.screen_loc = "[screen_start_x]:[screen_pixel_x],[screen_start_y]:[screen_pixel_y] to [screen_start_x+cols-1]:[screen_pixel_x],[screen_start_y-rows+1]:[screen_pixel_y]"
	if(master.tetris)
		var/mutable_appearance/bound_underlay
		var/screen_loc
		var/screen_x
		var/screen_y
		var/screen_pixel_x
		var/screen_pixel_y
		if(islist(numerical_display_contents))
			for(var/index in numerical_display_contents)
				var/datum/numbered_display/numbered_display = numerical_display_contents[index]
				var/obj/item/stored_item = numbered_display.sample_object
				stored_item.mouse_opacity = MOUSE_OPACITY_OPAQUE
				bound_underlay = LAZYACCESS(underlay_appearances_by_size, "[stored_item.tetris_width]x[stored_item.tetris_height]")
				if(!bound_underlay)
					bound_underlay = generate_bound_underlay(stored_item.tetris_width, stored_item.tetris_height)
					underlay_appearances_by_size["[stored_item.tetris_width]x[stored_item.tetris_height]"] = bound_underlay
				stored_item.underlays += bound_underlay
				screen_loc = LAZYACCESSASSOC(master.item_to_tetris_coordinates, stored_item, 1)
				screen_loc = master.tetris_coordinates_to_screen_loc(screen_loc)
				screen_x = copytext(screen_loc, 1, findtext(screen_loc, ","))
				screen_pixel_x = text2num(copytext(screen_x, findtext(screen_x, ":") + 1))
				screen_pixel_x += (world.icon_size/2)*((stored_item.tetris_width/world.icon_size)-1)
				screen_x = text2num(copytext(screen_x, 1, findtext(screen_x, ":")))
				screen_y = copytext(screen_loc, findtext(screen_loc, ",") + 1)
				screen_pixel_y = text2num(copytext(screen_y, findtext(screen_y, ":") + 1))
				screen_pixel_y += (world.icon_size/2)*((stored_item.tetris_height/world.icon_size)-1)
				screen_y = text2num(copytext(screen_y, 1, findtext(screen_y, ":")))
				stored_item.screen_loc = "[screen_x]:[screen_pixel_x],[screen_y]:[screen_pixel_y]"
				stored_item.plane = ABOVE_HUD_PLANE
				stored_item.maptext = MAPTEXT("<font color='white'>[(numbered_display.number > 1)? "[numbered_display.number]" : ""]</font>")
		else
			var/atom/real_location = real_location()
			for(var/obj/item/stored_item in real_location)
				if(QDELETED(stored_item))
					continue
				stored_item.mouse_opacity = MOUSE_OPACITY_OPAQUE
				bound_underlay = LAZYACCESS(underlay_appearances_by_size, "[stored_item.tetris_width]x[stored_item.tetris_height]")
				if(!bound_underlay)
					bound_underlay = generate_bound_underlay(stored_item.tetris_width, stored_item.tetris_height)
					underlay_appearances_by_size["[stored_item.tetris_width]x[stored_item.tetris_height]"] = bound_underlay
				stored_item.underlays += bound_underlay
				screen_loc = LAZYACCESSASSOC(master.item_to_tetris_coordinates, stored_item, 1)
				screen_loc = master.tetris_coordinates_to_screen_loc(screen_loc)
				screen_x = copytext(screen_loc, 1, findtext(screen_loc, ","))
				screen_pixel_x = text2num(copytext(screen_x, findtext(screen_x, ":") + 1))
				screen_pixel_x += (world.icon_size/2)*((stored_item.tetris_width/world.icon_size)-1)
				screen_x = text2num(copytext(screen_x, 1, findtext(screen_x, ":")))
				screen_y = copytext(screen_loc, findtext(screen_loc, ",") + 1)
				screen_pixel_y = text2num(copytext(screen_y, findtext(screen_y, ":") + 1))
				screen_pixel_y += (world.icon_size/2)*((stored_item.tetris_height/world.icon_size)-1)
				screen_y = text2num(copytext(screen_y, 1, findtext(screen_y, ":")))
				stored_item.screen_loc = "[screen_x]:[screen_pixel_x],[screen_y]:[screen_pixel_y]"
				stored_item.plane = ABOVE_HUD_PLANE
				stored_item.maptext = ""
		update_closer(rows, cols)
		return
	var/cx = screen_start_x
	var/cy = screen_start_y
	if(islist(numerical_display_contents))
		for(var/index in numerical_display_contents)
			var/datum/numbered_display/numbered_display = numerical_display_contents[index]
			numbered_display.sample_object.mouse_opacity = MOUSE_OPACITY_OPAQUE
			numbered_display.sample_object.screen_loc = "[cx]:[screen_pixel_x],[cy]:[screen_pixel_y]"
			numbered_display.sample_object.maptext = MAPTEXT("<font color='white'>[(numbered_display.number > 1)? "[numbered_display.number]" : ""]</font>")
			numbered_display.sample_object.plane = ABOVE_HUD_PLANE
			cy--
			if(screen_start_y - cy >= rows)
				cy = screen_start_y
				cx++
				if(cx - screen_start_x >= cols)
					break
	else
		var/atom/real_location = real_location()
		for(var/obj/stored_object in real_location)
			if(QDELETED(stored_object))
				continue
			stored_object.mouse_opacity = MOUSE_OPACITY_OPAQUE //This is here so storage items that spawn with contents correctly have the "click around item to equip"
			stored_object.screen_loc = "[cx]:[screen_pixel_x],[cy]:[screen_pixel_y]"
			stored_object.maptext = ""
			stored_object.plane = ABOVE_HUD_PLANE
			cy--
			if(screen_start_y - cy >= rows)
				cy = screen_start_y
				cx++
				if(cx - screen_start_x >= cols)
					break
	update_closer(rows, cols)

/datum/component/storage/_process_numerical_display()
	. = list()
	var/atom/real_location = real_location()
	for(var/obj/item/stored_item in real_location.contents)
		if(QDELETED(stored_item))
			continue
		if(!.["[stored_item.type]-[stored_item.name]"])
			.["[stored_item.type]-[stored_item.name]"] = new /datum/numbered_display(stored_item, 1)
		else
			var/datum/numbered_display/number_display = .["[stored_item.type]-[stored_item.name]"]
			number_display.number++

/datum/component/storage/signal_insertion_attempt(datum/source,
												obj/item/storing,
												mob/user,
												silent = FALSE,
												force = FALSE,
												worn_check = FALSE,
												params)
	if((!force && !can_be_inserted(storing, TRUE, user, worn_check, params = params)) || (storing == parent))
		return FALSE
	return handle_item_insertion(storing, silent, user, params = params, storage_click = FALSE)

/datum/component/storage/can_be_inserted(obj/item/storing, stop_messages, mob/user, worn_check = FALSE, params, storage_click = FALSE)
	if(!istype(storing) || (storing.item_flags & ABSTRACT))
		return FALSE //Not an item
	if(storing == parent)
		return FALSE //No paradoxes for you
	var/atom/host = parent
	var/atom/real_location = real_location()
	if(real_location == storing.loc)
		return FALSE //Means the item is already in the storage item
	if(locked)
		if(user && !stop_messages)
			host.add_fingerprint(user)
			to_chat(user, span_warning("[host] seems to be locked!"))
		return FALSE
	if(worn_check && !worn_check(parent, user, no_message = stop_messages))
		host.add_fingerprint(user)
		return FALSE
	if(LAZYLEN(real_location.contents) >= max_items)
		if(!stop_messages)
			to_chat(user, span_warning("[host] is full, make some space!"))
		return FALSE //Storage item is full
	if(LAZYLEN(can_hold))
		if(!is_type_in_typecache(storing, can_hold))
			if(!stop_messages)
				to_chat(user, span_warning("[host] cannot hold [storing]!"))
			return FALSE
	if(is_type_in_typecache(storing, cant_hold) || HAS_TRAIT(storing, TRAIT_NO_STORAGE_INSERT) || (can_hold_trait && !HAS_TRAIT(storing, can_hold_trait))) //Items which this container can't hold.
		if(!stop_messages)
			to_chat(user, span_warning("[host] cannot hold [storing]!"))
		return FALSE
	if((storing.w_class > max_w_class) && !is_type_in_typecache(storing, exception_hold))
		if(!stop_messages)
			to_chat(user, span_warning("[storing] is too big for [host]!"))
		return FALSE
	var/atom/recursive_loc = real_location?.loc
	var/depth = 0
	while(ismovable(recursive_loc))
		depth++
		var/datum/component/storage/biggerfish = recursive_loc.GetComponent(/datum/component/storage)
		if(biggerfish && !istype(biggerfish, /datum/component/storage/concrete/organ))
			//return false if we are inside of another container, and that container has a smaller max_w_class than us (like if we're a bag in a box)
			if(biggerfish.max_w_class < max_w_class)
				if(!stop_messages)
					to_chat(user, span_warning("[storing] can't fit in [host] while [recursive_loc] is in the way!"))
				return FALSE
			else if(worn_check && !biggerfish.worn_check(storing, user, stop_messages))
				if(!stop_messages)
					to_chat(user, span_warning("[storing] can't fit in [host] while [recursive_loc] is in the way!"))
				return FALSE
			else if(biggerfish.maximum_depth < depth)
				if(!stop_messages)
					to_chat(user, span_warning("[storing] can't fit in [host] while [recursive_loc] is in the way!"))
				return FALSE
		recursive_loc = recursive_loc.loc
	var/sum_w_class = storing.w_class
	for(var/obj/item/stored_item in real_location)
		sum_w_class += stored_item.w_class //Adds up the combined w_classes which will be in the storage item if the item is added to it.
	if(sum_w_class > max_combined_w_class)
		if(!stop_messages)
			to_chat(user, span_warning("[storing] won't fit in [host], make some space!"))
		return FALSE
	if(isitem(host))
		var/obj/item/host_item = host
		var/datum/component/storage/storage_internal = storing.GetComponent(/datum/component/storage)
		if((storing.w_class >= host_item.w_class) && storage_internal && !allow_big_nesting)
			if(!stop_messages)
				to_chat(user, span_warning("[host_item] cannot hold [storing] as it's a storage item of the same size!"))
			return FALSE //To prevent the stacking of same sized storage items
	//SHOULD be handled in unEquip, but better safe than sorry
	if(HAS_TRAIT(storing, TRAIT_NODROP))
		if(!stop_messages)
			to_chat(user, span_warning("\The [storing] is stuck to your hand, you can't put it in \the [host]!"))
		return FALSE
	var/datum/component/storage/concrete/master = master()
	if(!istype(master))
		return FALSE
	return master.slave_can_insert_object(src, storing, stop_messages, user, params = params, storage_click = storage_click)

/datum/component/storage/handle_item_insertion(obj/item/storing, prevent_warning = FALSE, mob/user, datum/component/storage/remote, params, storage_click = FALSE)
	var/atom/parent = src.parent
	var/datum/component/storage/concrete/master = master()
	if(!istype(master))
		return FALSE
	if(silent)
		prevent_warning = TRUE
	if(user)
		parent.add_fingerprint(user)
	return master.handle_item_insertion_from_slave(src, storing, prevent_warning, user, params = params, storage_click = storage_click)

/datum/component/storage/signal_take_obj(datum/source, atom/movable/taken, new_loc, force = FALSE)
	if(!(taken in real_location()))
		return FALSE
	return remove_from_storage(taken, new_loc)

/datum/component/storage/remove_from_storage(atom/movable/removed, atom/new_location)
	if(!istype(removed))
		return FALSE
	var/datum/component/storage/concrete/master = master()
	if(!istype(master))
		return FALSE
	return master.remove_from_storage(removed, new_location)

/datum/component/storage/on_attack_hand(datum/source, mob/user)
	var/atom/A = parent
	if(!attack_hand_interact)
		return
	if(user.active_storage == src && A.loc == user) //if you're already looking inside the storage item
		user.active_storage.close(user)
		close(user)
		. = COMPONENT_CANCEL_ATTACK_CHAIN
		return

	if(isitem(A))
		var/obj/item/I = A
		if(!worn_check(I, user, TRUE))
			return FALSE

	if(A.loc == user)
		. = COMPONENT_CANCEL_ATTACK_CHAIN
		if(locked)
			to_chat(user, span_warning("[parent] seems to be locked!"))
		else
			show_to(user)
			if(rustle_sound)
				playsound(A, rustle_sound, 50, TRUE, -5)

//This proc is called when you want to place an item into the storage item
/datum/component/storage/attackby(datum/source, obj/item/attacking_item, mob/user, params, storage_click = FALSE)
	if(istype(attacking_item, /obj/item/hand_labeler))
		var/obj/item/hand_labeler/labeler = attacking_item
		if(labeler.mode)
			return FALSE
	. = TRUE //no afterattack
	if(iscyborg(user))
		return
	if(!can_be_inserted(attacking_item, FALSE, user, params = params, storage_click = storage_click))
		var/atom/real_location = real_location()
		if(LAZYLEN(real_location.contents) >= max_items) //don't use items on the backpack if they don't fit
			return TRUE
		return FALSE
	return handle_item_insertion(attacking_item, FALSE, user, params = params, storage_click = storage_click)

/datum/component/storage/on_move()
	for(var/mob/living/living_viewer in can_see_contents())
		if(!living_viewer.CanReach(parent) || !worn_check(parent, living_viewer, TRUE))
			hide_from(living_viewer)

/datum/component/storage/proc/on_equipped(obj/item/source, mob/user, slot)
	SIGNAL_HANDLER

	var/atom/parent_atom = parent
	for(var/mob/living/living_viewer in can_see_contents())
		if(!living_viewer.CanReach(parent_atom))
			hide_from(living_viewer)
	if(!worn_check_aggressive(parent, user, TRUE))
		hide_from(user)
	update_actions()

/datum/component/storage/proc/worn_check(obj/item/storer, mob/user, no_message = FALSE)
	. = TRUE
	if(!istype(storer) || !istype(user) || !CHECK_BITFIELD(storage_flags, STORAGE_NO_WORN_ACCESS|STORAGE_NO_EQUIPPED_ACCESS))
		return TRUE

	if((storage_flags & STORAGE_NO_EQUIPPED_ACCESS) && (storer.item_flags & IN_INVENTORY))
		if(!no_message)
			to_chat(user, span_warning("[storer] is too bulky! I need to set it down before I can access it's contents!"))
		return FALSE
	else if((storage_flags & STORAGE_NO_WORN_ACCESS) && (storer.item_flags & IN_INVENTORY) && !user.is_holding(storer))
		if(!no_message)
			to_chat(user, span_warning("My arms aren't long enough to reach into [storer] while wearing it!"))
		return FALSE

/datum/component/storage/proc/worn_check_aggressive(obj/item/storer, mob/user, no_message = FALSE)
	. = TRUE
	if(!istype(storer) || !istype(user) || !CHECK_BITFIELD(storage_flags, STORAGE_NO_WORN_ACCESS|STORAGE_NO_EQUIPPED_ACCESS))
		return TRUE

	if(storage_flags & STORAGE_NO_EQUIPPED_ACCESS)
		if(!no_message)
			to_chat(user, span_warning("[storer] is too bulky! I need to set it down before I can access it's contents!"))
		return FALSE
	else if((storage_flags & STORAGE_NO_WORN_ACCESS) && !user.is_holding(storer))
		if(!no_message)
			to_chat(user, span_warning("My arms aren't long enough to reach into [storer] while wearing it!"))
		return FALSE

/datum/component/storage/proc/should_block_user_take(datum/source, obj/item/stored, mob/user, worn_check = FALSE, no_message = FALSE)
	SIGNAL_HANDLER
	if(worn_check && !worn_check(source, user, no_message))
		return TRUE
	if(!istype(src, /datum/component/storage/concrete/organ))
		var/atom/real_location = real_location()
		var/atom/recursive_loc = real_location?.loc
		var/depth = 0
		while(isatom(recursive_loc) && !isturf(recursive_loc) && !isarea(recursive_loc))
			var/datum/component/storage/biggerfish = recursive_loc.GetComponent(/datum/component/storage)
			if(biggerfish && !istype(biggerfish, /datum/component/storage/concrete/organ))
				depth++
				if(!biggerfish.worn_check(biggerfish.parent, user, TRUE))
					if(!no_message)
						to_chat(user, span_warning("[recursive_loc] is in the way!"))
					return TRUE
				else if(biggerfish.maximum_depth < depth)
					if(!no_message)
						to_chat(user, span_warning("[recursive_loc] is in the way!"))
					return TRUE
			recursive_loc = recursive_loc.loc
	return FALSE

/datum/component/storage/proc/get_carry_weight()
	. = 0
	//we do need a typecheck here
	for(var/obj/item/stored in contents())
		. += stored.get_carry_weight()

/datum/component/storage/proc/update_closer(rows = 0, cols = 0)
	closer.cut_overlays()
	closer.icon_state = "close"
	var/half = (cols - 1)/2
	var/half_ceiling = CEILING(half, 1)
	var/half_floor = FLOOR(half, 1)
	closer.screen_loc = "[src.screen_start_x+half_floor]:[src.screen_pixel_x],[src.screen_start_y+1]:[src.screen_pixel_y]"
	switch(cols)
		if(-INFINITY to 1)
			closer.icon_state = "close"
		if(2)
			closer.icon_state = "close_left"
		if(3 to INFINITY)
			closer.icon_state = "close_mid"
	var/image/offset_image
	for(var/overlayer in 1 to half_floor)
		var/state = (overlayer >= half_floor) ? "close_left" : "close_mid"
		offset_image = image(closer.icon, state)
		offset_image.transform = offset_image.transform.Translate(world.icon_size * -overlayer, 0)
		closer.add_overlay(offset_image)
	for(var/overlayer in 1 to half_ceiling)
		var/state = (overlayer >= half_ceiling) ? "close_right" : "close_mid"
		offset_image = image(closer.icon, state)
		offset_image.transform = offset_image.transform.Translate(world.icon_size * overlayer, 0)
		closer.add_overlay(offset_image)
	if(cols > 1)
		var/image/close_overlay = image(closer.icon, "close_overlay")
		close_overlay.transform = close_overlay.transform.Translate(world.icon_size * (half - half_floor), 0)
		closer.add_overlay(close_overlay)
