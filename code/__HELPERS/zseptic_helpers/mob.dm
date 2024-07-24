/proc/parse_zone(zone)
	switch(zone)
		if(BODY_ZONE_PRECISE_L_EYE)
			return "Left Eyelid"
		if(BODY_ZONE_PRECISE_R_EYE)
			return "Right Eyelid"
		if(BODY_ZONE_PRECISE_FACE)
			return "Face"
		if(BODY_ZONE_PRECISE_MOUTH)
			return "Jaw"
		if(BODY_ZONE_HEAD)
			return "Head"
		if(BODY_ZONE_CHEST)
			return "Chest"
		if(BODY_ZONE_PRECISE_VITALS)
			return "Vitals"
		if(BODY_ZONE_PRECISE_GROIN)
			return "Groin"
		if(BODY_ZONE_PRECISE_NECK)
			return "Neck"
		if(BODY_ZONE_PRECISE_R_HAND)
			return "Right Hand"
		if(BODY_ZONE_PRECISE_L_HAND)
			return "Left Hand"
		if(BODY_ZONE_L_ARM)
			return "Left Arm"
		if(BODY_ZONE_R_ARM)
			return "Right Arm"
		if(BODY_ZONE_L_LEG)
			return "Left Leg"
		if(BODY_ZONE_R_LEG)
			return "Right Leg"
		if(BODY_ZONE_PRECISE_L_FOOT)
			return "Left Foot"
		if(BODY_ZONE_PRECISE_R_FOOT)
			return "Right Foot"
		else
			return zone
