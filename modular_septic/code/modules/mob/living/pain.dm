// Pain, ported from Baystation 12 and Eris, and cleaned up a bit.
/mob/living
	/// Pain (pain not taking other damage types into account) damage, generally a side effect of other types of damage
	var/painloss = 0
	/// Shock (pain taking into account other types of damage) damage
	var/traumatic_shock = 0
	/// Shock stage, as in how much our crit has progressed
	var/shock_stage = 0
	/// Last pain related message we have received - Used to prevent spam
	var/last_pain_message = ""
	/// Next time we are able to trigger custom_pain()
	var/next_pain_time = 0
	/// Next time we are able to send a custom_pain() chat message
	var/next_pain_message_time = 0

/// Hooks updating pain and shock to updatehealth
/mob/living/updatehealth()
	. = ..()
	if(status_flags & GODMODE)
		return
	update_pain()
	update_shock()

/// Updates pain value
/mob/living/proc/update_pain()
	painloss = getPainLoss()
	return painloss

/// Updates shock value
/mob/living/proc/update_shock()
	traumatic_shock = getShock(TRUE)
	return traumatic_shock

/// Can this mob get affected by shock?
/mob/living/proc/can_feel_pain()
	return FALSE

/// Called on Life(), handles constant pain (from other damages) and dynamic pain (painloss)
/mob/living/proc/handle_shock()
	return

/// Called on Life(), handles crit progression
/mob/living/proc/handle_shock_stage()
	return

/mob/proc/flash_pain(power)
	if(!hud_used?.pain_flash)
		return
	switch(power)
		if(5 to 25)
			flick("weakest_pain", hud_used.pain_flash)
		if(25 to 40)
			flick("weaker_pain", hud_used.pain_flash)
		if(40 to 75)
			flick("weak_pain", hud_used.pain_flash)
		if(75 to INFINITY)
			flick("pain", hud_used.pain_flash)

/mob/proc/flash_pain_endorphine()
	if(!hud_used?.pain_flash)
		return
	flick("endorphin_junkie", hud_used.pain_flash)

/mob/proc/flash_pain_major()
	if(!hud_used?.pain_flash)
		return
	flick("purplenig", hud_used.pain_flash)

/mob/proc/flash_pain_mental(power)
	if(!hud_used?.pain_flash)
		return
	switch(power)
		if(5 to INFINITY)
			flick("static", hud_used.pain_flash)

/mob/proc/flash_screen_flash(power)
	if(!hud_used?.pain_flash)
		return
	flick("flash_anim", hud_used.pain_flash)

/mob/proc/flash_darkness(power)
	if(!hud_used?.pain_flash)
		return
	switch(power)
		if(5 to INFINITY)
			flick("darkness", hud_used.pain_flash)

/mob/proc/flash_pain_manic(power)
	if(!hud_used?.pain_flash)
		return
	switch(power)
		if(5 to INFINITY)
			flick("endorphin_junkie", hud_used.pain_flash)

/mob/living/proc/custom_pain(message, power, forced, obj/item/bodypart/affecting, nopainloss)
	return
