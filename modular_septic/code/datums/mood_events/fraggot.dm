/datum/mood_event/fraggot
	description = span_flashingdanger(span_big("I must kill the fraggot!"))
	mood_change = -5
	timeout = 0

/datum/mood_event/fraggot/add_effects(mob/living/fraggot)
	description = span_flashingdanger(span_big("I must kill [fraggot.real_name]!"))
