/proc/find_cauterizing_tool(list/item_list)
	for(var/thing in item_list)
		var/obj/item/item = thing
		if(item.tool_behaviour == TOOL_CAUTERY || item.get_temperature() > 300)
			return item
	return FALSE

/proc/get_surgery_location_modifier(mob/M)
	var/turf/turf_loc = get_turf(M)
	if(locate(/obj/structure/table/optable, turf_loc))
		return 1
	else if(locate(/obj/machinery/stasis, turf_loc))
		return 0.9
	else if(locate(/obj/structure/table, turf_loc))
		return 0.8
	else if(locate(/obj/structure/bed, turf_loc))
		return 0.7
	else
		return 0.6

/proc/get_surgery_probability_multiplier(datum/surgery_step/step, mob/target, mob/user)
	var/probability = get_surgery_location_modifier(target)
	//self-surgery is hard
	if(target == user)
		probability *= 0.75
	return probability * step.success_multiplier

/proc/get_location_accessible(mob/M, location)
	var/covered_locations = 0 //based on body_parts_covered
	var/face_covered = 0 //based on flags_inv
	var/eyesmouth_covered = 0 //based on flags_cover
	if(iscarbon(M))
		var/mob/living/carbon/C = M
		for(var/obj/item/clothing/I in list(C.back, C.wear_mask, C.head))
			covered_locations |= I.body_parts_covered
			face_covered |= I.flags_inv
			eyesmouth_covered |= I.flags_cover
		if(ishuman(C))
			var/mob/living/carbon/human/H = C
			for(var/obj/item/I in list(H.wear_suit, H.w_uniform, H.shoes, H.belt, H.gloves, H.glasses, H.wrists, H.pants, H.oversuit, H.ears, H.ears_extra))
				covered_locations |= I.body_parts_covered
				face_covered |= I.flags_inv
				eyesmouth_covered |= I.flags_cover

	switch(location)
		if(BODY_ZONE_HEAD)
			if(covered_locations & HEAD)
				return FALSE
		if(BODY_ZONE_PRECISE_L_EYE, BODY_ZONE_PRECISE_R_EYE)
			if(covered_locations & EYES || face_covered & HIDEEYES || eyesmouth_covered & GLASSESCOVERSEYES)
				return FALSE
		if(BODY_ZONE_PRECISE_FACE)
			if(covered_locations & FACE || face_covered & HIDEFACE)
				return FALSE
		if(BODY_ZONE_PRECISE_MOUTH)
			if(covered_locations & JAW || face_covered & HIDEFACE || eyesmouth_covered & MASKCOVERSMOUTH || eyesmouth_covered & HEADCOVERSMOUTH)
				return FALSE
		if(BODY_ZONE_CHEST)
			if(covered_locations & CHEST)
				return FALSE
		if(BODY_ZONE_PRECISE_VITALS)
			if(covered_locations & VITALS)
				return FALSE
		if(BODY_ZONE_PRECISE_GROIN)
			if(covered_locations & GROIN)
				return FALSE
		if(BODY_ZONE_L_ARM)
			if(covered_locations & ARM_LEFT)
				return FALSE
		if(BODY_ZONE_R_ARM)
			if(covered_locations & ARM_RIGHT)
				return FALSE
		if(BODY_ZONE_L_LEG)
			if(covered_locations & LEG_LEFT)
				return FALSE
		if(BODY_ZONE_R_LEG)
			if(covered_locations & LEG_RIGHT)
				return FALSE
		if(BODY_ZONE_PRECISE_L_HAND)
			if(covered_locations & HAND_LEFT)
				return FALSE
		if(BODY_ZONE_PRECISE_R_HAND)
			if(covered_locations & HAND_RIGHT)
				return FALSE
		if(BODY_ZONE_PRECISE_L_FOOT)
			if(covered_locations & FOOT_LEFT)
				return FALSE
		if(BODY_ZONE_PRECISE_R_FOOT)
			if(covered_locations & FOOT_RIGHT)
				return FALSE

	return TRUE

/proc/spread_germs_to_bodypart(obj/item/bodypart/bodypart, mob/living/carbon/human/user, obj/item/tool)
	. = FALSE
	if(!istype(user) || !istype(bodypart) || !istype(bodypart.owner) || bodypart.is_robotic_limb())
		return

	//Germs from the surgeon
	var/our_germ_level = user.germ_level
	if(user.gloves)
		our_germ_level = user.gloves.germ_level

	//Germs from the tool
	if(tool)
		our_germ_level += tool.germ_level
	//No tool, pretend the surgeon is the tool
	else
		our_germ_level *= 2

	//Germs from the dirtiness on the surgery room
	var/turf/open/floor/floor = get_turf(bodypart.owner)
	if(istype(floor))
		our_germ_level += floor.germ_level

	//Divide it by 3 to be reasonable
	our_germ_level = CEILING(our_germ_level/3, 1)

	//If the patient has antibiotics, kill germs by an amount equal to 10x the antibiotic force
	//e.g. nalixidic acid has 35 force, thus would decrease germs here by 350
	var/antibiotics = bodypart.owner.get_antibiotics()
	our_germ_level = max(0, our_germ_level - (antibiotics * 10))

	//This amount is not meaningful enough to cause an infection
	if(our_germ_level < INFECTION_LEVEL_ONE/2)
		return

	. = TRUE

	//If we still have germs, let's get that W

	//Injuries first
	for(var/datum/injury/injury as anything in bodypart.injuries)
		if((injury.required_status == BODYPART_ORGANIC) && (injury.germ_level < SURGERY_GERM_MAXIMUM))
			injury.adjust_germ_level(our_germ_level, maximum_germs = SURGERY_GERM_MAXIMUM)

	//Then, infect the organs on the bodypart
	for(var/obj/item/organ/organ as anything in bodypart.get_organs())
		if(organ.is_organic_organ() && !CHECK_BITFIELD(organ.organ_flags, ORGAN_NOINFECTION) && (organ.germ_level < SURGERY_GERM_MAXIMUM))
			organ.adjust_germ_level(our_germ_level, maximum_germs = SURGERY_GERM_MAXIMUM)

	//Then, infect the bodypart
	if(bodypart.is_organic_limb() && !CHECK_BITFIELD(bodypart.limb_flags, BODYPART_NO_INFECTION) && (bodypart.germ_level < SURGERY_GERM_MAXIMUM))
		bodypart.adjust_germ_level(our_germ_level, maximum_germs = SURGERY_GERM_MAXIMUM)

/obj/item/proc/unspeculumize(obj/item/source, mob/living/affected_mob, obj/item/bodypart/limb)
	for(var/datum/component/embedded/embedded_source as anything in source.GetComponents(/datum/component/embedded))
		if(embedded_source.injury)
			embedded_source.injury.injury_flags &= ~INJURY_RETRACTED
	if(istype(affected_mob))
		playsound(source, 'modular_septic/sound/gore/stuck1.ogg', 60, 0)
		affected_mob.update_damage_overlays()
	source.UnregisterSignal(source, COMSIG_ITEM_UNEMBEDDED)
