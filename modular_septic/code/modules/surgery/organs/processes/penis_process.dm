//The penis process actually handles horniness in general
/datum/organ_process/penis
	slot = ORGAN_SLOT_PENIS
	mob_types = list(/mob/living/carbon/human)

/datum/organ_process/penis/needs_process(mob/living/carbon/owner)
	return (..() && !(NOHORNY in owner.dna.species.species_traits))

/datum/organ_process/penis/handle_process(mob/living/carbon/human/owner, delta_time, times_fired)
	// horny handling
	switch(owner.arousal)
		if(AROUSAL_LEVEL_HORNY to INFINITY)
			SEND_SIGNAL(owner, COMSIG_ADD_MOOD_EVENT, "horny", /datum/mood_event/reallyneedsex)
		if(AROUSAL_LEVEL_AROUSED to AROUSAL_LEVEL_HORNY)
			SEND_SIGNAL(owner, COMSIG_ADD_MOOD_EVENT, "horny", /datum/mood_event/needsex)
		else
			SEND_SIGNAL(owner, COMSIG_CLEAR_MOOD_EVENT, "horny")
	//lust reduction
	if(owner.lust)
		owner.adjust_lust(-DELUST_FACTOR)
	return TRUE
