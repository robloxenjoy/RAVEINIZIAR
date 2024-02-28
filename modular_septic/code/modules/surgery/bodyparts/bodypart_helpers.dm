/mob/living/proc/get_bodypart(zone)
	return

/mob/living/proc/get_bodypart_nostump(zone)
	return

/mob/living/carbon/get_bodypart(zone)
	if(!zone)
		zone = BODY_ZONE_CHEST
	return bodyparts_zones[zone]

/mob/living/carbon/get_bodypart_nostump(zone)
	if(!zone)
		zone = BODY_ZONE_CHEST
	var/obj/item/bodypart/bodypart = bodyparts_zones[zone]
	if(bodypart && !bodypart.is_stump())
		return bodypart

/mob/living/carbon/has_hand_for_held_index(i, check_disabled = TRUE)
	if(!i)
		return FALSE
	var/obj/item/bodypart/hand_instance = LAZYACCESS(hand_bodyparts, i)
	if(hand_instance && !(check_disabled && hand_instance.bodypart_disabled))
		return hand_instance
	return FALSE

/// Not nearly as commonly used as get_active_hand()
/mob/proc/get_active_foot()
	return FALSE

/mob/living/carbon/get_active_foot()
	return LAZYACCESS(leg_bodyparts, active_hand_index + 2)

/// Get the bodypart for whatever hand we have active, Only relevant for carbons
/mob/proc/get_active_hand()
	return FALSE

/mob/living/carbon/get_active_hand()
	return LAZYACCESS(hand_bodyparts, active_hand_index)

/mob/proc/has_left_hand(check_disabled = TRUE)
	return TRUE

/mob/living/carbon/has_left_hand(check_disabled = TRUE)
	for(var/obj/item/bodypart/hand_instance in hand_bodyparts)
		if(!(hand_instance.held_index % RIGHT_HANDS) || (check_disabled && hand_instance.bodypart_disabled))
			continue
		return TRUE
	return FALSE

/mob/living/carbon/alien/larva/has_left_hand()
	return TRUE

/mob/proc/has_right_hand(check_disabled = TRUE)
	return TRUE

/mob/living/carbon/has_right_hand(check_disabled = TRUE)
	for(var/obj/item/bodypart/hand_instance in hand_bodyparts)
		if((hand_instance.held_index % RIGHT_HANDS) || (check_disabled && hand_instance.bodypart_disabled))
			continue
		return TRUE
	return FALSE

/mob/living/carbon/alien/larva/has_right_hand()
	return TRUE

/mob/living/proc/get_missing_limbs()
	return list()

/mob/living/carbon/get_missing_limbs()
	var/static/list/full = ALL_BODYPARTS_ORDERED
	var/list/missing = full.Copy()
	for(var/zone in full)
		if(get_bodypart(zone))
			missing -= zone
	return missing

/mob/living/carbon/alien/larva/get_missing_limbs()
	var/static/list/full = list(BODY_ZONE_HEAD, BODY_ZONE_CHEST)
	var/list/missing = full.Copy()
	for(var/zone in full)
		if(get_bodypart(zone))
			missing -= zone
	return missing

/mob/living/proc/get_disabled_limbs()
	return list()

/mob/living/carbon/get_disabled_limbs()
	var/static/list/full = ALL_BODYPARTS_ORDERED
	var/list/disabled = list()
	for(var/zone in full)
		var/obj/item/bodypart/affecting = get_bodypart(zone)
		if(affecting?.bodypart_disabled)
			disabled += zone
	return disabled

/mob/living/carbon/alien/larva/get_disabled_limbs()
	var/list/full = list(BODY_ZONE_HEAD, BODY_ZONE_CHEST)
	var/list/disabled = list()
	for(var/zone in full)
		var/obj/item/bodypart/affecting = get_bodypart(zone)
		if(affecting?.bodypart_disabled)
			disabled += zone
	return disabled

///Remove a specific embedded item from the carbon mob
/mob/living/carbon/proc/remove_embedded_object(obj/item/embedded_item)
	SEND_SIGNAL(src, COMSIG_CARBON_EMBED_REMOVAL, embedded_item)

///Remove all embedded objects from all limbs on the carbon mob
/mob/living/carbon/proc/remove_all_embedded_objects()
	for(var/X in bodyparts)
		var/obj/item/bodypart/bodypart = X
		for(var/obj/item/embedded_item in bodypart.embedded_objects)
			remove_embedded_object(embedded_item)

/mob/living/carbon/proc/has_embedded_objects(include_harmless=FALSE)
	for(var/X in bodyparts)
		var/obj/item/bodypart/bodypart = X
		for(var/obj/item/embedded_item in bodypart.embedded_objects)
			if(!include_harmless && embedded_item.isEmbedHarmless())
				continue
			return TRUE

//Helper for quickly creating a new limb - used by augment code in species.dm spec_attacked_by
/mob/living/carbon/proc/newBodyPart(zone = BODY_ZONE_CHEST, robotic = FALSE, dropping_limb = FALSE)
	var/obj/item/bodypart/new_limb
	switch(zone)
		if(BODY_ZONE_HEAD)
			new_limb = new /obj/item/bodypart/head()
		if(BODY_ZONE_PRECISE_FACE)
			new_limb = new /obj/item/bodypart/face()
		if(BODY_ZONE_PRECISE_L_EYE)
			new_limb = new /obj/item/bodypart/l_eyelid()
		if(BODY_ZONE_PRECISE_R_EYE)
			new_limb = new /obj/item/bodypart/r_eyelid()
		if(BODY_ZONE_PRECISE_MOUTH)
			new_limb = new /obj/item/bodypart/mouth()
		if(BODY_ZONE_PRECISE_NECK)
			new_limb = new /obj/item/bodypart/neck()
		if(BODY_ZONE_CHEST)
			new_limb = new /obj/item/bodypart/chest()
		if(BODY_ZONE_PRECISE_VITALS)
			new_limb = new /obj/item/bodypart/vitals()
		if(BODY_ZONE_PRECISE_GROIN)
			new_limb = new /obj/item/bodypart/groin()
		if(BODY_ZONE_L_ARM)
			new_limb = new /obj/item/bodypart/l_arm()
		if(BODY_ZONE_PRECISE_L_HAND)
			new_limb = new /obj/item/bodypart/l_hand()
		if(BODY_ZONE_R_ARM)
			new_limb = new /obj/item/bodypart/r_arm()
		if(BODY_ZONE_PRECISE_R_HAND)
			new_limb = new /obj/item/bodypart/r_hand()
		if(BODY_ZONE_L_LEG)
			new_limb = new /obj/item/bodypart/l_leg()
		if(BODY_ZONE_PRECISE_L_FOOT)
			new_limb = new /obj/item/bodypart/l_foot()
		if(BODY_ZONE_R_LEG)
			new_limb = new /obj/item/bodypart/r_leg()
		if(BODY_ZONE_PRECISE_R_FOOT)
			new_limb = new /obj/item/bodypart/r_foot()
	if(new_limb)
		new_limb.update_limb(dropping_limb, src)
		if(robotic)
			new_limb.change_bodypart_status(BODYPART_ROBOTIC)
			new_limb.limb_flags |= BODYPART_SYNTHETIC
	return new_limb

/mob/living/carbon/human/newBodyPart(zone = BODY_ZONE_CHEST, robotic = FALSE, dropping_limb)
	var/obj/item/bodypart/new_limb
	var/datum/species/species = dna.species
	var/obj/item/bodypart/selected_type = species.bodypart_overides[zone]
	new_limb = new selected_type()
	if(new_limb)
		if(robotic)
			new_limb.change_bodypart_status(BODYPART_ROBOTIC)
			new_limb.limb_flags |= BODYPART_SYNTHETIC
		new_limb.update_limb(dropping_limb, src)
	return new_limb

/mob/living/carbon/alien/larva/newBodyPart(zone, robotic, dropping_limb)
	var/obj/item/bodypart/new_limb
	switch(zone)
		if(BODY_ZONE_HEAD)
			new_limb = new /obj/item/bodypart/head/larva()
		if(BODY_ZONE_CHEST)
			new_limb = new /obj/item/bodypart/chest/larva()
	if(new_limb)
		if(robotic)
			new_limb.change_bodypart_status(BODYPART_ROBOTIC)
			new_limb.limb_flags |= BODYPART_SYNTHETIC
		new_limb.update_limb(dropping_limb, src)
	return new_limb

/mob/living/carbon/alien/humanoid/newBodyPart(zone, robotic, dropping_limb)
	var/obj/item/bodypart/new_limb
	switch(zone)
		if(BODY_ZONE_L_ARM)
			new_limb = new /obj/item/bodypart/l_arm/alien()
		if(BODY_ZONE_R_ARM)
			new_limb = new /obj/item/bodypart/r_arm/alien()
		if(BODY_ZONE_HEAD)
			new_limb = new /obj/item/bodypart/head/alien()
		if(BODY_ZONE_L_LEG)
			new_limb = new /obj/item/bodypart/l_leg/alien()
		if(BODY_ZONE_R_LEG)
			new_limb = new /obj/item/bodypart/r_leg/alien()
		if(BODY_ZONE_CHEST)
			new_limb = new /obj/item/bodypart/chest/alien()
	if(new_limb)
		if(robotic)
			new_limb.change_bodypart_status(BODYPART_ROBOTIC)
			new_limb.limb_flags |= BODYPART_SYNTHETIC
		new_limb.update_limb(dropping_limb, src)
	return new_limb

/proc/skintone2hex(skin_tone)
	. = 0
	switch(skin_tone)
		if("caucasian1")
			. = "efa6b2"
		if("caucasian2")
			. = "d0a2b9"
		if("caucasian3")
			. = "c4abc5"
		if("arab")
			. = "fa9e32"
		if("nox")
			. = "7f4160"
		if("albino")
			. = "faf3f7"
		if("orange")
			. = "ffc905"

/mob/living/carbon/proc/Digitigrade_Leg_Swap(swap_back)
	var/body_plan_changed = FALSE
	for(var/X in bodyparts)
		var/obj/item/bodypart/O = X
		var/obj/item/bodypart/N
		if((!O.use_digitigrade && swap_back == FALSE) || (O.use_digitigrade && swap_back == TRUE))
			if(O.body_part == LEG_LEFT)
				if(swap_back == TRUE)
					N = new /obj/item/bodypart/l_leg
				else
					N = new /obj/item/bodypart/l_leg/digitigrade
			else if(O.body_part == LEG_RIGHT)
				if(swap_back == TRUE)
					N = new /obj/item/bodypart/r_leg
				else
					N = new /obj/item/bodypart/r_leg/digitigrade
		if(!N)
			continue
		body_plan_changed = TRUE
		O.drop_limb(TRUE, FALSE, TRUE)
		qdel(O)
		N.attach_limb(src) //no sanity for if this fails here because we just dropped out a limb of the same zone, SHOULD be okay
	if(body_plan_changed && ishuman(src))
		var/mob/living/carbon/human/H = src
		if(H.w_uniform)
			var/obj/item/clothing/under/U = H.w_uniform
			if(U.mutantrace_variation)
				if(swap_back)
					U.adjusted = NORMAL_STYLE
				else
					U.adjusted = DIGITIGRADE_STYLE
				H.update_inv_w_uniform()
		if(H.shoes && !swap_back)
			H.dropItemToGround(H.shoes)

/// Proc to hook behavior on bodypart additions.
/mob/living/carbon/add_bodypart(obj/item/bodypart/new_bodypart)
	bodyparts += new_bodypart
	bodyparts_zones[new_bodypart.body_zone] = new_bodypart
	if(new_bodypart.stance_index)
		set_num_legs(num_legs + 1)
		//usable will get updated when limb efficiency is updated
		set_usable_legs(usable_legs + 1)
	if(new_bodypart.held_index)
		set_num_hands(num_hands + 1)
		//usable will get updated when limb efficiency is updated
		set_usable_hands(usable_hands + 1)

/// Proc to hook behavior on bodypart removals.
/mob/living/carbon/remove_bodypart(obj/item/bodypart/old_bodypart)
	bodyparts -= old_bodypart
	bodyparts_zones -= old_bodypart.body_zone
	if(old_bodypart.stance_index)
		set_num_legs(num_legs - 1)
		if(!old_bodypart.bodypart_disabled)
			set_usable_legs(usable_legs - 1)
	if(old_bodypart.held_index)
		set_num_hands(num_hands - 1)
		if(!old_bodypart.bodypart_disabled)
			set_usable_hands(usable_hands - 1)

/mob/proc/update_limb_efficiencies()
	return

/mob/living/carbon/update_limb_efficiencies()
	if(status_flags & BUILDING_ORGANS)
		return
	for(var/thing in bodyparts)
		var/obj/item/bodypart/limb = thing
		limb.update_limb_efficiency()

/mob/living/proc/get_infected_bodyparts()
	return

/mob/living/carbon/get_infected_bodyparts()
	. = list()
	for(var/thing in bodyparts)
		var/obj/item/bodypart/limb = thing
		if(limb.germ_level)
			. += limb
