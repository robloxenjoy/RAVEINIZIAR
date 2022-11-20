/datum/status_effect/liquids_affected
	id = "liquidsaffected"
	alert_type = null
	duration = -1

/datum/status_effect/liquids_affected/on_apply()
	. = ..()
	//We should be on top of a liquid movable if this is applied
	tick()

/datum/status_effect/liquids_affected/on_remove()
	. = ..()
	owner.remove_movespeed_modifier(/datum/movespeed_modifier/status_effect/water_slowdown)
	REMOVE_TRAIT(owner, TRAIT_MOVE_FLOATING, SUBMERGED_TRAIT)
	var/turf/water_turf = get_turf(owner)
	water_turf?.zFall(owner)

/datum/status_effect/liquids_affected/tick()
	var/turf/water_turf = get_turf(owner)
	if(!water_turf)
		qdel(src)
		return
	if(!water_turf.liquids || (water_turf.liquids.liquid_state <= LIQUID_STATE_PUDDLE))
		var/turf/below_turf = get_step_multiz(water_turf, DOWN)
		if(!water_turf.can_zFall(owner, 1, below_turf) || !below_turf?.liquids || (below_turf.liquids.liquid_state < LIQUID_STATE_FULLTILE))
			qdel(src)
			return
		water_turf = below_turf
	calculate_water_slow(water_turf)
	calculate_floating(water_turf)
	//Make the reagents touch the person
	var/fraction = SUBMERGEMENT_PERCENT(owner, water_turf.liquids)
	var/datum/reagents/temporary_holder = water_turf.liquids.simulate_reagents_flat(SUBMERGEMENT_REAGENTS_TOUCH_AMOUNT * fraction)
	temporary_holder.expose(owner, TOUCH)
	qdel(temporary_holder)
	return ..()

/datum/status_effect/liquids_affected/proc/calculate_water_slow(turf/water_turf)
	//TODO: Factor in swimming skill here?
	var/slowdown_amount = water_turf.liquids.liquid_state * 0.5
	owner.add_or_update_variable_movespeed_modifier(/datum/movespeed_modifier/status_effect/water_slowdown, slowdown_amount)

/datum/status_effect/liquids_affected/proc/calculate_floating(turf/water_turf)
	//TODO: Factor in swimming skill here?
	if(water_turf.liquids.liquid_state >= LIQUID_STATE_WAIST)
		if(ishuman(owner))
			var/mob/living/carbon/human/human_owner = owner
			if(human_owner.carry_weight >= DROWNING_WEIGHT)
				REMOVE_TRAIT(owner, TRAIT_MOVE_FLOATING, SUBMERGED_TRAIT)
				return
		ADD_TRAIT(owner, TRAIT_MOVE_FLOATING, SUBMERGED_TRAIT)
		return
	REMOVE_TRAIT(owner, TRAIT_MOVE_FLOATING, SUBMERGED_TRAIT)
