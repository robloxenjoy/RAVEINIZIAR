/datum/reagent/benzene
	name = "Benzene"
	description = "A very common hydrocarbon, used as a precursor for various chemicals. Reduces presence of red blood cells when metabolized."
	ph = 7
	taste_description = "alcoholic sweetness"
	color = "#aaaaaa55" // rgb: 170, 170, 170, 85 (alpha)
	liquid_fire_power = 10 //benzene is highly flammable
	liquid_fire_burnrate = 0.1
	liquid_evaporation_rate = 20 //like ethanol, evaporates quick

//benzene is very toxic
/datum/reagent/benzene/on_mob_life(mob/living/carbon/M, delta_time, times_fired)
	. = ..()
	M.adjust_bloodvolume(-0.5)

/datum/reagent/toxin/acid
	liquid_evaporation_rate = 1 //slow evaporation

//fluoride stares....
/datum/reagent/fluorine/on_mob_metabolize(mob/living/L)
	. = ..()
	ADD_TRAIT(L, TRAIT_FLUORIDE_STARE, "[type]")

/datum/reagent/fluorine/on_mob_end_metabolize(mob/living/L)
	. = ..()
	REMOVE_TRAIT(L, TRAIT_FLUORIDE_STARE, "[type]")

//kerosene
/datum/reagent/fuel/kerosene
	name = "Kerosene"
	description = "A combustible hydrocarbon used as a precursor in chemical manufacturing, as well as a widely used fuel."
	ph = 7
	taste_description = "alcoholic sweetness"
	color = "#aaaaaa55" // rgb: 170, 170, 170, 85 (alpha)
	liquid_fire_power = 15 //kerosene is highly flammable
	liquid_fire_burnrate = 0.25
	liquid_evaporation_rate = 20 //like ethanol, evaporates quick
