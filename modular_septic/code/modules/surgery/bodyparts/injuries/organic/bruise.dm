/** BRUISES **/
/datum/injury/bruise
	bleed_threshold = 20
	autoheal_cutoff = 30
	damage_type = WOUND_BLUNT

/datum/injury/bruise/small
	stages = list(
		"средний синяк" = 15,
		"умеренный синяк" = 10,
		"мелкий синяк" = 5,
		"малюткин синяк" = 0
		)

/datum/injury/bruise/moderate
	stages = list(
		"большой ушиб" = 25,
		"нормальный ушиб" = 20,
		"средний синяк" = 15,
		"умеренный синяк" = 10,
		"мелкий синяк" = 5,
		"малюткин синяк" = 0
		)
	max_bleeding_stage = 2

/datum/injury/bruise/large
	stages = list(
		"большущий ушиб" = 50,
		"серьёзный ушиб" = 30,
		"нормальный ушиб" = 20,
		"средний синяк" = 15,
		"умеренный синяк" = 10,
		"мелкий синяк" = 5,
		"малюткин синяк" = 0
		)
	max_bleeding_stage = 3
	fade_away_time = INFINITY

/datum/injury/bruise/huge
	stages = list(
		"гигантский ушиб" = 80,
		"большущий ушиб" = 50,
		"серьёзный ушиб" = 30,
		"нормальный ушиб" = 20,
		"средний синяк" = 15,
		"умеренный синяк" = 10,
		"мелкий синяк" = 5,
		"малюткин синяк" = 0
		)
	max_bleeding_stage = 4
	infection_rate = 1.3
	fade_away_time = INFINITY

/datum/injury/bruise/monumental
	stages = list(
		"гигантский ушиб" = 80,
		"большущий ушиб" = 50,
		"серьёзный ушиб" = 30,
		"нормальный ушиб" = 20,
		"средний синяк" = 15,
		"умеренный синяк" = 10,
		"мелкий синяк" = 5,
		"малюткин синяк" = 0
		)
	max_bleeding_stage = 4
	infection_rate = 1.3
	fade_away_time = INFINITY
