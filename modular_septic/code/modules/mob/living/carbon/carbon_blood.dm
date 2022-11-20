/// Do we lack a functioning heart?
/mob/living/carbon/undergoing_cardiac_arrest()
	if(!needs_heart())
		return FALSE

	return ((getorganslotefficiency(ORGAN_SLOT_HEART) < ORGAN_FAILING_EFFICIENCY) || (pulse <= PULSE_NONE))

/mob/living/carbon/is_asystole()
	return undergoing_cardiac_arrest()

/mob/living/carbon/set_heartattack(status)
	if(!can_heartattack())
		return FALSE

	var/list/hearts = getorganslotlist(ORGAN_SLOT_HEART)
	if(status)
		pulse = PULSE_NONE
		for(var/obj/item/organ/heart/heart in hearts)
			heart.Stop()
	else
		pulse = PULSE_NORM
		for(var/obj/item/organ/heart/heart in hearts)
			heart.Restart()

// Brain is fried
/mob/living/carbon/undergoing_nervous_system_failure()
	var/obj/item/organ/brain/brain = getorganslot(ORGAN_SLOT_BRAIN)
	if(!brain)
		return TRUE
	if(brain.is_failing())
		return TRUE

// Better drag bleed
/mob/living/carbon/bleedDragAmount()
	var/bleed_amount = 0
	for(var/i in all_wounds)
		var/datum/wound/iter_wound = i
		bleed_amount += iter_wound.drag_bleed_amount()
	for(var/i in all_injuries)
		var/datum/injury/iter_injury = i
		bleed_amount += iter_injury.drag_bleed_amt()
	return round(bleed_amount, 1)

// Better bleeding
/mob/living/carbon/bleed(amt)
	if(!adjust_bloodvolume(-amt))
		return

	//Blood loss still happens in locker, floor stays clean
	if(isturf(loc) && prob(sqrt(amt)*BLOOD_DRIP_RATE_MOD))
		add_splatter_floor(loc, (amt < 10))
	return TRUE

// Better bleed warning
/mob/living/carbon/bleed_warn(bleed_amt = 0, forced = FALSE)
	if((get_blood_circulation() <= 0) || !client)
		return
	if(!COOLDOWN_FINISHED(src, bleeding_message_cd) && !forced)
		return

	if(!bleed_amt) // if we weren't provided the amount of blood we lost this tick in the args
		bleed_amt = get_bleed_rate()

	var/bleeding_severity = ""
	var/next_cooldown = BLEEDING_MESSAGE_BASE_CD

	switch(bleed_amt)
		if(-INFINITY to 0)
			return
		if(0 to 1)
			bleeding_severity = "You feel light trickles of blood across your skin"
			next_cooldown *= 2.5
		if(1 to 3)
			bleeding_severity = "You feel a small stream of blood running across your body"
			next_cooldown *= 2
		if(3 to 5)
			bleeding_severity = "You skin feels clammy from the flow of blood leaving your body"
			next_cooldown *= 1.7
		if(5 to 7)
			bleeding_severity = "Your body grows more and more numb as blood pours out"
			next_cooldown *= 1.5
		if(7 to INFINITY)
			bleeding_severity = "Your heartbeat thrashes wildly trying to keep up with your massive bloodloss"

	var/rate_of_change = ", but it's getting better." // if there's no wounds actively getting bloodier or maintaining the same flow, we must be getting better!
	if(HAS_TRAIT(src, TRAIT_COAGULATING)) // if we have coagulant, we're getting better quick
		rate_of_change = ", but it's clotting up quickly!"
	else
		// flick through our wounds to see if there are any bleeding ones getting worse or holding flow (maybe move this to handle_blood and cache it so we don't need to cycle through the wounds so much)
		for(var/i in all_wounds)
			var/datum/wound/iter_wound = i
			if(!iter_wound.blood_flow)
				continue
			var/iter_wound_roc = iter_wound.get_bleed_rate_of_change()
			switch(iter_wound_roc)
				if(BLOOD_FLOW_INCREASING) // assume the worst, if one wound is getting bloodier, we focus on that
					rate_of_change = ", <b>and it's getting worse!</b>"
					break
				if(BLOOD_FLOW_STEADY) // our best case now is that our bleeding isn't getting worse
					rate_of_change = ", and it's holding steady."
				if(BLOOD_FLOW_DECREASING) // this only matters if none of the wounds fit the above two cases, included here for completeness
					continue
		// same for injuries
		if(rate_of_change != ", <b>and it's getting worse!</b>")
			for(var/i in all_injuries)
				var/datum/injury/iter_injury = i
				if(!iter_injury.is_bleeding())
					continue
				var/iter_injury_roc = iter_injury.get_bleed_rate_of_change()
				switch(iter_injury_roc)
					if(BLOOD_FLOW_INCREASING) // assume the worst, if one wound is getting bloodier, we focus on that
						rate_of_change = ", <b>and it's getting worse!</b>"
						break
					if(BLOOD_FLOW_STEADY) // our best case now is that our bleeding isn't getting worse
						rate_of_change = ", and it's holding steady."
					if(BLOOD_FLOW_DECREASING) // this only matters if none of the injuries fit the above two cases, included here for completeness
						continue
		// if we have a torn artery it won't get better on it's on
		if(rate_of_change != ", <b>and it's getting worse!</b>")
			for(var/bp in bodyparts)
				var/obj/item/bodypart/bodypart = bp
				if(bodypart.is_artery_torn())
					rate_of_change = ", and it's holding steady."

	to_chat(src, span_userdanger("[bleeding_severity][rate_of_change]</span>"))
	COOLDOWN_START(src, bleeding_message_cd, next_cooldown)

/// This is basically a meme, but having multiple infected and failing organs = you are in septic shock
/mob/living/carbon/proc/undergoing_septic_shock()
	var/fuckeduporgans = 0
	for(var/obj/item/organ/organ as anything in internal_organs)
		if((organ.germ_level >= INFECTION_LEVEL_TWO) && organ.is_failing())
			fuckeduporgans++
	for(var/obj/item/bodypart/bodypart as anything in bodyparts)
		if(bodypart.germ_level >= INFECTION_LEVEL_THREE)
			fuckeduporgans++
	return (fuckeduporgans >= 6)

/// Blood volume, affected by the heart
/mob/living/carbon/proc/get_blood_circulation()
	if(HAS_TRAIT(src, TRAIT_BLOODLOSSIMMUNE))
		return BLOOD_VOLUME_NORMAL
	if(!needs_heart())
		return blood_volume

	var/heart_efficiency = getorganslotefficiency(ORGAN_SLOT_HEART)
	var/apparent_blood_volume = blood_volume

	var/pulse_mod = 1
	if(HAS_TRAIT(src, TRAIT_FAKEDEATH))
		pulse_mod = 1
	else
		switch(pulse)
			if(-INFINITY to PULSE_NONE)
				//Did someone at least perform CPR?
				if(recent_heart_pump && (world.time <= text2num(recent_heart_pump[1]) + heart_pump_duration))
					pulse_mod *= recent_heart_pump[recent_heart_pump[1]]
				else
					if(stat < DEAD)
						//Fuck - But we're still alive so there is *some* blood flow.
						pulse_mod *= 0.1
					else
						//Dead people don't pump blood, at all
						pulse_mod *= 0
			if(PULSE_SLOW)
				pulse_mod *= 0.9
			if(PULSE_FAST)
				pulse_mod *= 1.1
			if(PULSE_FASTER, PULSE_THREADY)
				pulse_mod *= 1.25

	var/min_efficiency = recent_heart_pump ? 0.5 : 0.25
	apparent_blood_volume *= clamp(1 - (100 - heart_efficiency)/100, min_efficiency, 5)
	apparent_blood_volume *= pulse_mod

	var/blockage = get_chem_effect(src, CE_BLOCKAGE)
	if(blockage)
		var/list/hearts = getorganslotlist(ORGAN_SLOT_HEART)
		var/bypassed_heart = FALSE
		for(var/thing in hearts)
			var/obj/item/organ/heart/heart = thing
			if(heart.open)
				bypassed_heart = TRUE
		if(!bypassed_heart)
			apparent_blood_volume *= max(0, 1 - (blockage/100))

	return apparent_blood_volume

/// Blood volume, affected by the condition of circulation organs, affected by the oxygen loss - What ultimately matters for brain.
/mob/living/carbon/proc/get_blood_oxygenation()
	if(HAS_TRAIT(src, TRAIT_BLOODLOSSIMMUNE))
		return BLOOD_VOLUME_NORMAL

	var/apparent_blood_volume = get_blood_circulation()
	if(blood_carries_oxygen())
		if(!needs_lungs())
			return apparent_blood_volume
	else
		apparent_blood_volume = BLOOD_VOLUME_NORMAL

	var/apparent_blood_volume_mod = max(0, 1 - getOxyLoss()/maxHealth)
	var/oxygenated = get_chem_effect(CE_OXYGENATED)
	if(oxygenated == 1) // Tirimol
		apparent_blood_volume_mod += 0.5
	else if(oxygenated >= 2) // Dexalin plus
		apparent_blood_volume_mod += 0.8
	apparent_blood_volume = apparent_blood_volume * apparent_blood_volume_mod
	return apparent_blood_volume

/// Do we need blood to sustain the brain?
/mob/living/carbon/proc/blood_carries_oxygen()
	return TRUE

/// Get the pulse integer
/mob/living/carbon/proc/pulse()
	return pulse

/// A pulse to be read by players
/mob/living/carbon/proc/get_pulse_as_number(raw_pulse = pulse)
	switch(raw_pulse)
		if(PULSE_NONE)
			return 0
		if(PULSE_SLOW)
			return rand(40, 60)
		if(PULSE_NORM)
			return rand(60, 90)
		if(PULSE_FAST)
			return rand(90, 120)
		if(PULSE_FASTER)
			return rand(120, 160)
		if(PULSE_THREADY)
			return PULSE_MAX_BPM
	CRASH("For some reason, on a get_pulse_as_number() call, someone's pulse is not a valid integer!")

/// Generates realistic-ish pulse output based on preset levels as text
/mob/living/carbon/proc/get_pulse(method)	//method 0 is for hands, 1 is for machines, more accurate
	if(method == GETPULSE_PERFECT)
		return pulse

	var/list/hearts = getorganslotlist(ORGAN_SLOT_HEART)
	if(!length(hearts))
		// No heart, no pulse
		return "0"

	var/bypassed_heart = FALSE
	for(var/thing in hearts)
		var/obj/item/organ/heart/heart = thing
		if(heart.open)
			bypassed_heart = TRUE

	if(bypassed_heart && (method <= GETPULSE_BASIC))
		// Heart is a open type (?) and cannot be checked unless it's a machine
		return "muddled and unclear"

	var/bpm = get_pulse_as_number()
	if(bpm >= PULSE_MAX_BPM)
		if(method == GETPULSE_ADVANCED)
			return ">[PULSE_MAX_BPM]"
		else
			return "extremely weak and fast"

	if(method == GETPULSE_ADVANCED)
		return "[bpm]"
	else
		return "[bpm > 0 ? max(0, bpm + rand(-10, 10)) : 0]"
