/turf/open/floor/plating/asteroid/snow/nevado_surface
	name = "snow"
	desc = "Looks cold."
	baseturfs = /turf/open/floor/plating/asteroid/snow/nevado_surface

/turf/open/floor/plating/asteroid/snow/ice/nevado_surface
	name = "ice"
	desc = "Looks very cold."
	baseturfs = /turf/open/floor/plating/asteroid/snow/nevado_surface

/turf/open/floor/plating/asteroid/snow/river
	name = "icy river"
	desc = "Looks wet and cold."
	icon_state = "snow-ice"
	base_icon_state = "snow-ice"
	plane = OPENSPACE_PLANE
	baseturfs = /turf/open/floor/plating/polovich/metalfloor
	liquid_height = -(ONE_LIQUIDS_HEIGHT*4)
	turf_height = -TURF_HEIGHT_BLOCK_THRESHOLD
	floor_variance = 0
	footstep = FOOTSTEP_WATER
	barefootstep = FOOTSTEP_WATER
	clawfootstep = FOOTSTEP_WATER
	heavyfootstep = FOOTSTEP_WATER
	var/initial_liquid_list = list(
		/datum/reagent/consumable/ice = 400,
	)
	var/initial_liquid_temperature = T0C-10
	var/initial_liquid_no_react = FALSE
	var/liquids_vaporize = TRUE
	var/liquids_are_immutable = FALSE

/turf/open/floor/plating/asteroid/snow/river/Initialize(mapload)
	. = ..()
	if(liquids_are_immutable)
		var/atom/movable/liquid/liquidation = SSliquids.get_immutable(initial_liquid_list)
		if(liquidation)
			liquidation.add_turf(src)
	else if(!liquids && LAZYLEN(initial_liquid_list))
		add_liquid_list(initial_liquid_list, initial_liquid_no_react, initial_liquid_temperature, liquids_vaporize)
	initial_liquid_list = null

/turf/open/floor/plating/asteroid/snow/river/baluarte
	name = "Water"
	desc = "Looks wet."
	initial_liquid_list = list(
		/datum/reagent/water = 400,
	)
	initial_liquid_temperature = T0C+1 //water will freeze at 0c obviously
	liquid_height = -LIQUID_SHOULDERS_LEVEL_HEIGHT

/turf/open/floor/plating/asteroid/snow/river/baluarte/shallow
	name = "Shallow Water"
	desc = "Looks wet. It's better not to drink from here."
	icon = 'modular_septic/icons/turf/floors/water.dmi'
	icon_state = "riverwater"
	base_icon_state = "riverwater"
	initial_liquid_list = /atom/movable/liquid/immutable/ocean/shallow
	liquids_are_immutable = TRUE
	liquid_height = -LIQUID_ANKLES_LEVEL_HEIGHT
	initial_gas_mix = OPENTURF_DEFAULT_ATMOS
	turf_height = 0
	slowdown = 3
	bullet_sizzle = TRUE
	bullet_bounce_sound = null

/turf/open/floor/plating/asteroid/snow/river/baluarte/shallow/deep
	name = "Deep Shallow Water"
	desc = "Looks wet. It's better not to drink from here, also it deep."
	icon = 'modular_septic/icons/turf/floors/water.dmi'
	icon_state = "riverwater"
	base_icon_state = "riverwater"
	initial_liquid_list = /atom/movable/liquid/immutable/ocean/shallow/deep
	liquids_are_immutable = TRUE
	liquid_height = -LIQUID_SHOULDERS_LEVEL_HEIGHT
	initial_gas_mix = OPENTURF_DEFAULT_ATMOS
	slowdown = 4

/turf/open/floor/plating/asteroid/snow/river/baluarte/shallow/verydeep
	name = "Very Deep Shallow Water"
	desc = "Looks wet. It's better not to drink from here, also it very deep."
	icon = 'modular_septic/icons/turf/floors/water.dmi'
	icon_state = "riverwater"
	base_icon_state = "riverwater"
	initial_liquid_list = /atom/movable/liquid/immutable/ocean/shallow/verydeep
	liquids_are_immutable = TRUE
	liquid_height = -LIQUID_FULLTILE_LEVEL_HEIGHT
	initial_gas_mix = OPENTURF_DEFAULT_ATMOS
	slowdown = 5

/turf/open/floor/plating/asteroid/snow/river/baluarte/shallow/somedeep
	name = "Deep Shallow Water"
	desc = "Looks wet. It's better not to drink from here, also it some deep."
	icon = 'modular_septic/icons/turf/floors/water.dmi'
	icon_state = "riverwater"
	base_icon_state = "riverwater"
	initial_liquid_list = /atom/movable/liquid/immutable/ocean/shallow/deep
	liquids_are_immutable = TRUE
	liquid_height = -LIQUID_WAIST_LEVEL_HEIGHT
	initial_gas_mix = OPENTURF_DEFAULT_ATMOS
	slowdown = 5

/turf/open/floor/plating/asteroid/snow/river/nevado_surface
	baseturfs = /turf/open/floor/plating/asteroid/snow/nevado_surface
	initial_liquid_list = /atom/movable/liquid/immutable/ocean/nevado
	liquids_are_immutable = TRUE
	initial_gas_mix = OPENTURF_DEFAULT_ATMOS

/turf/open/floor/plating/asteroid/snow/river/nevado_surface/shallow/ankle
	name = "Shallow Water"
	desc = "Looks wet. It's better not to drink from here."
	initial_gas_mix = OPENTURF_DEFAULT_ATMOS
	initial_liquid_list = /atom/movable/liquid/immutable/ocean/shallow
	liquid_height = -LIQUID_ANKLES_LEVEL_HEIGHT
	turf_height = -TURF_HEIGHT_BLOCK_THRESHOLD
	liquids_are_immutable = TRUE
	slowdown = 5
	icon = 'modular_septic/icons/turf/floors/water.dmi'
	icon_state = "riverwater"
	base_icon_state = "riverwater"
	bullet_sizzle = TRUE
	bullet_bounce_sound = null
	footstep = FOOTSTEP_WATER
	barefootstep = FOOTSTEP_WATER
	clawfootstep = FOOTSTEP_WATER
	heavyfootstep = FOOTSTEP_WATER
	baseturfs = /turf/open/floor/plating/polovich/dirt/dark
	resistance_flags = FIRE_PROOF

/turf/open/floor/plating/asteroid/snow/river/nevado_surface/shallow/ankle/norm
	name = "Water"
	desc = "Looks wet."
	baseturfs = /turf/open/floor/plating/polovich/dirt/dark
	initial_liquid_list = list(
		/datum/reagent/water = 150,
	)
	initial_gas_mix = OPENTURF_DEFAULT_ATMOS
	initial_liquid_temperature = T0C-40
	liquid_height = -LIQUID_SHOULDERS_LEVEL_HEIGHT
	turf_height = -500
	liquids_are_immutable = FALSE
	resistance_flags = FIRE_PROOF

/turf/open/floor/plating/asteroid/snow/river/nevado_surface/shallow/ankle/norm/badwater
	name = "Water"
	desc = "Looks wet."
	baseturfs = /turf/open/floor/plating/polovich/dirt/dark
	initial_liquid_list = list(
		/datum/reagent/toxin/badwater/shallow = 150,
	)
	initial_gas_mix = OPENTURF_DEFAULT_ATMOS
	initial_liquid_temperature = T0C-40
	liquid_height = -LIQUID_WAIST_LEVEL_HEIGHT
	turf_height = -500
	liquids_are_immutable = FALSE
	resistance_flags = FIRE_PROOF

/turf/open/floor/plating/asteroid/snow/river/nevado_surface/shallow/ankle/attack_jaw(mob/living/carbon/M as mob)
	. = ..()
	var/turf/turf_loc = get_turf(src)
	if(get_dist(turf_loc?.liquids,M) <= 1)
		if(M.wear_mask && M.wear_mask.flags_cover & MASKCOVERSMOUTH)
			visible_message(M, span_warning("The mask is in the way!"))
			return
	var/datum/reagents/temporary_holder = turf_loc.liquids.take_reagents_flat(CHOKE_REAGENTS_INGEST_ON_BREATH_AMOUNT)
	temporary_holder.trans_to(src, temporary_holder.total_volume, methods = INGEST)
	qdel(temporary_holder)
	visible_message(span_notice("[M] drinks the liquid."))
	playsound(M.loc, 'sound/items/drink.ogg', rand(10, 50), TRUE)

/obj/effect/overlay/ms13/water
	name = "water"
	icon = 'icons/turf/water.dmi'
	density = FALSE
	mouse_opacity = 0
	layer = TURF_LAYER_WATER
	plane = FLOOR_PLANE
	anchored = TRUE

/obj/effect/overlay/ms13/water/shallow
	icon_state = "water_shallow_bottom"

/obj/effect/overlay/ms13/water/top
	layer = TURF_LAYER_WATER_UNDER

/obj/effect/overlay/ms13/water/top/shallow
	icon_state = "water_shallow_top"

/turf/open/floor/plating/asteroid/snow/river/nevado_surface/acid
	name = "infernal river of dissolution"
	desc = "Ah, an acid bath. Delicious."
	initial_liquid_list = list(
		/datum/reagent/toxin/piranha_solution = 500,
	)
	liquids_are_immutable = FALSE

/turf/open/floor/plating/asteroid/nevado_caves
	name = "cave floor"
	baseturfs = /turf/open/floor/plating/asteroid/nevado_caves
	icon = 'modular_septic/icons/turf/floors/coolrock.dmi'
	icon_state = "coolrock"
	base_icon_state = "coolrock"
	floor_variance = 50
	initial_gas_mix = OPENTURF_DEFAULT_ATMOS
	planetary_atmos = TRUE
	digResult = /obj/item/stack/ore/glass

/turf/open/floor/plating/asteroid/nevado_caves/Initialize(mapload)
	. = ..()
	if(prob(floor_variance))
		icon_state = "[base_icon_state][rand(0,1)]"
	else
		icon_state = base_icon_state

/turf/open/floor/plating/asteroid/nevado_caves/setup_broken_states()
	return list("coolrock_dug")

/turf/closed/mineral/random/nevado_caves
	name = "cave wall"
	icon = 'modular_septic/icons/turf/mining.dmi'
	smooth_icon = 'modular_septic/icons/turf/walls/redrock.dmi'
	icon_state = "redrock"
	base_icon_state = "redrock"
	environment_type = "redrock"
	turf_type = /turf/open/floor/plating/asteroid/nevado_caves
	baseturfs = /turf/open/floor/plating/asteroid/nevado_caves
	initial_gas_mix = OPENTURF_DEFAULT_ATMOS
	defer_change = TRUE

	mineralChance = 10
	mineralSpawnChanceList = list( \
		/obj/item/stack/ore/uranium = 5, /obj/item/stack/ore/diamond = 2, /obj/item/stack/ore/gold = 10, \
		/obj/item/stack/ore/titanium = 11, /obj/item/stack/ore/silver = 12, /obj/item/stack/ore/plasma = 20, \
		/obj/item/stack/ore/iron = 50)
