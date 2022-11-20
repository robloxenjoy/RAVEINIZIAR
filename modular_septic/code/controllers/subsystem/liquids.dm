SUBSYSTEM_DEF(liquids)
	name = "Liquids"
	wait = 1 SECONDS
	flags = SS_KEEP_TIMING
	runlevels = RUNLEVEL_GAME | RUNLEVEL_POSTGAME

	var/list/active_turfs = list()
	var/list/currentrun_active_turfs = list()

	var/list/active_groups = list()

	var/list/active_immutables = list()

	var/list/evaporation_queue = list()
	var/evaporation_counter = 0 //Only process evaporation on intervals

	var/list/processing_fire = list()
	var/fire_counter = 0 //Only process fires on intervals

	var/list/singleton_immutables = list()

	var/run_type = SSLIQUIDS_RUN_TYPE_TURFS

/datum/controller/subsystem/liquids/proc/get_immutable(type)
	if(!singleton_immutables[type])
		var/atom/movable/liquid/immutable/new_one = new type()
		singleton_immutables[type] = new_one
	return singleton_immutables[type]

/datum/controller/subsystem/liquids/stat_entry(msg)
	msg += "AT:[active_turfs.len]|AG:[active_groups.len]|AIM:[active_immutables.len]|EQ:[evaporation_queue.len]|PF:[processing_fire.len]"
	return ..()

/datum/controller/subsystem/liquids/fire(resumed = FALSE)
	if(run_type == SSLIQUIDS_RUN_TYPE_TURFS)
		if(!length(currentrun_active_turfs) && length(active_turfs))
			currentrun_active_turfs = active_turfs.Copy()
		for(var/turf in currentrun_active_turfs)
			if(MC_TICK_CHECK)
				return
			var/turf/processing = turf
			processing.process_liquid_cell()
			currentrun_active_turfs -= processing //work off of index later
		if(!currentrun_active_turfs.len)
			run_type = SSLIQUIDS_RUN_TYPE_GROUPS
	if(run_type == SSLIQUIDS_RUN_TYPE_GROUPS)
		var/datum/liquids_group/liquids_group //faster declaration
		for(var/group in active_groups)
			liquids_group = group
			if(liquids_group.dirty)
				liquids_group.share()
				liquids_group.dirty = FALSE
			else if(!liquids_group.amount_of_active_turfs)
				liquids_group.decay_counter++
				if(liquids_group.decay_counter >= LIQUIDS_GROUP_DECAY_TIME)
					//Perhaps check if any turfs in here can spread before removing it? It's not unlikely they would
					liquids_group.break_group()
			if(MC_TICK_CHECK)
				break
		run_type = SSLIQUIDS_RUN_TYPE_IMMUTABLES
	if(run_type == SSLIQUIDS_RUN_TYPE_IMMUTABLES)
		var/turf/processing //faster declaration
		for(var/turf in active_immutables)
			processing = turf
			processing.process_immutable_liquid()
		run_type = SSLIQUIDS_RUN_TYPE_EVAPORATION

	if(run_type == SSLIQUIDS_RUN_TYPE_EVAPORATION)
		evaporation_counter++
		if(evaporation_counter >= REQUIRED_EVAPORATION_PROCESSES)
			for(var/turf in evaporation_queue)
				var/turf/evaporating = turf
				if(prob(EVAPORATION_CHANCE))
					evaporating.liquids.process_evaporation()
				if(MC_TICK_CHECK)
					break
			evaporation_counter = 0
		run_type = SSLIQUIDS_RUN_TYPE_FIRE

	if(run_type == SSLIQUIDS_RUN_TYPE_FIRE)
		fire_counter++
		if(fire_counter >= REQUIRED_FIRE_PROCESSES)
			var/turf/processing //faster declaration
			for(var/turf in processing_fire)
				processing = turf
				processing.liquids.process_fire()
				if(MC_TICK_CHECK)
					break
			fire_counter = 0
		run_type = SSLIQUIDS_RUN_TYPE_TURFS

/datum/controller/subsystem/liquids/proc/add_active_turf(turf/added_turf)
	if(!active_turfs[added_turf])
		active_turfs[added_turf] = TRUE
		if(added_turf.liquids_group)
			added_turf.liquids_group.amount_of_active_turfs++

/datum/controller/subsystem/liquids/proc/remove_active_turf(turf/remove_turf)
	if(active_turfs[remove_turf])
		active_turfs -= remove_turf
		if(remove_turf.liquids_group)
			remove_turf.liquids_group.amount_of_active_turfs--
