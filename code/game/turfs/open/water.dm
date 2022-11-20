/turf/open/water
	gender = PLURAL
	name = "Shallow Water"
	desc = "Shallow water. It's better not to drink from here."
	icon = 'icons/turf/floors.dmi'
	icon_state = "riverwater"
	baseturfs = /turf/open/floor/plating/polovich/dirt/dark
	initial_gas_mix = OPENTURF_DEFAULT_ATMOS
//	planetary_atmos = TRUE
	slowdown = 3
	bullet_sizzle = TRUE
	bullet_bounce_sound = null //needs a splashing sound one day.

	footstep = FOOTSTEP_WATER
	barefootstep = FOOTSTEP_WATER
	clawfootstep = FOOTSTEP_WATER
	heavyfootstep = FOOTSTEP_WATER
/*
/turf/open/water/Initialize(mapload)
	create_reagents(100, DRAINABLE)
	reagents.add_reagent(/datum/reagent/water, 85)
	. = ..()
*/
/turf/open/water/attack_jaw(mob/living/user, list/modifiers)
	. = ..()
	if(.)
		return
	user.reagents.add_reagent_list(list(/datum/reagent/water = 5, /datum/reagent/toxin = 1))
	visible_message(span_notice("[user] drinks from the shallow water."))
	playsound(user.loc, 'sound/items/drink.ogg', rand(10, 50), TRUE)

/turf/open/water/jungle
	initial_gas_mix = OPENTURF_DEFAULT_ATMOS
