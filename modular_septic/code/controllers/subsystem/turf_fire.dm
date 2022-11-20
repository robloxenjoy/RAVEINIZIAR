SUBSYSTEM_DEF(turf_fire)
	name = "Turf Fire"
	runlevels = RUNLEVEL_GAME|RUNLEVEL_POSTGAME
	flags = SS_NO_INIT
	wait = 2 SECONDS
	var/list/fires = list()

/datum/controller/subsystem/turf_fire/fire()
	for(var/atom/movable/fire/fire as anything in fires)
		fire.process()
		// this really isn't essential
		if(MC_TICK_CHECK)
			return
