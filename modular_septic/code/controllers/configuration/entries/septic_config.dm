/**
  * Disables atmos.
  * All this means is that every turf will use planetary, immutable atmos.
  */
/datum/config_entry/flag/disable_atmos
	config_entry_value = 1

/**
  * Enables the FoV component, which hides objects and mobs behind the parent from their sight, unless they turn around, duh.
  * Camera mobs, AIs, ghosts and some other are of course exempt from this. This also doesn't influence simplemob AI, for the best.
  */
/datum/config_entry/flag/use_field_of_vision
	config_entry_value = 1

/datum/config_entry/string/ipstack_api_key
	protection = CONFIG_ENTRY_HIDDEN | CONFIG_ENTRY_LOCKED

/datum/config_entry/string/servertagline

/datum/config_entry/string/flufftagline

/datum/config_entry/string/bunkertroll

/datum/config_entry/string/bantroll

/datum/config_entry/number/movedelay/sprint_speed
	integer = FALSE

/datum/config_entry/number/movedelay/sprint_speed/ValidateAndSet()
	. = ..()
	var/datum/movespeed_modifier/sprinting/M = get_cached_movespeed_modifier(/datum/movespeed_modifier/sprinting)
	M.sync()

/datum/config_entry/number/sprint_stamina_cost
	config_entry_value = SPRINT_DEFAULT_STAMINA_COST
	integer = FALSE

/datum/config_entry/number/sprint_stamina_cost/ValidateAndSet()
	. = ..()
	GLOB.sprint_stamina_cost = config_entry_value

/datum/config_entry/number/sprint_fatigue_cost
	config_entry_value = SPRINT_DEFAULT_FATIGUE_COST
	integer = FALSE

/datum/config_entry/number/sprint_fatigue_cost/ValidateAndSet()
	. = ..()
	GLOB.sprint_fatigue_cost = config_entry_value
