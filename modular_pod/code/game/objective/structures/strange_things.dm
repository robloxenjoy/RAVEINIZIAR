/obj/structure/beast/heck
	name = "Neptunian Heck"
	desc = "A creature that is dug into the dirt. Interesting."
	icon = 'modular_pod/icons/obj/things/things.dmi'
	icon_state = "neptunian_heck"
	plane = ABOVE_GAME_PLANE
	layer = FLY_LAYER
	var/voice = 'modular_pod/sound/eff/good_voice.wav'
	var/uncosc = TRUE
	var/last_words = 0
	var/words_delay = 4000
	var/words_list = list("I am stuck here.", "I have numb body.", "Can someone give me a halyab egg to eat?", "Chaots are idiots, you don’t even suspect why they need these weird eggs.", "I hate this shitty half-chaos.", "I want to go home to Neptune, but I'm cursed.")

/obj/structure/beast/heck/proc/speak(message)
	say(message)

/obj/structure/beast/heck/Initialize()
	. = ..()
	if(uncosc = TRUE)
		if(istype(SSoutdoor_effects.current_step_datum, /datum/time_of_day/night))
			uncocs = FALSE
			if(last_words + words_delay <= world.time && words_list.len > 0 && DT_PROB(2.5, delta_time))
				var/words = pick(words_list)
				speak(words)
				sound_hint()
				playsound(src, voice,  volume, TRUE, vary = FALSE)
				last_words = world.time
		else
			uncosc = TRUE

/obj/structure/beast/heck/attackby(obj/item/I, mob/living/user, params)
	. = ..()
	if(istype(I, /obj/item/halyabegg))
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