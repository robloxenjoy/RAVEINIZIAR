/obj/machinery/firealarm
	icon = 'modular_septic/icons/obj/machinery/fire_alarm.dmi'
	icon_state = "fire0"
	base_icon_state = "fire"
	var/datum/looping_sound/fire_alarm/soundloop
	var/datum/looping_sound/fire_alarm/sound

/obj/machinery/firealarm/Initialize(mapload, dir, building)
	. = ..()
	AddElement(/datum/element/wall_mount)
	soundloop = new(src, FALSE)

/obj/machinery/firealarm/Destroy()
	. = ..()
	QDEL_NULL(soundloop)

/obj/machinery/firealarm/should_atmos_process(datum/gas_mixture/air, exposed_temperature)
	if(obj_flags & EMAGGED || machine_stat)
		return FALSE
	var/turf/turf_loc = loc
	if(istype(turf_loc) && turf_loc.turf_fire)
		return TRUE
	if(exposed_temperature > T0C + 80 || exposed_temperature < T0C - 10)
		return TRUE

/obj/machinery/firealarm/update_fire_light(fire)
	. = ..()
	var/area/area = get_area(src)
	if(!area?.fire)
		soundloop.stop()

/obj/machinery/firealarm/reset(mob/user)
	if(!is_operational)
		return
	var/area/area = get_area(src)
	area.firereset()
	playsound(loc, 'modular_septic/sound/machinery/firealarm_start.wav', 75, FALSE, 3)
	if(user)
		log_game("[user] reset a fire alarm at [COORD(src)]")
	update_appearance(UPDATE_ICON)

/obj/machinery/firealarm/alarm(mob/user)
	if(!is_operational || !COOLDOWN_FINISHED(src, last_alarm))
		return
	COOLDOWN_START(src, last_alarm, FIREALARM_COOLDOWN)
	var/area/area = get_area(src)
	area.firealert(src)
	playsound(loc, 'modular_septic/sound/machinery/firealarm_start.wav', 75, FALSE, 3)
	addtimer(CALLBACK(src, .proc/activate_soundloop), 2.5 SECONDS)
	if(user)
		log_game("[user] triggered a fire alarm at [COORD(src)]")
	update_appearance()

/obj/machinery/firealarm/proc/activate_soundloop()
	var/area/area = get_area(src)
	if(!area?.fire)
		return
	soundloop.start()
