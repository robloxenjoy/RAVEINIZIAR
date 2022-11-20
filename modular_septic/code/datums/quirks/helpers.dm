 //gets a list of all quirk datums that fit the category
/mob/living/proc/get_quirks(category = CAT_QUIRK_ALL)
	var/list/get_quirks = list()
	switch(category)
		//All quirks
		if(CAT_QUIRK_ALL)
			for(var/Q in quirks)
				get_quirks += Q
		//Major Disabilities
		if(CAT_QUIRK_MAJOR_DISABILITY)
			for(var/V in quirks)
				var/datum/quirk/Q = V
				if(Q.value < -4)
					get_quirks += Q
		//Minor Disabilities
		if(CAT_QUIRK_MINOR_DISABILITY)
			for(var/V in quirks)
				var/datum/quirk/Q = V
				if((Q.value >= -4) && (Q.value < 0))
					get_quirks += Q
		//Neutral and Positive quirks
		if(CAT_QUIRK_NOTES)
			for(var/V in quirks)
				var/datum/quirk/Q = V
				if(Q.value >= 0)
					get_quirks += Q
	return get_quirks
