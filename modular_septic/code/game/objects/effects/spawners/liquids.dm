/obj/effect/spawner/liquid
	name = "liquid spawner"
	var/list/liquid_list = list(
		/datum/reagent/water = 10,
	)
	var/no_react = FALSE
	var/liquid_temperature = T20C

/obj/effect/spawner/liquid/Initialize(mapload)
	. = ..()
	var/turf/our_turf = get_turf(src)
	if(our_turf)
		our_turf.add_liquid_list(liquid_list, no_react, liquid_temperature)
	return INITIALIZE_HINT_QDEL
