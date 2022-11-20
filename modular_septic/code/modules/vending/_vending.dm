/obj/machinery/vending
	var/infected = FALSE
	var/infected_noise = 'modular_septic/sound/effects/pain_fuck.wav'

/obj/machinery/vending/Initialize(mapload)
	. = ..()
	hacking = set_hacking()
	if(InitializeExtraItems())
		product_records = list()
		build_inventory(products, product_records)
		hidden_records = list()
		build_inventory(contraband, hidden_records)
		coin_records = list()
		build_inventory(premium, coin_records)

/obj/machinery/vending/process(delta_time, volume = 70)
	if(machine_stat & (BROKEN|NOPOWER))
		return PROCESS_KILL
	if(!active)
		return

	if(seconds_electrified > MACHINE_NOT_ELECTRIFIED)
		seconds_electrified--

	if(last_slogan + slogan_delay <= world.time && slogan_list.len > 0 && !shut_up && DT_PROB(2.5, delta_time))
		var/slogan = pick(slogan_list)
		if(infected)
			playsound(src, infected_noise,  volume, TRUE, vary = FALSE)
		speak(slogan)
		last_slogan = world.time

/obj/machinery/vending/proc/InitializeExtraItems()
	return

/**
 * Generates the vending machine's hacking datum.
 */
/obj/machinery/vending/proc/set_hacking()
	return new /datum/hacking/vending(src)
