/obj/machinery/fusebox
	name = "Fuse Box"
	desc = "A large rectangular box filled with wiring, and switches that control the power in the room. Rectangular boxes are also known to contain severed human heads."
	icon = 'modular_septic/icons/obj/structures/efn.dmi'
	icon_state = "powerbox"
	base_icon_state = "powerbox"
	plane = GAME_PLANE_UPPER
	layer = WALL_OBJ_LAYER
	density = FALSE
	resistance_flags = INDESTRUCTIBLE | LAVA_PROOF | FIRE_PROOF | UNACIDABLE | ACID_PROOF | FREEZE_PROOF
	var/powerswitch_flags
	var/door_opened = FALSE
	var/locked = TRUE

/obj/machinery/fusebox/Initialize(mapload)
	. = ..()
	update_appearance(UPDATE_ICON)

/obj/machinery/fusebox/update_overlays()
	. = ..()
	if(!door_opened)
		. += "[base_icon_state]_door_closed"
	else
		. += "[base_icon_state]_door"
