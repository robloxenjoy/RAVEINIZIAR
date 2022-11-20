/datum/element/radioactive
	id_arg_index = 2
	element_flags = ELEMENT_BESPOKE|ELEMENT_DETACH

	var/delay_between_radiation_pulses = 3 SECONDS
	var/max_range = 3
	var/threshold = RAD_LIGHT_INSULATION
	var/chance = URANIUM_IRRADIATION_CHANCE
	var/minimum_exposure_time = URANIUM_RADIATION_MINIMUM_EXPOSURE_TIME

/datum/element/radioactive/Attach(datum/target, \
								delay_between_radiation_pulses = 3 SECONDS, \
								max_range = 3, \
								threshold = RAD_LIGHT_INSULATION, \
								chance = URANIUM_IRRADIATION_CHANCE, \
								minimum_exposure_time = URANIUM_RADIATION_MINIMUM_EXPOSURE_TIME)
	. = ..()
	if(.)
		return
	radioactive_objects -= target
	src.delay_between_radiation_pulses = delay_between_radiation_pulses
	src.max_range = max_range
	src.threshold = threshold
	src.chance = chance
	src.minimum_exposure_time = minimum_exposure_time
	radioactive_objects[target] = world.time

/datum/element/radioactive/Detach(datum/source)
	. = ..()
	radioactive_objects -= source

/datum/element/radioactive/process(delta_time)
	for(var/atom/radioactive_atom as anything in radioactive_objects)
		if(world.time - radioactive_objects[radioactive_atom] < delay_between_radiation_pulses)
			continue

		radiation_pulse(
			source = radioactive_atom,
			max_range = src.max_range,
			threshold = src.threshold,
			chance = src.chance,
			minimum_exposure_time = src.minimum_exposure_time,
		)

		radioactive_objects[radioactive_atom] = world.time
		SEND_SIGNAL(radioactive_atom, COMSIG_RADIOACTIVE_PULSE_SENT, world.time)
