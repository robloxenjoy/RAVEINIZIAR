//Atropine changes
/datum/reagent/medicine/atropine

/datum/reagent/medicine/atropine/on_mob_metabolize(mob/living/L)
	. = ..()
	if(!iscarbon(L))
		return
	var/mob/living/carbon/C = L
	var/numbing = min(50, CEILING(C.getShock(TRUE)/2, 1))
	C.add_chem_effect(CE_BLOODRESTORE, 1, "[type]")
	C.add_chem_effect(CE_PAINKILLER, numbing, "[type]")
	C.add_chem_effect(CE_STABLE, 1, "[type]")
	if(C.undergoing_cardiac_arrest() || C.undergoing_nervous_system_failure())
		C.add_chem_effect(CE_ORGAN_REGEN, 1, "[type]")

/datum/reagent/medicine/atropine/on_mob_end_metabolize(mob/living/L)
	. = ..()
	L.remove_chem_effect(CE_BLOODRESTORE, "[type]")
	L.remove_chem_effect(CE_ORGAN_REGEN, "[type] ")
	L.remove_chem_effect(CE_PAINKILLER, "[type]")
	L.remove_chem_effect(CE_TOXIN, "[type]")
	L.remove_chem_effect(CE_BLOCKAGE, "[type]")
	L.remove_chem_effect(CE_STABLE, "[type]")

/datum/reagent/medicine/atropine/on_mob_life(mob/living/carbon/M, delta_time, times_fired)
	. = ..()
	M.losebreath = max(0, M.losebreath - (delta_time * 0.5))

/datum/reagent/medicine/atropine/overdose_start(mob/living/M)
	. = ..()
	M.remove_chem_effect(CE_STABLE, "[type]")
	M.add_chem_effect(CE_TOXIN, 2, "[type]")
	M.add_chem_effect(CE_BLOCKAGE, 20, "[type]")

/datum/reagent/medicine/atropine/overdose_process(mob/living/M, delta_time, times_fired)
	. = ..()
	M.Dizzy(1 * REM * delta_time)
	M.Jitter(1 * REM * delta_time)
	ADJUSTBRAINLOSS(M, 2 * REM * delta_time)

//Powerful painkiller
/datum/reagent/medicine/morphine
	name = "Morphine"
	description = "A powerful yet highly addictive painkiller. Causes drowsyness. Overdosing causes jitteryness and muscle spasms."
	metabolization_rate = 0.5 * REAGENTS_METABOLISM
	overdose_threshold = OVERDOSE_STANDARD
	addiction_types = list(/datum/addiction/opiods = 15)

/datum/reagent/medicine/morphine/on_mob_metabolize(mob/living/L)
	. = ..()
	L.add_chem_effect(CE_PAINKILLER, 80, "[type]")

/datum/reagent/medicine/morphine/on_mob_end_metabolize(mob/living/L)
	. = ..()
	L.remove_chem_effect(CE_PAINKILLER, "[type]")

/datum/reagent/medicine/morphine/on_mob_life(mob/living/carbon/M, delta_time, times_fired)
	if(current_cycle >= 5)
		SEND_SIGNAL(M, COMSIG_ADD_MOOD_EVENT, "numb", /datum/mood_event/narcotic_medium, name)
	switch(current_cycle)
		if(12)
			to_chat(M, span_warning("I feel tired...") )
		if(13 to 20)
			if(prob(50))
				M.drowsyness += 1 * REM * delta_time
	return ..()

/datum/reagent/medicine/morphine/overdose_process(mob/living/M, delta_time, times_fired)
	M.drowsyness += 1 * REM * delta_time
	if(DT_PROB(20, delta_time))
		M.drop_all_held_items()
	if(DT_PROB(20, delta_time))
		M.Dizzy(2)
		M.Jitter(2)
	return ..()

//Slight painkiller, stabilizes pulse
/datum/reagent/medicine/inaprovaline
	name = "Inaprovalil"
	description = "Inaprovalil works as a pulse stabilizer and light painkiller. Useful for treating shock. \
				Overdosing causes fatigue and drowsyness."
	metabolization_rate = 0.5 * REAGENTS_METABOLISM
	overdose_threshold = OVERDOSE_STANDARD

/datum/reagent/medicine/inaprovaline/on_mob_metabolize(mob/living/L)
	. = ..()
	L.add_chem_effect(CE_PAINKILLER, 25, "[type]")
	L.add_chem_effect(CE_STABLE, 1, "[type]")

/datum/reagent/medicine/inaprovaline/on_mob_end_metabolize(mob/living/L)
	. = ..()
	L.remove_chem_effect(CE_PAINKILLER, "[type]")
	L.remove_chem_effect(CE_STABLE, "[type]")
	L.remove_chem_effect(CE_SPEED, "[type]")

/datum/reagent/medicine/inaprovaline/overdose_start(mob/living/M)
	. = ..()
	M.add_chem_effect(CE_SPEED, -1, "[type]")

/datum/reagent/medicine/inaprovaline/overdose_process(mob/living/M, delta_time, times_fired)
	. = ..()
	if(DT_PROB(5, delta_time))
		M.adjustFatigueLoss(25, FALSE)
	if(DT_PROB(5, delta_time))
		M.slurring = max(M.slurring, 10)
	if(DT_PROB(5, delta_time))
		M.drowsyness = max(M.drowsyness, 5)
	return TRUE

//Pulse increase and painkiller
/datum/reagent/determination
	name = "Adrenaline"
	description = "Adrenaline is a hormone used as a drug to treat cardiac arrest and other cardiac dysrhythmias resulting in diminished or absent cardiac output."
	taste_description = "rush"
	reagent_state = LIQUID
	metabolization_rate = 0.5 * REAGENTS_METABOLISM
	color = "#c8a5dc"

/datum/reagent/determination/on_mob_metabolize(mob/living/L)
	. = ..()
	L.add_chem_effect(CE_STIMULANT, 1, "[type]")
	L.add_chem_effect(CE_PULSE, 1, "[type]")
	L.add_chem_effect(CE_PAINKILLER, min(3*holder.get_reagent_amount(/datum/reagent/determination), 25), "[type]")

/datum/reagent/determination/on_mob_end_metabolize(mob/living/carbon/M)
	. = ..()
	M.remove_chem_effect(CE_STIMULANT, "[type]")
	M.remove_chem_effect(CE_PULSE, "[type]")
	M.remove_chem_effect(CE_PAINKILLER, "[type]")

//Naturally synthesized painkiller, similar to epinephrine
/datum/reagent/medicine/endorphin
	name = "Endorphin"
	description = "Endorphins are chemically similar to morphine, but naturally synthesized by the human body. \
				They are typically produced as a bodily response to pain, but can also be produced under favorable circumstances. \
				Overdosing will cause drowsyness and jitteriness."
	reagent_state = LIQUID
	color = "#ff799679"
	metabolization_rate = 0.5 * REAGENTS_METABOLISM
	overdose_threshold = 30
	ph = 6.5
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	taste_description = "euphoria"

/datum/reagent/medicine/endorphin/on_mob_metabolize(mob/living/carbon/M)
	. = ..()
	M.add_chem_effect(CE_PAINKILLER, 20, "[type]")

/datum/reagent/medicine/endorphin/on_mob_end_metabolize(mob/living/carbon/M)
	. = ..()
	M.remove_chem_effect(CE_PAINKILLER, 20, "[type]")

/datum/reagent/medicine/endorphin/overdose_start(mob/living/M)
	to_chat(M, span_userdanger("I feel EUPHORIC!"))
	SEND_SIGNAL(M, COMSIG_ADD_MOOD_EVENT, "[type]_overdose", /datum/mood_event/endorphin_enlightenment, name)

/datum/reagent/medicine/endorphin/overdose_process(mob/living/M, delta_time, times_fired)
	. = ..()
	if(DT_PROB(40, delta_time))
		M.adjust_drowsyness(5)
	if(DT_PROB(20, delta_time))
		M.adjust_disgust(5)
	M.jitteriness += 3

//Pulse increase and painkiller
/datum/reagent/medicine/epinephrine
	name = "Epinephrine"
	description = "Epinephrine slowly heals damage if a patient is in critical condition, and regulates hypoxia. \
				Overdosing causes fatigue and toxins."
	color = "#c5fff880"
	taste_description = "rush"

/datum/reagent/medicine/epinephrine/on_mob_metabolize(mob/living/carbon/M)
	. = ..()
	M.add_chem_effect(CE_STIMULANT, 1, "[type]")
	M.add_chem_effect(CE_PULSE, 1, "[type]")
	var/epinephrine_amount = holder.get_reagent_amount(/datum/reagent/medicine/epinephrine)
	M.add_chem_effect(CE_PAINKILLER, min(5*epinephrine_amount, 30), "[type]")
	if((epinephrine_amount >= overdose_threshold/2) && M.undergoing_cardiac_arrest() && (M.diceroll(GET_MOB_ATTRIBUTE_VALUE(M, STAT_ENDURANCE), context = DICE_CONTEXT_MENTAL) >= DICE_SUCCESS))
		M.set_heartattack(FALSE)

/datum/reagent/medicine/epinephrine/on_mob_end_metabolize(mob/living/carbon/M)
	. = ..()
	M.remove_chem_effect(CE_TOXIN, "[type]")
	M.remove_chem_effect(CE_STIMULANT, "[type]")
	M.remove_chem_effect(CE_PULSE, "[type]")
	M.remove_chem_effect(CE_PAINKILLER, "[type]")

/datum/reagent/medicine/epinephrine/on_mob_life(mob/living/carbon/M, delta_time, times_fired)
	if(holder.has_reagent(/datum/reagent/toxin/lexorin))
		holder.remove_reagent(/datum/reagent/toxin/lexorin, 2 * REM * delta_time)
		holder.remove_reagent(/datum/reagent/medicine/epinephrine, 1 * REM * delta_time)
		if(DT_PROB(10, delta_time))
			holder.add_reagent(/datum/reagent/toxin/histamine, 4)
		..()
		return TRUE
	if((M.getMaxHealth() - M.get_physical_damage()) <= M.crit_threshold)
		M.adjustToxLoss(-0.5 * REM * delta_time, FALSE)
		M.adjustBruteLoss(-0.5 * REM * delta_time, FALSE)
		M.adjustFireLoss(-0.5 * REM * delta_time, FALSE)
		M.adjustOxyLoss(-0.5 * REM * delta_time, FALSE)
	if(M.losebreath >= 4)
		M.losebreath -= 2 * REM * delta_time
		M.losebreath = max(0, M.losebreath)
	M.adjustStaminaLoss(-0.5 * REM * delta_time, FALSE)
	M.adjustFatigueLoss(-0.5 * REM * delta_time, FALSE)
	if(DT_PROB(10, delta_time))
		M.AdjustAllImmobility(-20)
	..()
	return TRUE

/datum/reagent/medicine/epinephrine/overdose_start(mob/living/M)
	to_chat(M, span_userdanger("I am an ADRENALINE JUNKIE!"))
	SEND_SIGNAL(M, COMSIG_ADD_MOOD_EVENT, "[type]_overdose", /datum/mood_event/adrenaline_junkie)
	M.add_chem_effect(CE_TOXIN, 2, "[type]")
	M.increase_chem_effect(CE_PULSE, 1, "[type]")

/datum/reagent/medicine/epinephrine/overdose_process(mob/living/M, delta_time, times_fired)
	if(DT_PROB(18, REM * delta_time))
		M.adjustStaminaLoss(2.5, FALSE)
		M.adjustFatigueLoss(3, FALSE)
		M.adjustToxLoss(1, FALSE)
		M.losebreath++
		..()
		return TRUE
	return ..()

//Reduces pulse slightly
/datum/reagent/medicine/lisinopril
	name = "Lisinopril"
	description = "Lisinopril is a drug used to reduce blood pressure by dilating blood vessels. \
		It is not processed by the liver and has a very slow metabolization. \
		Overdosing causes arterial blockage."
	ph = 5.1
	metabolization_rate = 0.2 * REAGENTS_METABOLISM //Lisinopril has a very, very slow metabolism IRL
	self_consuming = TRUE //Does not get processed by the liver
	color = "#dbafc0"
	overdose_threshold = OVERDOSE_STANDARD

/datum/reagent/medicine/lisinopril/on_mob_metabolize(mob/living/L)
	. = ..()
	L.add_chem_effect(CE_PULSE, -2, "[type]")

/datum/reagent/medicine/lisinopril/on_mob_end_metabolize(mob/living/L)
	. = ..()
	L.remove_chem_effect(CE_PULSE, "[type]")
	L.remove_chem_effect(CE_BLOCKAGE, "[type]")

/datum/reagent/medicine/lisinopril/overdose_start(mob/living/M)
	. = ..()
	M.add_chem_effect(CE_BLOCKAGE, 40, "[type]")

//Oxygenation
/datum/reagent/medicine/salbutamol
	name = "Salbutamol"
	description = "Rapidly restores blood oxygenation and dilates the lungs."

/datum/reagent/medicine/salbutamol/on_mob_metabolize(mob/living/L)
	. = ..()
	L.add_chem_effect(CE_OXYGENATED, 2, "[type]")

/datum/reagent/medicine/salbutamol/on_mob_end_metabolize(mob/living/L)
	. = ..()
	L.remove_chem_effect(CE_OXYGENATED, "[type]")

/datum/reagent/medicine/salbutamol/on_mob_life(mob/living/carbon/M, delta_time, times_fired)
	M.adjustOxyLoss(-3 * REM * delta_time, 0)
	..()
	return TRUE

//Antibiotic
/datum/reagent/medicine/spaceacillin
	name = "Penicillin"
	description = "Penicillin is a broad spectrum antibiotic and immune response booster. \
				Overdosing weakens immune response instead."
	metabolization_rate = 0.2 * REAGENTS_METABOLISM
	overdose_threshold = OVERDOSE_STANDARD

/datum/reagent/medicine/spaceacillin/on_mob_metabolize(mob/living/L)
	. = ..()
	L.add_chem_effect(CE_ANTIBIOTIC, 50, "[type]")
	if(iscarbon(L))
		var/mob/living/carbon/carbon_mob = L
		carbon_mob.immunity += 25

/datum/reagent/medicine/spaceacillin/on_mob_end_metabolize(mob/living/L)
	. = ..()
	L.remove_chem_effect(CE_ANTIBIOTIC, "[type]")
	if(iscarbon(L))
		var/mob/living/carbon/carbon_mob = L
		carbon_mob.immunity -= 25

/datum/reagent/medicine/spaceacillin/overdose_start(mob/living/M)
	. = ..()
	if(iscarbon(M))
		var/mob/living/carbon/carbon_mob = M
		carbon_mob.immunity -= 75
	M.remove_chem_effect(CE_ANTIBIOTIC, "[type]")

//Black Tar Heroin
/datum/reagent/medicine/blacktar
	name = "Black Tar Heroin"
	description = "The strongest painkiller. \
				Highly addictive, easily overdoseable at 15u."
	ph = 6.9
	reagent_state = LIQUID
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	metabolization_rate = REAGENTS_METABOLISM
	overdose_threshold = OVERDOSE_STANDARD
	self_consuming = TRUE //Does not get processed by the liver
	color = "#820000"
	overdose_threshold = 51

/datum/reagent/medicine/blacktar/overdose_start(mob/living/M)
	. = ..()
	if(!iscarbon(M))
		return
	var/mob/living/carbon/C = M
	C.set_heartattack(TRUE)
	C.HeadRape(4 SECONDS)

/datum/reagent/medicine/blacktar/on_mob_metabolize(mob/living/L, delta_time, times_fired)
	. = ..()
	L.playsound_local(L, 'modular_septic/sound/insanity/painhuff_start.wav', 100)
	to_chat(L, span_achievementneutral("My skin feels numb and I can't feel pain anymore."))
	L.heal_overall_damage(brute = 6 * REM * delta_time)
	L.add_chem_effect(CE_PULSE, -2, "[type]")
	L.add_chem_effect(CE_PAINKILLER, 200, "[type]")

/datum/reagent/medicine/blacktar/on_mob_end_metabolize(mob/living/L)
	. = ..()
	L.playsound_local(L, 'modular_septic/sound/insanity/painhuff_end.wav', 100)
	to_chat(L, span_achievementneutral("My skin doesn't feel numb anymore."))
	L.remove_chem_effect(CE_PAINKILLER, "[type]")
	L.remove_chem_effect(CE_PULSE, "[type]")

//Copium
/datum/reagent/medicine/copium
	name = "Copium"
	description = "The strongest painkiller. \
				Highly addictive, easily overdoseable at 15u."
	ph = 6.9
	reagent_state = GAS
	metabolization_rate = REAGENTS_METABOLISM*0.5
	self_consuming = TRUE //Does not get processed by the liver
	color = "#d364ff"
	overdose_threshold = 15

/datum/reagent/medicine/copium/overdose_start(mob/living/M)
	. = ..()
	if(!iscarbon(M))
		return
	var/mob/living/carbon/C = M
	C.set_heartattack(TRUE)
	C.client?.give_award(/datum/award/achievement/misc/copium, C)

/datum/reagent/medicine/copium/on_mob_metabolize(mob/living/L)
	. = ..()
	L.playsound_local(L, 'modular_septic/sound/insanity/painhuff_start.wav', 100)
	to_chat(L, span_achievementneutral("My skin feels numb and I can't feel pain anymore."))
	L.add_chem_effect(CE_PULSE, -2, "[type]")
	L.add_chem_effect(CE_PAINKILLER, 200, "[type]")

/datum/reagent/medicine/copium/on_mob_end_metabolize(mob/living/L)
	. = ..()
	L.playsound_local(L, 'modular_septic/sound/insanity/painhuff_end.wav', 100)
	to_chat(L, span_achievementneutral("My skin doesn't feel numb anymore."))
	L.remove_chem_effect(CE_PAINKILLER, "[type]")
	L.remove_chem_effect(CE_PULSE, "[type]")

//Radiation sickness medication
/datum/reagent/medicine/potass_iodide
	description = "A chemical used to treat radiation sickness, effectively working as a stopgap while the radiation is being flushed away. \
				Will not work if the patient is in the late stages of radiation sickness."

/datum/reagent/medicine/potass_iodide/on_mob_metabolize(mob/living/L)
	. = ..()
	var/datum/component/irradiated/hisashi_ouchi = L.GetComponent(/datum/component/irradiated)
	if(!hisashi_ouchi || (hisashi_ouchi.radiation_sickness < RADIATION_SICKNESS_UNHEALABLE))
		ADD_TRAIT(L, TRAIT_HALT_RADIATION_EFFECTS, "[type]")

/datum/reagent/medicine/potass_iodide/on_mob_end_metabolize(mob/living/L)
	. = ..()
	REMOVE_TRAIT(L, TRAIT_HALT_RADIATION_EFFECTS, "[type]")

/datum/reagent/medicine/potass_iodide/on_mob_life(mob/living/carbon/M, delta_time, times_fired)
	. = ..()
	var/datum/component/irradiated/hisashi_ouchi = M.GetComponent(/datum/component/irradiated)
	if(hisashi_ouchi && (hisashi_ouchi.radiation_sickness < RADIATION_SICKNESS_UNHEALABLE))
		hisashi_ouchi.radiation_sickness = clamp(CEILING(hisashi_ouchi.radiation_sickness - delta_time SECONDS, 1), 0, RADIATION_SICKNESS_MAXIMUM)
