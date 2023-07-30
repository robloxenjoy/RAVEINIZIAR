/obj/effect/spawner/liquid
	name = "liquid spawner"
	icon = 'modular_septic/icons/obj/structures/structures_spawners.dmi'
	icon_state = "liquid_spawner"
	var/list/liquid_list = list(
		/datum/reagent/water = 10,
	)
	var/liquid_no_react = FALSE
	var/liquid_temperature = T20C
	var/liquids_are_immutable = FALSE
	var/liquids_vaporizes = TRUE

/obj/effect/spawner/liquid/Initialize(mapload)
	. = ..()
	var/turf/our_turf = get_turf(src)
	if(our_turf)
		if(liquids_are_immutable)
			var/atom/movable/liquid/liquidation = SSliquids.get_immutable(liquid_list)
			if(liquidation)
				liquidation.add_turf(src)
		else if(LAZYLEN(liquid_list))
			our_turf.add_liquid_list(liquid_list, liquid_no_react, liquid_temperature, liquids_vaporizes)
	return INITIALIZE_HINT_QDEL

/obj/effect/spawner/liquid/shallow
	name = "shallow liquid spawner"
	liquid_list = list(
		/datum/reagent/toxin/badwater/shallow = 10,
	)
	liquid_no_react = FALSE
	liquid_temperature = T0C-10
	liquids_are_immutable = FALSE
	liquids_vaporizes = FALSE

/obj/effect/spawner/liquid/shallow/flood
	name = "shallow liquid spawner"
	liquid_list = list(
		/datum/reagent/toxin/badwater/shallow = 450,
	)
	liquid_no_react = FALSE
	liquid_temperature = T0C-10
	liquids_are_immutable = FALSE
	liquids_vaporizes = FALSE