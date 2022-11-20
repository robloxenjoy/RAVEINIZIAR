/datum/reagent/fuel
	//Gasoline evaporates rather fast - 20u every 10 seconds
	liquid_evaporation_rate = 20
	liquid_fire_power = 10
	liquid_fire_burnrate = 0.1
	accelerant_quality = 10

//mmm warter
/datum/reagent/water
	//10u every 10 seconds
	liquid_evaporation_rate = 10

/datum/reagent/water/expose_turf(turf/open/exposed_turf, reac_volume)
	. = ..()
	if(!. && exposed_turf.turf_fire)
		exposed_turf.turf_fire.reduce_power(reac_volume)

/datum/reagent/water/expose_atom(atom/exposed_atom, reac_volume)
	. = ..()
	if(!.)
		exposed_atom.adjust_germ_level(-reac_volume * SANITIZATION_PER_UNIT_WATER)

/datum/reagent/water/on_mob_life(mob/living/carbon/M, delta_time, times_fired)
	if(ishuman(M))
		var/mob/living/carbon/human/H = M
		if(!HAS_TRAIT(H, TRAIT_NOTHIRST))
			var/kidney_efficiency = H.getorganslotefficiency(ORGAN_SLOT_KIDNEYS)
			if(kidney_efficiency > 0)
				H.adjust_hydration(15 * REAGENTS_METABOLISM * REM * (kidney_efficiency/GLOB.organ_processes_by_slot[ORGAN_SLOT_KIDNEYS].optimal_threshold) * delta_time)
	return ..()

//mm tide pods
/datum/reagent/space_cleaner
	var/sanitization = SANITIZATION_PER_UNIT_SPACE_CLEANER

/datum/reagent/space_cleaner/expose_atom(atom/exposed_atom, reac_volume)
	. = ..()
	if(!.)
		exposed_atom.adjust_germ_level(-reac_volume * sanitization)

/datum/reagent/space_cleaner/sterilizine
	sanitization = SANITIZATION_PER_UNIT_STERILIZINE

//water but evil
/datum/reagent/hellwater
	accelerant_quality = 20

//mmmm bone meal
/datum/reagent/bone_dust
	name = "bone meal"
	description = "Probably not actually a good idea to eat."
	taste_description = "grainy alchemy and calcium"
