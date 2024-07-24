/datum/mood_event/adrenaline_junkie
	description = span_userlove("Strength in Suffering.")
	mood_change = -8
	timeout = 5 MINUTES

/datum/mood_event/adrenaline_junkie/add_effects()
	var/static/cruel_lines = list(
		"Strength in Suffering.",
		"Crossing the grid of death.",
		"Divine light has been sent to hell.",
		"Creature VS fucker.",
		"Help is here.",
	)
	description = span_userlove(pick(cruel_lines))

/datum/mood_event/endorphin_enlightenment
	description = span_userlove("Excess of life.")
	mood_change = -8
	timeout = 5 MINUTES
