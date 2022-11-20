/turf
	/// Pollution datum of this turf
	var/datum/pollution/pollution

/turf/proc/pollute_turf(pollution_type, amount, cap)
	if(!pollution)
		pollution = new(src)
	pollution.add_pollutant(pollution_type, amount)

/turf/proc/pollute_list_turf(list/pollutions, cap)
	if(!pollution)
		pollution = new(src)
	if(cap && pollution.total_amount >= cap)
		return
	pollution.add_pollutant_list(pollutions)
