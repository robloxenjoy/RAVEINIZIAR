SUBSYSTEM_DEF(light_flickering)
	name = "Light Flickering"
	wait = 1 MINUTES
	flags = SS_NO_INIT | SS_BACKGROUND
	runlevels = RUNLEVEL_GAME
	var/list/obj/machinery/light/active_lights = list()

/datum/controller/subsystem/light_flickering/fire(resumed)
	for(var/obj/machinery/light/light as anything in active_lights)
		if(!prob(20))
			continue
		playsound(light, 'modular_septic/sound/machinery/broken_bulb_sound.wav', 50, FALSE, 0)
		light.flicker(10)
