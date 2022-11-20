//DEV NOTE: Implementing inverse and failed chems is a waste of time i do not want to invest on right now
//Have somewhat boring chems for now

/******BRUTE******/
/*(Common) Suffix: -ine*/

//libital -> codeine
/datum/reagent/medicine/c2/libital
	name = "Codeine"
	description = "Codeine is a slight painkiller and brute reliever opioid."
	reagent_state = SOLID
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	metabolization_rate = REAGENTS_METABOLISM
	addiction_types = list(/datum/addiction/opiods = 5) //1 per 2 seconds
	overdose_threshold = 0
	failed_chem = null
	inverse_chem = null
	impure_chem = null

/datum/reagent/medicine/c2/libital/on_mob_metabolize(mob/living/L)
	. = ..()
	L.add_chem_effect(CE_PAINKILLER, 20, "[type]")

/datum/reagent/medicine/c2/libital/on_mob_end_metabolize(mob/living/L)
	. = ..()
	L.remove_chem_effect(CE_PAINKILLER, "[type]")

/datum/reagent/medicine/c2/libital/on_mob_life(mob/living/carbon/M, delta_time, times_fired)
	. = ..()
	M.heal_overall_damage(brute = 2 * REM * delta_time)
	return TRUE

//helbital -> bicaridine
/datum/reagent/medicine/c2/helbital
	name = "Bicaridine"
	description = "Bicaridine is a fast-acting medication to treat physical trauma. \
				Overdosing may cause headaches and dizzyness."
	reagent_state = LIQUID
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	metabolization_rate = REAGENTS_METABOLISM
	overdose_threshold = OVERDOSE_STANDARD
	addiction_types = list(/datum/addiction/opiods = 10) //2 per 2 seconds
	overdose_threshold = 0
	failed_chem = null
	inverse_chem = null
	impure_chem = null

/datum/reagent/medicine/c2/helbital/on_mob_life(mob/living/carbon/M, delta_time, times_fired)
	. = ..()
	M.heal_overall_damage(brute = 6 * REM * delta_time)
	return TRUE

/datum/reagent/medicine/c2/helbital/overdose_start(mob/living/M)
	. = ..()
	M.HeadRape(4 SECONDS)

/datum/reagent/medicine/c2/helbital/overdose_process(mob/living/M, delta_time, times_fired)
	. = ..()
	M.HeadRape(4 SECONDS)

/******BURN******/
/*(Common) Suffix: -ane*/

//aiuri -> naproxane
/datum/reagent/medicine/c2/aiuri
	name = "Naproxane"
	description = "Naproxane is an anti-inflammatory and burn reliever opioid."
	reagent_state = LIQUID
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	metabolization_rate = REAGENTS_METABOLISM
	overdose_threshold = OVERDOSE_STANDARD
	addiction_types = list(/datum/addiction/opiods = 10) //2 per 2 seconds
	overdose_threshold = 0
	failed_chem = null
	inverse_chem = null
	impure_chem = null

/datum/reagent/medicine/c2/aiuri/on_mob_metabolize(mob/living/L)
	. = ..()
	L.add_chem_effect(CE_PAINKILLER, 20, "[type]")

/datum/reagent/medicine/c2/aiuri/on_mob_end_metabolize(mob/living/L)
	. = ..()
	L.remove_chem_effect(CE_PAINKILLER, "[type]")

/datum/reagent/medicine/c2/aiuri/on_mob_life(mob/living/carbon/M, delta_time, times_fired)
	. = ..()
	M.heal_overall_damage(burn = 2 * REM * delta_time)
	return TRUE

//lenturi -> kelotane
/datum/reagent/medicine/c2/lenturi
	name = "Kelotane"
	description = "Kelotane is a fast-acting medication to treat burns. \
				Overdosing causes toxic allergic reactions."
	reagent_state = LIQUID
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	metabolization_rate = REAGENTS_METABOLISM
	addiction_types = list(/datum/addiction/opiods = 5) //1 per 2 seconds
	overdose_threshold = 0
	failed_chem = null
	inverse_chem = null
	impure_chem = null

/datum/reagent/medicine/c2/lenturi/on_mob_life(mob/living/carbon/M, delta_time, times_fired)
	. = ..()
	M.heal_overall_damage(burn = 6 * REM * delta_time)
	return TRUE

/datum/reagent/medicine/c2/lenturi/on_mob_end_metabolize(mob/living/L)
	. = ..()
	L.remove_chem_effect(CE_TOXIN, "[type]")

/datum/reagent/medicine/c2/lenturi/overdose_start(mob/living/M)
	. = ..()
	M.add_chem_effect(CE_TOXIN, 1, "[type]")

/datum/reagent/medicine/c2/lenturi/overdose_process(mob/living/carbon/M, delta_time, times_fired)
	. = ..()
	M.adjustToxLoss(2 * REM * delta_time)

/******TOXIN******/
/*(Common) Suffix: -al*/

//multiver -> charcoal
/datum/reagent/medicine/c2/multiver
	name = "Activated Charcoal"
	description = "Activated charcoal is a broad spectrum antitoxin used to stimulate toxin filtering by the kidneys and liver."
	ph = 7.2
	reagent_state = SOLID
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	metabolization_rate = REAGENTS_METABOLISM
	overdose_threshold = 0
	failed_chem = null
	inverse_chem = null
	impure_chem = null

/datum/reagent/medicine/c2/multiver/on_mob_metabolize(mob/living/L)
	. = ..()
	L.add_chem_effect(CE_ANTITOX, 65, "[type]")

/datum/reagent/medicine/c2/multiver/on_mob_end_metabolize(mob/living/L)
	. = ..()
	L.remove_chem_effect(CE_ANTITOX, "[type]")

//syriniver -> dylovene
/datum/reagent/medicine/c2/syriniver
	name = "Dylovenal"
	description = "Dylovenal is a broad-spectrum antitoxin used to neutralize toxins in the bloodstream."
	ph = 5.6
	reagent_state = LIQUID
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	metabolization_rate = REAGENTS_METABOLISM
	overdose_threshold = 0
	failed_chem = null
	inverse_chem = null
	impure_chem = null

/datum/reagent/medicine/c2/syriniver/on_mob_metabolize(mob/living/L)
	. = ..()
	L.add_chem_effect(CE_ANTITOX, 20, "[type]")

/datum/reagent/medicine/c2/syriniver/on_mob_end_metabolize(mob/living/L)
	. = ..()
	L.remove_chem_effect(CE_ANTITOX, 20, "[type]")

/datum/reagent/medicine/c2/syriniver/on_mob_life(mob/living/carbon/human/M, delta_time, times_fired)
	. = ..()
	M.adjustToxLoss(-2 * REM * delta_time)
	return TRUE

/******OXY******/
/*(Common) Suffix: -ol*/

//convermol -> formoterol
/datum/reagent/medicine/c2/convermol
	name = "Formoterol"
	description = "A bronchodilator capable of efficiently oxygenating the lungs of affected patients."
	reagent_state = SOLID
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	metabolization_rate = REAGENTS_METABOLISM
	overdose_threshold = 0
	failed_chem = null
	inverse_chem = null
	impure_chem = null

/datum/reagent/medicine/c2/convermol/on_mob_life(mob/living/carbon/human/M, delta_time, times_fired)
	. = ..()
	M.adjustOxyLoss(-4 * REM * delta_time)
	return TRUE

//tirimol -> levalbuterol
/datum/reagent/medicine/c2/tirimol
	name = "Levalbuterol"
	description = "Levalbuterol is a beta agonist capable of efficiently restoring blood oxygenation."
	reagent_state = LIQUID
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	metabolization_rate = REAGENTS_METABOLISM
	overdose_threshold = 0
	failed_chem = null
	inverse_chem = null
	impure_chem = null

/datum/reagent/medicine/c2/tirimol/on_mob_metabolize(mob/living/L)
	. = ..()
	L.add_chem_effect(CE_OXYGENATED, 1, "[type]")

/datum/reagent/medicine/c2/tirimol/on_mob_end_metabolize(mob/living/L)
	. = ..()
	L.remove_chem_effect(CE_OXYGENATED, "[type]")

/******COMBOS******/
/*(Common) Suffix: -eral*/

//synthflesh -> menderal
/datum/reagent/medicine/c2/synthflesh
	name = "Menderal" //Because it mends all... I am so clever!
	description = "Heals both brute and burn damage. 100u or more can restore corpses husked by burns. \
				Toxic when ingested, touch application only."
	reagent_state = SOLID
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	metabolization_rate = REAGENTS_METABOLISM
	overdose_threshold = 0
	failed_chem = null
	inverse_chem = null
	impure_chem = null

/datum/reagent/medicine/c2/synthflesh/expose_mob(mob/living/exposed_mob, methods=TOUCH, reac_volume, show_message = TRUE)
	. = ..()
	if(exposed_mob.stat == DEAD)
		show_message = 0
	if(!(initial_methods & (PATCH|TOUCH|VAPOR)))
		return
	var/mob/living/carbon/carbies = exposed_mob
	if(istype(carbies))
		for(var/i in carbies.all_wounds)
			var/datum/wound/iter_wound = i
			iter_wound.on_synthflesh(reac_volume)
	exposed_mob.heal_overall_damage(brute = 1.5 * reac_volume, burn = 1.5 * reac_volume)
	if(show_message)
		to_chat(exposed_mob, span_danger("You feel your burns and bruises healing! It stings like hell!"))
	SEND_SIGNAL(exposed_mob, COMSIG_ADD_MOOD_EVENT, "painful_medicine", /datum/mood_event/painful_medicine)
	if(HAS_TRAIT_FROM(exposed_mob, TRAIT_HUSK, BURN) && carbies.getFireLoss() < UNHUSK_DAMAGE_THRESHOLD && (carbies.reagents.get_reagent_amount(/datum/reagent/medicine/c2/synthflesh) + reac_volume >= SYNTHFLESH_UNHUSK_AMOUNT))
		carbies.cure_husk(BURN)
		carbies.visible_message("<span class='nicegreen'>A rubbery liquid coats [carbies]'s burns. [carbies] looks a lot healthier!") //we're avoiding using the phrases "burnt flesh" and "burnt skin" here because carbies could be a skeleton or a golem or something

/datum/reagent/medicine/c2/synthflesh/on_mob_life(mob/living/carbon/M, delta_time, times_fired)
	. = ..()
	if(!(initial_methods & (PATCH|TOUCH|VAPOR)))
		M.adjustToxLoss(2 * REM * delta_time)
	return TRUE

//probital -> dicorderal
/datum/reagent/medicine/c2/probital
	name = "Dicorderal"
	description = "Heals both brute and burn damage, but rather slowly."
	color = "#c15aec"
	reagent_state = LIQUID
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	metabolization_rate = REAGENTS_METABOLISM
	overdose_threshold = 0
	failed_chem = null
	inverse_chem = null
	impure_chem = null

/datum/reagent/medicine/c2/probital/on_mob_metabolize(mob/living/L)
	. = ..()
	L.add_chem_effect(CE_PAINKILLER, 25, "[type]")

/datum/reagent/medicine/c2/probital/on_mob_end_metabolize(mob/living/L)
	. = ..()
	L.remove_chem_effect(CE_PAINKILLER, "[type]")

/datum/reagent/medicine/c2/probital/on_mob_life(mob/living/carbon/M, delta_time, times_fired)
	. = ..()
	M.heal_overall_damage(brute = 3 * REM * delta_time, burn = 3 * REM * delta_time)
	return TRUE

/******ORGAN******/
/*Suffix: -il*/

//penthrite -> minoxidil
/datum/reagent/medicine/c2/penthrite
	name = "Trekhin"
	description = "Trekhin is used as a blood pressure reducer, as well as healing organ damage over time."
	color = "#fff48c8e"
	ph = 3.8
	reagent_state = LIQUID
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	metabolization_rate = REAGENTS_METABOLISM
	overdose_threshold = 0
	taste_description = "sour"
	failed_chem = null
	inverse_chem = null
	impure_chem = null

/datum/reagent/medicine/c2/penthrite/on_mob_metabolize(mob/living/L)
	. = ..()
	L.add_chem_effect(CE_PULSE, -1, "[type]")

/datum/reagent/medicine/c2/penthrite/on_mob_end_metabolize(mob/living/L)
	. = ..()
	L.remove_chem_effect(CE_PULSE, "[type]")

/datum/reagent/medicine/c2/penthrite/on_mob_life(mob/living/carbon/M, delta_time, times_fired)
	. = ..()
	var/list/damaged_organs = list()
	for(var/obj/item/organ/organ as anything in M.internal_organs)
		if(organ.damage && !CHECK_BITFIELD(organ.organ_flags, ORGAN_NO_VIOLENT_DAMAGE))
			damaged_organs += organ
	if(LAZYLEN(damaged_organs))
		var/obj/item/organ/organ = pick(damaged_organs)
		organ.applyOrganDamage(-2 * 0.5 * delta_time)
	return TRUE

/******RADIATION******/
/*(Common) Suffix: none yet i guess*/

//seiver -> prussian blue
/datum/reagent/medicine/c2/seiver
	name = "Prussian Blue"
	description = "Originally created as a dye, this chemical can be used to effectively reduce radiation. \
				Does not act against radiation sickness."
	color = "#003053"
	ph = 6.4
	reagent_state = LIQUID
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	metabolization_rate = REAGENTS_METABOLISM*2
	overdose_threshold = 0
	failed_chem = null
	inverse_chem = null
	impure_chem = null

/datum/reagent/medicine/c2/seiver/on_mob_life(mob/living/carbon/M, delta_time, times_fired)
	. = ..()
	var/datum/component/irradiated/hisashi_ouchi = M.GetComponent(/datum/component/irradiated)
	if(hisashi_ouchi)
		hisashi_ouchi.rads = clamp(CEILING(hisashi_ouchi.rads - (RADIATION_CLEANING_POWER/20)*delta_time, 1), 0, RADIATION_MAXIMUM_RADS)
