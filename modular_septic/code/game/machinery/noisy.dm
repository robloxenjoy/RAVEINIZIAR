/obj/machinery/broken_ventilation
	name = "broken vent"
	desc = "Some holes in the wall to cycle air around the warehouse, looks like it hasn't been maintained for years, but it still runs."
	icon = 'modular_septic/icons/obj/structures/efn.dmi'
	icon_state = "vents"
	base_icon_state = "vents"
	plane = GAME_PLANE_UPPER
	layer = WALL_OBJ_LAYER
	density = FALSE
	var/datum/looping_sound/vent/soundloop

/obj/machinery/broken_ventilation/Initialize(mapload)
	. = ..()
	soundloop = new(src, FALSE)

/obj/machinery/broken_ventilation/process()
	. = ..()
	if((machine_stat & (NOPOWER|BROKEN)) && !(interaction_flags_machine & INTERACT_MACHINE_OFFLINE))
		soundloop.stop()
	else
		soundloop.start()

/obj/machinery/broken_ventilation/Destroy()
	. = ..()
	QDEL_NULL(soundloop)

/obj/machinery/broken_ventilation/north
	// Infared didn't draw directionals.
	pixel_y = 30

/obj/effect/escape_noises
	name = "escape noises"
	icon = 'modular_septic/icons/obj/structures/efn.dmi'
	icon_state = "escape_noises"
	plane = GAME_PLANE_UPPER
	layer = WALL_OBJ_LAYER
	density = FALSE
	var/datum/looping_sound/escape_noises/soundloop

/obj/effect/escape_noises/Initialize(mapload)
	. = ..()
	icon_state = null
	soundloop = new(src, FALSE)

/obj/effect/escape_noises/process()
	. = ..()
	soundloop.start()

/obj/effect/escape_noises/Destroy()
	. = ..()
	QDEL_NULL(soundloop)
