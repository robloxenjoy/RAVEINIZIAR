/datum/organ_process/anus
	slot = ORGAN_SLOT_ANUS
	mob_types = list(/mob/living/carbon)

/datum/organ_process/anus/needs_process(mob/living/carbon/owner)
	return (..() && !(NOINTESTINES in owner.dna.species.species_traits))

/datum/organ_process/anus/handle_process(mob/living/carbon/owner, delta_time, times_fired)
	var/anal_efficiency = owner.getorganslotefficiency(ORGAN_SLOT_ANUS)
	if(anal_efficiency < failing_threshold)
		if(DT_PROB(5, delta_time))
			owner.shit(FALSE)
		return TRUE
	return TRUE
