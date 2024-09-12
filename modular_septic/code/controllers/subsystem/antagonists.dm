SUBSYSTEM_DEF(antagonists)
	name = "Antagonists"
	flags = SS_NO_FIRE

	var/fog_world = FALSE
	var/gay_guns = FALSE

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
	if(fog_world)
		for(var/area/maintenance/polovich/forest/C in world)
			if(C.fogger)
				new /obj/effect/foga(C)
