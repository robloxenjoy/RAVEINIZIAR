//Consider making all of these behaviours a smart component/element? Something that's only applied wherever it needs to be
//Could probably have the variables on the turf level, and the behaviours being activated/deactived on the component level as the vars are updated
/turf/open/CanPass(atom/movable/mover, border_dir)
	if(!(mover.movement_type & PHASING | FLOATING | FLYING))
		var/turf/mover_turf = get_turf(mover)
		if((turf_height - mover_turf?.turf_height) >= TURF_HEIGHT_BLOCK_THRESHOLD)
			return FALSE
	return ..()
