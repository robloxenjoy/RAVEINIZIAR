/// Hide mutant bodyparts
/mob/living/carbon/human/proc/hide_furry_shit()
	set name = "Hide Mutant Bodyparts"
	set category = "IC"

	if(incapacitated())
		to_chat(src, span_warning("I can't do that right now."))
		return
	if(!do_mob(src, src, 3 SECONDS))
		to_chat(src, span_warning(fail_msg()))
		return
	if(HAS_TRAIT_FROM(src, TRAIT_HIDING_MUTANTPARTS, VERB_TRAIT))
		REMOVE_TRAIT(src, TRAIT_HIDING_MUTANTPARTS, VERB_TRAIT)
		to_chat(src, span_notice("I will now show my mutant bodyparts."))
	else
		ADD_TRAIT(src, TRAIT_HIDING_MUTANTPARTS, VERB_TRAIT)
		to_chat(src, span_notice("I will now hide my mutant bodyparts."))
	update_mutant_bodyparts()

//Zombification
/mob/living/carbon/human/proc/prepare_to_walk()
	set name = "Hell is full"
	set desc = "A second chance at life. With a twist."
	set category = "IC.Dead"

	if(!getorganslot(ORGAN_SLOT_BRAIN))
		to_chat(src, span_warning("I have no brain."))
		return

	if(HAS_TRAIT(src, TRAIT_NO_ROTTEN_AFTERLIFE) || (mind && HAS_TRAIT(mind, TRAIT_NO_ROTTEN_AFTERLIFE)))
		to_chat(src, span_warning("Pfft, hell doesn't exist, silly!"))
		return

	if(HAS_TRAIT_FROM(src, TRAIT_FAKEDEATH, "zombie_infection"))
		to_chat(src, span_dead("I am already a lost soul."))
		return

	if(HasDisease(/datum/disease/zombification))
		to_chat(src, span_warning("I am already preparing to walk again."))
		return

	ForceContractDisease(new /datum/disease/zombification, FALSE, TRUE)
	to_chat(src, span_userdanger("I am preparing to walk again."))
