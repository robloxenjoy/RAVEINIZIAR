/proc/parse_zone(zone)
	switch(zone)
		if(BODY_ZONE_PRECISE_L_EYE)
			return "left eyelid"
		if(BODY_ZONE_PRECISE_R_EYE)
			return "right eyelid"
		if(BODY_ZONE_PRECISE_MOUTH)
			return "jaw"
		if(BODY_ZONE_PRECISE_NECK)
			return "throat"
		if(BODY_ZONE_PRECISE_R_HAND)
			return "right hand"
		if(BODY_ZONE_PRECISE_L_HAND)
			return "left hand"
		if(BODY_ZONE_L_ARM)
			return "left arm"
		if(BODY_ZONE_R_ARM)
			return "right arm"
		if(BODY_ZONE_L_LEG)
			return "left leg"
		if(BODY_ZONE_R_LEG)
			return "right leg"
		if(BODY_ZONE_PRECISE_L_FOOT)
			return "left foot"
		if(BODY_ZONE_PRECISE_R_FOOT)
			return "right foot"
		else
			return zone
