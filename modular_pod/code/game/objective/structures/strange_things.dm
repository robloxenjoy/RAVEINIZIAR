/obj/structure/beast/heck
	name = "Neptunian Heck"
	desc = "A creature that is dug into the dirt. Interesting."
	icon = 'modular_pod/icons/obj/things/things.dmi'
	icon_state = "neptunian_heck_uncosc"
	plane = ABOVE_GAME_PLANE
	layer = FLY_LAYER
	var/uncosc = TRUE
	var/last_words = 0
	var/words_delay = 4000
	var/words_list = list("I am stuck here.", "I have numb body.", "Can someone give me a halyab egg to eat?", "Chaots are idiots, you don’t even suspect why they need these weird eggs.", "I hate this shitty half-chaos.", "I want to go home to Neptune, but I'm cursed.")

/obj/structure/beast/heck/proc/speak(message)
	say(message)

/obj/structure/beast/heck/Initialize()
	. = ..()
	if(uncosc == TRUE)
		if(istype(SSoutdoor_effects.current_step_datum, /datum/time_of_day/night))
			uncosc = FALSE
			icon_state = "neptunian_heck"
			if(last_words + words_delay <= world.time && prob(50))
				var/words = pick(words_list)
				speak(words)
				sound_hint()
				playsound(src, 'modular_pod/sound/eff/good_voice.wav', 55, FALSE)
				last_words = world.time
		else
			icon_state = "neptunian_heck_uncosc"
			uncosc = TRUE

/obj/structure/beast/heck/attackby(obj/item/I, mob/living/user, params)
	. = ..()
	if(istype(I, /obj/item/halyabegg))
		if(uncosc == TRUE)
			return
		user.visible_message(span_notice("[user] starts feeding the Neptunian Heck with [I]."),span_notice("You begin feed [src] with [I]."), span_hear("You hear the sound of feeding."))
		if(do_after(user, 5 SECONDS, target = src))
			to_chat(user, span_notice("You finish feeding [src]."))
			sound_hint()
			playsound(get_turf(src), 'modular_pod/sound/eff/eat.wav', 100 , FALSE, FALSE)
			new /obj/item/gun/energy/remis/siren(get_turf(user))
			var/thankyou_words = pick("Thank you for this shitty egg!", "Oh, fantastic!", "Hmmm, the gift!")
			speak(thankyou_words)
			qdel(I)
	else
		if(uncosc == FALSE)
			var/bad_words = pick("WHAT?!", "WHAT ARE YOU DOING?!", "STOP!", "OH FUCK!", "FUCK!", "PLEASE, NO!!!")
			speak(bad_words)
			playsound(get_turf(src), 'modular_pod/sound/eff/painy.wav', 100 , FALSE, FALSE)

/obj/structure/beast/heck/examine(mob/user)
	. = ..()
	if(uncosc)
		. += span_notice("This heck is sleeping.")

/obj/structure/beast/heck/play_attack_sound(damage_amount, damage_type = BRUTE, damage_flag = 0)
	switch(damage_type)
		if(BRUTE)
			if(damage_amount)
				playsound(src, 'sound/effects/attackblob.ogg', 100, TRUE)
			else
				playsound(src, 'sound/weapons/tap.ogg', 50, TRUE)
		if(BURN)
			if(damage_amount)
				playsound(src, 'sound/items/welder.ogg', 100, TRUE)

/obj/structure/beast/heck/deconstruct(disassembled = TRUE)
	if(!(flags_1 & NODECONSTRUCT_1))
		new /obj/item/organ/anus(get_turf(src))
		new /obj/effect/decal/cleanable/spacespot(get_turf(src))
		playsound(src,'modular_pod/sound/eff/death.wav', 50, TRUE)
	qdel(src)

/obj/structure/beast/songster
	name = "Songster"
	desc = "This hums something beautiful."
	icon = 'modular_pod/icons/obj/things/things.dmi'
	icon_state = "songster"
	plane = ABOVE_GAME_PLANE
	layer = FLY_LAYER
	var/enabled = FALSE
	var/list/rangers = list()
	var/volume = 50

/obj/structure/beast/songster/play_attack_sound(damage_amount, damage_type = BRUTE, damage_flag = 0)
	switch(damage_type)
		if(BRUTE)
			if(damage_amount)
				playsound(src, 'sound/effects/attackblob.ogg', 100, TRUE)
			else
				playsound(src, 'sound/weapons/tap.ogg', 50, TRUE)
		if(BURN)
			if(damage_amount)
				playsound(src, 'sound/items/welder.ogg', 100, TRUE)

/obj/structure/beast/songster/deconstruct(disassembled = TRUE)
	if(!(flags_1 & NODECONSTRUCT_1))
		new /obj/item/organ/nerve/neck/robot(get_turf(src))
		new /obj/effect/decal/cleanable/vomit(get_turf(src))
		playsound(src,'modular_pod/sound/eff/death_sing.wav', 50, TRUE)
		song_over()
	qdel(src)

/obj/structure/beast/songster/proc/song_over()
	for(var/mob/living/L in rangers)
		if(!L || !L.client)
			continue
		L.stop_sound_channel(CHANNEL_JUKEBOX)
	rangers = list()

/obj/structure/beast/songster/attack_hand(mob/living/carbon/user, list/modifiers)
	. = ..()
	if(user.a_intent == INTENT_HELP)
		user.visible_message(span_notice("[user] strokes Songster."),span_notice("You stroke Songster."), span_hear("You hear cute sound."))
		if(enabled == FALSE)
			START_PROCESSING(SSobj, src)
		else
			STOP_PROCESSING(SSobj, src)
			song_over()

/obj/structure/beast/songster/process()
	if(enabled == TRUE)
		for(var/mob/M in range(10,src))
			if(!M.client || !(M.client.prefs.toggles & SOUND_INSTRUMENTS))
				continue
			if(!(M in rangers))
				rangers[M] = TRUE
				M.playsound_local(get_turf(M), null, volume, channel = CHANNEL_JUKEBOX, 'modular_pod/sound/mus/radioakt.ogg', use_reverb = TRUE)
		for(var/mob/L in rangers)
			if(get_dist(src,L) > 10)
				rangers -= L
				if(!L || !L.client)
					continue
				L.stop_sound_channel(CHANNEL_JUKEBOX)

/obj/structure/halo
	name = "Halo"
	desc = "Where does it come from?"
	icon = 'modular_pod/icons/obj/things/things.dmi'
	icon_state = "shine_white"
	density = FALSE
	resistance_flags = INDESTRUCTIBLE | FIRE_PROOF | ACID_PROOF | LAVA_PROOF
	anchored = TRUE
	layer = CLOSED_TURF_LAYER

/obj/structure/halo/black
	icon_state = "shine_black"

/obj/structure/halo/red
	icon_state = "shine_red"

/obj/structure/halo/whiteblack
	icon_state = "shine_whiteblack"

/obj/structure/halo/shine_whiteblack_two
	icon_state = "shine_whiteblack_two"

/obj/structure/halo/shine_whiteblack_three
	icon_state = "shine_whiteblack_three"