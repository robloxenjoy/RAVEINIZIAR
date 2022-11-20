/datum/simcard_virus/memz
	name = "Worm.Nokey.Memz"
	var/stage = 0
	var/activated = FALSE

/datum/simcard_virus/memz/simcard_installed(obj/item/cellphone/new_phone)
	. = ..()
	START_PROCESSING(SScellphone, src)

/datum/simcard_virus/memz/simcard_uninstalled(obj/item/cellphone/new_phone)
	. = ..()
	STOP_PROCESSING(SScellphone, src)

/datum/simcard_virus/memz/process(delta_time)
	if(!parent.parent)
		return PROCESS_KILL
	if(!DT_PROB(2.5, delta_time))
		return
	switch(stage)
		if(0)
			hint(80)
			if(prob(8))
				stage += 1
		if(1)
			hint(80)
			QDEL_NULL(parent.parent.ringtone_soundloop)
			parent.parent.ringtone_soundloop = new /datum/looping_sound/phone_ringtone/hacked(parent.parent, FALSE)
			if(prob(13))
				stage += 1
		if(2)
			hint(50)
			if(prob(18))
				stage += 1
		if(3)
			if(!parent.parent.start_glitching())
				hint(25)
			if(prob(23))
				stage += 1
		if(4)
			parent.parent.begin_selfdestruct()
			STOP_PROCESSING(SScellphone, src)

/datum/simcard_virus/memz/proc/hint(hint_chance = 25)
	if(!prob(hint_chance))
		return
	if(stage <= 2)
		var/scream = pick('modular_septic/sound/efn/virus_scream.ogg', 'modular_septic/sound/efn/virus_scream2.ogg', 'modular_septic/sound/efn/virus_scream3.ogg')
		playsound(parent.parent, scream, rand(5, 19), FALSE)
		parent.parent.audible_message(span_danger("[icon2html(parent.parent, world)] [parent.parent] vibrate[parent.parent.p_s()] quietly."))
	else
		playsound(parent.parent, 'modular_septic/sound/efn/virus_acute.ogg', rand(25, 45), FALSE)
		parent.parent.audible_message(span_danger("[icon2html(parent.parent, world)] [parent.parent] vibrate[parent.parent.p_s()] loudly, [parent.parent.p_their()] screen blinking and glitching!"))
