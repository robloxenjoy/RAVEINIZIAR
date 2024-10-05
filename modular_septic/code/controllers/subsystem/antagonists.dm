SUBSYSTEM_DEF(antagonists)
	name = "Antagonists"
	flags = SS_NO_FIRE

	var/fog_world = FALSE
	var/gay_guns = FALSE
	var/blue_mode = FALSE
//	var/crazy_traps = FALSE

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
	if(prob(60))
		blue_mode = TRUE
//	if(prob(50))
//		crazy_traps = TRUE
	if(fog_world)
		for(var/area/maintenance/polovich/forest/C in world)
			if(C.fogger)
				for(var/turf/T in C)
					new /obj/effect/foga(T)
	if(blue_mode)
		SSticker.login_music = 'modular_septic/xtal.ogg'
		for(var/area/maintenance/polovich/lobby/C in world)
			if(C.crazy)
				for(var/turf/T in C)
					T.color = pick("#00abd2", "#0090f5")
				for(var/obj/structure/kaos/blackwindow/window in C)
					window.set_light(8, 4, "#0000b9")