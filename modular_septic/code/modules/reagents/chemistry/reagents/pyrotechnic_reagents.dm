/datum/reagent/thermite
	liquid_evaporation_rate = 10
	liquid_fire_power = 20
	liquid_fire_burnrate = 0.1
	accelerant_quality = 2

/datum/reagent/clf3
	liquid_evaporation_rate = 40
	liquid_fire_power = 30
	liquid_fire_burnrate = 0.1
	accelerant_quality = 20

/datum/reagent/phlogiston
	liquid_evaporation_rate = 10
	liquid_fire_power = 20
	liquid_fire_burnrate = 0.1
	accelerant_quality = 20

/datum/reagent/napalm
	liquid_evaporation_rate = 10
	liquid_fire_power = 30
	liquid_fire_burnrate = 0.1
	accelerant_quality = 20

/datum/reagent/firefighting_foam/expose_turf(turf/open/exposed_turf, reac_volume)
	. = ..()
	if(!. && exposed_turf.turf_fire)
		qdel(exposed_turf.turf_fire)
