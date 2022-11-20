/obj/machinery/door/metal_door/wood_door
	name = "Wooden Door"
	desc = "A flimsy wooden door used for libraries and other nerd-related areas"
	icon = 'modular_septic/icons/obj/structures/wood_door.dmi'
	base_icon_state = "wood"
	icon_state = "wood"
	doorOpen = 'modular_septic/sound/doors/wood/door_wooden_open.ogg'
	doorClose = 'modular_septic/sound/doors/wood/door_wooden_close.ogg'
	doorDeni = 'modular_septic/sound/doors/wood/door_wooden_try.ogg'
	kickfailure = list('modular_septic/sound/doors/wood/door_wooden_kickfail1.ogg', 'modular_septic/sound/doors/wood/door_wooden_kickfail2.ogg')
	kicksuccess = 'modular_septic/sound/doors/wood/door_wooden_kicksuccess.ogg'
	kickcriticalsuccess = 'modular_septic/sound/doors/smod_freeman_extreme.ogg'

/obj/machinery/door/metal_door/wood_door/generate_door_combo()
	var/turf/doorturf = get_turf(src)
	door_frame = new /obj/structure/metal_door_frame/wooden_door_frame(doorturf)
	thrown_door = new /obj/structure/metal_door/wooden_door(doorturf)

/obj/structure/metal_door_frame/wooden_door_frame
	name = "Wooden Door Frame"
	desc = "Someone broke down this fucking door, now where did it go?"
	icon = 'modular_septic/icons/obj/structures/wood_door.dmi'
	base_icon_state = "wood_broken"
	icon_state = "wood_broken"

/obj/structure/metal_door/wooden_door
	name = "Wooden Door"
	desc = "A wooden plank with a door knob on it, has some metal pieces at the edge, I wonder what this radical invention is for."
	icon = 'modular_septic/icons/obj/structures/wood_door.dmi'
	base_icon_state = "wood_freeman_evidence"
	icon_state = "wood_freeman_evidence"

/obj/machinery/door/metal_door/wood_door/north
	dir = NORTH
	pixel_x = -16
	pixel_y = -8

/obj/machinery/door/metal_door/wood_door/south
	dir = SOUTH
	pixel_x = -16
	pixel_y = -8

/obj/machinery/door/metal_door/wood_door/east
	dir = EAST
	pixel_x = -16

/obj/machinery/door/metal_door/wood_door/west
	dir = WEST
	pixel_x = -16
