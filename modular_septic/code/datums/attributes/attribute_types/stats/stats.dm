/datum/attribute/stat/strength
	name = "Strength"
	shorthand = "ST"
	desc = "Strength measures how strong your blows are, as well as your capacity at carrying weight. \
		Favorite attribute of the warrior."
	icon_state = "strength"

/datum/attribute/stat/dexterity
	name = "Dexterity"
	shorthand = "DX"
	desc = "Dexterity measures your reflexes and balance, making you better at landing blows as well as avoiding them. \
		Favorite attribute of the thief."
	icon_state = "dexterity"

/datum/attribute/stat/endurance
	name = "Endurance"
	shorthand = "ED"
	desc = "Endurance measures your capability at handling pain, disease and other physical hardships. \
		Favorite attribute of the masochist."
	icon_state = "endurance"

/datum/attribute/stat/intelligence
	name = "Intellect"
	shorthand = "IQ"
	desc = "Intellect measures your abilities to perform complex tasks and retain information. \
		Favorite attribute of the scholar."
	icon_state = "intelligence"

//i had to
/datum/attribute/stat/intelligence/description_from_level(level)
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
			return "legendary"
		if(21 to INFINITY)
			return "divine"
		else
			return "invalid"

/datum/attribute/stat/perception
	name = "Perception"
	shorthand = "PR"
	desc = "Perception measures your general alertness. \
		Favorite attribute of the detective."
	icon_state = "perception"

/datum/attribute/stat/will
	name = "Will"
	shorthand = "WL"
	desc = "Will measures your ability to withstand psychological stress and your \
		resistance to supernatural attacks. \
		Favorite attribute of the priest."
	icon_state = "willpower"
