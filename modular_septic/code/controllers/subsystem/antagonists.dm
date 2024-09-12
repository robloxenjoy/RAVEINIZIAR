SUBSYSTEM_DEF(antagonists)
	name = "Antagonists"
	flags = SS_NO_FIRE

	var/fog_world = FALSE
	var/gay_guns = FALSE
	var/crazy_traps = FALSE

/datum/controller/subsystem/antagonists/Initialize(start_timeofday)
	. = ..()
	GLOB.syndicate_employers = list("Dream Agent", "Dream HVAX")
	GLOB.normal_employers = list("Dream Agent", "Dream KVAX")
	GLOB.hijack_employers = list("Dream HVAX")
	GLOB.nanotrasen_employers = list("Dream KVAX")
	if(prob(50))
		fog_world = TRUE
	if(prob(50))
		gay_guns = TRUE
	if(prob(50))
		crazy_traps = TRUE
	if(fog_world)
		for(var/area/maintenance/polovich/forest/C in world)
			if(C.fogger)
				for(var/turf/T in C)
					new /obj/effect/foga(T)
	if(crazy_traps)
		for(var/turf/open/floor/plating/polovich/C in world)
			if(C.trapturf)
				for(var/obj/M in get_turf(C))
					if(M && !M.can_spawn_various_shit)
						return
					if(prob(40))
						new /obj/structure/barbwire(C)
					else
						if(prob(20))
							new /obj/structure/mineexplosive/mineplit(C)