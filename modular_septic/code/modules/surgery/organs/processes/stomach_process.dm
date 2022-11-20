/datum/organ_process/stomach
	slot = ORGAN_SLOT_STOMACH
	mob_types = list(/mob/living/carbon/human)

/datum/organ_process/stomach/needs_process(mob/living/carbon/owner)
	return (..() && !(NOSTOMACH in owner.dna.species.species_traits))

/datum/organ_process/stomach/handle_process(mob/living/carbon/owner, delta_time, times_fired)
	// Manage digestion
	if(!HAS_TRAIT(owner, TRAIT_NOHUNGER))
		handle_nutrition(owner, delta_time, times_fired)
	// If we don't feel hunger, we should still try and digest whatever is in the stomachs
	handle_digestion(owner, delta_time, times_fired)
	// Disgust too is important regardless of hunger
	handle_disgust(owner, delta_time, times_fired)
	return TRUE

/datum/organ_process/stomach/proc/handle_nutrition(mob/living/carbon/human/owner, delta_time, times_fired)
	var/stomach_efficiency = owner.getorganslotefficiency(ORGAN_SLOT_STOMACH)
	//The fucking TRAIT_FAT mutation is the dumbest shit ever. It makes the code so difficult to work with
	if(HAS_TRAIT_FROM(owner, TRAIT_FAT, OBESITY))//I share your pain, past coder.
		if(owner.overeatduration < 200 SECONDS)
			to_chat(owner, span_notice("I feel fit again!"))
			REMOVE_TRAIT(owner, TRAIT_FAT, OBESITY)
			owner.remove_movespeed_modifier(/datum/movespeed_modifier/obesity)
			owner.update_inv_w_uniform()
			owner.update_inv_wear_suit()
	else
		if(owner.overeatduration >= 200 SECONDS)
			to_chat(owner, span_danger("I suddenly feel blubbery!"))
			ADD_TRAIT(owner, TRAIT_FAT, OBESITY)
			owner.add_movespeed_modifier(/datum/movespeed_modifier/obesity)
			owner.update_inv_w_uniform()
			owner.update_inv_wear_suit()

	// nutrition decrease and satiety
	if(owner.nutrition > 0)
		// THEY HUNGER
		var/hunger_rate = owner.total_nutriment_req
		hunger_rate *= optimal_threshold/max(stomach_efficiency, 25)
		// Whether we cap off our satiety or move it towards 0
		if(owner.satiety > MAX_SATIETY)
			owner.satiety = MAX_SATIETY
		else if(owner.satiety > 0)
			owner.satiety -= (0.5 * delta_time)
		else if(owner.satiety < -MAX_SATIETY)
			owner.satiety = -MAX_SATIETY
		else if(owner.satiety < 0)
			owner.satiety += (0.5 * delta_time)
			if(DT_PROB(round(-owner.satiety/75), delta_time))
				owner.Jitter(5)
			hunger_rate *= 2
		hunger_rate *= owner.physiology.hunger_mod
		owner.adjust_nutrition(-hunger_rate * (0.5 * delta_time))

	if(owner.nutrition > NUTRITION_LEVEL_FULL)
		//capped so people don't take forever to unfat
		if(owner.overeatduration < 20 MINUTES)
			owner.overeatduration = min(owner.overeatduration + (1 SECONDS * delta_time), 20 MINUTES)
	else if(owner.overeatduration > 0)
		owner.overeatduration = max(owner.overeatduration - (2 SECONDS * delta_time), 0)

	//metabolism change
	if(owner.nutrition > NUTRITION_LEVEL_FAT)
		owner.metabolism_efficiency = 1
	else if(owner.nutrition > NUTRITION_LEVEL_FED && owner.satiety > 80)
		if(owner.metabolism_efficiency != 1.25)
			to_chat(owner, span_notice("I feel vigorous."))
		owner.metabolism_efficiency = 1.25
	else if(owner.nutrition < (NUTRITION_LEVEL_STARVING + 50))
		if(owner.metabolism_efficiency != 0.8)
			to_chat(owner, span_notice("I feel sluggish."))
		owner.metabolism_efficiency = 0.8
	else
		if(owner.metabolism_efficiency == 1.25)
			to_chat(owner, span_notice("I no longer feel vigorous."))
		owner.metabolism_efficiency = 1

	//Hunger slowdown for if mood isn't enabled
	if(CONFIG_GET(flag/disable_human_mood))
		if(!HAS_TRAIT(owner, TRAIT_NOHUNGER))
			var/hungry = (500 - owner.nutrition) / 5 //So overeat would be 100 and default level would be 80
			if(hungry >= 70)
				owner.add_or_update_variable_movespeed_modifier(/datum/movespeed_modifier/hunger, TRUE, multiplicative_slowdown = (hungry / 50))
			else
				owner.remove_movespeed_modifier(/datum/movespeed_modifier/hunger, TRUE)

	switch(owner.nutrition)
		if(NUTRITION_LEVEL_WELL_FED to INFINITY)
			owner.update_hud_nutrition(4)
		if(NUTRITION_LEVEL_FED to NUTRITION_LEVEL_WELL_FED)
			owner.update_hud_nutrition(3)
		if(NUTRITION_LEVEL_HUNGRY to NUTRITION_LEVEL_FED)
			owner.update_hud_nutrition(2)
		if(NUTRITION_LEVEL_STARVING to NUTRITION_LEVEL_HUNGRY)
			owner.update_hud_nutrition(1)
		if(0 to NUTRITION_LEVEL_STARVING)
			owner.update_hud_nutrition(0)

/datum/organ_process/stomach/proc/handle_digestion(mob/living/carbon/human/owner, delta_time, times_fired)
	var/datum/organ_process/intestine_process = GLOB.organ_processes_by_slot[ORGAN_SLOT_INTESTINES]
	var/datum/organ_process/bladder_process = GLOB.organ_processes_by_slot[ORGAN_SLOT_BLADDER]

	var/intestinal_efficiency = owner.getorganslotefficiency(ORGAN_SLOT_INTESTINES)
	var/list/intestines = owner.getorganslotlist(ORGAN_SLOT_INTESTINES)
	for(var/obj/item/organ/intestine as anything in intestines)
		if(intestine.get_slot_efficiency(ORGAN_SLOT_INTESTINES) < intestine_process.failing_threshold)
			intestines -= intestine

	var/bladderal_efficiency = owner.getorganslotefficiency(ORGAN_SLOT_BLADDER)
	var/list/bladders = owner.getorganslotlist(ORGAN_SLOT_BLADDER)
	for(var/obj/item/organ/bladder as anything in bladders)
		if(bladder.get_slot_efficiency(ORGAN_SLOT_BLADDER) < bladder_process.failing_threshold)
			bladders -= bladder

	var/stomachal_efficiency = owner.getorganslotefficiency(ORGAN_SLOT_STOMACH)
	var/list/stomachs = owner.getorganslotlist(ORGAN_SLOT_STOMACH)
	for(var/obj/item/organ/stomach/stomach as anything in stomachs)
		// digest food, sent all reagents that can metabolize to the body
		for(var/chunk in stomach.reagents.reagent_list)
			var/datum/reagent/bit = chunk

			// If the reagent does not metabolize then it will sit in the stomach
			// This has an effect on items like plastic causing them to take up space in the stomach
			if(bit.metabolization_rate <= 0)
				continue

			// Ensure that the the minimum is equal to the metabolization_rate of the reagent if it is higher then the STOMACH_METABOLISM_CONSTANT
			var/rate_min = max(bit.metabolization_rate, STOMACH_METABOLISM_CONSTANT)
			// Do not transfer over more then we have
			var/amount_max = bit.volume

			// If the reagent is part of the food reagents for the organ
			// prevent all the reagents form being used leaving the food reagents
			var/amount_food = stomach.food_reagents[bit.type]
			if(amount_food)
				amount_max = max(amount_max - amount_food, 0)
			// Each stomach has an efficiency of it's own
			var/this_stomach_efficiency = stomach.get_slot_efficiency(ORGAN_SLOT_STOMACH)
			// Transfer the amount of reagents based on volume with a min amount of 1u
			var/amount = min((round(stomach.metabolism_efficiency * (this_stomach_efficiency/optimal_threshold) * amount_max, 0.05) + rate_min) * delta_time, amount_max)
			if(amount <= 0)
				continue

			// shit and piss will clog up the stomach without being metabolized
			if(istype(bit, /datum/reagent/consumable/shit))
				if(NOINTESTINES in owner.dna.species.species_traits)
					stomach.reagents.remove_all_type(bit.type)
					continue
				if(!length(intestines) || (intestinal_efficiency < intestine_process.failing_threshold))
					continue
				// try to transfer the shit to the intestines
				var/divided_amount = CEILING(amount/(max(1, length(intestines))), 0.1)
				if(divided_amount > 0)
					if(intestinal_efficiency >= intestine_process.failing_threshold)
						for(var/obj/item/organ/intestine as anything in intestines)
							intestines -= intestine
							var/modifier = clamp(FLOOR(intestine.get_slot_efficiency(ORGAN_SLOT_INTESTINES)/intestine_process.optimal_threshold, 0.1), 0.1, 3)
							var/spillover = max(0, intestine.reagents.total_volume + (divided_amount * modifier) - intestine.reagents.maximum_volume)
							intestine.reagents.add_reagent(/datum/reagent/consumable/shit, (divided_amount * modifier) - spillover, data = owner.get_blood_data())
							stomach.reagents.remove_reagent(/datum/reagent/consumable/shit, (divided_amount * modifier) - spillover)
							// this is here to stay
							if(spillover)
								// unless a friend helps out that is
								if(length(intestines))
									divided_amount = CEILING(divided_amount + spillover/length(intestines), 0.1)
				// oh dear, this is here to stay - in the stomach
				continue
			else if(istype(bit, /datum/reagent/consumable/piss))
				if(NOBLADDER in owner.dna.species.species_traits)
					stomach.reagents.remove_all_type(bit.type)
					continue
				if(!length(bladders) || (bladderal_efficiency < bladder_process.failing_threshold))
					continue
				// try to transfer the piss to the bladders
				var/divided_amount = CEILING(amount/(max(1, length(bladders))), 0.1)
				if(divided_amount > 0)
					if(bladderal_efficiency >= bladder_process.failing_threshold)
						for(var/obj/item/organ/bladder as anything in bladders)
							bladders -= bladder
							var/modifier = clamp(FLOOR(bladder.get_slot_efficiency(ORGAN_SLOT_BLADDER)/bladder_process.optimal_threshold, 0.1), 0.1, 3)
							var/spillover = max(0, bladder.reagents.total_volume + (divided_amount * modifier) - bladder.reagents.maximum_volume)
							bladder.reagents.add_reagent(/datum/reagent/consumable/piss, (divided_amount * modifier) - spillover)
							stomach.reagents.remove_reagent(/datum/reagent/consumable/piss, (divided_amount * modifier) - spillover)
							// this is here to stay
							if(spillover)
								// unless a friend helps out that is
								if(length(bladders))
									divided_amount = CEILING(divided_amount + spillover/length(bladders), 0.1)
				// oh dear, this is here to stay - in the stomach
				continue

			// transfer the reagents over to the body at the rate of the stomach metabolim
			// this way the body is where all reagents that are processed and react
			// the stomach manages how fast they are feed in a drip style
			stomach.reagents.trans_id_to(owner, bit.type, amount=amount)

			var/pissable = FALSE
			var/shittable = FALSE
			if(istype(bit, /datum/reagent/consumable))
				var/datum/reagent/consumable/food = bit
				if(food.nutriment_factor)
					shittable = TRUE
				if(food.hydration_factor)
					pissable = TRUE
			else if(istype(bit, /datum/reagent/water))
				pissable = TRUE
			if(shittable && !(NOINTESTINES in owner.dna.species.species_traits))
				// what goes in, must come out (as shit)
				var/divided_amount = CEILING(amount/(max(1, length(intestines))), 0.1)
				if(divided_amount > 0)
					if(intestinal_efficiency >= intestine_process.failing_threshold)
						for(var/obj/item/organ/intestine as anything in intestines)
							intestines -= intestine
							var/modifier = clamp(FLOOR(intestine_process.optimal_threshold/intestine.get_slot_efficiency(ORGAN_SLOT_INTESTINES), 0.1), 0.1, 3)
							var/spillover = max(0, intestine.reagents.total_volume + (divided_amount * modifier) - intestine.reagents.maximum_volume)
							intestine.reagents.add_reagent(/datum/reagent/consumable/shit, (divided_amount * modifier) - spillover, data = owner.get_blood_data())
							// this is here to stay
							if(spillover)
								// unless a friend helps out that is
								if(!length(intestines))
									stomach.reagents.add_reagent(/datum/reagent/consumable/shit, spillover, data = owner.get_blood_data())
								else
									divided_amount = CEILING(divided_amount + spillover/length(intestines), 0.1)
					// oh dear, this is here to stay - in the stomach
					else
						stomach.reagents.add_reagent(/datum/reagent/consumable/shit, divided_amount, data = owner.get_blood_data())
			if(pissable && !(NOBLADDER in owner.dna.species.species_traits))
				// what goes in, must come out (as piss)
				var/divided_amount = CEILING(amount/(max(1, length(bladders))), 0.1)
				if(divided_amount > 0)
					if(bladderal_efficiency >= bladder_process.failing_threshold)
						for(var/obj/item/organ/bladder as anything in bladders)
							bladders -= bladder
							var/modifier = clamp(FLOOR(bladder_process.optimal_threshold/bladder.get_slot_efficiency(ORGAN_SLOT_BLADDER), 0.1), 0.1, 3)
							var/spillover = max(0, bladder.reagents.total_volume + (divided_amount * modifier) - bladder.reagents.maximum_volume)
							bladder.reagents.add_reagent(/datum/reagent/consumable/piss, (divided_amount * modifier) - spillover)
							// this is here to stay
							if(spillover)
								// unless a friend helps out that is
								if(!length(bladders))
									stomach.reagents.add_reagent(/datum/reagent/consumable/piss, spillover)
								else
									divided_amount = CEILING(divided_amount + spillover/length(bladders), 0.1)
					// oh dear, this is here to stay - in the stomach
					else
						stomach.reagents.add_reagent(/datum/reagent/consumable/piss, divided_amount)

	for(var/obj/item/organ/stomach/stomach as anything in stomachs)
		// This stomach is ok
		if(!stomach.is_bruised() && !stomach.is_failing())
			continue

		// We are checking if we have nutriment in a damaged stomach.
		var/datum/reagent/nutri = locate(/datum/reagent/consumable/nutriment) in stomach.reagents.reagent_list

		// No nutriment found lets exit out
		if(!nutri)
			continue

		// remove the food reagent amount
		var/nutri_vol = nutri.volume
		var/amount_food = stomach.food_reagents[nutri.type]
		if(amount_food)
			nutri_vol = max(nutri_vol - amount_food, 0)

		// found nutriment was stomach food reagent
		if(!(nutri_vol > 0))
			continue

		// Each stomach has an efficiency of it's own
		if(stomach.damage < stomach.high_threshold)
			// The stomach is damaged, has nutriment, but low on theshold, low prob of vomit
			if(DT_PROB(0.0125 * (optimal_threshold - stomachal_efficiency) * (nutri_vol ** 2), delta_time))
				owner.vomit(optimal_threshold - stomachal_efficiency)
				to_chat(owner, span_warning("My [stomach.name] reels in pain as you're incapable of holding down all that food!"))
				return
		else
			// the change of vomit is now high
			if(DT_PROB(0.05 * (optimal_threshold - stomachal_efficiency) * (nutri_vol ** 2), delta_time))
				owner.vomit(optimal_threshold - stomachal_efficiency)
				to_chat(owner, span_warning("My [stomach.name] reels in pain as you're incapable of holding down all that food!"))
				return

/datum/organ_process/stomach/proc/handle_disgust(mob/living/carbon/human/owner, delta_time, times_fired)
	var/combined_disgust_metabolism = 0
	for(var/thing in owner.getorganslotlist(ORGAN_SLOT_STOMACH))
		var/obj/item/organ/stomach/stomach = thing
		combined_disgust_metabolism += stomach.disgust_metabolism
	if(owner.disgust)
		var/pukeprob = 2.5 + (0.025 * owner.disgust)
		if(owner.disgust >= DISGUST_LEVEL_GROSS)
			if(DT_PROB(5, delta_time))
				owner.stuttering += 1
				owner.add_confusion(2)
			if(DT_PROB(5, delta_time) && !owner.stat)
				to_chat(owner, span_warning("I feel kind of iffy..."))
			owner.jitteriness = max(owner.jitteriness - 3, 0)
		if(owner.disgust >= DISGUST_LEVEL_VERYGROSS)
			if(DT_PROB(pukeprob, delta_time)) //iT hAndLeS mOrE ThaN PukInG
				owner.add_confusion(2.5)
				owner.stuttering += 1
				owner.vomit(10, 0, 1, 0, 1, 0)
			owner.Dizzy(5)
		if(owner.disgust >= DISGUST_LEVEL_DISGUSTED)
			if(DT_PROB(13, delta_time))
				owner.blur_eyes(3) //We need to add more shit down here
		owner.adjust_disgust(-0.25 * combined_disgust_metabolism * delta_time)
	switch(owner.disgust)
		if(0 to DISGUST_LEVEL_GROSS)
			owner.clear_alert("disgust")
			SEND_SIGNAL(owner, COMSIG_CLEAR_MOOD_EVENT, "disgust")
		if(DISGUST_LEVEL_GROSS to DISGUST_LEVEL_VERYGROSS)
			owner.throw_alert("disgust", /atom/movable/screen/alert/gross)
			SEND_SIGNAL(owner, COMSIG_ADD_MOOD_EVENT, "disgust", /datum/mood_event/gross)
		if(DISGUST_LEVEL_VERYGROSS to DISGUST_LEVEL_DISGUSTED)
			owner.throw_alert("disgust", /atom/movable/screen/alert/verygross)
			SEND_SIGNAL(owner, COMSIG_ADD_MOOD_EVENT, "disgust", /datum/mood_event/verygross)
		if(DISGUST_LEVEL_DISGUSTED to INFINITY)
			owner.throw_alert("disgust", /atom/movable/screen/alert/disgusted)
			SEND_SIGNAL(owner, COMSIG_ADD_MOOD_EVENT, "disgust", /datum/mood_event/disgusted)
