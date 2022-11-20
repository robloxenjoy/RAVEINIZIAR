/turf/open/hotspot_expose(exposed_temperature, exposed_volume, soh)
	if(liquids && !liquids.fire_state && liquids.check_fire(TRUE))
		SSliquids.processing_fire[src] = TRUE
	return ..()

/obj/effect/hotspot
	plane = POLLUTION_PLANE
	layer = GASFIRE_LAYER

/obj/effect/hotspot/Initialize(mapload, starting_volume, starting_temperature)
	. = ..()
	if(prob(IGNITE_TURF_CHANCE))
		var/turf/my_turf = loc
		my_turf.ignite_turf_fire(rand(IGNITE_TURF_LOW_POWER,IGNITE_TURF_HIGH_POWER))
