/// We need those arguments
/mob/living/carbon/human/breathe(delta_time, times_fired, datum/organ_process/lung_process)
	if(!dna.species.breathe(src, delta_time, times_fired, lung_process))
		return ..()

/// Returns how often we need to breathe, basically
/mob/living/carbon/human/get_breath_modulo()
	var/breath_modulo_total
	for(var/thing in getorganslotlist(ORGAN_SLOT_LUNGS))
		var/obj/item/organ/lungs/lung = thing
		breath_modulo_total += lung.get_breath_modulo()
	if(undergoing_cardiac_arrest())
		breath_modulo_total -= 2
	if(!isnull(breath_modulo_total))
		return max(breath_modulo_total, 1)
	else
		return ..()

/// Funny alert and stuff
/mob/living/carbon/human/check_breath(datum/gas_mixture/breath, lung_efficiency, list/lungs, datum/organ_process/lung_process)
	if(lung_efficiency < lung_process.failing_threshold)
		failed_last_breath = TRUE
		update_hud_breath(failed_last_breath, lung_efficiency, lung_process.bruised_threshold, lung_process.failing_threshold)
		return FALSE

	check_breath_lungs(breath, lung_efficiency, lungs, lung_process)
	return TRUE

/mob/living/carbon/human/proc/check_breath_lungs(datum/gas_mixture/breath, lung_efficiency = 0, list/lungs, datum/organ_process/lung_process)
	if(!breath || (breath.total_moles() <= 0) || (lung_efficiency < lung_process.failing_threshold) || !LAZYLEN(lungs))
		check_failed_breath(breath, lung_efficiency, lungs, lung_process)
		return FALSE

	var/gas_breathed = 0

	var/list/breath_gases = breath.gases

	for(var/gas_id in GLOB.meta_gas_info)
		breath.assert_gas(gas_id)

	if(istype(wear_mask) && (wear_mask.clothing_flags & GAS_FILTERING) && wear_mask.has_filter)
		breath = wear_mask.consume_filter(breath)

	//Partial pressures in our breath
	var/O2_pp = breath.get_breath_partial_pressure(breath_gases[/datum/gas/oxygen][MOLES])+(8*breath.get_breath_partial_pressure(breath_gases[/datum/gas/pluoxium][MOLES]))
	var/N2_pp = breath.get_breath_partial_pressure(breath_gases[/datum/gas/nitrogen][MOLES])
	var/Toxins_pp = breath.get_breath_partial_pressure(breath_gases[/datum/gas/plasma][MOLES])
	var/CO2_pp = breath.get_breath_partial_pressure(breath_gases[/datum/gas/carbon_dioxide][MOLES])

	//Vars for n2o and healium induced euphorias.
	var/n2o_euphoria = EUPHORIA_LAST_FLAG
	var/healium_euphoria = EUPHORIA_LAST_FLAG

	// Get these damn variables from our lungs
	var/safe_oxygen_min = 0
	var/safe_oxygen_max = 0
	var/safe_nitro_min = 0
	var/safe_nitro_max = 0
	var/safe_co2_min = 0
	var/safe_co2_max = 0
	var/safe_plas_min = 0
	var/safe_plas_max = 0
	var/SA_para_min = 0
	var/SA_sleep_min = 0
	var/BZ_trip_balls_min = 0
	var/BZ_brain_damage_min = 0
	var/gas_stimulation_min = 0
	var/healium_para_min = 0
	var/healium_sleep_min = 0
	var/suffers_miasma = FALSE

	var/oxy_breath_dam_min = 0
	var/oxy_breath_dam_max = 0
	var/oxy_damage_type = ""
	var/nitro_breath_dam_min = 0
	var/nitro_breath_dam_max = 0
	var/nitro_damage_type = ""
	var/co2_breath_dam_min = 0
	var/co2_breath_dam_max = 0
	var/co2_damage_type = ""
	var/plas_breath_dam_min = 0
	var/plas_breath_dam_max = 0
	var/plas_damage_type = ""

	var/tritium_irradiation_moles_min = 0
	var/tritium_irradiation_moles_max = 0
	var/tritium_irradiation_probability_min = 0
	var/tritium_irradiation_probability_max = 0

	var/amount_lungs = length(lungs)

	// loopity loop
	for(var/thing in lungs)
		var/obj/item/organ/lungs/lung = thing
		// "master lung" handles these variables
		if(lungs[1] == lung)
			oxy_damage_type = lung.oxy_damage_type
			nitro_damage_type = lung.nitro_damage_type
			co2_damage_type = lung.co2_damage_type
			plas_damage_type = lung.plas_damage_type
		// one lung is enough to get miasma'd
		if(lung.suffers_miasma)
			suffers_miasma = TRUE
		// these add up, but get divided by the amount of lungs later
		oxy_breath_dam_min += lung.oxy_breath_dam_min
		oxy_breath_dam_max += lung.oxy_breath_dam_max
		nitro_breath_dam_min += lung.nitro_breath_dam_min
		nitro_breath_dam_max += lung.nitro_breath_dam_max
		co2_breath_dam_min += lung.co2_breath_dam_min
		co2_breath_dam_max += lung.co2_breath_dam_max
		plas_breath_dam_min += lung.plas_breath_dam_min
		plas_breath_dam_max += lung.plas_breath_dam_max
		safe_oxygen_min += lung.safe_oxygen_min
		safe_oxygen_max += lung.safe_oxygen_max
		safe_nitro_min += lung.safe_nitro_min
		safe_nitro_max += lung.safe_nitro_max
		safe_co2_min += lung.safe_co2_min
		safe_co2_max += lung.safe_co2_max
		safe_plas_min += lung.safe_plas_min
		safe_plas_max += lung.safe_plas_max
		SA_para_min += lung.SA_para_min
		SA_sleep_min += lung.SA_sleep_min
		BZ_trip_balls_min += lung.BZ_trip_balls_min
		BZ_brain_damage_min += lung.BZ_brain_damage_min
		gas_stimulation_min += lung.gas_stimulation_min
		healium_para_min += lung.healium_para_min
		healium_sleep_min += lung.healium_sleep_min
		tritium_irradiation_moles_min += lung.tritium_irradiation_moles_min
		tritium_irradiation_moles_max += lung.tritium_irradiation_moles_min
		tritium_irradiation_probability_min += lung.tritium_irradiation_probability_min
		tritium_irradiation_probability_max += lung.tritium_irradiation_probability_max

		lung.handle_gas_override(src, breath_gases, gas_breathed)

	// remember these? time to divide them by the amount of lungs, to get the average
	oxy_breath_dam_min /= amount_lungs
	oxy_breath_dam_max /= amount_lungs
	nitro_breath_dam_min /= amount_lungs
	nitro_breath_dam_max /= amount_lungs
	co2_breath_dam_min /= amount_lungs
	co2_breath_dam_max /= amount_lungs
	plas_breath_dam_min /= amount_lungs
	plas_breath_dam_max /= amount_lungs
	safe_oxygen_min /= amount_lungs
	safe_oxygen_max /= amount_lungs
	safe_nitro_min /= amount_lungs
	safe_nitro_max /= amount_lungs
	safe_co2_min /= amount_lungs
	safe_co2_max /= amount_lungs
	safe_plas_min /= amount_lungs
	safe_plas_max /= amount_lungs
	SA_para_min /= amount_lungs
	SA_sleep_min /= amount_lungs
	BZ_trip_balls_min /= amount_lungs
	BZ_brain_damage_min /= amount_lungs
	healium_para_min /= amount_lungs
	healium_sleep_min /= amount_lungs

	//-- OXY --//

	//Too much oxygen! //Yes, some lungs may not like it!
	if(safe_oxygen_max)
		if(O2_pp > safe_oxygen_max)
			var/ratio = (breath_gases[/datum/gas/oxygen][MOLES]/safe_oxygen_max) * 10
			apply_damage_type(clamp(ratio, oxy_breath_dam_min, oxy_breath_dam_max), oxy_damage_type)

	//Too little oxygen!
	if(safe_oxygen_min)
		if(O2_pp < safe_oxygen_min)
			gas_breathed = check_too_little_breath(O2_pp, safe_oxygen_min, breath_gases[/datum/gas/oxygen][MOLES], lung_efficiency, lungs, lung_process)
		else
			failed_last_breath = FALSE
			gas_breathed = breath_gases[/datum/gas/oxygen][MOLES]

	//Exhale
	breath_gases[/datum/gas/oxygen][MOLES] -= gas_breathed
	breath_gases[/datum/gas/carbon_dioxide][MOLES] += gas_breathed
	gas_breathed = 0

	//-- Nitrogen --//

	//Too much nitrogen!
	if(safe_nitro_max)
		if(N2_pp > safe_nitro_max)
			var/ratio = (breath_gases[/datum/gas/nitrogen][MOLES]/safe_nitro_max) * 10
			apply_damage_type(clamp(ratio, nitro_breath_dam_min, nitro_breath_dam_max), nitro_damage_type)

	//Too little nitrogen!
	if(safe_nitro_min)
		if(N2_pp < safe_nitro_min)
			gas_breathed = check_too_little_breath(N2_pp, safe_nitro_min, breath_gases[/datum/gas/nitrogen][MOLES], lung_efficiency, lungs, lung_process)
		else
			failed_last_breath = FALSE
			gas_breathed = breath_gases[/datum/gas/nitrogen][MOLES]

	//Exhale
	breath_gases[/datum/gas/nitrogen][MOLES] -= gas_breathed
	breath_gases[/datum/gas/carbon_dioxide][MOLES] += gas_breathed
	gas_breathed = 0

	//-- CO2 --//

	//CO2 does not affect failed_last_breath. So if there was enough oxygen in the air but too much co2, this will hurt you, but only once per 4 ticks, instead of once per tick.
	if(safe_co2_max)
		if(CO2_pp > safe_co2_max)
			if(!co2overloadtime) // If it's the first breath with too much CO2 in it, lets start a counter, then have them pass out after 12s or so.
				co2overloadtime = world.time
			else if(world.time - co2overloadtime > 120)
				Unconscious(60)
				apply_damage_type(3, co2_damage_type) // Lets hurt em a little, let them know we mean business
				if(world.time - co2overloadtime > 300) // They've been in here 30s now, lets start to kill them for their own good!
					apply_damage_type(8, co2_damage_type)
			if(prob(20)) // Lets give them some chance to know somethings not right though I guess.
				emote("cough")
		else
			co2overloadtime = 0

	//Too little CO2!
	if(safe_co2_min)
		if(CO2_pp < safe_co2_min)
			gas_breathed = check_too_little_breath(CO2_pp, safe_co2_min, breath_gases[/datum/gas/carbon_dioxide][MOLES], lung_efficiency, lungs, lung_process)
		else
			failed_last_breath = FALSE
			gas_breathed = breath_gases[/datum/gas/carbon_dioxide][MOLES]

	//Exhale
	breath_gases[/datum/gas/carbon_dioxide][MOLES] -= gas_breathed
	breath_gases[/datum/gas/oxygen][MOLES] += gas_breathed
	gas_breathed = 0


	//-- TOX --//

	//Too much plasma!
	if(safe_plas_max)
		if(Toxins_pp > safe_plas_max)
			var/ratio = (breath_gases[/datum/gas/plasma][MOLES]/safe_plas_max) * 10
			apply_damage_type(clamp(ratio, plas_breath_dam_min, plas_breath_dam_max), plas_damage_type)

	//Too little plasma!
	if(safe_plas_min)
		if(Toxins_pp < safe_plas_min)
			gas_breathed = check_too_little_breath(Toxins_pp, safe_plas_min, breath_gases[/datum/gas/plasma][MOLES], lung_efficiency, lungs, lung_process)
		else
			failed_last_breath = FALSE
			gas_breathed = breath_gases[/datum/gas/plasma][MOLES]

	//Exhale
	breath_gases[/datum/gas/plasma][MOLES] -= gas_breathed
	breath_gases[/datum/gas/carbon_dioxide][MOLES] += gas_breathed
	gas_breathed = 0


	//-- TRACES --//

	if(breath) // If there's some other shit in the air lets deal with it here.

	// N2O

		var/SA_pp = breath.get_breath_partial_pressure(breath_gases[/datum/gas/nitrous_oxide][MOLES])
		if(SA_pp > SA_para_min) // Enough to make us stunned for a bit
			Unconscious(60) // 60 gives them one second to wake up and run away a bit!
			if(SA_pp > SA_sleep_min) // Enough to make us sleep as well
				Sleeping(min(AmountSleeping() + 100, 200))
				add_chem_effect(CE_PAINKILLER, 100, "nitrous_oxide")
		else if(SA_pp > 0.01) // There is sleeping gas in their lungs, but only a little, so give them a bit of a warning
			if(prob(20))
				n2o_euphoria = EUPHORIA_ACTIVE
				emote(pick("giggle", "laugh"))
			remove_chem_effect(CE_PAINKILLER, "nitrous_oxide")
		else
			remove_chem_effect(CE_PAINKILLER, "nitrous_oxide")
			n2o_euphoria = EUPHORIA_INACTIVE

	// BZ

		var/bz_pp = breath.get_breath_partial_pressure(breath_gases[/datum/gas/bz][MOLES])
		if(bz_pp > BZ_trip_balls_min)
			hallucination += 10
			reagents.add_reagent(/datum/reagent/bz_metabolites,5)
		if(bz_pp > BZ_brain_damage_min && prob(33))
			adjustOrganLoss(ORGAN_SLOT_BRAIN, 3, 150)

	// Tritium
		var/trit_pp = breath.get_breath_partial_pressure(breath_gases[/datum/gas/tritium][MOLES])
		// If you're breathing in half an atmosphere of radioactive gas, you fucked up.
		if (trit_pp > tritium_irradiation_moles_min && SSradiation.can_irradiate_basic(src))
			var/lerp_scale = min(tritium_irradiation_moles_max, trit_pp - tritium_irradiation_moles_min) / (tritium_irradiation_moles_max - tritium_irradiation_moles_min)
			var/chance = LERP(tritium_irradiation_probability_min, tritium_irradiation_probability_max, lerp_scale)
			if (prob(chance))
				AddComponent(/datum/component/irradiated)

		gas_breathed = breath_gases[/datum/gas/tritium][MOLES]

		if (trit_pp > 0)
			var/ratio = gas_breathed * 15
			adjustToxLoss(clamp(ratio, MIN_TOXIC_GAS_DAMAGE, MAX_TOXIC_GAS_DAMAGE))

		breath_gases[/datum/gas/tritium][MOLES] -= gas_breathed

	// Nitryl
		var/nitryl_pp = breath.get_breath_partial_pressure(breath_gases[/datum/gas/nitryl][MOLES])
		if (prob(nitryl_pp))
			emote("burp")
		if (prob(nitryl_pp) && nitryl_pp>10)
			adjustOrganLoss(ORGAN_SLOT_LUNGS, nitryl_pp/2)
			to_chat(src, span_notice("You feel a burning sensation in your chest"))
		gas_breathed = breath_gases[/datum/gas/nitryl][MOLES]
		if (gas_breathed > gas_stimulation_min)
			reagents.add_reagent(/datum/reagent/nitryl,1)

		breath_gases[/datum/gas/nitryl][MOLES]-=gas_breathed

	// Freon
		var/freon_pp = breath.get_breath_partial_pressure(breath_gases[/datum/gas/freon][MOLES])
		if (prob(freon_pp))
			to_chat(src, span_alert("Your mouth feels like it's burning!"))
		if (freon_pp >40)
			emote("gasp")
			adjustFireLoss(15)
			if (prob(freon_pp/2))
				to_chat(src, span_alert("Your throat closes up!"))
				silent = max(silent, 3)
		else
			adjustFireLoss(freon_pp/4)
		gas_breathed = breath_gases[/datum/gas/freon][MOLES]
		if (gas_breathed > gas_stimulation_min)
			reagents.add_reagent(/datum/reagent/freon,1)

		breath_gases[/datum/gas/freon][MOLES]-=gas_breathed

	// Healium
		var/healium_pp = breath.get_breath_partial_pressure(breath_gases[/datum/gas/healium][MOLES])
		if(healium_pp > gas_stimulation_min)
			if(prob(15))
				to_chat(src, span_alert("Your head starts spinning and your lungs burn!"))
				healium_euphoria = EUPHORIA_ACTIVE
				emote("gasp")
		else
			healium_euphoria = EUPHORIA_INACTIVE

		if(healium_pp > healium_para_min)
			Unconscious(rand(30, 50))//not in seconds to have a much higher variation
			if(healium_pp > healium_sleep_min)
				var/existing = reagents.get_reagent_amount(/datum/reagent/healium)
				reagents.add_reagent(/datum/reagent/healium,max(0, 1 - existing))
		gas_breathed = breath_gases[/datum/gas/healium][MOLES]
		breath_gases[/datum/gas/healium][MOLES]-=gas_breathed

	// Proto Nitrate
		// Inert
	// Zauker
		var/zauker_pp = breath.get_breath_partial_pressure(breath_gases[/datum/gas/zauker][MOLES])
		if(zauker_pp > gas_stimulation_min)
			adjustBruteLoss(25)
			adjustOxyLoss(5)
			adjustFireLoss(8)
			adjustToxLoss(8)
		gas_breathed = breath_gases[/datum/gas/zauker][MOLES]
		breath_gases[/datum/gas/zauker][MOLES]-=gas_breathed

	// Halon
		var/halon_pp = breath.get_breath_partial_pressure(breath_gases[/datum/gas/halon][MOLES])
		if(halon_pp > gas_stimulation_min)
			adjustOxyLoss(5)
			var/existing = reagents.get_reagent_amount(/datum/reagent/halon)
			reagents.add_reagent(/datum/reagent/halon,max(0, 1 - existing))
		gas_breathed = breath_gases[/datum/gas/halon][MOLES]
		breath_gases[/datum/gas/halon][MOLES]-=gas_breathed

	// Stimulum
		gas_breathed = breath_gases[/datum/gas/stimulum][MOLES]
		if (gas_breathed > gas_stimulation_min)
			var/existing = reagents.get_reagent_amount(/datum/reagent/stimulum)
			reagents.add_reagent(/datum/reagent/stimulum,max(0, 1 - existing))
		breath_gases[/datum/gas/stimulum][MOLES]-=gas_breathed

	// Hyper-Nob
		gas_breathed = breath_gases[/datum/gas/hypernoblium][MOLES]
		if (gas_breathed > gas_stimulation_min)
			var/existing = reagents.get_reagent_amount(/datum/reagent/hypernoblium)
			reagents.add_reagent(/datum/reagent/hypernoblium,max(0, 1 - existing))
		breath_gases[/datum/gas/hypernoblium][MOLES]-=gas_breathed

	// Miasma
		if (breath_gases[/datum/gas/miasma] && suffers_miasma)
			var/miasma_pp = breath.get_breath_partial_pressure(breath_gases[/datum/gas/miasma][MOLES])

			//Miasma sickness
			if(prob(0.5 * miasma_pp))
				var/datum/disease/advance/miasma_disease = new /datum/disease/advance/random(min(round(max(miasma_pp/2, 1), 1), 6), min(round(max(miasma_pp, 1), 1), 8))
				//tl;dr the first argument chooses the smaller of miasma_pp/2 or 6(typical max virus symptoms), the second chooses the smaller of miasma_pp or 8(max virus symptom level) //
				miasma_disease.name = "Unknown"//^each argument has a minimum of 1 and rounds to the nearest value. Feel free to change the pp scaling I couldn't decide on good numbers for it.
				miasma_disease.try_infect(src)

			// Miasma side effects
			switch(miasma_pp)
				if(0.25 to 5)
					// At lower pp, give out a little warning
					SEND_SIGNAL(src, COMSIG_CLEAR_MOOD_EVENT, "smell")
					if(prob(5))
						to_chat(src, span_notice("There is an unpleasant smell in the air."))
				if(5 to 15)
					//At somewhat higher pp, warning becomes more obvious
					if(prob(15))
						to_chat(src, span_warning("You smell something horribly decayed inside this room."))
						SEND_SIGNAL(src, COMSIG_ADD_MOOD_EVENT, "smell", /datum/mood_event/disgust/bad_smell)
				if(15 to 30)
					//Small chance to vomit. By now, people have internals on anyway
					if(prob(5))
						to_chat(src, span_warning("The stench of rotting carcasses is unbearable!"))
						SEND_SIGNAL(src, COMSIG_ADD_MOOD_EVENT, "smell", /datum/mood_event/disgust/nauseating_stench)
						vomit()
				if(30 to INFINITY)
					//Higher chance to vomit. Let the horror start
					if(prob(15))
						to_chat(src, span_warning("The stench of rotting carcasses is unbearable!"))
						SEND_SIGNAL(src, COMSIG_ADD_MOOD_EVENT, "smell", /datum/mood_event/disgust/nauseating_stench)
						vomit()
				else
					SEND_SIGNAL(src, COMSIG_CLEAR_MOOD_EVENT, "smell")

			// In a full miasma atmosphere with 101.34 pKa, about 10 disgust per breath, is pretty low compared to threshholds
			// Then again, this is a purely hypothetical scenario and hardly reachable
			adjust_disgust(0.1 * miasma_pp)

			breath_gases[/datum/gas/miasma][MOLES]-=gas_breathed

		// Clear out moods when no miasma at all
		else
			SEND_SIGNAL(src, COMSIG_CLEAR_MOOD_EVENT, "smell")

		if (n2o_euphoria == EUPHORIA_ACTIVE || healium_euphoria == EUPHORIA_ACTIVE)
			SEND_SIGNAL(src, COMSIG_ADD_MOOD_EVENT, "chemical_euphoria", /datum/mood_event/chemical_euphoria)
		else if (n2o_euphoria == EUPHORIA_INACTIVE && healium_euphoria == EUPHORIA_INACTIVE)
			SEND_SIGNAL(src, COMSIG_CLEAR_MOOD_EVENT, "chemical_euphoria")

		// Activate mood on first flag, remove on second, do nothing on third.
		if(!failed_last_breath)
			adjustOxyLoss(-HUMAN_MAX_OXYLOSS)
			update_hud_breath(failed_last_breath, lung_efficiency, lung_process.bruised_threshold, lung_process.failing_threshold)

		check_breath_temperature(breath, lung_efficiency, lungs, lung_process)
		breath.garbage_collect()

	return TRUE

/mob/living/carbon/human/proc/check_too_little_breath(breath_pp = 0, safe_breath_min = 0, true_pp = 0, lung_efficiency = 100, list/lungs, datum/organ_process/lung_process)
	. = 0
	if(!safe_breath_min) //the other args are either: Ok being 0 or Specifically handled.
		return FALSE
	if(prob(20))
		agony_gasp()

	if(breath_pp > 0)
		var/ratio = safe_breath_min/breath_pp
		adjustOxyLoss(min(5*ratio, HUMAN_MAX_OXYLOSS)) // Don't fuck them up too fast (space only does HUMAN_MAX_OXYLOSS after all!
		. = true_pp*ratio/6
	else
		adjustOxyLoss(HUMAN_MAX_OXYLOSS)
	failed_last_breath = TRUE
	update_hud_breath(failed_last_breath, lung_efficiency, lung_process.bruised_threshold, lung_process.failing_threshold)

/mob/living/carbon/human/check_failed_breath(datum/gas_mixture/breath, lung_efficiency = 0, list/lungs, datum/organ_process/lung_process)
	for(var/thing in lungs)
		var/obj/item/organ/lungs/lung = thing
		if(reagents.has_reagent(lung.crit_stabilizing_reagent, needs_metabolizing = TRUE))
			return FALSE
	if(prob(20))
		agony_gasp()

	adjustOxyLoss(HUMAN_MAX_OXYLOSS)
	failed_last_breath = TRUE
	update_hud_breath(failed_last_breath, lung_efficiency, lung_process.bruised_threshold, lung_process.failing_threshold)

/mob/living/carbon/human/check_breath_temperature(datum/gas_mixture/breath, lung_efficiency = 0, list/lungs, datum/organ_process/lung_process)
	var/obj/item/organ/lungs/lung = LAZYACCESS(lungs, 1)
	if(!lung)
		return

	var/breath_temperature = breath.temperature
	var/cold_message = lung.cold_message
	var/cold_level_1_threshold = lung.cold_level_1_threshold
	var/cold_level_2_threshold = lung.cold_level_2_threshold
	var/cold_level_3_threshold = lung.cold_level_3_threshold
	var/cold_level_1_damage = lung.cold_level_1_damage
	var/cold_level_2_damage = lung.cold_level_2_damage
	var/cold_level_3_damage = lung.cold_level_3_damage
	var/cold_damage_type = lung.cold_damage_type
	var/hot_message = lung.hot_message
	var/heat_level_1_threshold = lung.heat_level_1_threshold
	var/heat_level_2_threshold = lung.heat_level_2_threshold
	var/heat_level_3_threshold = lung.heat_level_3_threshold
	var/heat_level_1_damage = lung.heat_level_1_damage
	var/heat_level_2_damage = lung.heat_level_2_damage
	var/heat_level_3_damage = lung.heat_level_3_damage
	var/heat_damage_type = lung.heat_damage_type
	// COLD DAMAGE
	if(!HAS_TRAIT(src, TRAIT_RESISTCOLD))
		var/cold_modifier = dna.species.coldmod
		if(breath_temperature < cold_level_3_threshold)
			apply_damage(cold_level_3_damage*cold_modifier, cold_damage_type, check_zone(BODY_ZONE_PRECISE_FACE))
		if(breath_temperature > cold_level_3_threshold && breath_temperature < cold_level_2_threshold)
			apply_damage(cold_level_2_damage*cold_modifier, cold_damage_type, check_zone(BODY_ZONE_PRECISE_FACE))
			lung.applyOrganDamage(heat_level_1_damage)
		if(breath_temperature > cold_level_2_threshold && breath_temperature < cold_level_1_threshold)
			apply_damage(cold_level_1_damage*cold_modifier, cold_damage_type, check_zone(BODY_ZONE_PRECISE_FACE))
			lung.applyOrganDamage(heat_level_2_damage)
		if((breath_temperature < cold_level_1_threshold) && prob(20))
			to_chat(src, span_warning("I feel [cold_message] in my [lung]!"))
	// HEAT DAMAGE
	if(!HAS_TRAIT(src, TRAIT_RESISTHEAT))
		var/heat_modifier = dna.species.heatmod
		if(breath_temperature >= heat_level_1_threshold && breath_temperature < heat_level_2_threshold)
			apply_damage(heat_level_1_damage*heat_modifier, heat_damage_type, check_zone(BODY_ZONE_PRECISE_FACE))
		if(breath_temperature >= heat_level_2_threshold && breath_temperature < heat_level_3_threshold)
			apply_damage(heat_level_2_damage*heat_modifier, heat_damage_type, check_zone(BODY_ZONE_PRECISE_FACE))
			lung.applyOrganDamage(heat_level_1_damage)
		if(breath_temperature >= heat_level_3_threshold)
			apply_damage(heat_level_3_damage*heat_modifier, heat_damage_type, check_zone(BODY_ZONE_PRECISE_FACE))
			lung.applyOrganDamage(heat_level_2_damage)
		if((breath_temperature >= heat_level_1_threshold) && prob(20))
			to_chat(src, span_warning("I feel [hot_message] in my [lung]!"))

	// The air you breathe out should match your body temperature
	breath.temperature = bodytemperature
