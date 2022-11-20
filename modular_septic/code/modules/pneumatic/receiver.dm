/obj/machinery/pneumaticreceiver
	name = "pneumatic receiver"
	desc = "A trustworthy receiver that doesn't contain a pipebomb."
	icon = 'icons/obj/atmospherics/pipes/disposal.dmi'
	anchored = TRUE
	max_integrity = 600
	armor = list(MELEE = 60, BULLET = 60, LASER = 10, ENERGY = 100, BOMB = 0, BIO = 100, FIRE = 90, ACID = 30)
	damage_deflection = 10
	obj_flags = CAN_BE_HIT
	var/datum/gas_mixture/air_contents
	var/full_pressure = FALSE
	var/pressure_charging = TRUE
	var/obj/structure/pneumaticconstruct/stored

/obj/machinery/pneumaticreceiver/Initialize(mapload, obj/structure/pneumaticconstruct/make_from)
	. = ..()

	if(make_from)
		setDir(make_from.dir)
		make_from.moveToNullspace()
		stored = make_from
		pressure_charging = FALSE // newly built disposal bins start with pump off
	else
		stored = new /obj/structure/pneumaticconstruct(null, null , SOUTH , FALSE , src)
