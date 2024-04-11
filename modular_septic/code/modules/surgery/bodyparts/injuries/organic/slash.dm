/** SLASHES **/
/datum/injury/slash
	bleed_threshold = 5
	damage_type = WOUND_SLASH

/datum/injury/slash/small
	// link wound descriptions to amounts of damage
	// Minor cuts have max_bleeding_stage set to the stage that bears the wound type's name.
	// The major cut types have the max_bleeding_stage set to the clot stage (which is accordingly given the "blood soaked" descriptor).
	max_bleeding_stage = 3
	stages = list(
		"уродский порез" = 20,
		"надорванный порез" = 10,
		"порез" = 5,
		"мелкий порез" = 2,
		"малюткин порез" = 0
		)

/datum/injury/slash/deep
	max_bleeding_stage = 3
	infection_rate = 1.3
	stages = list(
		"глубокий порез" = 25,
		"уродский порез" = 20,
		"надорванный порез" = 15,
		"порез" = 8,
		"мелкий порез" = 2,
		"малюткин порез" = 0
		)
	fade_away_time = INFINITY

/datum/injury/slash/flesh
	max_bleeding_stage = 4
	infection_rate = 1.5
	stages = list(
		"уродское рассечение" = 35,
		"ублюдочный разрез" = 30,
		"глубокий порез" = 25,
		"надорванный порез" = 15,
		"порез" = 5,
		"мелкий порез" = 0
		)
	fade_away_time = INFINITY

/datum/injury/slash/gaping
	max_bleeding_stage = 3
	infection_rate = 2
	stages = list(
		"кровавый полумесяц" = 50,
		"глубокий порез" = 25,
		"надорванный порез" = 15,
		"порез" = 5,
		"прямой порез" = 0
		)
	fade_away_time = INFINITY

/datum/injury/slash/gaping_big
	max_bleeding_stage = 3
	infection_rate = 2.5
	stages = list(
		"большой полумесяц" = 60,
		"серьёзное рассечение" = 40,
		"глубокий порез" = 25,
		"надорванный порез" = 10,
		"прямой порез" = 0
		)
	fade_away_time = INFINITY

/datum/injury/slash/massive
	max_bleeding_stage = 3
	infection_rate = 2.5
	stages = list(
		"серьёзный разруб" = 70,
		"серьёзный полумесяц" = 50,
		"глубокий порез" = 25,
		"большой злостный порез" = 10,
		"зубчатый порез" = 0
		)
	fade_away_time = INFINITY
