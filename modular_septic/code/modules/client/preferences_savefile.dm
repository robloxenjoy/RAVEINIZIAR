/datum/preferences/proc/save_character_septic(savefile/S)
	if(!S?.cd)
		return FALSE
	//Languages
	WRITE_FILE(S["languages"], languages)
	//Augments
	WRITE_FILE(S["augments"], augments)
	//Augments styles
	WRITE_FILE(S["augment_styles"], augment_styles)
	//Body markings
	WRITE_FILE(S["body_markings"], body_markings)
	//Birthsign
	WRITE_FILE(S["birthsign"], birthsign)
	return TRUE

/datum/preferences/proc/load_character_septic(savefile/S)
	if(!S?.cd)
		return FALSE
	//Languages
	READ_FILE(S["languages"], languages)
	//Augments
	READ_FILE(S["augments"], augments)
	//Augments styles
	READ_FILE(S["augment_styles"], augment_styles)
	//Body markings
	READ_FILE(S["body_markings"], body_markings)
	//Birthsign
	READ_FILE(S["birthsign"], birthsign)
	return TRUE
