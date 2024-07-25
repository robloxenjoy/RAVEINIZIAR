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
		"ugly cut" = 20,
		"damaged cut" = 10,
		"cut" = 5,
		"tiny cut" = 2,
		"so tiny cut" = 0
		)

/datum/injury/slash/deep
	max_bleeding_stage = 3
	infection_rate = 1.3
	stages = list(
		"deep cut" = 25,
		"ugly cut" = 20,
		"damaged cut" = 15,
		"cut" = 8,
		"tiny cut" = 2,
		"so tiny cut" = 0
		)
	fade_away_time = INFINITY

/datum/injury/slash/flesh
	max_bleeding_stage = 4
	infection_rate = 1.5
	stages = list(
		"ugly section" = 35,
		"ugly cut" = 30,
		"deep cut" = 25,
		"damaged cut" = 15,
		"cut" = 5,
		"so tiny cut" = 0
		)
	fade_away_time = INFINITY

/datum/injury/slash/gaping
	max_bleeding_stage = 3
	infection_rate = 2
	stages = list(
		"tearful crescent" = 50,
		"deep cut" = 25,
		"damaged cut" = 15,
		"cut" = 5,
		"straight cut" = 0
		)
	fade_away_time = INFINITY

/datum/injury/slash/gaping_big
	max_bleeding_stage = 3
	infection_rate = 2.5
	stages = list(
		"big crescent" = 60,
		"serious section" = 40,
		"deep cut" = 25,
		"damaged cut" = 10,
		"straight cut" = 0
		)
	fade_away_time = INFINITY

/datum/injury/slash/massive
	max_bleeding_stage = 3
	infection_rate = 2.5
	stages = list(
		"serious section" = 70,
		"serious crescent" = 50,
		"deep cut" = 25,
		"big evil cut" = 10,
		"toothed cut" = 0
		)
	fade_away_time = INFINITY
