/datum/species/handle_radiation(mob/living/carbon/human/source, delta_time, time_since_irradiated, rads, radiation_sickness)
	// Metallic tastes
	if(radiation_sickness >= RADIATION_SICKNESS_STAGE_1)
		ADD_TRAIT(source, TRAIT_METALLIC_TASTES, RADIATION_TRAIT)
	else
		REMOVE_TRAIT(source, TRAIT_METALLIC_TASTES, RADIATION_TRAIT)

	// Diarrhea and vomiting
	if(radiation_sickness >= RADIATION_SICKNESS_STAGE_2)
		if(DT_PROB(RAD_MOB_SHIT_PROB, delta_time))
			source.shit(FALSE)
		if(DT_PROB(RAD_MOB_PISS_PROB, delta_time))
			source.piss(FALSE)
		if(DT_PROB(RAD_MOB_VOMIT_PROB, delta_time))
			source.vomit(10, TRUE)

	// Fever
	if(radiation_sickness >= RADIATION_SICKNESS_STAGE_3)
		var/fever_temperature = (BODYTEMP_HEAT_DAMAGE_LIMIT - BODYTEMP_NORMAL - 5) + BODYTEMP_NORMAL
		source.adjust_bodytemperature(clamp((fever_temperature - T20C)/BODYTEMP_COLD_DIVISOR + 1, 0, fever_temperature - source.bodytemperature), use_insulation = FALSE)

	// Spleen damage
	if(radiation_sickness >= RADIATION_SICKNESS_STAGE_4)
		if(DT_PROB(RAD_MOB_SPLEEN_DAMAGE_PROB, delta_time))
			source.adjustOrganLoss(ORGAN_SLOT_SPLEEN, RAD_MOB_SPLEEN_DAMAGE_AMOUNT)

	// Blood volume reduction, bloody coughing, immunity cripple
	if(radiation_sickness >= RADIATION_SICKNESS_STAGE_5)
		ADD_TRAIT(source, TRAIT_IMMUNITY_CRIPPLED, RADIATION_TRAIT)
		if(DT_PROB(RAD_MOB_BLEED_PROB, delta_time))
			source.adjust_bloodvolume(-RAD_MOB_BLEED_AMOUNT)
		if(DT_PROB(RAD_MOB_COUGH_BLOOD_PROB, delta_time))
			source.emote("cough")
			source.bleed(RAD_MOB_COUGH_BLOOD_AMOUNT)
	else
		REMOVE_TRAIT(source, TRAIT_IMMUNITY_CRIPPLED, RADIATION_TRAIT)

	// Mutations
	if(radiation_sickness >= RADIATION_SICKNESS_STAGE_6)
		if(DT_PROB(RAD_MOB_MUTATE_PROB, delta_time))
			to_chat(source, span_userdanger("I mutate!"))
/*			source.easy_random_mutate(NEGATIVE + MINOR_NEGATIVE) SEPTIC EDIT REMOVAL */
			source.agony_gasp()
			source.domutcheck()
		if(!(source.hairstyle == "Bald") && (HAIR in species_traits))
			to_chat(source, span_userdanger("My hair is falling away!"))
			go_bald(source)

	// Stomach/intestine damage
	if(radiation_sickness >= RADIATION_SICKNESS_STAGE_7)
		if(DT_PROB(RAD_MOB_STOMACH_DAMAGE_PROB, delta_time))
			source.adjustOrganLoss(ORGAN_SLOT_STOMACH, RAD_MOB_STOMACH_DAMAGE_AMOUNT)
		if(DT_PROB(RAD_MOB_INTESTINES_DAMAGE_PROB, delta_time))
			source.adjustOrganLoss(ORGAN_SLOT_INTESTINES, RAD_MOB_INTESTINES_DAMAGE_AMOUNT)

	// Burn damage
	if(radiation_sickness >= RADIATION_SICKNESS_STAGE_8)
		if(DT_PROB(RAD_MOB_BURN_PROB, delta_time))
			source.take_bodypart_damage(burn = RAD_MOB_BURN_AMOUNT)

	// Brain damage and seizures (you're literally hisashi ouchi by this point)
	if(radiation_sickness >= RADIATION_SICKNESS_STAGE_9)
		if(DT_PROB(RAD_MOB_SEIZURE_PROB, delta_time))
			if(source.stat < UNCONSCIOUS)
				source.visible_message(span_danger("<b>[source]</b> starts having a seizure!"), \
									span_userdanger("I'm having a seizure!"))
			source.Jitter(1000)
			source.Unconscious(8 SECONDS)
		if(DT_PROB(RAD_MOB_BRAIN_DAMAGE_PROB, delta_time))
			ADJUSTBRAINLOSS(source, RAD_MOB_BRAIN_DAMAGE_AMOUNT)
