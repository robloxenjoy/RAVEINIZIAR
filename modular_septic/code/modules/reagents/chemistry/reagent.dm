/datum/reagent
	///Does this evaporate as a puddle?
	var/liquid_evaporation_rate = 0
	///How much fire power does the liquid have, for burning on simulated liquids. Not enough fire power/unit of entire mixture may result in no fire
	var/liquid_fire_power = 0
	///How fast does the liquid burn on simulated turfs, if it does
	var/liquid_fire_burnrate = 0
	///Whether a fire from this requires oxygen in the atmosphere
	var/fire_needs_oxygen = TRUE
	///Initial method used on a mob
	var/initial_methods = INJECT
	///Organic reagents can't get processed by IPCs, etc
	var/process_flags = REAGENT_ORGANIC
	///Dictates what chemicals we can separate from
	var/polarity = POLARITY_POLAR
	///How much of a solid reagent of the same polarity we can dissolve per 1u
	var/dissolve_per_unit = 1
	///How good of an accelerant is this reagent - used for turf fires
	var/accelerant_quality = 0

/datum/reagent/expose_mob(mob/living/exposed_mob, methods, reac_volume, show_message, touch_protection)
	initial_methods = methods
	return ..()

/// Called when an overdose starts
/datum/reagent/overdose_start(mob/living/M)
	to_chat(M, span_userdanger("I feel like i took too much of [name]!"))
	SEND_SIGNAL(M, COMSIG_ADD_MOOD_EVENT, "[type]_overdose", /datum/mood_event/overdose, name)
