/obj/machinery/power/apc
	/// The crewmembers do get a bit quirky at night
	var/power_outage_sound = 'modular_septic/sound/effects/poweroutage.ogg'
	/// Volume of the power outage sound
	var/power_outage_volume = 100
	/// Extrarange of the power outage sound
	var/power_outage_extrarange = 3

/obj/machinery/power/apc/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/wall_mount)
