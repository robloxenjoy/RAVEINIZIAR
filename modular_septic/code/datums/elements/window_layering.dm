/datum/element/window_layering
	element_flags = ELEMENT_BESPOKE | ELEMENT_DETACH
	/// Whether or not we should add a cap overlay
	var/has_top = FALSE

/datum/element/window_layering/Attach(datum/target, has_top = FALSE)
	. = ..()
	if(!ismovable(target))
		return ELEMENT_INCOMPATIBLE
	src.has_top = has_top
	var/atom/movable/real_target = target
	on_dir_changed(real_target, real_target.dir, real_target.dir)
	RegisterSignal(real_target, COMSIG_ATOM_DIR_CHANGE, .proc/on_dir_changed)
	if(has_top)
		RegisterSignal(real_target, COMSIG_ATOM_UPDATE_OVERLAYS, .proc/update_overlays)
	real_target.update_appearance(UPDATE_ICON)

/datum/element/window_layering/Detach(datum/source)
	. = ..()
	UnregisterSignal(source, COMSIG_ATOM_DIR_CHANGE)
	if(has_top)
		UnregisterSignal(source, COMSIG_ATOM_UPDATE_OVERLAYS)
	var/atom/movable/real_source = source
	real_source.plane = initial(real_source.plane)
	real_source.layer = initial(real_source.layer)
	real_source.setDir(real_source.dir)
	real_source.update_appearance(UPDATE_ICON)

/datum/element/window_layering/proc/on_dir_changed(atom/movable/target, olddir, newdir)
	switch(newdir)
		if(NORTH)
			target.plane = GAME_PLANE_ABOVE_WINDOW
			target.layer = WINDOW_LOW_LAYER
		if(SOUTH)
			target.plane = GAME_PLANE_UPPER
			target.layer = WINDOW_HIGH_LAYER
		if(WEST, EAST)
			target.plane = GAME_PLANE_ABOVE_WINDOW
			target.layer = WINDOW_MIDDLE_LAYER
		else
			target.plane = GAME_PLANE_UPPER
			target.layer = WINDOW_HIGH_LAYER
	if(has_top)
		target.update_appearance(UPDATE_ICON)

/datum/element/window_layering/proc/update_overlays(atom/movable/target, list/overlays)
	var/mutable_appearance/cap_overlay = mutable_appearance(target.icon, "[target.icon_state]_top")
	switch(target.dir)
		if(NORTH)
			cap_overlay.plane = FRILL_PLANE_LOW
			cap_overlay.layer = WINDOW_CAP_LOW_LAYER
		if(SOUTH)
			cap_overlay.plane = FRILL_PLANE_LOW
			cap_overlay.layer = WINDOW_CAP_HIGH_LAYER
		if(WEST, EAST)
			cap_overlay.plane = FRILL_PLANE_LOW
			cap_overlay.layer = WINDOW_CAP_MID_LAYER
		else
			cap_overlay.plane = FRILL_PLANE_LOW
			cap_overlay.layer = WINDOW_CAP_HIGH_LAYER
	overlays += cap_overlay
