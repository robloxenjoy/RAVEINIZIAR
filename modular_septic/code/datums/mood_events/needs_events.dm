//hydration
/datum/mood_event/thirsty
	description = span_warning("Would like to have a drink.")
	mood_change = -4

/datum/mood_event/dehydrated
	description = span_boldwarning("I'm dehydrated!")
	mood_change = -6

//nutrition
/datum/mood_event/hungry
	description = span_warning("I'm hungry...")
	mood_change = -4

/datum/mood_event/starving
	description = span_warning("I'm starving!")
	mood_change = -6

//urination
/datum/mood_event/needpiss
	description = span_warning("I need to take a piss.")
	mood_change = -3

/datum/mood_event/reallyneedpiss
	description = span_boldwarning("My bladder is going to burst!")
	mood_change = -5

/datum/mood_event/pissed_self
	description = span_necrosis("I stupidly pissed myself, fuck.")
	mood_change = -8
	timeout = 10 MINUTES

//defecation
/datum/mood_event/needshit
	description = span_warning("I need to take a shit.")
	mood_change = -3

/datum/mood_event/reallyneedshit
	description = span_boldwarning("It's time to <b>SHIT!</b>")
	mood_change = -5

/datum/mood_event/shat_self
	description = span_necrosis("I just shit myself.")
	mood_change = -8
	timeout = 10 MINUTES

//hygiene
/datum/mood_event/clean
	description = span_nicegreen("I'm so clean!")
	mood_change = 2

/datum/mood_event/needshower
	description = span_warning("I need to wash.")
	mood_change = -2

/datum/mood_event/reallyneedshower
	description = span_infection("I'm dirty.")
	mood_change = -4

/datum/mood_event/smashplayer
	description = span_necrosis("Of course it fucking stinks...")
	mood_change = -6

//sex!
/datum/mood_event/goodsex
	description = span_nicegreen("THIS was fucked up.")
	mood_change = 4
	timeout = 3 MINUTES

/datum/mood_event/goodmasturbation
	description = span_nicegreen("And that was okay.")
	mood_change = 2
	timeout = 3 MINUTES

/datum/mood_event/needsex
	description = span_love("I feel horny.")
	mood_change = -2

/datum/mood_event/reallyneedsex
	description = span_userlove("Need to GET SEX!")
	mood_change = -4
