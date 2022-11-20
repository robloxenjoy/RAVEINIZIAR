/obj/item/organ/stomach/bone
	desc = "You have no idea what this strange ball of bones does."
	metabolism_efficiency = 0.025 //very bad
	/// How much [BRUTE] damage milk heals every second
	var/milk_brute_healing = 2.5
	/// How much [BURN] damage milk heals every second
	var/milk_burn_healing = 2.5

/obj/item/organ/stomach/bone/on_life(delta_time, times_fired)
	var/datum/reagent/consumable/milk/milk = locate(/datum/reagent/consumable/milk) in reagents.reagent_list
	if(milk)
		var/mob/living/carbon/body = owner
		if(milk.volume > 50)
			reagents.remove_reagent(milk.type, milk.volume - 5)
			to_chat(owner, span_warning("The excess milk is dripping off your bones!"))
		body.heal_bodypart_damage(milk_brute_healing * REAGENTS_EFFECT_MULTIPLIER * delta_time, milk_burn_healing * REAGENTS_EFFECT_MULTIPLIER * delta_time)

		for(var/i in body.all_wounds)
			var/datum/wound/iter_wound = i
			iter_wound.on_xadone(1 * REAGENTS_EFFECT_MULTIPLIER * delta_time)
		reagents.remove_reagent(milk.type, milk.metabolization_rate * delta_time)
	return ..()
