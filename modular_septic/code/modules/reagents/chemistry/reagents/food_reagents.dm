/datum/reagent/consumable
	/// How much hydration this reagent supplies
	var/hydration_factor = 1 * REAGENTS_METABOLISM

/datum/reagent/consumable/on_mob_life(mob/living/carbon/M, delta_time, times_fired)
	if(ishuman(M))
		var/mob/living/carbon/human/H = M
		if(!HAS_TRAIT(H, TRAIT_NOHUNGER))
			var/stomach_efficiency = H.getorganslotefficiency(ORGAN_SLOT_STOMACH)
			if(stomach_efficiency >= ORGAN_FAILING_EFFICIENCY)
				H.adjust_nutrition(nutriment_factor * REM * delta_time)
		if(!HAS_TRAIT(H, TRAIT_NOTHIRST))
			var/kidney_efficiency = H.getorganslotefficiency(ORGAN_SLOT_KIDNEYS)
			if(kidney_efficiency >= ORGAN_FAILING_EFFICIENCY)
				H.adjust_hydration(hydration_factor * REM * delta_time)
	current_cycle++
	if(length(reagent_removal_skip_list))
		return
	holder.remove_reagent(type, metabolization_rate * delta_time)
