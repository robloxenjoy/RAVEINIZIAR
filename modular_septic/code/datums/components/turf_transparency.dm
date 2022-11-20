/datum/component/turf_z_transparency
	/// Whether this is an open space or a transparent floor
	var/is_openspace = FALSE
	/// Vis_contents holder used to handle the messy plane stuff
	var/atom/movable/vis_contents_holder/vis_contents_holder

/**
 * Initialization sets up the signals to handle updating viscontents when turfs above/below update
 * Handle plane and layer here too so that they don't cover other obs/turfs in Dream Maker
 */
/datum/component/turf_z_transparency/Initialize(is_openspace = FALSE)
	. = ..()
	if(!isturf(parent))
		return COMPONENT_INCOMPATIBLE
	src.is_openspace = is_openspace

	var/turf/our_turf = parent
	if(is_openspace)
		our_turf.plane = OPENSPACE_PLANE
		our_turf.vis_contents += GLOB.openspace_backdrop_one_for_all
	else
		vis_contents_holder = new()
		vis_contents_holder.plane = OPENSPACE_PLANE
		vis_contents_holder.appearance_flags = RESET_ALPHA | RESET_COLOR
		our_turf.plane = TRANSPARENT_FLOOR_PLANE
		our_turf.vis_contents += vis_contents_holder
	our_turf.layer = OPENSPACE_LAYER

	ADD_TRAIT(our_turf, TURF_Z_TRANSPARENT_TRAIT, COMPONENT_TRAIT(type))
	var/turf/below_turf = our_turf.below()
	if(below_turf)
		if(vis_contents_holder)
			vis_contents_holder.vis_contents += below_turf
		else
			our_turf.vis_contents += below_turf
	update_multiz(our_turf)

/datum/component/turf_z_transparency/Destroy(force, silent)
	. = ..()
	if(vis_contents_holder)
		QDEL_NULL(vis_contents_holder)

/datum/component/turf_z_transparency/RegisterWithParent()
	. = ..()
	RegisterSignal(parent, COMSIG_TURF_MULTIZ_NEW, .proc/on_multiz_turf_new)
	RegisterSignal(parent, COMSIG_TURF_MULTIZ_DEL, .proc/on_multiz_turf_del)

/datum/component/turf_z_transparency/UnregisterFromParent()
	. = ..()
	UnregisterSignal(parent, list(COMSIG_TURF_MULTIZ_NEW, COMSIG_TURF_MULTIZ_DEL))
	var/turf/our_turf = parent
	our_turf.vis_contents.len = 0
	our_turf.underlays.len = 0
	our_turf.plane = initial(our_turf.plane)
	our_turf.layer = initial(our_turf.layer)
	REMOVE_TRAIT(our_turf, TURF_Z_TRANSPARENT_TRAIT, COMPONENT_TRAIT(type))

/// Updates the vis_contents or underlays below this tile
/datum/component/turf_z_transparency/proc/update_multiz(turf/our_turf)
	var/turf/below_turf = our_turf.below()
	if(!below_turf)
		our_turf.vis_contents.len = 0
		add_baseturf_underlay(our_turf)

	// Show girders below closed turfs
	if(isclosedturf(our_turf))
		var/mutable_appearance/girder_underlay = mutable_appearance('icons/obj/structures.dmi', "girder", layer = TURF_LAYER-0.01)
		girder_underlay.appearance_flags = RESET_ALPHA | RESET_COLOR
		our_turf.underlays += girder_underlay
		var/mutable_appearance/plating_underlay = mutable_appearance('icons/turf/floors.dmi', "plating", layer = TURF_LAYER-0.02)
		plating_underlay.appearance_flags = RESET_ALPHA | RESET_COLOR
		our_turf.underlays += plating_underlay

	return TRUE

/datum/component/turf_z_transparency/proc/on_multiz_turf_del(turf/our_turf, turf/below_turf, dir)
	SIGNAL_HANDLER

	if(dir != DOWN)
		return

	update_multiz(our_turf)

/datum/component/turf_z_transparency/proc/on_multiz_turf_new(turf/our_turf, turf/below_turf, dir)
	SIGNAL_HANDLER

	if(dir != DOWN)
		return

	update_multiz(our_turf)

/// Called when there is no real turf below this turf
/datum/component/turf_z_transparency/proc/add_baseturf_underlay(turf/our_turf)
	// We don't ever want our bottom turf to be openspace
	if(is_openspace)
		our_turf.ChangeTurf(/turf/open/floor/plating, flags = CHANGETURF_INHERIT_AIR)
		return
	var/turf/path = SSmapping.level_trait(our_turf.z, ZTRAIT_BASETURF) || /turf/open/space
	if(!ispath(path))
		path = text2path(path)
		if(!ispath(path))
			warning("Z-level [our_turf.z] has invalid baseturf '[SSmapping.level_trait(our_turf.z, ZTRAIT_BASETURF)]'")
			path = /turf/open/space
	var/mutable_appearance/underlay_appearance = mutable_appearance(initial(path.icon), initial(path.icon_state), layer = TURF_LAYER-0.02, plane = PLANE_SPACE)
	underlay_appearance.appearance_flags = RESET_ALPHA | RESET_COLOR
	our_turf.underlays += underlay_appearance
