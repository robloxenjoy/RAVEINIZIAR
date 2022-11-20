/datum/award
	/// Whether this is a positive or negative achievement (overdosing on crack and dying is a negative, for example)
	var/achievement_quality = ACHIEVEMENT_NEUTRAL
	/// Whether or not we get an unlock message
	var/unlock_message = FALSE
	/// Whether or not we should play the unlocking sound
	var/unlock_sound = FALSE

/datum/award/achievement
	unlock_message = TRUE
	unlock_sound = TRUE

/datum/award/proc/inform_user(client/user)
	var/unlock_text = ""
	var/unlock_sound_file = null
	switch(achievement_quality)
		if(ACHIEVEMENT_RARE)
			if(unlock_message)
				unlock_text = span_achievementrare("Achievement unlocked:\n<b>[name]</b>")
			if(unlock_sound)
				unlock_sound_file = 'modular_septic/sound/achievement/achievement_rare.wav'
		if(ACHIEVEMENT_GOOD)
			if(unlock_message)
				unlock_text = span_achievementgood("Achievement unlocked:\n<b>[name]</b>")
			if(unlock_sound)
				unlock_sound_file = 'modular_septic/sound/achievement/achievement_good.wav'
		if(ACHIEVEMENT_NEUTRAL)
			if(unlock_message)
				unlock_text = span_achievementneutral("Achievement unlocked:\n<b>[name]</b>")
			if(unlock_sound)
				unlock_sound_file = 'modular_septic/sound/achievement/achievement_neutral.wav'
		if(ACHIEVEMENT_BAD)
			if(unlock_message)
				unlock_text = span_achievementbad("Achievement unlocked:\n<b>[name]</b>")
			if(unlock_sound)
				unlock_sound_file = 'modular_septic/sound/achievement/achievement_bad.wav'
	if(unlock_text)
		to_chat(user, unlock_text)
	if(unlock_sound_file)
		var/sound/sounding = sound(unlock_sound_file, FALSE, 0, volume = 75)
		SEND_SOUND(user, sounding)
