/turf/onShuttleMove(turf/newT, list/movement_force, move_dir)
	if(newT == src) // In case of in place shuttle rotation shenanigans.
		return
	//Destination turf changes
	//Baseturfs is definitely a list or this proc wouldnt be called
	var/shuttle_boundary = baseturfs.Find(/turf/baseturf_skipover/shuttle)
	if(!shuttle_boundary)
		CRASH("A turf queued to move via shuttle somehow had no skipover in baseturfs. [src]([type]):[loc]")
	var/depth = length(baseturfs) - shuttle_boundary + 1

	if(newT.liquids_group)
		newT.liquids_group.remove_from_group(newT)
	if(newT.liquids)
		if(newT.liquids.immutable)
			newT.liquids.remove_turf(src)
		else
			qdel(newT.liquids, TRUE)

	if(liquids_group)
		liquids_group.remove_from_group(src)
	if(liquids)
		liquids.change_to_new_turf(newT)
		newT.reasses_liquids()

	newT.CopyOnTop(src, 1, depth, TRUE)
	newT.blocks_air = TRUE
	newT.air_update_turf(TRUE, FALSE)
	blocks_air = TRUE
	air_update_turf(TRUE, TRUE)
	if(isopenturf(newT))
		var/turf/open/new_open = newT
		new_open.copy_air_with_tile(src)
	SEND_SIGNAL(src, COMSIG_TURF_ON_SHUTTLE_MOVE, newT)

	return TRUE
