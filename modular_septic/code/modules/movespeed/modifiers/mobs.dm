/datum/movespeed_modifier/thirst
	variable = TRUE

/datum/movespeed_modifier/traumatic_shock
	variable = TRUE

/datum/movespeed_modifier/shock_stage
	multiplicative_slowdown = SHOCK_STAGE_SLOWDOWN

/datum/movespeed_modifier/cardiac_arrest
	multiplicative_slowdown = CARDIAC_ARREST_SLOWDOWN
	flags = IGNORE_NOSLOW

/datum/movespeed_modifier/sprinting
	multiplicative_slowdown = -SPRINT_DEFAULT_SPEED_INCREASE
	movetypes = GROUND
	flags = IGNORE_NOSLOW

/datum/movespeed_modifier/sprinting/proc/sync()
	var/mod = CONFIG_GET(number/movedelay/sprint_speed)
	multiplicative_slowdown = isnum(mod) ? -mod : initial(multiplicative_slowdown)

/datum/movespeed_modifier/grab_slowdown/aggressive
	multiplicative_slowdown = 3

/datum/movespeed_modifier/grab_slowdown/neck
	multiplicative_slowdown = 6

/datum/movespeed_modifier/grab_slowdown/kill
	multiplicative_slowdown = 6

/datum/movespeed_modifier/human_carry
	multiplicative_slowdown = 0

/datum/movespeed_modifier/chemical_effect/speedboost
	variable = TRUE
	blacklisted_movetypes = FLOATING

/datum/movespeed_modifier/status_effect/water_slowdown
	variable = TRUE
	blacklisted_movetypes = FLYING | FLOATING
