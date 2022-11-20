/***************************************************/
/********************PROPER GROUPING**************/

//Whenever you add a liquid cell add its contents to the group, have the group hold the reference to total reagents for processing sake
//Have the liquid turfs point to a partial liquids reference in the group for any interactions
//Have the liquid group handle the total reagents datum, and reactions too (apply fraction?)

/datum/liquids_group
	var/list/members = list()
	var/color
	var/next_share = 0
	var/dirty = TRUE
	var/amount_of_active_turfs = 0
	var/decay_counter = 0
	var/expected_turf_height = 0
	var/cached_color
	var/list/last_cached_fraction_share
	var/last_cached_total_volume = 0
	var/last_cached_thermal = 0
	var/last_cached_overlay_state = LIQUID_STATE_PUDDLE

/datum/liquids_group/New(height)
	SSliquids.active_groups[src] = TRUE
	color = "#[random_color()]"
	expected_turf_height = height

/datum/liquids_group/proc/add_to_group(turf/turf_added)
	members[turf_added] = TRUE
	turf_added.liquids_group = src
	if(SSliquids.active_turfs[turf_added])
		amount_of_active_turfs++
	if(turf_added.liquids)
		turf_added.liquids.has_cached_share = FALSE

/datum/liquids_group/proc/remove_from_group(turf/turf_removed)
	members -= turf_removed
	turf_removed.liquids_group = null
	if(SSliquids.active_turfs[turf_removed])
		amount_of_active_turfs--
	if(!length(members))
		qdel(src)

/datum/liquids_group/proc/can_merge_group(datum/liquids_group/other_group)
	if(expected_turf_height == other_group.expected_turf_height)
		return TRUE
	return FALSE

/datum/liquids_group/proc/merge_group(datum/liquids_group/other_group)
	amount_of_active_turfs += other_group.amount_of_active_turfs
	var/turf/member //faster declaration
	for(var/t in other_group.members)
		member = t
		member.liquids_group = src
		members[member] = TRUE
		if(member.liquids)
			member.liquids.has_cached_share = FALSE
	other_group.members = list()
	qdel(other_group)
	share()

/datum/liquids_group/proc/break_group()
	//Flag puddles to the evaporation queue
	var/turf/member //faster declaration
	for(var/t in members)
		member = t
		if(member.liquids?.liquid_state >= LIQUID_STATE_PUDDLE)
			SSliquids.evaporation_queue[member] = TRUE

	share(TRUE)
	qdel(src)

/datum/liquids_group/Destroy()
	SSliquids.active_groups -= src
	var/turf/member //faster declaration
	for(var/t in members)
		member = t
		member.liquids_group = null
	members = null
	return ..()

/datum/liquids_group/proc/check_adjacency(turf/checked)
	var/list/recursive_adjacent = list()
	var/list/current_adjacent = list()
	current_adjacent[checked] = TRUE
	recursive_adjacent[checked] = TRUE
	var/getting_new_turfs = TRUE
	var/indef_loop_safety = 0
	var/turf/adjacent_cell //faster declaration
	while(getting_new_turfs && indef_loop_safety < LIQUID_RECURSIVE_LOOP_SAFETY)
		indef_loop_safety++
		getting_new_turfs = FALSE
		var/list/new_adjacent = list()
		for(var/neighbor in current_adjacent)
			adjacent_cell = neighbor
			for(var/neighbor_of_neighbor in adjacent_cell.get_atmos_adjacent_turfs())
				if(!recursive_adjacent[neighbor_of_neighbor])
					new_adjacent[neighbor_of_neighbor] = TRUE
					recursive_adjacent[neighbor_of_neighbor] = TRUE
					getting_new_turfs = TRUE
		current_adjacent = new_adjacent
	//All adjacent, somehow
	if(LAZYLEN(recursive_adjacent) == length(members))
		return
	var/datum/liquids_group/new_group = new(expected_turf_height)
	for(var/member in members)
		if(!recursive_adjacent[member])
			remove_from_group(member)
			new_group.add_to_group(member)

/datum/liquids_group/proc/share(use_liquids_color = FALSE)
	var/any_share = FALSE
	var/cached_shares = 0
	var/list/cached_add = list()
	var/cached_volume = 0
	var/cached_thermal = 0

	var/atom/movable/liquid/cached_liquids
	var/turf/member //faster declaration
	for(var/cell in members)
		member = cell
		if(member.liquids)
			any_share = TRUE
			cached_liquids = member.liquids

			if(cached_liquids.has_cached_share && last_cached_fraction_share)
				cached_shares++
				continue

			for(var/reagent_type in cached_liquids.reagent_list)
				if(!cached_add[reagent_type])
					cached_add[reagent_type] = 0
				cached_add[reagent_type] += cached_liquids.reagent_list[reagent_type]
			cached_volume += cached_liquids.total_reagents
			cached_thermal += cached_liquids.total_reagents * cached_liquids.temperature
	if(!any_share)
		return

	decay_counter = 0

	if(cached_shares)
		for(var/reagent_type in last_cached_fraction_share)
			if(!cached_add[reagent_type])
				cached_add[reagent_type] = 0
			cached_add[reagent_type] += last_cached_fraction_share[reagent_type] * cached_shares
		cached_volume += last_cached_total_volume * cached_shares
		cached_thermal += cached_shares * last_cached_thermal

	for(var/reagent_type in cached_add)
		cached_add[reagent_type] = cached_add[reagent_type] / length(members)
	cached_volume = cached_volume / length(members)
	cached_thermal = cached_thermal / length(members)
	var/temp_to_set = cached_thermal / max(1, cached_volume)
	last_cached_thermal = cached_thermal
	last_cached_fraction_share = cached_add
	last_cached_total_volume = cached_volume
	var/mixed_color = use_liquids_color ? mix_color_from_reagent_list(cached_add) : color
	if(use_liquids_color)
		mixed_color = mix_color_from_reagent_list(cached_add)
	else if (GLOB.liquid_debug_colors)
		mixed_color = color
	else
		if(!cached_color)
			cached_color = mix_color_from_reagent_list(cached_add)
		mixed_color = cached_color

	var/height = CEILING(cached_volume/LIQUID_HEIGHT_DIVISOR, 1)

	var/determined_new_state
	var/state_height = height
	switch(state_height)
		if(0 to LIQUID_ANKLES_LEVEL_HEIGHT-1)
			determined_new_state = LIQUID_STATE_PUDDLE
		if(LIQUID_ANKLES_LEVEL_HEIGHT to LIQUID_WAIST_LEVEL_HEIGHT-1)
			determined_new_state = LIQUID_STATE_ANKLES
		if(LIQUID_WAIST_LEVEL_HEIGHT to LIQUID_SHOULDERS_LEVEL_HEIGHT-1)
			determined_new_state = LIQUID_STATE_WAIST
		if(LIQUID_SHOULDERS_LEVEL_HEIGHT to LIQUID_FULLTILE_LEVEL_HEIGHT-1)
			determined_new_state = LIQUID_STATE_SHOULDERS
		if(LIQUID_FULLTILE_LEVEL_HEIGHT to INFINITY)
			determined_new_state = LIQUID_STATE_FULLTILE

	var/new_liquids = FALSE
	for(var/cell in members)
		member = cell
		new_liquids = FALSE
		if(!member.liquids)
			new_liquids = TRUE
			member.liquids = new(member)
		cached_liquids = member.liquids

		cached_liquids.reagent_list = cached_add.Copy()
		cached_liquids.total_reagents = cached_volume
		cached_liquids.temperature = temp_to_set

		cached_liquids.has_cached_share = TRUE
		cached_liquids.attrition = 0

		cached_liquids.color = mixed_color
		cached_liquids.set_height(height)

		if(determined_new_state != cached_liquids.liquid_state)
			cached_liquids.set_new_liquid_state(determined_new_state)

		//Only simulate a turf exposure when we had to create a new liquid tile
		if(new_liquids)
			cached_liquids.expose_my_turf()

/datum/liquids_group/proc/process_cell(turf/cell)
	var/turf/adjacent_cell //faster declaration
	for(var/neighbor in cell.get_atmos_adjacent_turfs())
		adjacent_cell = neighbor
		var/my_liquid_height = TOTAL_LIQUID_HEIGHT(cell)
		var/target_liquid_height = TOTAL_LIQUID_HEIGHT(adjacent_cell)
		//IMMUTABLE MADNESS
		if(adjacent_cell.liquids?.immutable)
			if(cell.z != adjacent_cell.z)
				var/turf/z_turf_below = SSmapping.get_turf_below(cell)
				if(adjacent_cell == z_turf_below)
					qdel(cell.liquids, TRUE)
					return
				else
					continue

			//CHECK DIFFERENT TURF HEIGHT THING
			if(cell.liquid_height != adjacent_cell.liquid_height)
				var/difference = (my_liquid_height - target_liquid_height)
				if(difference > 1)
					var/coeff = (cell.liquids.liquid_height / (cell.liquids.liquid_height + abs(cell.liquid_height)))
					var/height_diff = min(0.4, abs(target_liquid_height / my_liquid_height) * coeff)
					cell.liquid_fraction_delete(height_diff)
					. = TRUE
				continue

			if((adjacent_cell.liquid_height - cell.liquid_height) > 1)
				SSliquids.active_immutables[adjacent_cell] = TRUE
				. = TRUE
				continue
		//END OF IMMUTABLE MADNESS

		//Don't try to share liquids normally if we can't
		if(!cell.can_share_liquids_with(adjacent_cell))
			continue

		//DIFFERING Z LEVEL HANDLING
		if(cell.z != adjacent_cell.z)
			//Only interact with cell directly below us
			var/turf/z_turf_below = SSmapping.get_turf_below(cell)
			if(adjacent_cell == z_turf_below)
				if(!(target_liquid_height >= LIQUID_HEIGHT_CONSIDER_FULL_TILE))
					cell.liquid_fraction_share(adjacent_cell, 1)
					qdel(cell.liquids, TRUE)
					. = TRUE
			continue
		//DIFFERENT HEIGHT HANDLING
		if(cell.liquid_height != adjacent_cell.liquid_height)
			//Give liquids to lower liquid heights, but not higher
			var/difference = (my_liquid_height - target_liquid_height)
			if(difference > 1)
				var/coeff = (cell.liquids.liquid_height / (cell.liquids.liquid_height + abs(cell.liquid_height)))
				var/fraction = min(0.4, abs(1 - (target_liquid_height / my_liquid_height)) * coeff)
				cell.liquid_fraction_share(adjacent_cell, fraction)
				. = TRUE
			continue
		//END OF HEIGHT
		if(!adjacent_cell.liquids_group)
			add_to_group(adjacent_cell)
		//Try merge groups if possible
		else if((adjacent_cell.liquids_group != cell.liquids_group) && cell.liquids_group.can_merge_group(adjacent_cell.liquids_group))
			cell.liquids_group.merge_group(adjacent_cell.liquids_group)
		. = TRUE
		SSliquids.add_active_turf(adjacent_cell)
	//Do we want it to spread once per process or many times?
	//Make sure to handle up/down z levels on adjacency properly
	if(.)
		dirty = TRUE
