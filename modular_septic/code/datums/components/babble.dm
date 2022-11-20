#define MAX_BABBLE_CHARACTERS 40

/datum/component/babble
	var/babble_sound_override
	var/babble_sound_male = 'modular_septic/sound/voice/babble/babble_male.wav'
	var/babble_sound_female = 'modular_septic/sound/voice/babble/babble_female.wav'
	var/babble_sound_agender = 'modular_septic/sound/voice/babble/babble_agender.wav'
	var/volume = BABBLE_DEFAULT_VOLUME
	var/duration = BABBLE_DEFAULT_DURATION
	var/last_babble = 0

/datum/component/babble/Initialize(babble_sound_override, \
								babble_sound_male = 'modular_septic/sound/voice/babble/babble_male.wav', \
								babble_sound_female = 'modular_septic/sound/voice/babble/babble_female.wav', \
								babble_sound_agender = 'modular_septic/sound/voice/babble/babble_agender.wav', \
								volume = BABBLE_DEFAULT_VOLUME, \
								duration = BABBLE_DEFAULT_DURATION)
	. = ..()
	if(!ismob(parent))
		return COMPONENT_INCOMPATIBLE
	src.babble_sound_override = babble_sound_override
	src.babble_sound_male = babble_sound_male
	src.babble_sound_female = babble_sound_female
	src.babble_sound_agender = babble_sound_agender
	src.volume = volume
	src.duration = duration

/datum/component/babble/RegisterWithParent()
	. = ..()
	RegisterSignal(parent, COMSIG_MOB_POST_SAY, .proc/after_say)

/datum/component/babble/UnregisterFromParent()
	. = ..()
	UnregisterSignal(parent, COMSIG_MOB_POST_SAY)

/datum/component/babble/proc/after_say(mob/babbler, list/speech_args, list/speech_spans, list/speech_mods)
	SIGNAL_HANDLER

	last_babble = world.time
	INVOKE_ASYNC(src, .proc/handle_babbling, babbler, speech_args, speech_spans, speech_mods)

/datum/component/babble/proc/handle_babbling(mob/babbler, list/speech_args, list/speech_spans, list/speech_mods)
	var/message = speech_args[SPEECH_MESSAGE]
	var/initial_babble_time = last_babble
	var/initial_babble_sound = babble_sound_override
	if(!initial_babble_sound)
		switch(babbler.gender)
			if(MALE)
				initial_babble_sound = babble_sound_male
			if(FEMALE)
				initial_babble_sound = babble_sound_female
			else
				initial_babble_sound = babble_sound_agender
	var/initial_volume = volume
	if(speech_mods[WHISPER_MODE])
		initial_volume -= 30
	else if(speech_spans[SPAN_YELL])
		initial_volume += 30
	var/initial_pitch = 0
	var/obj/item/clothing/mask/mask = babbler.get_item_by_slot(ITEM_SLOT_MASK)
	if(istype(mask) && mask.lowers_pitch && !mask.mask_adjusted)
		initial_pitch -= 10
	var/initial_delay = duration
	var/list/hearers = GLOB.player_list.Copy()
	for(var/mob/hearer as anything in hearers)
		if(hearer.client && hearer.can_hear())
			continue
		hearers -= hearer
	var/babble_delay_cumulative = 0
	for(var/i in 1 to min(length(message), MAX_BABBLE_CHARACTERS))
		var/volume = initial_volume
		var/pitch = initial_pitch
		var/current_delay = initial_delay
		switch(lowertext(message[i]))
			if("!")
				pitch += 16
			if("a")
				pitch += 12
			if("b")
				pitch += 11
			if("c")
				pitch += 10
			if("d")
				pitch += 9
			if("e")
				pitch += 8
			if("f")
				pitch += 7
			if("g")
				pitch += 6
			if("h")
				pitch += 5
			if("i")
				pitch += 4
			if("j")
				pitch += 3
			if("k")
				pitch += 2
			if("m")
				pitch += 1
			if("n")
				pitch -= 1
			if("o")
				pitch -= 2
			if("p")
				pitch -= 3
			if("q")
				pitch -= 4
			if("r")
				pitch -= 5
			if("s")
				pitch -= 6
			if("t")
				pitch -= 7
			if("u")
				pitch -= 8
			if("v")
				pitch -= 9
			if("w")
				pitch -= 10
			if("x")
				pitch -= 11
			if("y")
				pitch -= 12
			if("z")
				pitch -= 13
			if("?")
				pitch -= 16
			if(",", ";", "-")
				pitch -= 2
				current_delay *= 1.5
			if(".")
				pitch -= 4
				current_delay *= 2
			if(" ")
				volume = 0
			else
				pitch = 0
		addtimer(CALLBACK(src, .proc/play_babble, hearers, babbler, pick(initial_babble_sound), volume, pitch, initial_babble_time), babble_delay_cumulative + current_delay)
		babble_delay_cumulative += current_delay

/datum/component/babble/proc/play_babble(list/hearers, mob/babbler, babble_sound, volume, pitch, initial_babble_time)
	if(!volume || (last_babble != initial_babble_time))
		return
	for(var/mob/hearer as anything in hearers)
		hearer.playsound_local(get_turf(babbler), babble_sound, volume, FALSE, pitch)

#undef MAX_BABBLE_CHARACTERS
