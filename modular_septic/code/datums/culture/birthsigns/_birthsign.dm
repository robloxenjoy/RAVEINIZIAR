/datum/cultural_info/birthsign
	var/patron_saint = ""
	var/favored_profession = "Any"

/datum/cultural_info/birthsign/get_extra_desc(more)
	. = ..()
	if(patron_saint)
		. += "<br>Patron Saint: [patron_saint]"
	if(favored_profession)
		. += "<br>Favored Profession: [favored_profession]"
