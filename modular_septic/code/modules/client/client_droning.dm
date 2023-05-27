/client/proc/play_area_droning(area/area_droning, mob/listener)
	if(!area_droning || !listener)
		return
	var/droning_file = pick(area_droning.droning_sound)
	if(HAS_TRAIT(listener, TRAIT_LEAN))
		droning_file = 'modular_septic/sound/insanity/lean.ogg'
	/// Same file, don't bother
	if(current_droning_file == droning_file)
		return
	var/droning_repeat = area_droning.droning_repeat
	var/droning_wait = area_droning.droning_wait
	var/droning_channel = area_droning.droning_channel
	var/droning_volume = area_droning.droning_volume
	play_droning(FALSE, droning_file, droning_repeat, droning_wait, droning_channel, droning_volume)

/client/proc/play_combat_droning(mob/combatant)
	if(!combatant)
		return
	var/combat_music = combatant.mind?.combat_music
	if(!combat_music)
		return
	combat_music = pick(combat_music)
	/// Same file, don't bother
	if(current_droning_file == combat_music)
		return
	play_droning(TRUE, combat_music, TRUE, 0, CHANNEL_AMBIENCE_MUSIC, 75)

/client/proc/play_droning(is_combat = FALSE, droning_file, droning_repeat = TRUE, droning_wait = 0, droning_channel = CHANNEL_BUZZ, droning_volume = 75)
	if(!droning_file || (!is_combat && !(prefs?.toggles & SOUND_MUSIC_AMBIENCE)))
		pause_droning(current_droning_sound)
		return
	if(current_droning_file == droning_file)
		return
	pause_droning(current_droning_sound)
	//check if we have an existing sound datum for this file
	var/sound/droning_sound = LAZYACCESS(droning_sounds, droning_file)
	//if not, create new one
	if(!droning_sound)
		droning_sound = sound(droning_file, droning_repeat, droning_wait, droning_channel, droning_volume)
		LAZYADDASSOC(droning_sounds, droning_file, droning_sound)
		//I hope this works...
		droning_sound.status = NONE
	else
		droning_sound.status = SOUND_UPDATE
	if(is_combat)
		droning_sound.status = NONE
	current_droning_sound = droning_sound
	SEND_SOUND(src, current_droning_sound)
	current_droning_file = droning_sound.file

/client/proc/pause_droning(sound/droning)
	if(!droning)
		return
	droning.status = SOUND_PAUSED | SOUND_UPDATE
	SEND_SOUND(src, droning)

/client/proc/kill_droning(sound/droning)
	if(!droning)
		return
	pause_droning(droning)
	var/sound/killer_sound = sound()
	killer_sound.file = null
	killer_sound.status = NONE
	killer_sound.channel = droning.channel
	SEND_SOUND(src, killer_sound)
	current_droning_file = null
	current_droning_sound = null

/client/proc/reset_all_droning()
	pause_droning(current_droning_sound)
	droning_sounds = null

/client/proc/soundquery()
	return SoundQuery()

/client/proc/sendsound(sound/sent_sound)
	SEND_SOUND(src, sent_sound)
