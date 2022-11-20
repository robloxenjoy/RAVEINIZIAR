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
//	plane = FLOOR_PLANE      MAYBE THIS..............
	baseturfs = /turf/open/floor/plating/polovich/metalfloor
	liquid_height = -(ONE_LIQUIDS_HEIGHT*4)
	turf_height = -TURF_HEIGHT_BLOCK_THRESHOLD
	floor_variance = 0
	var/liquids_are_immutable = FALSE
	var/initial_liquid = /datum/reagent/consumable/ice
	var/initial_liquid_amount = 400
	var/initial_liquid_temperature = T0C-10
//	var/atom/watereffect = /obj/effect/overlay/ms13/water/shallow
//	var/atom/watertop = /obj/effect/overlay/ms13/water/top/shallow

//	var/initial_liquid_list = null
//	var/initial_liquid_list_amount = null
//	var/initial_liquid_list_temperature = null

/turf/open/floor/plating/asteroid/snow/river/Initialize()
	. = ..()
	if(liquids_are_immutable)
		var/atom/movable/liquid/liquidation = SSliquids.get_immutable(initial_liquid)
		if(liquidation)
			liquidation.add_turf(src)
	else
		if(!liquids && initial_liquid)
			add_liquid(initial_liquid, initial_liquid_amount, FALSE, initial_liquid_temperature)

/turf/open/floor/plating/asteroid/snow/river/baluarte
	name = "Water"
	desc = "Looks wet."
	initial_liquid = /datum/reagent/water
//	initial_gas_mix = OPENTURF_DEFAULT_ATMOS
//	planetary_atmos = TRUE
	initial_liquid_temperature = T0C
	liquid_height = -LIQUID_SHOULDERS_LEVEL_HEIGHT

/turf/open/floor/plating/asteroid/snow/river/baluarte/shallow
	name = "Shallow Water"
	desc = "Looks wet. It's better not to drink from here."
	icon = 'modular_septic/icons/turf/floors/water.dmi'
	icon_state = "riverwater"
	base_icon_state = "riverwater"
//	initial_liquid_list = (list(/datum/reagent/water = 80, /datum/reagent/toxin = 20))
//	initial_liquid_list_amount = 100
//	initial_liquid_list_temperature = T0C
	liquids_are_immutable = TRUE
	initial_liquid_amount = 100
	initial_liquid = /datum/reagent/toxin/badwater/shallow
	initial_gas_mix = OPENTURF_DEFAULT_ATMOS
//	planetary_atmos = TRUE
	initial_liquid_temperature = T0C
	liquid_height = -LIQUID_ANKLES_LEVEL_HEIGHT
	turf_height = 0
	slowdown = 3
	bullet_sizzle = TRUE
	bullet_bounce_sound = null
	footstep = FOOTSTEP_WATER
	barefootstep = FOOTSTEP_WATER
	clawfootstep = FOOTSTEP_WATER
	heavyfootstep = FOOTSTEP_WATER

/turf/open/floor/plating/asteroid/snow/river/baluarte/shallow/verydeep
	name = "Very Deep Shallow Water"
	desc = "Looks wet. It's better not to drink from here, also it very deep."
	icon = 'modular_septic/icons/turf/floors/water.dmi'
	icon_state = "riverwater"
	base_icon_state = "riverwater"
//	initial_liquid_list = (list(/datum/reagent/water = 80, /datum/reagent/toxin = 20))
//	initial_liquid_list_amount = 100
//	initial_liquid_list_temperature = T0C
	liquids_are_immutable = TRUE
	initial_liquid_amount = 100
	initial_liquid = /datum/reagent/toxin/badwater/shallow
	initial_gas_mix = OPENTURF_DEFAULT_ATMOS
//	planetary_atmos = TRUE
	initial_liquid_temperature = T0C
	liquid_height = -LIQUID_FULLTILE_LEVEL_HEIGHT
	slowdown = 5

/turf/open/floor/plating/asteroid/snow/river/baluarte/shallow/deep
	name = "Deep Shallow Water"
	desc = "Looks wet. It's better not to drink from here, also it deep."
	icon = 'modular_septic/icons/turf/floors/water.dmi'
	icon_state = "riverwater"
	base_icon_state = "riverwater"
//	initial_liquid_list = (list(/datum/reagent/water = 80, /datum/reagent/toxin = 20))
//	initial_liquid_list_amount = 100
//	initial_liquid_list_temperature = T0C
	liquids_are_immutable = TRUE
	initial_liquid_amount = 100
	initial_liquid = /datum/reagent/toxin/badwater/shallow
	initial_gas_mix = OPENTURF_DEFAULT_ATMOS
//	planetary_atmos = TRUE
	initial_liquid_temperature = T0C
	liquid_height = -LIQUID_SHOULDERS_LEVEL_HEIGHT
	slowdown = 4

/turf/open/floor/plating/asteroid/snow/river/baluarte/shallow/somedeep
	name = "Deep Shallow Water"
	desc = "Looks wet. It's better not to drink from here, also it some deep."
	icon = 'modular_septic/icons/turf/floors/water.dmi'
	icon_state = "riverwater"
	base_icon_state = "riverwater"
//	initial_liquid_list = (list(/datum/reagent/water = 80, /datum/reagent/toxin = 20))
//	initial_liquid_list_amount = 100
//	initial_liquid_list_temperature = T0C
	liquids_are_immutable = TRUE
	initial_liquid_amount = 100
	initial_liquid = /datum/reagent/toxin/badwater/shallow
	initial_gas_mix = OPENTURF_DEFAULT_ATMOS
//	planetary_atmos = TRUE
	initial_liquid_temperature = T0C
	liquid_height = -LIQUID_WAIST_LEVEL_HEIGHT
	slowdown = 5

/turf/open/floor/plating/asteroid/snow/river/nevado_surface
	baseturfs = /turf/open/floor/plating/asteroid/snow/nevado_surface
	initial_gas_mix = OPENTURF_DEFAULT_ATMOS
//	planetary_atmos = TRUE
	initial_liquid = /atom/movable/liquid/immutable/ocean/nevado
	liquids_are_immutable = TRUE

/turf/open/floor/plating/asteroid/snow/river/nevado_surface/shallow/ankle
	name = "Shallow Water"
	desc = "Looks wet. It's better not to drink from here."
//	baseturfs = /turf/open/floor/plating/asteroid/snow/nevado_surface
	initial_gas_mix = OPENTURF_DEFAULT_ATMOS
//	planetary_atmos = FALSE
//	initial_liquid_amount = 100
//	liquid_height = -LIQUID_WAIST_LEVEL_HEIGHT
//	liquid_height = -(ONE_LIQUIDS_HEIGHT*3)
//	layer = TURF_LAYER_WATER_BASE
	initial_liquid = /atom/movable/liquid/immutable/ocean/shallow
//	initial_liquid = /datum/reagent/toxin/badwater/shallow
//	initial_liquid_amount = 1000
//	initial_liquid_temperature = T0C-40
//	initial_liquid_temperature = T0C
	liquid_height = -LIQUID_SHOULDERS_LEVEL_HEIGHT
	turf_height = -TURF_HEIGHT_BLOCK_THRESHOLD
	liquids_are_immutable = TRUE
	slowdown = 5
//	initial_liquid_temperature = T0C
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
//	watereffect = /obj/effect/overlay/ms13/water/shallow
//	watertop = /obj/effect/overlay/ms13/water/top/shallow

/turf/open/floor/plating/asteroid/snow/river/nevado_surface/shallow/ankle/norm
	name = "Water"
	desc = "Looks wet."
	baseturfs = /turf/open/floor/plating/polovich/dirt/dark
	initial_liquid = /datum/reagent/water
	initial_gas_mix = OPENTURF_DEFAULT_ATMOS
//	planetary_atmos = TRUE
	initial_liquid_temperature = T0C-40
	liquid_height = -LIQUID_SHOULDERS_LEVEL_HEIGHT
	turf_height = -500
	liquids_are_immutable = FALSE
	resistance_flags = FIRE_PROOF

/turf/open/floor/plating/asteroid/snow/river/nevado_surface/shallow/ankle/norm/badwater
	name = "Water"
	desc = "Looks wet."
	baseturfs = /turf/open/floor/plating/polovich/dirt/dark
	initial_liquid = /datum/reagent/toxin/badwater/shallow
	initial_gas_mix = OPENTURF_DEFAULT_ATMOS
//	planetary_atmos = TRUE
	initial_liquid_temperature = T0C-40
	initial_liquid_amount = 100
	liquid_height = -LIQUID_WAIST_LEVEL_HEIGHT
	turf_height = -500
	liquids_are_immutable = FALSE
	resistance_flags = FIRE_PROOF

/*
/turf/open/floor/plating/asteroid/snow/river/nevado_surface/shallow/ankle/Initialize()
	. = ..()
	new watereffect(src)
	new watertop(src)
*/
/turf/open/floor/plating/asteroid/snow/river/nevado_surface/shallow/ankle/attack_jaw(mob/living/carbon/M as mob)
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

///turf/open/floor/plating/asteroid/snow/river/nevado_surface/shallow/ankle/proc/Extinguish(var/mob/living/L)
//	if(istype(L))
//		L.fire_stacks = 0
//		L.extinguish_mob()

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
	initial_liquid = /datum/reagent/toxin/piranha_solution
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
