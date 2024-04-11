/** PUNCTURES **/
/datum/injury/puncture
	bleed_threshold = 10
	damage_type = WOUND_PIERCE

/datum/injury/puncture/can_worsen(damage_type, damage)
	return FALSE //cannot be enlargened

/datum/injury/puncture/small
	max_bleeding_stage = 2
	stages = list(
		"прокол" = 5,
		"небольшой прокол" = 2,
		"малюткин прокол" = 0
		)

/datum/injury/puncture/flesh
	max_bleeding_stage = 2
	infection_rate = 1.3
	stages = list(
		"серьёзный прокол" = 15,
		"прокол" = 5,
		"небольшой прокол" = 2,
		"малюткин прокол" = 0
		)
	fade_away_time = INFINITY

/datum/injury/puncture/gaping
	max_bleeding_stage = 3
	infection_rate = 1.5
	stages = list(
		"дыра" = 30,
		"серьёзный прокол" = 15,
		"нормальный протокол" = 10,
		"прокол" = 5,
		"малюткин прокол" = 0
		)
	fade_away_time = INFINITY

/datum/injury/puncture/gaping_big
	max_bleeding_stage = 3
	infection_rate = 2
	stages = list(
		"зияющая дыра" = 50,
		"дыра" = 20,
		"серьёзный прокол" = 15,
		"нормальный прокол" = 10,
		"злой шрам" = 0
		)
	fade_away_time = INFINITY

/datum/injury/puncture/massive
	max_bleeding_stage = 3
	infection_rate = 2.5
	stages = list(
		"знатная дыра" = 60,
		"зияющая дыра" = 30,
		"дыра" = 25,
		"злой округлый шрам" = 10,
		"злой шрам" = 0
		)
	fade_away_time = INFINITY
