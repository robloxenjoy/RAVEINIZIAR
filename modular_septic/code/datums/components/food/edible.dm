/datum/component/edible/CanConsume(mob/living/eater, mob/living/feeder)
	. = ..()
	if(iscarbon(eater))
		var/mob/living/carbon/consumer_softproducts = eater
		var/obj/item/bodypart/jaw = consumer_softproducts.get_bodypart_nostump(BODY_ZONE_PRECISE_MOUTH)
		if(!jaw)
			return FALSE
		if(jaw.bodypart_disabled)
			return FALSE
		if(jaw.limb_efficiency <= 0)
			return FALSE

/datum/component/edible/TakeBite(mob/living/eater, mob/living/feeder)
	var/atom/owner = parent

	if(!owner.reagents)
		stack_trace("[eater] failed to bite [owner], because [owner] had no reagents.")
		return FALSE
	if(eater.satiety > -200)
		eater.satiety -= junkiness
	playsound(eater.loc,'sound/items/eatfood.ogg', rand(10,50), TRUE)
	if(owner.reagents.total_volume)
		var/jaw_efficiency = 100
		if(iscarbon(eater))
			var/obj/item/bodypart/jaw = eater.get_bodypart_nostump(BODY_ZONE_PRECISE_MOUTH)
			jaw_efficiency = jaw?.limb_efficiency
		if(jaw_efficiency <= LIMB_EFFICIENCY_DISABLING)
			to_chat(feeder, span_warning("Their jaw is far too inefficient to take a bite."))
			return
		SEND_SIGNAL(parent, COMSIG_FOOD_EATEN, eater, feeder, bitecount, bite_consumption)
		var/fraction = min(bite_consumption / owner.reagents.total_volume, 1)
		owner.reagents.trans_to(eater, CEILING(bite_consumption * (jaw_efficiency/LIMB_EFFICIENCY_OPTIMAL), 1), transfered_by = feeder, methods = INGEST)
		bitecount++
		if(!owner.reagents.total_volume)
			On_Consume(eater, feeder)
		checkLiked(fraction, eater)

		//Invoke our after eat callback if it is valid
		if(after_eat)
			after_eat.Invoke(eater, feeder, bitecount)

		return TRUE
