/turf
	var/atom/movable/liquid/liquids
	var/datum/liquids_group/liquids_group
	/// This height is used exclusively for liquid calculations!
	var/liquid_height = 0

/turf/examine(mob/user)
	. = ..()
	if(liquids)
		switch(liquids.liquid_state)
			if(LIQUID_STATE_PUDDLE)
				. += span_notice("[capitalize(name)] is coated with a puddle of liquids.")
			if(LIQUID_STATE_ANKLES)
				. += span_notice("[capitalize(name)] is flooded with an ankle-level pool of liquids.")
			if(LIQUID_STATE_WAIST)
				. += span_warning("[capitalize(name)] is flooded with a waist-level pool of liquids.")
			if(LIQUID_STATE_SHOULDERS)
				. += span_danger("[capitalize(name)] is flooded with a shoulder-level pool of liquids.")
			if(LIQUID_STATE_FULLTILE)
				. += span_danger("[capitalize(name)] is completely flooded with a pool of liquids.")

/turf/proc/convert_immutable_liquids()
	if(!liquids || !liquids.immutable)
		return
	var/datum/reagents/tempr = liquids.take_reagents_flat(liquids.total_reagents)
	var/cached_height = liquids.liquid_height
	liquids.remove_turf(src)
	liquids = new(src)
	liquids.liquid_height = cached_height //Prevent height effects
	add_liquid_from_reagents(tempr)
	qdel(tempr)

/turf/proc/reasses_liquids()
	if(!liquids)
		return
	if(liquids_group)
		liquids_group.remove_from_group(src)
	SSliquids.add_active_turf(src)

/turf/proc/liquid_fraction_delete(fraction)
	for(var/reagent_type in liquids.reagent_list)
		var/volume_change = liquids.reagent_list[reagent_type] * fraction
		liquids.reagent_list[reagent_type] -= volume_change
		liquids.total_reagents -= volume_change

/turf/proc/liquid_fraction_share(turf/taker, fraction)
	if(!liquids)
		return
	if(fraction > 1)
		CRASH("Liquid fraction share more than 100%")
	var/list/new_liquid_list = list()
	for(var/reagent_type in liquids.reagent_list)
		var/volume_change = liquids.reagent_list[reagent_type] * fraction
		liquids.reagent_list[reagent_type] -= volume_change
		liquids.total_reagents -= volume_change
		new_liquid_list[reagent_type] = volume_change
	taker.add_liquid_list(new_liquid_list, FALSE, liquids.temperature)
	liquids.has_cached_share = FALSE

/turf/proc/liquid_update_turf()
	if(liquids?.immutable)
		SSliquids.active_immutables[src] = TRUE
		return
	//Check atmos adjacency to cut off any disconnected groups
	if(liquids_group)
		var/assoc_atmos_turfs = list()
		for(var/neighbor in get_atmos_adjacent_turfs())
			assoc_atmos_turfs[neighbor] = TRUE
		//Check any cardinals that may have a matching group
		var/turf/connection //faster declaration
		for(var/direction in GLOB.cardinals)
			connection = get_step(src, direction)
			//Same group of which we do not share atmos adjacency
			if(!assoc_atmos_turfs[connection] && connection.liquids_group && connection.liquids_group == liquids_group)
				connection.liquids_group.check_adjacency(connection)

	SSliquids.add_active_turf(src)

/turf/proc/add_liquid_from_reagents(datum/reagents/giver, no_react = FALSE)
	var/list/compiled_list = list()
	var/list/has_solvent = list()
	var/datum/reagent/reagent //faster declaration
	for(var/reagent_type in giver.reagent_list)
		reagent = reagent_type
		if((reagent.reagent_state == LIQUID) && (reagent.dissolve_per_unit))
			if(has_solvent[reagent.polarity])
				has_solvent[reagent.polarity] += reagent.dissolve_per_unit * reagent.volume
			else
				has_solvent[reagent.polarity] = reagent.dissolve_per_unit * reagent.volume
	for(var/reagent_type in giver.reagent_list)
		reagent = reagent_type
		//It's not a liquid, can only pool if we happen to have the right solvent
		if(reagent.reagent_state != LIQUID)
			if(!has_solvent[reagent.polarity])
				continue
			var/can_dissolve = min(has_solvent[reagent.polarity], reagent.volume)
			has_solvent[reagent.polarity] -= can_dissolve
			compiled_list[reagent.type] = can_dissolve
		else
			compiled_list[reagent.type] = reagent.volume
	//Let's say the beaker is full of non-liquids - Then we can't pool up
	if(length(compiled_list))
		add_liquid_list(compiled_list, no_react, giver.chem_temp)

//More efficient than add_liquid for multiples
/turf/proc/add_liquid_list(list/reagent_list, no_react = FALSE, chem_temp = 300)
	if(!liquids)
		liquids = new(src)
	if(liquids.immutable)
		return

	var/prev_total_reagents = liquids.total_reagents
	var/prev_thermal_energy = prev_total_reagents * liquids.temperature

	for(var/reagent in reagent_list)
		if(!liquids.reagent_list[reagent])
			liquids.reagent_list[reagent] = 0
		liquids.reagent_list[reagent] += reagent_list[reagent]
		liquids.total_reagents += reagent_list[reagent]

	var/recieved_thermal_energy = (liquids.total_reagents - prev_total_reagents) * chem_temp
	liquids.temperature = (recieved_thermal_energy + prev_thermal_energy) / liquids.total_reagents

	if(!no_react)
		//We do react so, make a simulation
		liquids.create_reagents(10000)
		var/datum/reagents/reagent_holder = liquids.reagents
		reagent_holder.add_reagent_list(liquids.reagent_list)
		reagent_holder.chem_temp = liquids.temperature
		if(reagent_holder.handle_reactions())//Any reactions happened, so re-calculate our reagents
			liquids.reagent_list = list()
			liquids.total_reagents = 0
			var/datum/reagent/reagent //faster declaration
			for(var/reagent_type in reagent_holder.reagent_list)
				reagent = reagent_type
				liquids.reagent_list[reagent.type] = reagent.volume
				liquids.total_reagents += reagent.volume
			liquids.temperature = reagent_holder.chem_temp
			if(!liquids.total_reagents) //Our reaction exerted all of our reagents, remove self
				qdel(reagent_holder)
				qdel(liquids)
				return
		qdel(reagent_holder)
		//Expose turf
		liquids.expose_my_turf()

	liquids.calculate_height()
	liquids.set_color_from_reagents()
	liquids.has_cached_share = FALSE
	SSliquids.add_active_turf(src)
	if(liquids_group)
		liquids_group.dirty = TRUE

/turf/proc/add_liquid(reagent, amount, no_react = FALSE, chem_temp = 300)
	if(amount <= 0)
		return
	if(!liquids)
		liquids = new(src)
	if(liquids.immutable)
		return

	var/prev_thermal_energy = liquids.total_reagents * liquids.temperature

	if(!liquids.reagent_list[reagent])
		liquids.reagent_list[reagent] = 0
	liquids.reagent_list[reagent] += amount
	liquids.total_reagents += amount

	liquids.temperature = ((amount * chem_temp) + prev_thermal_energy) / max(1, liquids.total_reagents)

	if(!no_react)
		//We do react so, make a simulation
		liquids.create_reagents(10000)
		var/datum/reagents/reagent_holder = liquids.reagents
		reagent_holder.add_reagent_list(liquids.reagent_list)
		//Any reactions happened, so re-calculate our reagents
		if(reagent_holder.handle_reactions())
			liquids.reagent_list = list()
			liquids.total_reagents = 0
			var/datum/reagent/liquid //faster declaration
			for(var/reagent_type in reagents.reagent_list)
				liquid = reagent_type
				liquids.reagent_list[liquid.type] = liquid.volume
				liquids.total_reagents += liquid.volume
			liquids.temperature = reagent_holder.chem_temp
			if(!liquids.total_reagents) //Our reaction exerted all of our reagents, remove self
				qdel(reagent_holder)
				qdel(liquids)
				return
		qdel(reagent_holder)
		//Expose turf
		liquids.expose_my_turf()

	liquids.calculate_height()
	liquids.set_color_from_reagents()
	liquids.has_cached_share = FALSE
	SSliquids.add_active_turf(src)
	if(liquids_group)
		liquids_group.dirty = TRUE

/turf/proc/can_share_liquids_with(turf/target)
	//One of us is a spaceturf
	if(isspaceturf(target) || isspaceturf(src))
		return FALSE
	//Target is immutable
	if(target.liquids?.immutable)
		return FALSE
	//We're just a puddle, we can't spread
	if(liquids?.liquid_height <= 1)
		return FALSE

	//Only share with turf right below us, if z level differs
	if(z != target.z)
		var/turf/z_turf_below = SSmapping.get_turf_below(src)
		if(target == z_turf_below)
			return TRUE
		return FALSE
	else
		//Varied heights handling
		var/my_liquid_height = TOTAL_LIQUID_HEIGHT(src)
		var/target_liquid_height = TOTAL_LIQUID_HEIGHT(target)
		var/difference = (my_liquid_height - target_liquid_height)
		//Give liquids to lower liquid heights, but not higher
		if(difference > 1)
			return TRUE

	return FALSE

/turf/proc/process_liquid_cell()
	if(!liquids)
		if(!liquids_group)
			var/turf/neighbor //faster declaration
			for(var/t in get_atmos_adjacent_turfs())
				neighbor = t
				if(neighbor.liquids)
					if(neighbor.liquids.immutable)
						SSliquids.active_immutables[neighbor] = TRUE
					else if(neighbor.can_share_liquids_with(src))
						if(neighbor.liquids_group)
							liquids_group = new(liquid_height)
							liquids_group.add_to_group(src)
						SSliquids.add_active_turf(neighbor)
						SSliquids.remove_active_turf(src)
						break
		SSliquids.remove_active_turf(src)
		return
	if(!liquids_group)
		liquids_group = new(liquid_height)
		liquids_group.add_to_group(src)
	var/shared = liquids_group.process_cell(src)
	if(QDELETED(liquids)) //Liquids may be deleted in process cell
		SSliquids.remove_active_turf(src)
		return
	if(!shared)
		liquids.attrition++
	if(liquids.attrition >= LIQUID_ATTRITION_TO_STOP_ACTIVITY)
		SSliquids.remove_active_turf(src)

/turf/proc/process_immutable_liquid()
	var/any_share = FALSE
	var/turf/neighbor //faster declaration
	for(var/turf in get_atmos_adjacent_turfs())
		neighbor = turf
		if(can_share_liquids_with(neighbor))
			//Move this elsewhere sometime later?
			if(neighbor.liquids && (neighbor.liquids.liquid_height > liquids.liquid_height))
				continue
			any_share = TRUE
			neighbor.add_liquid_list(liquids.reagent_list, TRUE, liquids.temperature)
	if(!any_share)
		SSliquids.active_immutables -= src
