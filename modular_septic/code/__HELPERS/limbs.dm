/proc/setup_bodyparts()
	. = list()
	var/obj/item/bodypart/part
	for(var/thing in BODYPARTS_PATH)
		part = new thing()
		part.moveToNullspace()
		STOP_PROCESSING(SSobj, part)
		. += part

/proc/setup_bodyparts_by_zone()
	. = list()
	for(var/obj/item/bodypart/part as anything in GLOB.bodyparts)
		if(!initial(part.body_zone))
			continue
		.[initial(part.body_zone)] = part

/proc/setup_bodyzone_to_parent_bodyzone()
	. = list()
	var/obj/item/bodypart/part
	for(var/thing in ALL_BODYPARTS)
		part = GLOB.bodyparts_by_zone[thing]
		if(!initial(part?.parent_body_zone))
			continue
		.[initial(part.body_zone)] = initial(part.parent_body_zone)

/proc/setup_bodyzone_to_bitflag()
	. = list()
	for(var/thing in ALL_BODYPARTS)
		var/obj/item/bodypart/part = GLOB.bodyparts_by_zone[thing]
		if(!initial(part?.body_part))
			continue
		.[initial(part.body_zone)] = initial(part.body_part)

/proc/setup_bitflag_to_bodyzone()
	. = list()
	for(var/thing in ALL_BODYPARTS)
		var/obj/item/bodypart/part = GLOB.bodyparts_by_zone[thing]
		if(!initial(part?.body_part))
			continue
		//this is dumb
		.["[initial(part.body_part)]"] = initial(part.body_zone)

/proc/setup_bodyzone_to_children()
	. = list()
	for(var/thing in ALL_BODYPARTS)
		var/obj/item/bodypart/part = GLOB.bodyparts_by_zone[thing]
		if(!length(part?.children_zones))
			continue
		.[initial(part.body_zone)] = part.children_zones.Copy()

/proc/parse_handedness(handedness_flags = DEFAULT_HANDEDNESS)
	if(handedness_flags & AMBIDEXTROUS)
		return "Poorly Ambidextrous"
	else if((handedness_flags & RIGHT_HANDED) && (handedness_flags & LEFT_HANDED))
		return "Ambidextrous"
	else if(handedness_flags & RIGHT_HANDED)
		return "Right Handed"
	else if(handedness_flags & LEFT_HANDED)
		return "Left Handed"
	else
		return "Ambidextrous"

/proc/unparse_handedness(handedness_text = "Right Handed")
	switch(handedness_text)
		if("Poorly Ambidextrous")
			return AMBIDEXTROUS | RIGHT_HANDED | LEFT_HANDED
		if("Ambidextrous")
			return RIGHT_HANDED | LEFT_HANDED
		if("Right Handed")
			return RIGHT_HANDED
		if("Left Handed")
			return LEFT_HANDED
		else
			return RIGHT_HANDED | LEFT_HANDED

/proc/ran_zone(zone, probability = 80)
	if(prob(probability))
		zone = check_zone(zone)
	else
		zone = pick_weight(GLOB.bodyzone_to_relative_size-zone)
	return zone

/proc/above_neck(zone)
	var/static/list/zones = list(
		BODY_ZONE_HEAD,
		BODY_ZONE_PRECISE_FACE,
		BODY_ZONE_PRECISE_MOUTH,
		BODY_ZONE_PRECISE_NECK,
		BODY_ZONE_PRECISE_L_EYE,
		BODY_ZONE_PRECISE_R_EYE,
	)
	if(zones.Find(zone))
		return TRUE
	return FALSE

/proc/check_zone(zone)
	if(!zone)
		return BODY_ZONE_CHEST
	return zone

/proc/body_parts_covered2organ_names(bpc)
	var/list/covered_parts = list()

	if(!bpc)
		return covered_parts

	if(CHECK_MULTIPLE_BITFIELDS(bpc, HEAD|EYES|FACE|JAW|NECK|CHEST|GROIN|VITALS|ARMS|HANDS|LEGS|FEET))
		covered_parts |= ALL_BODYPARTS
	else
		if(bpc & HEAD)
			covered_parts |= list(BODY_ZONE_HEAD)
		if(bpc & FACE)
			covered_parts |= list(BODY_ZONE_PRECISE_FACE)
		if(bpc & JAW)
			covered_parts |= list(BODY_ZONE_PRECISE_MOUTH)
		if(bpc & NECK)
			covered_parts |= list(BODY_ZONE_PRECISE_NECK)
		if(bpc & CHEST)
			covered_parts |= list(BODY_ZONE_CHEST)
		if(bpc & GROIN)
			covered_parts |= list(BODY_ZONE_PRECISE_GROIN)
		if(bpc & VITALS)
			covered_parts |= list(BODY_ZONE_PRECISE_VITALS)
		if(CHECK_MULTIPLE_BITFIELDS(bpc, EYES))
			covered_parts |= list(BODY_ZONE_PRECISE_L_EYE, BODY_ZONE_PRECISE_R_EYE)
		else
			if(bpc & EYE_LEFT)
				covered_parts |= list(BODY_ZONE_PRECISE_L_EYE)
			if(bpc & EYE_RIGHT)
				covered_parts |= list(BODY_ZONE_PRECISE_R_EYE)

		if(CHECK_MULTIPLE_BITFIELDS(bpc, ARMS))
			covered_parts |= list(BODY_ZONE_L_ARM,BODY_ZONE_R_ARM)
		else
			if(bpc & ARM_LEFT)
				covered_parts |= list(BODY_ZONE_L_ARM)
			if(bpc & ARM_RIGHT)
				covered_parts |= list(BODY_ZONE_R_ARM)

		if(CHECK_MULTIPLE_BITFIELDS(bpc, HANDS))
			covered_parts |= list(BODY_ZONE_PRECISE_R_HAND,BODY_ZONE_PRECISE_L_HAND)
		else
			if(bpc & HAND_LEFT)
				covered_parts |= list(BODY_ZONE_PRECISE_L_HAND)
			if(bpc & HAND_RIGHT)
				covered_parts |= list(BODY_ZONE_PRECISE_R_HAND)

		if(CHECK_MULTIPLE_BITFIELDS(bpc, LEGS))
			covered_parts |= list(BODY_ZONE_L_LEG,BODY_ZONE_R_LEG)
		else
			if(bpc & LEG_LEFT)
				covered_parts |= list(BODY_ZONE_L_LEG)
			if(bpc & LEG_RIGHT)
				covered_parts |= list(BODY_ZONE_R_LEG)

		if(CHECK_MULTIPLE_BITFIELDS(bpc, FEET))
			covered_parts |= list(BODY_ZONE_PRECISE_L_FOOT,BODY_ZONE_PRECISE_R_FOOT)
		else
			if(bpc & FOOT_LEFT)
				covered_parts |= list(BODY_ZONE_PRECISE_L_FOOT)
			if(bpc & FOOT_RIGHT)
				covered_parts |= list(BODY_ZONE_PRECISE_R_FOOT)

	return covered_parts

/proc/zone2body_parts_covered(def_zone)
	switch(def_zone)
		if(BODY_ZONE_CHEST)
			return list(CHEST)
		if(BODY_ZONE_PRECISE_GROIN)
			return list(GROIN)
		if(BODY_ZONE_PRECISE_VITALS)
			return list(VITALS)
		if(BODY_ZONE_PRECISE_NECK)
			return list(NECK)
		if(BODY_ZONE_PRECISE_FACE)
			return list(FACE)
		if(BODY_ZONE_PRECISE_MOUTH)
			return list(JAW)
		if(BODY_ZONE_PRECISE_L_EYE)
			return list(EYE_LEFT)
		if(BODY_ZONE_PRECISE_R_EYE)
			return list(EYE_RIGHT)
		if(BODY_ZONE_HEAD)
			return list(HEAD)
		if(BODY_ZONE_L_ARM)
			return list(ARM_LEFT)
		if(BODY_ZONE_PRECISE_L_HAND)
			return list(HAND_LEFT)
		if(BODY_ZONE_R_ARM)
			return list(ARM_RIGHT)
		if(BODY_ZONE_PRECISE_R_HAND)
			return list(HAND_RIGHT)
		if(BODY_ZONE_L_LEG)
			return list(LEG_LEFT)
		if(BODY_ZONE_PRECISE_L_FOOT)
			return list(FOOT_LEFT)
		if(BODY_ZONE_R_LEG)
			return list(LEG_RIGHT)
		if(BODY_ZONE_PRECISE_R_FOOT)
			return list(FOOT_RIGHT)

/proc/slot2body_zone(slot)
	switch(slot)
		if(ITEM_SLOT_BACK, ITEM_SLOT_OCLOTHING, ITEM_SLOT_ICLOTHING, ITEM_SLOT_ID)
			return BODY_ZONE_CHEST
		if(ITEM_SLOT_BELT)
			return BODY_ZONE_PRECISE_GROIN
		if(ITEM_SLOT_GLOVES, ITEM_SLOT_HANDS, ITEM_SLOT_HANDCUFFED)
			return pick(BODY_ZONE_PRECISE_L_HAND, BODY_ZONE_PRECISE_R_HAND)
		if(ITEM_SLOT_RWRIST)
			return pick(BODY_ZONE_PRECISE_R_HAND)
		if(ITEM_SLOT_LWRIST)
			return pick(BODY_ZONE_PRECISE_L_HAND)
		if(ITEM_SLOT_HEAD)
			return BODY_ZONE_HEAD
		if(ITEM_SLOT_EARS, ITEM_SLOT_LEAR, ITEM_SLOT_REAR)
			return BODY_ZONE_PRECISE_FACE
		if(ITEM_SLOT_NECK)
			return BODY_ZONE_PRECISE_NECK
		if(ITEM_SLOT_EYES)
			return pick(BODY_ZONE_PRECISE_L_EYE, BODY_ZONE_PRECISE_R_EYE)
		if(ITEM_SLOT_FEET)
			return pick(BODY_ZONE_PRECISE_R_FOOT, BODY_ZONE_PRECISE_L_FOOT)
		if(ITEM_SLOT_LEGCUFFED)
			return pick(BODY_ZONE_L_LEG, BODY_ZONE_R_LEG)
