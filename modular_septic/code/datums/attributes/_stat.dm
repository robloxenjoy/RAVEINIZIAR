/datum/attribute/stat
	/// Used when space is too valuable to write a full word
	var/shorthand = "FK"

/datum/attribute/stat/description_from_level(level)
	switch(CEILING(level, 1))
		if(-INFINITY to 6)
			return "disabled"
		if(7)
			return "bad"
		if(8,9)
			return "below average"
		if(10)
			return "average"
		if(11,12)
			return "above average"
		if(13,14)
			return "nice"
		if(15,16)
			return "amazing"
		if(17,18)
			return "perfect"
		if(19,20)
			return "mythical"
		if(21 to INFINITY)
			return "legendary"
		else
			return "unknown"
