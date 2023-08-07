/// Returns how often we need to breathe, basically
/mob/living/carbon/proc/get_breath_modulo()
	return 4

/// Returns how much air we need to breathe in
/mob/living/carbon/proc/get_breath_volume()
	return BREATH_VOLUME

/// We handle breathing with the new organ process system, which will call breathe()
/mob/living/carbon/handle_breathing(delta_time, times_fired)
	return

/// Second link in a breath chain, calls check_breath()
/mob/living/carbon/breathe(delta_time, times_fired, datum/organ_process/lung_process)
	if(reagents.has_reagent(/datum/reagent/toxin/lexorin, needs_metabolizing = TRUE))
		return

	if(istype(loc, /obj/machinery/atmospherics/components/unary/cryo_cell))
		return

	var/datum/gas_mixture/environment
	if(loc)
		environment = loc.return_air()

	var/datum/gas_mixture/breath

	var/turf/turf_loc = get_turf(src)
	if(turf_loc?.pollution)
		turf_loc.pollution.touch_act(src)

	if(getorganslotefficiency(ORGAN_SLOT_BREATHING_TUBE) < ORGAN_FAILING_EFFICIENCY)
		//You can't breath at all when in critical, when being choked, holding your breath, or drowning,
		//so you're going to miss a breath
		if(HAS_TRAIT(src, TRAIT_HOLDING_BREATH) || HAS_TRAIT(src, TRAIT_MAGIC_CHOKE) || \
			(undergoing_cardiac_arrest() && !get_chem_effect(CE_STABLE)) || \
			(pulledby?.grab_state >= GRAB_KILL) || \
			turf_loc?.liquids && !HAS_TRAIT(src, TRAIT_WATER_BREATHING) && ((body_position == LYING_DOWN && turf_loc.liquids.liquid_state >= LIQUID_STATE_WAIST) || (body_position == STANDING_UP && turf_loc.liquids.liquid_state >= LIQUID_STATE_FULLTILE)) )
			losebreath++

	var/lung_efficiency = getorganslotefficiency(ORGAN_SLOT_LUNGS)
	var/list/lungs = getorganslotlist(ORGAN_SLOT_LUNGS)
	//Suffocation
	if(losebreath >= 1) //You've missed a breath, take oxy damage
		losebreath--
		if(prob(10))
			if(turf_loc?.liquids)
				agony_gargle()
			else
				agony_gasp()
		if(turf_loc?.liquids)
			if((oxyloss > OXYGEN_DAMAGE_CHOKING_THRESHOLD) || (stat > CONSCIOUS))
				//Try and drink water#]
				var/datum/reagents/temporary_holder = turf_loc.liquids.take_reagents_flat(CHOKE_REAGENTS_INGEST_ON_BREATH_AMOUNT)
				temporary_holder.trans_to(src, temporary_holder.total_volume, methods = INGEST)
				qdel(temporary_holder)
				visible_message(span_warning("<b>[src]</b> chokes on liquids!"), \
							span_userdanger("I'm choking on liquids!"))
				emote("liquidchoke")
		if(istype(loc, /obj/))
			var/obj/loc_as_obj = loc
			loc_as_obj.handle_internal_lifeform(src,0)
	//Breathing normally
	else
		//Breathe from internal
		var/breath_volume = get_breath_volume()
		breath = get_breath_from_internal(breath_volume)
		if(isnull(breath)) //in case of 0 pressure internals
			if(isobj(loc)) //Breathe from loc as object
				var/obj/loc_as_obj = loc
				breath = loc_as_obj.handle_internal_lifeform(src, breath_volume)
			else if(isturf(loc)) //Breathe from loc as turf
				var/breath_moles = 0
				if(environment)
					breath_moles = environment.total_moles()*(breath_volume/CELL_VOLUME)
				breath = loc.remove_air(breath_moles)
				if(turf_loc?.pollution && COOLDOWN_FINISHED(src, next_smell))
					COOLDOWN_START(src, next_smell, SMELL_COOLDOWN)
					turf_loc.pollution.smell_act(src)
					if(istype(wear_mask) && (wear_mask.clothing_flags & GAS_FILTERING) && wear_mask.has_filter)
						wear_mask.consume_filter_pollution(turf_loc.pollution)
					else
						turf_loc.pollution.breathe_act(src)
		else
			//Breathe from loc as obj again
			if(isobj(loc))
				var/obj/loc_as_obj = loc
				loc_as_obj.handle_internal_lifeform(src,0)
			if(GLOB.internals_breating_sound)
				playsound(src, GLOB.internals_breating_sound, 40, 1, SHORT_RANGE_SOUND_EXTRARANGE)

	check_breath(breath, lung_efficiency, lungs, lung_process)

/turf/attack_jaw(mob/living/carbon/M as mob)
	var/turf/turf_loc = get_turf(src)
//	var/turf/turf_loc = loc
	if(get_dist(turf_loc?.liquids,M) <= 1)
		if(M.wear_mask && M.wear_mask.flags_cover & MASKCOVERSMOUTH)
			visible_message(M, span_warning("The mask is in the way!"))
			return
		var/datum/reagents/temporary_holder = turf_loc.liquids.take_reagents_flat(CHOKE_REAGENTS_INGEST_ON_BREATH_AMOUNT)
		temporary_holder.trans_to(src, temporary_holder.total_volume, methods = INGEST)
		qdel(temporary_holder)
		visible_message(span_notice("[M] drinks the liquid."))
		playsound(M.loc, 'sound/items/drink.ogg', rand(10, 50), TRUE)
		return

/// Third link in a breath chain, calls handle_breath_temperature()
/mob/living/carbon/check_breath(datum/gas_mixture/breath, lung_efficiency = 0, list/lungs, datum/organ_process/lung_process)
	if(!breath || (breath.total_moles() <= 0) || (lung_efficiency < lung_process.failing_threshold) || !LAZYLEN(lungs))
		check_failed_breath(breath, lung_efficiency, lungs, lung_process)
		return FALSE

	var/safe_oxy_min = 16
	var/safe_co2_max = 10
	var/safe_tox_max = 0.05
	var/SA_para_min = 1
	var/SA_sleep_min = 5
	var/oxygen_used = 0
	var/breath_pressure = (breath.total_moles()*R_IDEAL_GAS_EQUATION*breath.temperature)/BREATH_VOLUME

	var/list/breath_gases = breath.gases
	breath.assert_gases(/datum/gas/oxygen, /datum/gas/plasma, /datum/gas/carbon_dioxide, /datum/gas/nitrous_oxide, /datum/gas/bz)

	var/O2_partialpressure = (breath_gases[/datum/gas/oxygen][MOLES]/breath.total_moles())*breath_pressure
	var/toxins_partialpressure = (breath_gases[/datum/gas/plasma][MOLES]/breath.total_moles())*breath_pressure
	var/CO2_partialpressure = (breath_gases[/datum/gas/carbon_dioxide][MOLES]/breath.total_moles())*breath_pressure

	//OXYGEN
	if(O2_partialpressure < safe_oxy_min) //Not enough oxygen
		if(prob(20))
			emote("gasp")
		if(O2_partialpressure > 0)
			var/ratio = 1 - O2_partialpressure/safe_oxy_min
			adjustOxyLoss(min(5*ratio, 3))
			failed_last_breath = TRUE
			oxygen_used = breath_gases[/datum/gas/oxygen][MOLES]*ratio
		else
			adjustOxyLoss(3)
			failed_last_breath = TRUE

	else //Enough oxygen
		failed_last_breath = FALSE
		if(health >= crit_threshold)
			adjustOxyLoss(-5)
		oxygen_used = breath_gases[/datum/gas/oxygen][MOLES]

	breath_gases[/datum/gas/oxygen][MOLES] -= oxygen_used
	breath_gases[/datum/gas/carbon_dioxide][MOLES] += oxygen_used

	//CARBON DIOXIDE
	if(CO2_partialpressure > safe_co2_max)
		if(!co2overloadtime)
			co2overloadtime = world.time
		else if(world.time - co2overloadtime > 120)
			Unconscious(60)
			adjustOxyLoss(3)
			if(world.time - co2overloadtime > 300)
				adjustOxyLoss(8)
		if(prob(20))
			emote("cough")

	else
		co2overloadtime = 0

	//TOXINS/PLASMA
	if(toxins_partialpressure > safe_tox_max)
		var/ratio = (breath_gases[/datum/gas/plasma][MOLES]/safe_tox_max) * 10
		adjustToxLoss(clamp(ratio, MIN_TOXIC_GAS_DAMAGE, MAX_TOXIC_GAS_DAMAGE))

	//NITROUS OXIDE
	if(breath_gases[/datum/gas/nitrous_oxide])
		var/SA_partialpressure = (breath_gases[/datum/gas/nitrous_oxide][MOLES]/breath.total_moles())*breath_pressure
		if(SA_partialpressure > SA_para_min)
			SEND_SIGNAL(src, COMSIG_CLEAR_MOOD_EVENT, "chemical_euphoria")
			Unconscious(60)
			if(SA_partialpressure > SA_sleep_min)
				Sleeping(max(AmountSleeping() + 40, 200))
		else if(SA_partialpressure > 0.01)
			if(prob(20))
				emote(pick("giggle","laugh"))
			SEND_SIGNAL(src, COMSIG_ADD_MOOD_EVENT, "chemical_euphoria", /datum/mood_event/chemical_euphoria)
		else
			SEND_SIGNAL(src, COMSIG_CLEAR_MOOD_EVENT, "chemical_euphoria")
	else
		SEND_SIGNAL(src, COMSIG_CLEAR_MOOD_EVENT, "chemical_euphoria")

	//BZ (Facepunch port of their Agent B)
	if(breath_gases[/datum/gas/bz])
		var/bz_partialpressure = (breath_gases[/datum/gas/bz][MOLES]/breath.total_moles())*breath_pressure
		if(bz_partialpressure > 1)
			hallucination += 10
		else if(bz_partialpressure > 0.01)
			hallucination += 5

	//NITRYL
	if(breath_gases[/datum/gas/nitryl])
		var/nitryl_partialpressure = (breath_gases[/datum/gas/nitryl][MOLES]/breath.total_moles())*breath_pressure
		adjustFireLoss(nitryl_partialpressure/4)

	//FREON
	if(breath_gases[/datum/gas/freon])
		var/freon_partialpressure = (breath_gases[/datum/gas/freon][MOLES]/breath.total_moles())*breath_pressure
		adjustFireLoss(freon_partialpressure * 0.25)

	//MIASMA
	if(breath_gases[/datum/gas/miasma])
		var/miasma_partialpressure = (breath_gases[/datum/gas/miasma][MOLES]/breath.total_moles())*breath_pressure

//		if(prob(1 * miasma_partialpressure))
//			var/datum/disease/advance/miasma_disease = new /datum/disease/advance/random(2,3)
//			miasma_disease.name = "Unknown"
//			ForceContractDisease(miasma_disease, TRUE, TRUE)

		//Miasma side effects
		switch(miasma_partialpressure)
			if(0.25 to 5)
				// At lower pp, give out a little warning
				SEND_SIGNAL(src, COMSIG_CLEAR_MOOD_EVENT, "smell")
				if(prob(5))
					to_chat(src, span_notice("There is an unpleasant smell in the air."))
			if(5 to 20)
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
				if(prob(25))
					to_chat(src, span_warning("The stench of rotting carcasses is unbearable!"))
					SEND_SIGNAL(src, COMSIG_ADD_MOOD_EVENT, "smell", /datum/mood_event/disgust/nauseating_stench)
					vomit()
			else
				SEND_SIGNAL(src, COMSIG_CLEAR_MOOD_EVENT, "smell")

	//Clear all moods if no miasma at all
	else
		SEND_SIGNAL(src, COMSIG_CLEAR_MOOD_EVENT, "smell")

	breath.garbage_collect()

	//BREATH TEMPERATURE
	check_breath_temperature(breath, lung_efficiency, lungs, lung_process)
	// remember to exhale too!
	check_exhale(breath, lung_efficiency, lungs, lung_process)

	return TRUE

/mob/living/carbon/proc/check_exhale(datum/gas_mixture/breath, lung_efficiency = 0, list/lungs, datum/organ_process/lung_process)
	if(!breath)
		return
	loc.assume_air(breath)
	air_update_turf(FALSE, FALSE)

/mob/living/carbon/proc/check_failed_breath(datum/gas_mixture/breath, lung_efficiency = 0, list/lungs, datum/organ_process/lung_process)
	if(get_chem_effect(CE_OXYGENATED))
		return FALSE
	if(get_chem_effect(CE_STABLE) && lung_efficiency)
		return FALSE
	if(prob(20))
		agony_gasp()
	adjustOxyLoss(3)

	failed_last_breath = TRUE

//Fourth and final link in a breath chain
/mob/living/carbon/proc/check_breath_temperature(datum/gas_mixture/breath, lung_efficiency, list/lungs, datum/organ_process/lung_process)
	// The air you breathe out should match your body temperature
	breath.temperature = bodytemperature
