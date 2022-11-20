/obj/item/gas_filter/proc/reduce_filter_status_pollution(datum/pollution/pollution)

	var/danger_points = 0

	var/datum/pollutant/pollutant
	for(var/pollutant_type in pollution.pollutants)
		var/pollutant_amount = pollution.pollutants[pollutant_type]
		pollutant = SSpollution.pollutant_singletons[pollutant_type]
		danger_points += (pollutant.filter_wear * pollutant_amount)

	filter_status = max(filter_status - danger_points, 0)
	return filter_status
