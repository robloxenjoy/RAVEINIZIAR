/obj/machinery/status_display
	icon = 'modular_septic/icons/obj/machinery/status_display.dmi'

/obj/machinery/status_display/Initialize(mapload, ndir, building)
	. = ..()
	AddElement(/datum/element/wall_mount)
