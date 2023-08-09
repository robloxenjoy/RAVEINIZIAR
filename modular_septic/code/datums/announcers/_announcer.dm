/datum/centcom_announcer
	welcome_sounds = list('modular_pod/sound/mus/start.ogg')
	///Roundshift end audio
	var/goodbye_sounds = list('modular_pod/sound/mus/hrumka.ogg')

/datum/centcom_announcer/proc/combat_map_preset()
	command_report_sounds = list('modular_pod/sound/mus/announce.ogg')
	event_sounds = list(ANNOUNCER_AIMALF = 'sound/ai/default/aimalf.ogg',
		ANNOUNCER_ALIENS = 'sound/ai/default/aliens.ogg',
		ANNOUNCER_ANIMES = 'sound/ai/default/animes.ogg',
		ANNOUNCER_GRANOMALIES = 'sound/ai/default/granomalies.ogg',
		ANNOUNCER_INTERCEPT = 'sound/ai/default/intercept.ogg',
		ANNOUNCER_IONSTORM = 'sound/ai/default/ionstorm.ogg',
		ANNOUNCER_METEORS = 'sound/ai/default/meteors.ogg',
		ANNOUNCER_OUTBREAK5 = 'sound/ai/default/outbreak5.ogg',
		ANNOUNCER_OUTBREAK7 = 'sound/ai/default/outbreak7.ogg',
		ANNOUNCER_POWEROFF = 'sound/ai/default/poweroff.ogg',
		ANNOUNCER_POWERON = 'sound/ai/default/poweron.ogg',
		ANNOUNCER_RADIATION = 'sound/ai/default/radiation.ogg',
		ANNOUNCER_SHUTTLECALLED = 'modular_septic/sound/misc/podcalled.ogg',
		ANNOUNCER_SHUTTLEDOCK = 'modular_septic/sound/misc/podbeep.ogg',
		ANNOUNCER_SHUTTLERECALLED = 'modular_septic/sound/misc/podrecalled.ogg',
		ANNOUNCER_SPANOMALIES = 'sound/ai/default/spanomalies.ogg')

/datum/centcom_announcer/proc/get_rand_goodbye_sound()
	return pick(goodbye_sounds) // maybe for later
