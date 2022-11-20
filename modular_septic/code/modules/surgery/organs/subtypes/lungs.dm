/obj/item/organ/lungs
	name = "lung"
	desc = "I can't breathe - Words that precede unfortunate events."
	icon_state = "lung"
	base_icon_state = "lung"
	w_class = WEIGHT_CLASS_NORMAL
	zone = BODY_ZONE_CHEST
	organ_efficiency = list(ORGAN_SLOT_LUNGS = 50) // Most people have two lungs you dolt
	side = RIGHT_SIDE

	low_threshold_passed = span_warning("I feel short of breath.")
	high_threshold_passed = span_warning("I feel some sort of constriction around my chest as my breathing becomes shallow and rapid.")
	now_fixed = span_warning("My lungs seem to once again be able to hold air.")
	low_threshold_cleared = span_info("I can breathe normally again.")
	high_threshold_cleared = span_info("The constriction around my chest loosens as my breathing calms down.")

	food_reagents = list(/datum/reagent/consumable/nutriment = 5, /datum/reagent/medicine/salbutamol = 5)

	// i am here to remind you once again that humans have TWO lungs
	maxHealth = STANDARD_ORGAN_THRESHOLD * 0.8
	high_threshold = STANDARD_ORGAN_THRESHOLD * 0.4
	low_threshold = STANDARD_ORGAN_THRESHOLD * 0.2

	organ_volume = 1
	max_blood_storage = 25
	current_blood = 25
	blood_req = 4
	oxygen_req = 4
	nutriment_req = 4
	hydration_req = 4

	//Breathing variables
	//These thresholds are checked against what amounts to total_mix_pressure * (gas_type_mols/total_mols)
	var/safe_oxygen_min = 8 // Minimum safe partial pressure of O2, in kPa
	var/safe_oxygen_max = 0
	var/safe_nitro_min = 0
	var/safe_nitro_max = 0
	var/safe_co2_min = 0
	var/safe_co2_max = 5 // Yes it's an arbitrary value who cares?
	var/safe_plas_min = 0
	///How much breath partial pressure is a safe amount of toxins. 0 means that we are immune to toxins.
	var/safe_plas_max = 0.025
	///Sleeping agent
	var/SA_para_min = 0.5
	///Sleeping agent
	var/SA_sleep_min = 2.5
	///BZ gas
	var/BZ_trip_balls_min = 0.5
	///Give people some room to play around without killing the station
	var/BZ_brain_damage_min = 5
	///Nitryl, Stimulum and Freon
	var/gas_stimulation_min = 0.001
	///Minimum amount of healium to make you unconscious for 4 seconds
	var/healium_para_min = 1.5
	///Minimum amount of healium to knock you down for good
	var/healium_sleep_min = 3
	///Whether these lungs react negatively to miasma
	var/suffers_miasma = TRUE

	var/oxy_breath_dam_min = MIN_TOXIC_GAS_DAMAGE
	var/oxy_breath_dam_max = MAX_TOXIC_GAS_DAMAGE
	var/oxy_damage_type = OXY
	var/nitro_breath_dam_min = MIN_TOXIC_GAS_DAMAGE
	var/nitro_breath_dam_max = MAX_TOXIC_GAS_DAMAGE
	var/nitro_damage_type = OXY
	var/co2_breath_dam_min = MIN_TOXIC_GAS_DAMAGE
	var/co2_breath_dam_max = MAX_TOXIC_GAS_DAMAGE
	var/co2_damage_type = OXY
	var/plas_breath_dam_min = MIN_TOXIC_GAS_DAMAGE
	var/plas_breath_dam_max = MAX_TOXIC_GAS_DAMAGE
	var/plas_damage_type = TOX

	var/tritium_irradiation_moles_min = 1
	var/tritium_irradiation_moles_max = 15
	var/tritium_irradiation_probability_min = 10
	var/tritium_irradiation_probability_max = 60

	var/cold_message = "my face freezing and an icicle forming"
	var/cold_level_1_threshold = 260
	var/cold_level_2_threshold = 200
	var/cold_level_3_threshold = 120
	var/cold_level_1_damage = COLD_GAS_DAMAGE_LEVEL_1 //Keep in mind with gas damage levels, you can set these to be negative, if you want someone to heal, instead.
	var/cold_level_2_damage = COLD_GAS_DAMAGE_LEVEL_2
	var/cold_level_3_damage = COLD_GAS_DAMAGE_LEVEL_3
	var/cold_damage_type = BURN

	var/hot_message = "my face burning and a searing heat"
	var/heat_level_1_threshold = 360
	var/heat_level_2_threshold = 400
	var/heat_level_3_threshold = 1000
	var/heat_level_1_damage = HEAT_GAS_DAMAGE_LEVEL_1
	var/heat_level_2_damage = HEAT_GAS_DAMAGE_LEVEL_2
	var/heat_level_3_damage = HEAT_GAS_DAMAGE_LEVEL_3
	var/heat_damage_type = BURN

	var/breath_modulo = 2

	var/crit_stabilizing_reagent = /datum/reagent/medicine/epinephrine

	// oxyloss
	var/oxygen_deprivation = 0
	var/max_oxygen_deprivation = 50

/obj/item/organ/lungs/left
	side = LEFT_SIDE

/obj/item/organ/lungs/update_icon_state()
	. = ..()
	if(side == RIGHT_SIDE)
		icon_state = "[base_icon_state]-r"
	else
		icon_state = "[base_icon_state]-l"

/obj/item/organ/lungs/on_life(delta_time, times_fired)
	. = ..()
	if(failed)
		if(!is_failing())
			failed = FALSE
			return
	else if(is_failing())
		if(owner.stat == CONSCIOUS)
			owner.visible_message(span_danger("<b>[owner]</b> grabs [owner.p_their()] throat, struggling for breath!"), \
						span_userdanger("I CAN'T BREATHE!"))
		failed = TRUE
	if(damage >= low_threshold)
		var/do_i_cough = DT_PROB((damage < high_threshold) ? 2.5 : 5, delta_time) // between : past high
		if(do_i_cough)
			owner.emote("cough")

/obj/item/organ/lungs/get_availability(datum/species/S)
	return !(TRAIT_NOBREATH in S.inherent_traits)

/obj/item/organ/lungs/proc/add_oxygen_deprivation(amount)
	var/last_deprive = oxygen_deprivation
	oxygen_deprivation = min(max_oxygen_deprivation, max(0, oxygen_deprivation + amount))
	return (oxygen_deprivation - last_deprive)

/obj/item/organ/lungs/proc/remove_oxygen_deprivation(amount)
	var/last_deprive = oxygen_deprivation
	oxygen_deprivation = min(max_oxygen_deprivation, max(0, oxygen_deprivation - amount))
	return (oxygen_deprivation - last_deprive)

// Returns a percentage value for use by GetOxyloss().
/obj/item/organ/lungs/proc/get_oxygen_deprivation()
	if(is_failing())
		return max_oxygen_deprivation
	return FLOOR(oxygen_deprivation, 1)

/obj/item/organ/lungs/proc/can_oxy_deprive()
	if(oxygen_deprivation < max_oxygen_deprivation)
		return TRUE
	return FALSE

/obj/item/organ/lungs/proc/can_oxy_heal()
	if(oxygen_deprivation)
		return TRUE
	return FALSE

/obj/item/organ/lungs/proc/get_breath_modulo()
	if(is_dead())
		return 0
	var/final_breath_modulo = breath_modulo
	if(is_failing())
		final_breath_modulo -= 2
	else if(is_bruised())
		final_breath_modulo -= 1
	return final_breath_modulo

/obj/item/organ/lungs/proc/handle_gas_override(mob/living/carbon/human/breather, list/breath_gases, gas_breathed)
