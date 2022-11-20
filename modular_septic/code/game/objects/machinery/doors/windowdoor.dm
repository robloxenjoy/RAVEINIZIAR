/obj/machinery/door/window/open(forced=FALSE)
	if (operating) //doors can still open when emag-disabled
		return 0
	if(!forced)
		if(!hasPower())
			return 0
	if(forced < 2)
		if(obj_flags & EMAGGED)
			return 0
	if(!operating) //in case of emag
		operating = TRUE
	do_animate("opening")
	playsound(src, 'modular_septic/sound/machinery/windowdoor_open.wav', 85, TRUE)
	icon_state ="[base_state]open"
	sleep(10)
	set_density(FALSE)
	air_update_turf(TRUE, FALSE)
	update_freelook_sight()

	if(operating == 1) //emag again
		operating = FALSE
	return 1

/obj/machinery/door/window/close(forced=FALSE)
	if (operating)
		return 0
	if(!forced)
		if(!hasPower())
			return 0
	if(forced < 2)
		if(obj_flags & EMAGGED)
			return 0
	operating = TRUE
	do_animate("closing")
	playsound(src, 'modular_septic/sound/machinery/windowdoor_close.wav', 85, TRUE)
	icon_state = base_state

	set_density(TRUE)
	air_update_turf(TRUE, TRUE)
	update_freelook_sight()
	sleep(10)

	operating = FALSE
	return 1
