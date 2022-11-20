/atom/movable/screen/alert
	plane = PEEPER_PLANE
	layer = PEEPER_ACTION_LAYER
	/// In case we have a peeper tab we are associated with
	var/datum/peeper_tab/alerts/mytab

/atom/movable/screen/alert/MouseEntered(location, control, params)
	. = ..()
	mytab?.update_alert_tooltip(src)

/atom/movable/screen/alert/MouseExited(location, control, params)
	. = ..()
	mytab?.update_alert_tooltip(null)
