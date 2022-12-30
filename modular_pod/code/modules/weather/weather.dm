var/global/israin = 0

/turf
	var/rained = 0
	var/outdoor = 0

/client
	var/list/rain_overlays = list()

/mob/living/carbon/human
	var/sound/rain = sound()
	var/sound/rain_wind = sound()
	var/sound/rain_thunder = sound()


SUBSYSTEM_DEF(weatherr)
	name = "Weatherr"
	priority = 2
	wait = 59
	flags = SS_TICKER
	var/obj/rain = null
	var/starttime = 0
	var/lasttime = 0
	var/duration = 15000
	var/cooldown = 30000
	var/list/wturfs = list()

	var/list/thunder = list('sound/stalker/weather/thunder_1.ogg','sound/stalker/weather/thunder_2.ogg','sound/stalker/weather/thunder_3.ogg','sound/stalker/weather/thunder_4.ogg'\
							,'sound/stalker/weather/thunder_5.ogg','sound/stalker/weather/thunder_6.ogg','sound/stalker/weather/thunder_7.ogg')

	var/list/wind = list('sound/stalker/weather/wind_1.ogg','sound/stalker/weather/wind_2.ogg','sound/stalker/weather/wind_3.ogg','sound/stalker/weather/wind_4.ogg',\
						'sound/stalker/weather/wind_5.ogg','sound/stalker/weather/wind_6.ogg')


/datum/controller/subsystem/weatherr/Initialize()
	cooldown = rand(8000, 9900)
	duration = rand(3500, 4250)
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

/datum/controller/subsystem/weatherr/fire()
/*
	if(world.time >= (lasttime + cooldown*0.9))
		if(!SStext.pre_rained)
			SStext.pre_rain()
*/
	if(world.time >= (lasttime + cooldown))
		if(!israin)
			starttime = world.time
			israin = 1
			StartRain()
			StartSound()

	if(world.time >= (starttime + duration))
		if(israin)
			lasttime = world.time
			israin = 0
			StopRain()
			StopSound()

	if(israin)
		HandleSound()

/datum/controller/subsystem/weatherr/proc/StartRain()
	rain.icon_state = "rain"
	for(var/area/maintenance/polovich/forest/rain/A in world)
		for(var/turf/open/floor/plating/polovich/T in A.contents)
			T.rained = 1
/*
			if(istype(T, /turf/open/floor/plating/polovich/dirt/dark/gryazka))
				var/turf/open/floor/plating/polovich/dirt/dark/gryazka/AT = T
				if(AT)
					spawn(rand(200,400))
						AT.icon_state = "[AT.icon_state]_water"
*/
			CHECK_TICK
/*
	for(var/client/C in GLOB.clients)
		if(istype(C.mob, /mob/living/carbon/human))
			for(var/turf/stalker/T in range(7, C.mob.loc))
				if(T.rained)
					var/image/I = image('icons/stalker/structure/decor.dmi', T, "rain", layer = 10)
					if(I)
						if(!C.rain_overlays.Find("[T.x],[T.y],[T.z]"))
							C.rain_overlays["[T.x],[T.y],[T.z]"] = I
							C.images |= C.rain_overlays["[T.x],[T.y],[T.z]"]
*/
//Stext.rain_start()

/datum/controller/subsystem/weatherr/proc/StopRain()
	rain.icon_state = ""
	for(var/area/maintenance/polovich/forest/rain/A in world)
		for(var/turf/open/floor/plating/polovich/T in A.contents)
			T.rained = 0
/*
			if(istype(T, /turf/open/floor/plating/polovich/dirt/dark/gryazka))
				var/turf/open/floor/plating/polovich/dirt/dark/gryazka/AT = T
				if(AT)
					spawn(rand(3000,6000))
//						AT.icon_state = "[copytext("[AT.AP.icon_state]",1,5)]"
						AT.icon_state = "blackgryaz"
						AT.dir = rand(0, 4)
//						AT.dir = rand(0,4)
*/
//			CHECK_TICK
/*
	for(var/client/C in GLOB.clients)
		C.images &= C.hidingAtoms
		C.rain_overlays.Cut()
*/
	cooldown = rand(7000, 9000)
	duration = rand(1000, 2000)

/datum/controller/subsystem/weatherr/proc/StartSound()
	for(var/mob/living/carbon/human/H in GLOB.alive_mob_list)
		if(H.client)
			H.start_rain_sound()

/datum/controller/subsystem/weatherr/proc/HandleSound()
	var/rain_thunder_file = pick(SSweatherr.thunder)
	var/rain_wind_file = pick(SSweatherr.wind)
	var/cast_rain = 0
	var/cast_wind = 0
	if(prob(10))
		cast_rain = 1
	if(prob(20))
		cast_wind = 1

	for(var/mob/living/carbon/human/H in world)
		if(H.client)

			H << H.rain

			if(cast_rain)
				H.rain_thunder.file = rain_thunder_file
				H << H.rain_thunder
			if(cast_wind)
				H.rain_wind.file = rain_wind_file
				H << H.rain_wind

/datum/controller/subsystem/weatherr/proc/StopSound()
	for(var/mob/living/carbon/human/H in world)
		if(H.client)

			H.rain.status = 0
			H.rain.file = null
			H << H.rain
			H.rain_thunder.file = null
			H << H.rain_thunder
			H.rain_wind.file = null
			H << H.rain_wind



/mob/living/carbon/human/Login()
	..()
	if(!client)
		return
	if(israin)
		start_rain_sound()
		for(var/turf/open/floor/plating/polovich/T in range(7,src))
			if(T.rained)
				var/image/I = image('icons/stalker/structure/decor.dmi', T, "rain", layer = TURF_FIRE_LAYER)
				if(I)
					if(!client.rain_overlays.Find("[T.x],[T.y],[T.z]"))
						client.rain_overlays["[T.x],[T.y],[T.z]"] = I
						client.images -= client.rain_overlays["[T.x],[T.y],[T.z]"]
						client.images |= client.rain_overlays["[T.x],[T.y],[T.z]"]

/mob/living/carbon/human/proc/start_rain_sound()
	if(!israin)
		return

	rain.status = SOUND_STREAM
	rain.file = 'sound/stalker/weather/new_rain2.ogg'
	rain.repeat = 1
	rain.volume = 50
	rain.falloff = 2
//	rain.channel = SSchannels.CHANNEL_WEATHER(12)
	rain.channel = CHANNEL_WEATHER
	rain.y = 1
	rain.wait = 1
	src << rain

	rain_wind.file = null
	rain_wind.wait = 1
	rain_wind.volume = 100
	rain_wind.falloff = 2
	rain_wind.channel = CHANNEL_WEATHEREFFECT
	rain_wind.y = 1

	rain_thunder.file = null
	rain_thunder.wait = 1
	rain_thunder.volume = 100
	rain_thunder.falloff = 2
	rain_thunder.channel = CHANNEL_WEATHEREFFECTOTHER
	rain_thunder.y = 1
