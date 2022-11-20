/obj/machinery/atmospherics/pipe/heat_exchanging/process_atmos()
	var/environment_temperature = 0
	var/datum/gas_mixture/pipe_air = return_air()

	var/turf/turf_loc = loc
	if(istype(turf_loc))
		if(islava(turf_loc))
			environment_temperature = 5000 //Yuck
		else if (turf_loc.liquids && turf_loc.liquids.liquid_state >= LIQUID_STATE_FOR_HEAT_EXCHANGERS)
			environment_temperature = turf_loc.liquids.temperature
		else if(turf_loc.blocks_air)
			environment_temperature = turf_loc.temperature
		else if(isopenturf(turf_loc))
			var/turf/open/open_loc = turf_loc
			environment_temperature = open_loc.GetTemperature()
	else
		environment_temperature = turf_loc.temperature
	if(abs(environment_temperature-pipe_air.temperature) > minimum_temperature_difference)
		parent.temperature_interact(turf_loc, volume, thermal_conductivity)

	//heatup/cooldown any mobs buckled to ourselves based on our temperature
	if(has_buckled_mobs())
		var/hc = pipe_air.heat_capacity()
		var/mob/living/heat_source = buckled_mobs[1]
		//Best guess-estimate of the total bodytemperature of all the mobs, since they share the same environment it's ~ok~ to guess like this
		var/avg_temp = (pipe_air.temperature * hc + (heat_source.bodytemperature * buckled_mobs.len) * 3500) / (hc + (buckled_mobs ? buckled_mobs.len * 3500 : 0))
		for(var/m in buckled_mobs)
			var/mob/living/living = m
			living.bodytemperature = avg_temp
		pipe_air.temperature = avg_temp
