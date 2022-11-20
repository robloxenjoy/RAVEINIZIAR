/**
  * Attached to smoothing atoms. Adds a globally-cached object to their vis_contents and updates based on junction changes.
  */
/datum/element/frill
	id_arg_index = 2
	element_flags = ELEMENT_BESPOKE | ELEMENT_DETACH
	var/icon
	var/upper_plane = FRILL_PLANE
	var/upper_layer = ABOVE_MOB_LAYER
	var/lower_plane = GAME_PLANE
	var/lower_layer = ABOVE_MOB_LAYER
	var/uses_icon_state = FALSE

/datum/element/frill/Attach(atom/target, \
							icon, \
							uses_icon_state = FALSE, \
							upper_plane = FRILL_PLANE, \
							upper_layer = ABOVE_MOB_LAYER, \
							lower_plane = GAME_PLANE, \
							lower_layer = ABOVE_MOB_LAYER)
	if(!isturf(target) && !ismovable(target))
		return ELEMENT_INCOMPATIBLE
	. = ..()
	src.icon = icon
	src.uses_icon_state = uses_icon_state
	src.upper_plane = upper_plane
	src.upper_layer = upper_layer
	src.lower_plane = lower_plane
	src.lower_layer = lower_layer
	RegisterSignal(target, COMSIG_ATOM_SET_SMOOTHED_ICON_STATE, .proc/on_junction_change)
	target.update_appearance(UPDATE_ICON)

/datum/element/frill/Detach(atom/target)
	. = ..()
	UnregisterSignal(target, COMSIG_ATOM_SET_SMOOTHED_ICON_STATE)
	target.update_appearance(UPDATE_ICON)

/datum/element/frill/proc/on_junction_change(atom/source, new_junction, icon_state)
	SIGNAL_HANDLER

	var/final_icon_state = (uses_icon_state ? icon_state : "frill")
	if(!(source.smoothing_junction & NORTH))
		source.cut_overlay(get_frill_appearance(icon, final_icon_state, source.smoothing_junction, plane = upper_plane, layer = upper_layer))
	else
		source.cut_overlay(get_frill_appearance(icon, final_icon_state, source.smoothing_junction, plane = lower_plane, layer = lower_layer))

	if(!(new_junction & NORTH))
		source.add_overlay(get_frill_appearance(icon, final_icon_state, new_junction, plane = upper_plane, layer = upper_layer))
	else
		source.add_overlay(get_frill_appearance(icon, final_icon_state, new_junction, plane = lower_plane, layer = lower_layer))
