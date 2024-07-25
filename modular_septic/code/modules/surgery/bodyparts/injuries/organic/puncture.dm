/** PUNCTURES **/
/datum/injury/puncture
	bleed_threshold = 10
	damage_type = WOUND_PIERCE

/datum/injury/puncture/can_worsen(damage_type, damage)
	return FALSE //cannot be enlargened

/datum/injury/puncture/small
	max_bleeding_stage = 2
	stages = list(
		"puncture" = 5,
		"middle puncture" = 2,
		"tiny puncture" = 0
		)

/datum/injury/puncture/flesh
	max_bleeding_stage = 2
	infection_rate = 1.3
	stages = list(
		"serious puncture" = 15,
		"puncture" = 5,
		"middle puncture" = 2,
		"tiny puncture" = 0
		)
	fade_away_time = INFINITY

/datum/injury/puncture/gaping
	max_bleeding_stage = 3
	infection_rate = 1.5
	stages = list(
		"hole" = 30,
		"serious puncture" = 15,
		"middle puncture" = 10,
		"puncture" = 5,
		"tiny puncture" = 0
		)
	fade_away_time = INFINITY

/datum/injury/puncture/gaping_big
	max_bleeding_stage = 3
	infection_rate = 2
	stages = list(
		"gaping hole" = 50,
		"hole" = 20,
		"seriois puncture" = 15,
		"middle puncture" = 10,
		"evil scar" = 0
		)
	fade_away_time = INFINITY

/datum/injury/puncture/massive
	max_bleeding_stage = 3
	infection_rate = 2.5
	stages = list(
		"crazy gaping hole" = 60,
		"gaping hole" = 30,
		"hole" = 25,
		"evil round scar" = 10,
		"evil scar" = 0
		)
	fade_away_time = INFINITY
