//Used to manage sending droning sounds to various clients
SUBSYSTEM_DEF(droning)
	name = "Droning"
	flags = SS_NO_INIT|SS_NO_FIRE

	var/crazymuzon = FALSE
/*
/sound
	var/transition = 0

/sound/proc/Transition(var/mob/M)
	transition = 1
	status = SOUND_UPDATE

	while(volume > 0)
		volume = max(volume - 2, 0)
		M << src
		/////////
		sleep(2.5)
		/////////

//	status = SOUND_STREAM
	transition = 0
*/
/datum/controller/subsystem/droning/proc/area_entered(area/area_entered, client/entering)
	if(!area_entered || !entering)
		return
	if(HAS_TRAIT(entering.mob, TRAIT_LEAN) && !area_entered.droning_sound)
		//just kill the previous droning sound
		kill_droning(entering)
		return
	if(HAS_TRAIT(entering.mob, TRAIT_BLOODARN) && !area_entered.droning_sound)
		//just kill the previous droning sound
		kill_droning(entering)
		return
	var/list/last_droning = list()
	last_droning |= entering.last_droning_sound
	var/list/new_droning = list()
	new_droning |= area_entered.droning_sound
	if(HAS_TRAIT(entering.mob, TRAIT_LEAN))
		new_droning = list('modular_septic/sound/insanity/lean.ogg', 100)
//	if(HAS_TRAIT(entering.mob, TRAIT_BLOODARN))
//		new_droning = list('modular_pod/sound/mus/radioakt.ogg', 100)
	//Same ambience, don't bother
	if(last_droning ~= new_droning)
		return
	play_area_sound(area_entered, entering)

/datum/controller/subsystem/droning/proc/play_area_sound(area/area_player, client/listener)
	if(!area_player || !listener)
		return
	if(LAZYLEN(area_player.droning_sound))

//		if((istype(area_player, /area/maintenance/polovich/forest)) || (istype(area_player, /area/medical/spawned)))
//		if(SSoutdoor_effects.current_step_datum == /datum/time_of_day/midnight || SSoutdoor_effects.current_step_datum == /datum/time_of_day/dusk || SSoutdoor_effects.current_step_datum == /datum/time_of_day/dawn)
//		if(istype(SSoutdoor_effects.current_step_datum, /datum/time_of_day/midnight) || (SSoutdoor_effects.current_step_datum, /datum/time_of_day/dusk) || (SSoutdoor_effects.current_step_datum, /datum/time_of_day/dawn))
/*
			if(istype(SSoutdoor_effects.current_step_datum, /datum/time_of_day/midnight))
				area_player.droning_sound = DRONING_PURENIGHT
			else if(istype(SSoutdoor_effects.current_step_datum, /datum/time_of_day/night))
				area_player.droning_sound = DRONING_PURENIGHT
			else if(istype(SSoutdoor_effects.current_step_datum, /datum/time_of_day/dusk))
				area_player.droning_sound = DRONING_PURENIGHT
			else if(istype(SSoutdoor_effects.current_step_datum, /datum/time_of_day/dawn))
				area_player.droning_sound = DRONING_PURENIGHT
			else if(istype(SSoutdoor_effects.current_step_datum, /datum/time_of_day/dawndawn))
				area_player.droning_sound = DRONING_PURENIGHT
			else
				area_player.droning_sound = DRONING_FOREST
*/

/*

			if(isnight(SSoutdoor_effects.current_step_datum))
				area_player.droning_sound = DRONING_PURENIGHT
			else
				area_player.droning_sound = DRONING_FOREST

		if(istype(area_player, /area/maintenance/polovich/village))
			if(isnight(SSoutdoor_effects.current_step_datum))
				area_player.droning_sound = DRONING_PURENIGHT_AKT
			else
				area_player.droning_sound = DRONING_AKT
*/

		//kill the previous droning sound
//		kill_droning(area_player, listener)
		last_phase(area_player, listener)
	else
		if(listener?.droning_sound)
			kill_droning(listener)
/*
		if(!listener.mob.transition)
			var/sound/droning = sound(pick(area_player.droning_sound), area_player.droning_repeat, area_player.droning_wait, area_player.droning_channel, area_player.droning_volume)
			if(HAS_TRAIT(listener.mob, TRAIT_LEAN))
				droning.file = 'modular_septic/sound/insanity/lean.ogg'
			if(HAS_TRAIT(listener.mob, TRAIT_BLOODARN))
				droning.file = 'modular_pod/sound/mus/radioakt.ogg'
			SEND_SOUND(listener, droning)
			listener.droning_sound = droning
			listener.last_droning_sound = area_player.droning_sound
*/
/*
/datum/controller/subsystem/droning/proc/last_phase(area/area_player, client/listener)
	while(listener.mob.transition)
		if(!listener.mob.transition)
			break
	var/sound/droning = sound(pick(area_player.droning_sound), area_player.droning_repeat, area_player.droning_wait, area_player.droning_channel, area_player.droning_volume)
	if(HAS_TRAIT(listener.mob, TRAIT_LEAN))
		droning.file = 'modular_septic/sound/insanity/lean.ogg'
	if(HAS_TRAIT(listener.mob, TRAIT_BLOODARN))
		droning.file = 'modular_pod/sound/mus/radioakt.ogg'
	listener.droning_sound = droning
	listener.last_droning_sound = area_player.droning_sound
	SEND_SOUND(listener, droning)
*/
/datum/controller/subsystem/droning/proc/play_combat_music(music = null, client/dreamer)
	if(!music || !dreamer)
		return
	if(HAS_TRAIT(dreamer.mob, TRAIT_LEAN))
		return
	if(HAS_TRAIT(dreamer.mob, TRAIT_BLOODARN))
		return
	//kill the previous droning sound
	kill_droning(dreamer)
	var/sound/combat_music = sound(pick(music), repeat = TRUE, wait = 0, channel = CHANNEL_BUZZ, volume = 70)
	SEND_SOUND(dreamer, combat_music)
	dreamer.droning_sound = combat_music
	dreamer.last_droning_sound = combat_music.file

/datum/controller/subsystem/droning/proc/last_phase(area/area_player, client/listener)
	if(!area_player || !listener)
		return
	var/shouldskip = FALSE
	if(!listener?.droning_sound)
		shouldskip = TRUE
//	victim.mob.transition = TRUE
	if(shouldskip)
		var/sound/droning = sound(pick(area_player.droning_sound), area_player.droning_repeat, area_player.droning_wait, area_player.droning_channel, area_player.droning_volume)
		if(crazymuzon)
			droning.file = DRONING_MUZON
		if(HAS_TRAIT(listener.mob, TRAIT_LEAN))
			droning.file = 'modular_septic/sound/insanity/lean.ogg'
//		if(HAS_TRAIT(listener.mob, TRAIT_BLOODARN))
//			droning.file = 'modular_pod/sound/mus/radioakt.ogg'
		listener.droning_sound = droning
		listener.last_droning_sound = area_player.droning_sound
		SEND_SOUND(listener, droning)
	else
		var/sound/sound_killer = sound()
		sound_killer.channel = listener.droning_sound.channel
		sound_killer.volume = area_player.droning_volume
		while(sound_killer.volume > 0)
			if(sound_killer.volume <= 0)
				break
//			sound_killer.volume = max(sound_killer.volume - 2, 0)
			sound_killer.volume = max(sound_killer.volume - 5, 0)
//			SEND_SOUND(listener, sound_killer)
			sound_killer.status = SOUND_UPDATE
			SEND_SOUND(listener, sound_killer)
			sleep(1)
		listener.droning_sound = null
		listener.last_droning_sound = null
		var/sound/droning = sound(pick(area_player.droning_sound), area_player.droning_repeat, area_player.droning_wait, area_player.droning_channel, area_player.droning_volume)
		if(crazymuzon)
			droning.file = DRONING_MUZON
		listener.droning_sound = droning
		listener.last_droning_sound = area_player.droning_sound
		SEND_SOUND(listener, droning)

/datum/controller/subsystem/droning/proc/kill_droning(client/victim)
	if(!victim?.droning_sound)
		return
	var/sound/sound_killer = sound()
	sound_killer.channel = victim.droning_sound.channel
	SEND_SOUND(victim, sound_killer)
	victim.droning_sound = null
	victim.last_droning_sound = null

/datum/controller/subsystem/droning/proc/play_loop(area/area_entered, client/dreamer)
	if(!area_entered || !dreamer)
		return
//	var/retard = null
	kill_loop(dreamer)
	if(LAZYLEN(area_entered.ambientsounds_normal))
//		retard = area_entered.ambientsounds_normal
		var/sound/loop_sound = sound(pick(area_entered.ambientsounds_normal), repeat = TRUE, wait = 0, channel = CHANNEL_MUSIC, volume = 30)
		SEND_SOUND(dreamer, loop_sound)
		dreamer.loop_sound = TRUE
	else
		if(dreamer?.loop_sound)
			kill_loop(dreamer)

/*
	var/retard = null
	if(area_entered.loopniqqa)
		if(GLOB.tod == "night")
			if(area_entered.ambientnight)
				retard = area_entered.ambientnight
		else
			if(area_entered.ambientsounds)
				retard = area_entered.ambientsounds
*/

/datum/controller/subsystem/droning/proc/kill_loop(client/victim)
	if(!victim?.loop_sound)
		return
	victim?.mob.stop_sound_channel(CHANNEL_MUSIC)
	victim?.loop_sound = FALSE

//	victim.mob.transition = FALSE

/*
/datum/controller/subsystem/droning/proc/transition(client/victim)
	if(!victim?.droning_sound)
		return
	var/sound/sound_trans = sound()
	sound_trans.channel = victim.droning_sound.channel
//	SEND_SOUND(victim, sound_killer)
//	victim.droning_sound = null
//	victim.last_droning_sound = null

	while(sound_trans.volume > 0)
		sound_trans.volume = max(sound_trans.volume - 2, 0)
		SEND_SOUND(victim, sound_trans)
		sleep(2.5)
*/
/datum/controller/subsystem/droning/proc/stop_droning(client/victim)
	if(!victim?.droning_sound)
		return
	var/sound/sound_stopper = sound()
	sound_stopper.channel = victim.droning_sound.channel
	victim.droning_sound.volume = 0
	victim.droning_sound.status = SOUND_UPDATE
