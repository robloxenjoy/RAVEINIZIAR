#define AIRLOCK_CONTROL_RANGE 5

// This code allows for airlocks to be controlled externally by setting an id_tag and comm frequency (disables ID access)
/obj/machinery/door/airlock
	/// The current state of the airlock, used to construct the airlock overlays
	var/airlock_state
	var/frequency
	var/datum/radio_frequency/radio_connection

/obj/machinery/door/airlock/receive_signal(datum/signal/signal)
	if(!signal)
		return

	if(id_tag != signal.data["tag"] || !signal.data["command"])
		return

	switch(signal.data["command"])
		if("open")
			open(1)

		if("close")
			close(1)

		if("unlock")
			locked = FALSE
			update_appearance()

		if("lock")
			locked = TRUE
			update_appearance()

		if("secure_open")
			locked = FALSE
			update_appearance()

			sleep(2)
			open(1)

			locked = TRUE
			update_appearance()

		if("secure_close")
			locked = FALSE
			close(1)

			locked = TRUE
			sleep(2)
			update_appearance()

	send_status()


/obj/machinery/door/airlock/proc/send_status()
	if(radio_connection)
		var/datum/signal/signal = new(list(
			"tag" = id_tag,
			"timestamp" = world.time,
			"door_status" = density ? "closed" : "open",
			"lock_status" = locked ? "locked" : "unlocked"
		))
		radio_connection.post_signal(src, signal, range = AIRLOCK_CONTROL_RANGE, filter = RADIO_AIRLOCK)

/obj/machinery/door/airlock/open(surpress_send)
	. = ..()
	if(!surpress_send)
		send_status()

/obj/machinery/door/airlock/close(surpress_send)
	. = ..()
	if(!surpress_send)
		send_status()

/obj/machinery/door/airlock/proc/set_frequency(new_frequency)
	SSradio.remove_object(src, frequency)
	if(new_frequency)
		frequency = new_frequency
		radio_connection = SSradio.add_object(src, frequency, RADIO_AIRLOCK)

/obj/machinery/door/airlock/Destroy()
	if(frequency)
		SSradio.remove_object(src,frequency)
	return ..()
