/proc/parse_zone(zone)
	switch(zone)
		if(BODY_ZONE_PRECISE_L_EYE)
			return "Левая Глазница"
		if(BODY_ZONE_PRECISE_R_EYE)
			return "Правая Глазница"
		if(BODY_ZONE_PRECISE_MOUTH)
			return "Челюсть"
		if(BODY_ZONE_HEAD)
			return "Голова"
		if(BODY_ZONE_CHEST)
			return "Грудь"
		if(BODY_ZONE_PRECISE_VITALS)
			return "Живот"
		if(BODY_ZONE_PRECISE_GROIN)
			return "Пах"
		if(BODY_ZONE_PRECISE_NECK)
			return "Шея"
		if(BODY_ZONE_PRECISE_R_HAND)
			return "Правая Кисть"
		if(BODY_ZONE_PRECISE_L_HAND)
			return "Левая Кисть"
		if(BODY_ZONE_L_ARM)
			return "Левая Рука"
		if(BODY_ZONE_R_ARM)
			return "Правая Рука"
		if(BODY_ZONE_L_LEG)
			return "Левая Нога"
		if(BODY_ZONE_R_LEG)
			return "Правая Нога"
		if(BODY_ZONE_PRECISE_L_FOOT)
			return "Левая Стопа"
		if(BODY_ZONE_PRECISE_R_FOOT)
			return "Правая Стопа"
		else
			return zone
