/proc/init_frill_blockers()
	var/list/blockers = list()
	for(var/type in subtypesof(/atom/movable/blocker))
		var/atom/movable/blocker/blocker = new type()
		blockers[blocker.type] = blocker
	return blockers
