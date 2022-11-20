/obj/structure/pneumaticpipe
	name = "pneumatic pipe"
	desc = "A pneumatic pipe that run throughout ZoomTech outposts and stations, implemented to get corn syrup and M16's to the enemy and the blue helmets to the friendlies."
	icon = 'icons/obj/atmospherics/pipes/disposal.dmi'
	anchored = TRUE
	density = FALSE
	obj_flags = CAN_BE_HIT | ON_BLUEPRINTS
	dir = NONE // dir will contain dominant direction for junction pipes
	max_integrity = 600
	armor = list(MELEE = 60, BULLET = 70, LASER = 10, ENERGY = 100, BOMB = 0, BIO = 100, FIRE = 90, ACID = 30)
	layer = MID_TURF_LAYER
	damage_deflection = 10
	var/obj/structure/pneumaticconstruct/stored

/obj/structure/pneumaticpipe/Initialize(mapload, obj/structure/disposalconstruct/make_from)
	. = ..()

	if(!QDELETED(make_from))
		setDir(make_from.dir)
		make_from.forceMove(src)
		stored = make_from
	else
		stored = new /obj/structure/pneumaticconstruct(src, null , SOUTH , FALSE , src)

	if(ISDIAGONALDIR(dir)) // Bent pipes already have all the dirs set
		initialize_dirs = NONE

	if(initialize_dirs != DISP_DIR_NONE)
		dpdir = dir

		if(initialize_dirs & DISP_DIR_LEFT)
			dpdir |= turn(dir, 90)
		if(initialize_dirs & DISP_DIR_RIGHT)
			dpdir |= turn(dir, -90)
		if(initialize_dirs & DISP_DIR_FLIP)
			dpdir |= turn(dir, 180)
