/// Handling organs
/mob/living/carbon/handle_organs(delta_time, times_fired)
	if(stat < DEAD)
		var/list/already_processed_life = list()
		var/list/organlist
		var/obj/item/organ/organ
		for(var/organ_slot in GLOB.organ_process_order)
			if(QDELETED(src))
				break
			organlist = LAZYACCESS(internal_organs_slot, organ_slot)
			for(var/thing in organlist)
				if(QDELETED(src))
					break
				organ = thing
				// This exists mostly because reagent metabolization can cause organ shuffling
				if(!QDELETED(organ) && !already_processed_life[organ_slot] && (organ.owner == src))
					if(organ.needs_processing)
						organ.on_life(delta_time, times_fired)
					already_processed_life[organ] = TRUE
		var/datum/organ_process/organ_process
		for(var/thing in GLOB.organ_process_datum_order)
			if(QDELETED(src))
				break
			organ_process = GLOB.organ_processes_by_slot[thing]
			if(organ_process.needs_process(src))
				organ_process.handle_process(src, delta_time, times_fired)
	else
		var/obj/item/organ/organ
		for(var/thing in internal_organs)
			organ = thing
			//Needed so organs decay while inside the body
			organ.on_death(delta_time, times_fired)

/// Handling bodyparts
/mob/living/carbon/handle_bodyparts(delta_time, times_fired)
	var/obj/item/bodypart/bodypart
	if(stat < DEAD)
		for(var/thing in bodyparts)
			bodypart = thing
			if(bodypart.needs_processing)
				. |= bodypart.on_life(delta_time, times_fired, TRUE)
	else
		for(var/thing in bodyparts)
			bodypart = thing
			//Needed so bodyparts decay while inside the body.
			bodypart.on_death(delta_time, times_fired)

/// Sleeping
/mob/living/carbon/Life(delta_time = SSMOBS_DT, times_fired)
	. = ..()
	if(!.) // We're dead
		return

	if(HAS_TRAIT(src, TRAIT_TRYINGTOSLEEP))
		handle_trying_to_sleep()

/mob/living/carbon/proc/handle_trying_to_sleep()
	if(getShock() >= max(PAIN_NO_SLEEP * (GET_MOB_ATTRIBUTE_VALUE(src, STAT_ENDURANCE)/ATTRIBUTE_MIDDLING), 1))
		REMOVE_TRAIT(src, TRAIT_TRYINGTOSLEEP, src)
		hud_used.sleeping.update_appearance()
	return Sleeping(8 SECONDS)

/// Immunity & disease
/mob/living/carbon/handle_diseases()
	. = ..()
	if((immunity >= 0.25 * default_immunity) && (immunity < default_immunity))
		immunity = min(immunity + 0.25, default_immunity)

/// Being burned to a crisp
/mob/living/carbon/proc/check_cremation(delta_time, times_fired)
	//Only cremate while actively on fire
	if(!on_fire)
		return

	//Only starts when the chest has taken full damage
	var/obj/item/bodypart/chest = get_bodypart(BODY_ZONE_CHEST)
	if(!(chest.get_damage() >= chest.max_damage))
		return

	//Burn off limbs one by one
	var/obj/item/bodypart/limb
	var/list/limb_list = LIMB_BODYPARTS
	var/still_has_limbs = FALSE
	for(var/zone in limb_list)
		limb = get_bodypart_nostump(zone)
		if(limb)
			still_has_limbs = TRUE
			if(limb.get_damage() >= limb.max_damage)
				limb.damage_integrity(WOUND_BURN, rand(0.5 * delta_time, 2 * delta_time))
				if(limb.limb_integrity <= 0)
					if(limb.status == BODYPART_ORGANIC) //Non-organic limbs don't burn
						limb.visible_message(span_warning("<b>[src]</b>'s [limb.name] crumbles into ash!"))
					else
						limb.visible_message(span_warning("<b>[src]</b>'s [limb.name] melts away!"))
					qdel(limb)

	if(still_has_limbs)
		return

	//Burn the head last
	var/obj/item/bodypart/head = get_bodypart_nostump(BODY_ZONE_HEAD)
	if(head)
		if(head.get_damage() >= head.max_damage)
			head.damage_integrity(WOUND_BURN, rand(0.5 * delta_time, 2 * delta_time))
			if(head.limb_integrity <= 0)
				if(head.status == BODYPART_ORGANIC) //Non-organic limbs don't burn
					visible_message(span_warning("<b>[src]</b>'s [head.name] crumbles into ash!"))
				else
					visible_message(span_warning("<b>[src]</b>'s [head.name] melts away!"))
				qdel(limb)
		return

	//Nothing left: dust the body, drop the items (if they're flammable they'll burn on their own)
	chest.damage_integrity(WOUND_BURN, rand(0.5 * delta_time, 2 * delta_time))
	if(chest.limb_integrity <= 0)
		visible_message(span_warning("<b>[src]</b>'s body crumbles into a pile of ash!"))
		dust(TRUE, TRUE)

/// Helper proc
/mob/living/carbon/needs_heart()
	if(HAS_TRAIT(src, TRAIT_STABLEHEART))
		return FALSE
	if((NOBLOOD in dna?.species?.species_traits) || (NOHEART in dna?.species?.species_traits))
		return FALSE
	return TRUE
