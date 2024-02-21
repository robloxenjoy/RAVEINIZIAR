/datum/mood_event/adrenaline_junkie
	description = span_userlove("Сила в страданиях.")
	mood_change = -8
	timeout = 5 MINUTES

/datum/mood_event/adrenaline_junkie/add_effects()
	var/static/cruel_lines = list(
		"Сила в страданиях.",
		"Пересекая сетку смерти.",
		"Божественный свет послан нахуй.",
		"Существо против пиздеца.",
		"Помощь здесь.",
	)
	description = span_userlove(pick(cruel_lines))

/datum/mood_event/endorphin_enlightenment
	description = span_userlove("Переизбыток жизни.")
	mood_change = -8
	timeout = 5 MINUTES
