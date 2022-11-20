/datum/organ_process/bladder
	slot = ORGAN_SLOT_BLADDER
	mob_types = list(/mob/living/carbon/human)

/datum/organ_process/bladder/needs_process(mob/living/carbon/owner)
	return (..() && !(NOBLADDER in owner.dna.species.species_traits))

/datum/organ_process/bladder/handle_process(mob/living/carbon/owner, delta_time, times_fired)
	var/list/bladders = owner.getorganslotlist(ORGAN_SLOT_BLADDER)
	var/needpee_event
	var/collective_piss_amount = 0
	for(var/obj/item/organ/bladder/bladder as anything in bladders)
		collective_piss_amount += (bladder.reagents.get_reagent_amount(/datum/reagent/consumable/piss) - bladder.food_reagents[/datum/reagent/consumable/piss])
	switch(collective_piss_amount)
		if(30 to 60)
			needpee_event = /datum/mood_event/needpiss
			if(DT_PROB(5, delta_time))
				to_chat(owner, span_warning(pick("I need to go to the bathroom.", "I need to pee.", "I need to take a leak.")))
		if(60 to INFINITY)
			needpee_event = /datum/mood_event/reallyneedpiss
			if(DT_PROB(10, delta_time))
				to_chat(owner, span_warning(pick("I <b>really</b> need to piss!", "My bladder is BLEEDING!", "I'm gonna piss myself!")))
	if(needpee_event)
		SEND_SIGNAL(owner, COMSIG_ADD_MOOD_EVENT, "need_pee", needpee_event)
	else
		SEND_SIGNAL(owner, COMSIG_CLEAR_MOOD_EVENT, "need_pee")
	handle_failing_bladders(owner, delta_time, times_fired)
	return TRUE

/datum/organ_process/bladder/proc/handle_failing_bladders(mob/living/carbon/owner, delta_time, times_fired)
	var/bladderal_efficiency = owner.getorganslotefficiency(ORGAN_SLOT_BLADDER)
	if(bladderal_efficiency < failing_threshold)
		if(DT_PROB(5, delta_time))
			owner.piss(FALSE)
		return TRUE
	return TRUE
