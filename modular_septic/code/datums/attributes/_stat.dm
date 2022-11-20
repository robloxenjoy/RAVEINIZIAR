/datum/attribute/stat
	/// Used when space is too valuable to write a full word
	var/shorthand = "FK"

/datum/attribute/stat/description_from_level(level)
	switch(CEILING(level, 1))
		if(-INFINITY to 6)
			return "crippling"
		if(7)
			return "poor"
		if(8,9)
			return "below average"
		if(10)
			return "average"
		if(11,12)
			return "above average"
		if(13,14)
			return "gifted"
		if(15,16)
			return "amazing"
		if(17,18)
			return "incredible"
		if(19,20)
			return "mythic"
		if(21 to INFINITY)
			return "legendary"
		else
			return "invalid"
