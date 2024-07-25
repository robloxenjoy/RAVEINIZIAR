/** BRUISES **/
/datum/injury/bruise
	bleed_threshold = 20
	autoheal_cutoff = 30
	damage_type = WOUND_BLUNT

/datum/injury/bruise/small
	stages = list(
		"middle bruise" = 15,
		"default bruise" = 10,
		"tiny bruise" = 5,
		"so tiny bruise" = 0
		)

/datum/injury/bruise/moderate
	stages = list(
		"so big hematoma" = 25,
		"big hematoma" = 20,
		"middle bruise" = 15,
		"default bruise" = 10,
		"tiny bruise" = 5,
		"so tiny bruise" = 0
		)
	max_bleeding_stage = 2

/datum/injury/bruise/large
	stages = list(
		"biggest hematoma" = 50,
		"serious hematoma" = 30,
		"big hematoma" = 20,
		"middle bruise" = 15,
		"default bruise" = 10,
		"tiny bruise" = 5,
		"so tiny bruise" = 0
		)
	max_bleeding_stage = 3
	fade_away_time = INFINITY

/datum/injury/bruise/huge
	stages = list(
		"gigantic hematoma" = 80,
		"biggest hematoma" = 50,
		"serious hematoma" = 30,
		"big hematoma" = 20,
		"middle bruise" = 15,
		"default bruise" = 10,
		"tiny bruise" = 5,
		"so tiny bruise" = 0
		)
	max_bleeding_stage = 4
	infection_rate = 1.3
	fade_away_time = INFINITY

/datum/injury/bruise/monumental
	stages = list(
		"gigantic hematoma" = 80,
		"biggest hematoma" = 50,
		"serious hematoma" = 30,
		"big hematoma" = 20,
		"middle bruise" = 15,
		"default bruise" = 10,
		"tiny bruise" = 5,
		"so tiny bruise" = 0
		)
	max_bleeding_stage = 4
	infection_rate = 1.3
	fade_away_time = INFINITY
