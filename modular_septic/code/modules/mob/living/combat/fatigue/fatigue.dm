/mob/living
	/// List of fatigue modifiers applying to this mob
	var/list/fatigue_modification //Lazy list, see fatigue_modifier.dm
	/// List of fatigue modifiers ignored by this mob. List -> List (id) -> List (sources)
	var/list/fatigue_mod_immunities //Lazy list, see fatigue_modifier.dm
	var/max_fatigue = DEFAULT_MAX_FATIGUE
	var/base_max_fatigue = DEFAULT_MAX_FATIGUE
	var/fatigue = DEFAULT_MAX_FATIGUE
	COOLDOWN_DECLARE(fatigue_regen_cooldown)

/// Go through the list of fatigue modifiers and calculate a final max_fatigue. ANY ADD/REMOVE DONE IN UPDATE_MOVESPEED MUST HAVE THE UPDATE ARGUMENT SET AS FALSE!
/mob/living/proc/update_fatigue()
	. = base_max_fatigue
	var/list/conflict_tracker = list()
	for(var/key in get_fatigue_modifiers())
		var/datum/fatigue_modifier/fatigue_mod = fatigue_modification[key]
		var/conflict = fatigue_mod.conflicts_with
		if(conflict)
			// Conflicting modifiers prioritize the ghighest priority
			if(conflict_tracker[conflict] < fatigue_mod.priority)
				conflict_tracker[conflict] = fatigue_mod.priority
			else
				continue
		. += fatigue_mod.fatigue_add
	max_fatigue = .
	fatigue = clamp(fatigue, FATIGUE_MINIMUM, max_fatigue)

/// Life() processing of fatigue
/mob/living/proc/handle_fatigue(delta_time, times_fired)
	return

/mob/living/proc/getFatigueLoss()
	return max(0, base_max_fatigue - fatigue)

/mob/living/proc/adjustFatigueLoss(amount, updating_health = TRUE, forced = FALSE)
	if(!forced && (status_flags & GODMODE))
		return FALSE
	fatigue = clamp(fatigue - amount, FATIGUE_MINIMUM, max_fatigue)
	if(amount > 0)
		COOLDOWN_START(src, fatigue_regen_cooldown, FATIGUE_REGEN_COOLDOWN_DURATION)
	if(updating_health)
		update_stamina()
	return amount

/mob/living/proc/setFatigueLoss(amount, updating_health = TRUE, forced = FALSE)
	var/prev_fatigue = fatigue
	fatigue = clamp(base_max_fatigue - amount, FATIGUE_MINIMUM, max_fatigue)
	if((fatigue - prev_fatigue) < 0)
		COOLDOWN_START(src, fatigue_regen_cooldown, FATIGUE_REGEN_COOLDOWN_DURATION)
	if(updating_health)
		update_stamina()
	return amount
