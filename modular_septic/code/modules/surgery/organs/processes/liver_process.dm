/datum/organ_process/liver
	slot = ORGAN_SLOT_LIVER
	processes_dead = TRUE

/datum/organ_process/liver/needs_process(mob/living/carbon/owner)
	return (..() && !HAS_TRAIT(owner, TRAIT_NOMETABOLISM) && !(NOLIVER in owner.dna?.species?.species_traits))

/datum/organ_process/liver/handle_process(mob/living/carbon/owner, delta_time, times_fired)
	var/liver_efficiency = owner.getorganslotefficiency(ORGAN_SLOT_LIVER)
	if(liver_efficiency >= failing_threshold)
		if(owner.stat < DEAD)
			// metabolize reagents
			owner.reagents.metabolize(owner, delta_time, times_fired, can_overdose=TRUE)
			return
		else
			for(var/reagent in owner.reagents.reagent_list)
				var/datum/reagent/R = reagent
				R.on_mob_dead(owner, delta_time)
	return TRUE
