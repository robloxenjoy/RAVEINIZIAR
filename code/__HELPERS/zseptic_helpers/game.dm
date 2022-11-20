//viewers() but with a signal, for blacklisting otherwise capable of viewing atoms
/proc/fov_viewers(depth = world.view, atom/center)
	if(!center)
		return
	. = viewers(depth, center)
	for(var/mob/viewer as anything in .)
		SEND_SIGNAL(viewer, COMSIG_MOB_FOV_VIEWER, center, depth, .)

//view() but with a signal, to allow blacklisting some of the otherwise visible atoms.
/proc/fov_view(dist = world.view, atom/center)
	. = view(dist, center)
	SEND_SIGNAL(center, COMSIG_MOB_FOV_VIEW, center, dist, .)
