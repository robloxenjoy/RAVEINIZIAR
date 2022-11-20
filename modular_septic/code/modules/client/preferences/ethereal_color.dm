/datum/preference/choiced/ethereal_color/is_accessible(datum/preferences/preferences)
	. = ..()
	if(!.)
		return
	return (preferences?.read_preference(/datum/preference/choiced/species) == /datum/species/ethereal)
