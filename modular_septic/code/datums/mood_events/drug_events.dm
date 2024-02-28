/datum/mood_event/adrenaline_junkie
	description = span_userlove("Power in misery.")
	mood_change = -8
	timeout = 5 MINUTES

/datum/mood_event/adrenaline_junkie/add_effects()
	var/static/cruel_lines = list(
		"Power in misery.",
		"Traversing the grid of death.",
		"Dopamine terrorist.",
		"Divine light severed.",
		"Man vs. No god.",
		"640x480.",
		"Hope eradicated.",
	)
	description = span_userlove(pick(cruel_lines))

/datum/mood_event/endorphin_enlightenment
	description = span_userlove("Overabundance of life.")
	mood_change = -8
	timeout = 5 MINUTES
