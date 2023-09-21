/mob/living/carbon/human
//	var/sound/rain = sound()
	var/sound/crazysounds = sound()
//	var/sound/wind = sound()
//	var/sound/rain_thunder = sound()


SUBSYSTEM_DEF(crazysoundz)
	name = "Crazysoundz"
	priority = 2
	wait = 59
	flags = SS_TICKER

	var/list/night = list('sound/stalker/weather/wind_1.ogg','sound/stalker/weather/wind_2.ogg','sound/stalker/weather/wind_3.ogg','sound/stalker/weather/wind_4.ogg',\
						'sound/stalker/weather/wind_5.ogg','sound/stalker/weather/wind_6.ogg', 'sound/stalker/weather/rnd_outdoor_night/ambient_night_1.ogg',\
						'sound/stalker/weather/rnd_outdoor_night/ambient_night_2.ogg', 'sound/stalker/weather/rnd_outdoor_night/ambient_night_3.ogg', 'sound/stalker/weather/rnd_outdoor_night/ambient_night_4.ogg',\
						'sound/stalker/weather/rnd_outdoor_night/ambient_night_5.ogg', 'sound/stalker/weather/rnd_outdoor_night/ambient_night_7.ogg', 'sound/stalker/weather/rnd_outdoor_night/ambient_night_8.ogg',\
						'sound/stalker/weather/rnd_outdoor_night/ambient_night_9.ogg', 'sound/stalker/weather/rnd_outdoor_night/ambient_night_11.ogg', 'sound/stalker/weather/rnd_outdoor_night/rnd_moan.ogg',\
						'sound/stalker/weather/rnd_outdoor_night/rnd_moan2.ogg', 'sound/stalker/weather/rnd_outdoor_night/rnd_moan3.ogg', 'sound/stalker/weather/rnd_outdoor_night/rnd_moan4.ogg',\
						'sound/stalker/weather/rnd_outdoor_night/rnd_moan5.ogg', 'sound/stalker/weather/rnd_outdoor_night/rnd_moan6.ogg')

	var/list/day = list('sound/stalker/weather/rnd_outdoor/ambient_wind_1.ogg', 'sound/stalker/weather/rnd_outdoor/ambient_wind_2.ogg', 'sound/stalker/weather/rnd_outdoor/ambient_wind_3.ogg',\
						'sound/stalker/weather/rnd_outdoor/ambient_wind_4.ogg', 'sound/stalker/weather/rnd_outdoor/rnd_bird_1.ogg', 'sound/stalker/weather/rnd_outdoor/rnd_bird_2.ogg', 'sound/stalker/weather/rnd_outdoor/rnd_bird_3.ogg',
						'sound/stalker/weather/rnd_outdoor/rnd_bird_4.ogg', 'sound/stalker/weather/rnd_outdoor/rnd_bird_5.ogg', 'sound/stalker/weather/rnd_outdoor/rnd_bird_6.ogg', 'sound/stalker/weather/rnd_outdoor/rnd_bird_7.ogg',
						'sound/stalker/weather/rnd_outdoor/rnd_bird_8.ogg', 'sound/stalker/weather/rnd_outdoor/rnd_bird_9.ogg', 'sound/stalker/weather/rnd_outdoor/rnd_bird_10.ogg', 'sound/stalker/weather/rnd_outdoor/rnd_bird_11.ogg',
						'sound/stalker/weather/rnd_outdoor/rnd_crow_1.ogg', 'sound/stalker/weather/rnd_outdoor/rnd_crow_2.ogg', 'sound/stalker/weather/rnd_outdoor/rnd_crow_3.ogg', 'sound/stalker/weather/rnd_outdoor/rnd_crow_4.ogg', 'sound/stalker/weather/rnd_outdoor/rnd_crow_5.ogg',
						'sound/stalker/weather/rnd_outdoor/rnd_crow_6.ogg', 'sound/stalker/weather/rnd_outdoor/rnd_dog1.ogg', 'sound/stalker/weather/rnd_outdoor/rnd_dog2.ogg', 'sound/stalker/weather/rnd_outdoor/rnd_dog3.ogg', 'sound/stalker/weather/rnd_outdoor/rnd_dog4.ogg', 'sound/stalker/weather/rnd_outdoor/rnd_dog5.ogg')

/*
/datum/controller/subsystem/crazysounds/Initialize()
	rain = new
//	rain = image('icons/stalker/structure/decor.dmi', icon_state = "rain", layer = 10)
	rain.icon = 'icons/stalker/effects/weather.dmi'
	rain.icon_state = ""
	rain.layer = TURF_FIRE_LAYER
	rain.mouse_opacity = 0
	rain.name = ""
	for(var/area/maintenance/polovich/forest/rain/A in world)
		for(var/turf/open/floor/plating/polovich/T in A.contents)
			T.vis_contents.Add(rain)
	..()
*/

/datum/controller/subsystem/crazysoundz/fire()
	HandleSound()

/datum/controller/subsystem/crazysoundz/proc/StartSound()
	for(var/mob/living/carbon/human/H in GLOB.alive_mob_list)
		if(H.client)
			H.start_crazy_sounds()

/datum/controller/subsystem/crazysoundz/proc/HandleSound()
	var/crazysounds_file = 'sound/stalker/weather/wind_1.ogg'
	if(isnight(SSoutdoor_effects.current_step_datum))
		crazysounds_file = pick(SScrazysoundz.night)
/*
	if(istype(SSoutdoor_effects.current_step_datum, /datum/time_of_day/midnight))
		var/crazysounds_file = pick(SScrazysounds.night)
	else if(istype(SSoutdoor_effects.current_step_datum, /datum/time_of_day/night))
		var/crazysounds_file = pick(SScrazysounds.night)
	else if(istype(SSoutdoor_effects.current_step_datum, /datum/time_of_day/dusk))
		var/crazysounds_file = pick(SScrazysounds.night)
	else if(istype(SSoutdoor_effects.current_step_datum, /datum/time_of_day/dawn))
		var/crazysounds_file = pick(SScrazysounds.night)
	else if(istype(SSoutdoor_effects.current_step_datum, /datum/time_of_day/dawndawn))
		var/crazysounds_file = pick(SScrazysounds.night)
*/
	else
		crazysounds_file = pick(SScrazysoundz.day)
	var/cast_crazy_sound
	if(prob(10))
		cast_crazy_sound = 1

	for(var/mob/living/carbon/human/H in world)
		if(H.client)
			if(cast_crazy_sound)
				H.crazysounds.file = crazysounds_file
				H << H.crazysounds

/datum/controller/subsystem/crazysoundz/proc/StopSound()
	for(var/mob/living/carbon/human/H in world)
		if(H.client)
			H.crazysounds.file = null
			H << H.crazysounds

/mob/living/carbon/human/Login()
	..()
	if(!client)
		return
	start_crazy_sounds()

/mob/living/carbon/human/proc/start_crazy_sounds()
	crazysounds.file = null
	crazysounds.wait = 1
	crazysounds.volume = 100
	crazysounds.falloff = 2
	crazysounds.channel = CHANNEL_WEATHEREFFECT
	crazysounds.y = 1