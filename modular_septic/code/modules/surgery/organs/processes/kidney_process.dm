#define HAS_SILENT_TOXIN 0 //don't provide a feedback message if this is the only toxin present
#define HAS_NO_TOXIN 1
#define HAS_PAINFUL_TOXIN 2

/datum/organ_process/kidneys
	slot = ORGAN_SLOT_KIDNEYS
	mob_types = list(/mob/living/carbon/human)

/datum/organ_process/kidneys/needs_process(mob/living/carbon/owner)
	return (..() && !HAS_TRAIT(owner, TRAIT_NOMETABOLISM) && !(NOKIDNEYS in owner.dna.species.species_traits))

/datum/organ_process/kidneys/handle_process(mob/living/carbon/owner, delta_time, times_fired)
	if(!HAS_TRAIT(owner, TRAIT_NOMETABOLISM))
		handle_toxins(owner, delta_time, times_fired)
	if(!HAS_TRAIT(owner, TRAIT_NOTHIRST))
		handle_hydration(owner, delta_time, times_fired)
	return TRUE

/datum/organ_process/kidneys/proc/handle_toxins(mob/living/carbon/human/owner, delta_time, times_fired)
	var/list/kidneys = owner.getorganslotlist(ORGAN_SLOT_KIDNEYS)
	var/kidney_efficiency = owner.getorganslotefficiency(ORGAN_SLOT_KIDNEYS)
	var/filter_toxins = FALSE
	var/collective_tox_tolerance = 0
	var/collective_tox_lethality = 0
	for(var/thing in kidneys)
		var/obj/item/organ/kidneys/kidney = thing
		if(kidney.is_failing())
			continue
		if(kidney.filter_toxins)
			filter_toxins = TRUE
		collective_tox_tolerance += kidney.tox_tolerance
		collective_tox_lethality += kidney.tox_lethality
	var/antitoxin_effect = owner.get_chem_effect(CE_ANTITOX)
	if(antitoxin_effect)
		filter_toxins = TRUE
		kidney_efficiency += antitoxin_effect
		collective_tox_tolerance += antitoxin_effect/10
		collective_tox_lethality -= antitoxin_effect/10
		if(!HAS_TRAIT(owner, TRAIT_TOXINLOVER))
			owner.adjustToxLoss(-kidney_efficiency/optimal_threshold)
	if(!filter_toxins || (kidney_efficiency < failing_threshold) || HAS_TRAIT(owner, TRAIT_TOXINLOVER))
		return
	var/list/stomachs = owner.getorganslot(ORGAN_SLOT_STOMACH)
	// handle toxin filtration
	for(var/datum/reagent/toxin/T in owner.reagents.reagent_list)
		var/thisamount = owner.reagents.get_reagent_amount(T.type)
		if(thisamount && thisamount <= collective_tox_tolerance * (kidney_efficiency/optimal_threshold))
			owner.reagents.remove_reagent(T.type, 0.5 * delta_time * (kidney_efficiency/optimal_threshold))
		else if(collective_tox_lethality > 0)
			owner.adjustOrganLoss(ORGAN_SLOT_LIVER, thisamount * collective_tox_lethality * (0.5 * delta_time))
	for(var/thing in stomachs)
		var/obj/belly = thing
		for(var/datum/reagent/toxin/T in belly.reagents.reagent_list)
			var/thisamount = belly.reagents.get_reagent_amount(T.type)
			if(thisamount && thisamount <= collective_tox_tolerance * (kidney_efficiency/optimal_threshold))
				owner.reagents.remove_reagent(T.type, 0.5 * delta_time * (kidney_efficiency/optimal_threshold))
			else if(collective_tox_lethality > 0)
				owner.adjustOrganLoss(ORGAN_SLOT_LIVER, thisamount * collective_tox_lethality * (100/kidney_efficiency) * (0.5 * delta_time))

/datum/organ_process/kidneys/proc/handle_hydration(mob/living/carbon/human/owner, delta_time, times_fired)
	var/kidney_efficiency = owner.getorganslotefficiency(ORGAN_SLOT_KIDNEYS)
	// hydration decrease and satiety
	if(owner.hydration > 0)
		var/thirst_rate = owner.total_hydration_req
		thirst_rate *= optimal_threshold/max(kidney_efficiency, 25)
		thirst_rate *= owner.physiology.thirst_mod
		owner.adjust_hydration(-thirst_rate * (0.5 * delta_time))

	//Thirst slowdown for if mood isn't enabled
	if(CONFIG_GET(flag/disable_human_mood))
		if(!HAS_TRAIT(owner, TRAIT_NOHUNGER))
			var/thirsty = (500 - owner.hydration) / 5
			if(thirsty >= 70)
				owner.add_or_update_variable_movespeed_modifier(/datum/movespeed_modifier/thirst, TRUE, multiplicative_slowdown = (thirsty / 50))
			else
				owner.remove_movespeed_modifier(/datum/movespeed_modifier/thirst, TRUE)

	switch(owner.hydration)
		if(HYDRATION_LEVEL_WELL_HYDRATED to INFINITY)
			owner.update_hud_hydration(4)
		if(HYDRATION_LEVEL_HYDRATED to HYDRATION_LEVEL_WELL_HYDRATED)
			owner.update_hud_hydration(3)
		if(HYDRATION_LEVEL_THIRSTY to HYDRATION_LEVEL_HYDRATED)
			owner.update_hud_hydration(2)
		if(HYDRATION_LEVEL_DEHYDRATED to HYDRATION_LEVEL_THIRSTY)
			owner.update_hud_hydration(1)
		if(0 to HYDRATION_LEVEL_DEHYDRATED)
			owner.update_hud_hydration(0)

#undef HAS_SILENT_TOXIN
#undef HAS_NO_TOXIN
#undef HAS_PAINFUL_TOXIN
