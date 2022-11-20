/datum/effort
	/// Display name of the effort, when selecting it
	var/name = "Yell at bomberman"
	/// How many extra efforts this costs
	var/cost = 1
	/// How much time, in deciseconds, this effort will last for
	var/duration = 1 MINUTES
	/// Message displayed to the user when the effort is first gained
	var/gain_message = span_effortgained("I feel more mundane.")
	/// Message displayed to the user when the effort wears off
	var/lose_message = span_effortlost("I still feel mundane.")

/// Checks that are done before letting the user choose this, or activate this
/datum/effort/proc/can_use(mob/user)
	if(cost > user.extra_effort)
		return FALSE
	return TRUE

/datum/effort/proc/activate(mob/user, silent = FALSE)
	if(!can_use(user))
		return FALSE
	if(cost)
		if(cost > user.extra_effort)
			to_chat(user, span_warning("Not enough extra effort."))
			return FALSE
		user.lose_extra_effort(cost, silent)
	if(!silent)
		user.playsound_local(user, 'modular_septic/sound/effects/effort.ogg', 100, FALSE)
		if(gain_message)
			to_chat(user, gain_message)
	ADD_TRAIT(user, TRAIT_EFFORT_ACTIVE, EFFORT_TRAIT)
	on_activation(user, silent)
	if(duration)
		addtimer(CALLBACK(src, .proc/deactivate, user, silent), duration)
	user.hud_used?.stat_viewer?.update_appearance()
	return TRUE

/datum/effort/proc/on_activation(mob/user, silent = FALSE)
	return TRUE

/datum/effort/proc/deactivate(mob/user, silent = FALSE)
	if(!silent)
		user.playsound_local(user, 'modular_septic/sound/effects/effort_expired.ogg', 100, FALSE)
		if(lose_message)
			to_chat(user, lose_message)
	REMOVE_TRAIT(user, TRAIT_EFFORT_ACTIVE, EFFORT_TRAIT)
	on_deactivation(user, silent)
	user.hud_used?.stat_viewer?.update_appearance()
	return TRUE

/datum/effort/proc/on_deactivation(mob/user, silent = FALSE)
	return TRUE
