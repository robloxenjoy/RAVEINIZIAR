/datum/organ_process/intestines
	slot = ORGAN_SLOT_INTESTINES
	mob_types = list(/mob/living/carbon/human)

/datum/organ_process/intestines/needs_process(mob/living/carbon/owner)
	return (..() && !(NOINTESTINES in owner.dna.species.species_traits))

/datum/organ_process/intestines/handle_process(mob/living/carbon/owner, delta_time, times_fired)
	var/list/intestines = owner.getorganslotlist(ORGAN_SLOT_INTESTINES)
	var/needshit_event
	var/collective_shit_amount = 0
	for(var/obj/item/organ/intestines/intestine as anything in intestines)
		collective_shit_amount += (intestine.reagents.get_reagent_amount(/datum/reagent/consumable/shit) - intestine.food_reagents[/datum/reagent/consumable/shit])
	switch(collective_shit_amount)
		if(30 to 60)
			needshit_event = /datum/mood_event/needshit
			if(DT_PROB(5, delta_time))
				to_chat(owner, span_warning(pick("I need to go to the bathroom.", "I need to shit.", "I need to take a dump.")))
		if(60 to INFINITY)
			needshit_event = /datum/mood_event/reallyneedshit
			if(DT_PROB(10, delta_time))
				to_chat(owner, span_warning(pick("I <b>really</b> need to shit!", "My anus is BLEEDING!", "I'm gonna shit myself!")))
	if(needshit_event)
		SEND_SIGNAL(owner, COMSIG_ADD_MOOD_EVENT, "need_poop", needshit_event)
	else
		SEND_SIGNAL(owner, COMSIG_CLEAR_MOOD_EVENT, "need_poop")
	return TRUE
