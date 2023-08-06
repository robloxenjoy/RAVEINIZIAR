/datum/mood_event/fraggot
	description = span_flashingdanger(span_big("I must kill the fatal! [emoji_parse(":fatal:")]"))
	mood_change = -5
	timeout = 0

/datum/mood_event/fraggot/add_effects(mob/living/fraggot)
	description = span_flashingdanger(span_big("I must kill [fraggot.real_name]!"))

/datum/mood_event/fraggot/killed
	description = span_flashingdanger(span_big("Fatal is killed! AWESOME!"))
	mood_change = 5
	timeout = 5 MINUTES

/datum/mood_event/fraggot/killed/add_effects(mob/living/fraggot)
	description = span_flashingdanger(span_big("FATAL IS KILLED!"))