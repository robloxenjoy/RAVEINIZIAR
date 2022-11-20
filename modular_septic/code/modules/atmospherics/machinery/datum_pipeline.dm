/datum/pipeline/temperature_interact(turf/target, share_volume, thermal_conductivity)
	var/total_heat_capacity = air.heat_capacity()
	var/partial_heat_capacity = total_heat_capacity * (share_volume / air.volume)
	var/target_temperature
	var/target_heat_capacity
	if(target.liquids?.liquid_state >= LIQUID_STATE_FOR_HEAT_EXCHANGERS)
		target_temperature = target.liquids.temperature
		target_heat_capacity = target.liquids.total_reagents * REAGENT_HEAT_CAPACITY
		var/delta_temperature = (air.temperature - target_temperature)

		if(target_heat_capacity <= 0 || partial_heat_capacity <= 0)
			return TRUE

		var/heat = thermal_conductivity * delta_temperature * (partial_heat_capacity * target_heat_capacity / (partial_heat_capacity + target_heat_capacity))

		air.temperature -= heat / total_heat_capacity
		if(!target.liquids.immutable)
			target.liquids.temperature += heat / target_heat_capacity
	else
		var/turf/modeled_location = target
		target_temperature = modeled_location.GetTemperature()
		target_heat_capacity = modeled_location.GetHeatCapacity()

		var/delta_temperature = air.temperature - target_temperature
		var/sharer_heat_capacity = target_heat_capacity

		if((sharer_heat_capacity <= 0) || (partial_heat_capacity <= 0))
			return TRUE
		var/heat = thermal_conductivity * delta_temperature * (partial_heat_capacity * sharer_heat_capacity / (partial_heat_capacity + sharer_heat_capacity))

		var/self_temperature_delta = - heat / total_heat_capacity
		var/sharer_temperature_delta = heat / sharer_heat_capacity

		air.temperature += self_temperature_delta
		modeled_location.TakeTemperature(sharer_temperature_delta)
		if(modeled_location.blocks_air)
			modeled_location.temperature_expose(air, modeled_location.temperature)

		update = TRUE
