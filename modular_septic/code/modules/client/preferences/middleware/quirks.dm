/datum/preference_middleware/quirks/New(datum/preferences)
	. = ..()
	src.preferences?.all_quirks = list()
