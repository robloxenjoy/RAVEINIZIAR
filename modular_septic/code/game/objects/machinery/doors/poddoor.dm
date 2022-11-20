/obj/machinery/door/poddoor
	icon = 'modular_septic/icons/obj/machinery/tall/doors/blastdoor.dmi'

/obj/machinery/door/poddoor/do_animate(animation)
	switch(animation)
		if("opening")
			flick("opening", src)
			playsound(src, 'modular_septic/sound/machinery/shutter-open.wav', 65, FALSE, 2)
		if("closing")
			flick("closing", src)
			playsound(src, 'modular_septic/sound/machinery/shutter-close.wav', 65, FALSE, 2)
