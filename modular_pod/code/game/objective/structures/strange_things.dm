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

/obj/item/crystal/green
	name = "Crystal"
	desc = "Thanks to this, the dark light will be filled with bright light."
	icon = 'modular_pod/icons/obj/things/things.dmi'
	icon_state = "green_crystal"
	light_range = 3
	light_power = 2
	light_color = "#00dd78"
	light_system = MOVABLE_LIGHT

/obj/item/crystal/red
	name = "Crystal"
	desc = "Thanks to this, the dark light will be filled with bright light."
	icon = 'modular_pod/icons/obj/things/things.dmi'
	icon_state = "red_crystal"
	light_color = "#ff460e"
	light_range = 3
	light_power = 2
	light_system = MOVABLE_LIGHT

/obj/item/crystal/blue
	name = "Crystal"
	desc = "Thanks to this, the dark light will be filled with bright light."
	icon = 'modular_pod/icons/obj/things/things.dmi'
	icon_state = "blue_crystal"
	light_color = "#008eff"
	light_range = 3
	light_power = 2
	light_system = MOVABLE_LIGHT

/obj/item/crystal/pink
	name = "Crystal"
	desc = "Thanks to this, the dark light will be filled with bright light."
	icon = 'modular_pod/icons/obj/things/things.dmi'
	icon_state = "pink_crystal"
	light_color = "#e252ea"
	light_range = 3
	light_power = 2
	light_system = MOVABLE_LIGHT

/*
/obj/structure/crystal_holder
	name = "Wooden Pole"
	desc = "Wooden Crystal holder. Just put a crystal in here."
	icon = 'modular_pod/icons/obj/things/things.dmi'
	icon_state = "crystal-holder-empty"
	anchored = FALSE
	density = TRUE
	plane = ABOVE_GAME_PLANE
	layer = WALL_OBJ_LAYER

	var/obj/item/crystal/green/greeny
	var/obj/item/crystal/red/reddy
	var/obj/item/crystal/blue/bluey
	var/obj/item/crystal/pink/pinky

/obj/structure/crystal_holder/already/green/New()
	..()
	greeny = new(src)
	update_icon()

/obj/structure/crystal_holder/already/red/New()
	..()
	reddy = new(src)
	update_icon()

/obj/structure/crystal_holder/already/blue/New()
	..()
	bluey = new(src)
	update_icon()

/obj/structure/crystal_holder/already/pink/New()
	..()
	pinky = new(src)
	update_icon()

/obj/structure/crystal_holder/update_icon()
	..()
	if(greeny)
		icon_state = "crystal-holder-green"
		set_light(3, 2, "#00dd78")
		switch(dir)
			if(NORTH)
				plane = GAME_PLANE_UPPER_BLOOM
			if(SOUTH)
				plane = ABOVE_FRILL_PLANE_BLOOM
			if(EAST)
				plane = GAME_PLANE_UPPER_BLOOM
			if(WEST)
				plane = GAME_PLANE_UPPER_BLOOM
			else
				plane = ABOVE_FRILL_PLANE_BLOOM
	else if(reddy)
		icon_state = "crystal-holder-red"
		set_light(3, 2, "#ff460e")
		switch(dir)
			if(NORTH)
				plane = GAME_PLANE_UPPER_BLOOM
			if(SOUTH)
				plane = ABOVE_FRILL_PLANE_BLOOM
			if(EAST)
				plane = GAME_PLANE_UPPER_BLOOM
			if(WEST)
				plane = GAME_PLANE_UPPER_BLOOM
			else
				plane = ABOVE_FRILL_PLANE_BLOOM
	else if(bluey)
		icon_state = "crystal-holder-blue"
		set_light(3, 2, "#008eff")
		switch(dir)
			if(NORTH)
				plane = GAME_PLANE_UPPER_BLOOM
			if(SOUTH)
				plane = ABOVE_FRILL_PLANE_BLOOM
			if(EAST)
				plane = GAME_PLANE_UPPER_BLOOM
			if(WEST)
				plane = GAME_PLANE_UPPER_BLOOM
			else
				plane = ABOVE_FRILL_PLANE_BLOOM
	else if(pinky)
		icon_state = "crystal-holder-pink"
		set_light(3, 2, "#e252ea")
		switch(dir)
			if(NORTH)
				plane = GAME_PLANE_UPPER_BLOOM
			if(SOUTH)
				plane = ABOVE_FRILL_PLANE_BLOOM
			if(EAST)
				plane = GAME_PLANE_UPPER_BLOOM
			if(WEST)
				plane = GAME_PLANE_UPPER_BLOOM
			else
				plane = ABOVE_FRILL_PLANE_BLOOM
	else
		icon_state = "crystal-holder-empty"
		set_light(0, 0, null)

/obj/structure/crystal_holder/proc/insert_crystal_green(obj/item/crystal/green/T)
	T.forceMove(src)
	greeny = T
	update_icon()
	playsound(src, 'sound/items/torch_fixture1.ogg', 50, TRUE)

/obj/structure/crystal_holder/proc/insert_crystal_red(obj/item/crystal/red/T)
	T.forceMove(src)
	reddy = T
	update_icon()
	playsound(src, 'sound/items/torch_fixture1.ogg', 50, TRUE)

/obj/structure/crystal_holder/proc/insert_crystal_blue(obj/item/crystal/blue/T)
	T.forceMove(src)
	bluey = T
	update_icon()
	playsound(src, 'sound/items/torch_fixture1.ogg', 50, TRUE)

/obj/structure/crystal_holder/proc/insert_crystal_pink(obj/item/crystal/pink/T)
	T.forceMove(src)
	pinky = T
	update_icon()
	playsound(src, 'sound/items/torch_fixture1.ogg', 50, TRUE)

/obj/structure/crystal_holder/attackby(obj/item/W, mob/user)
	if(istype(W, /obj/item/crystal/green))
		if(greeny || bluey || reddy || pinky)
			return
		else
			insert_crystal_green(W)
	else if(istype(W, /obj/item/crystal/blue))
		if(greeny || bluey || reddy || pinky)
			return
		else
			insert_crystal_blue(W)
	else if(istype(W, /obj/item/crystal/red))
		if(greeny || bluey || reddy || pinky)
			return
		else
			insert_crystal_red(W)
	else if(istype(W, /obj/item/crystal/pink))
		if(greeny || bluey || reddy || pinky)
			return
		else
			insert_crystal_pink(W)

	src.add_fingerprint(user)
	update_icon()

/obj/structure/crystal_holder/proc/remove_green()
	. = greeny
	greeny.update_icon()
	greeny = null
	update_icon()
	playsound(src, 'sound/items/torch_fixture0.ogg', 50, TRUE)

/obj/structure/crystal_holder/proc/remove_blue()
	. = bluey
	bluey.update_icon()
	bluey = null
	update_icon()
	playsound(src, 'sound/items/torch_fixture0.ogg', 50, TRUE)

/obj/structure/crystal_holder/proc/remove_red()
	. = reddy
	reddy.update_icon()
	reddy = null
	update_icon()
	playsound(src, 'sound/items/torch_fixture0.ogg', 50, TRUE)

/obj/structure/crystal_holder/proc/remove_pink()
	. = pinky
	pinky.update_icon()
	pinky = null
	update_icon()
	playsound(src, 'sound/items/torch_fixture0.ogg', 50, TRUE)

/obj/structure/crystal_holder/attack_hand(mob/user)

	add_fingerprint(user)
/*
	if(!greeny || !reddy || !pinky || !bluey)
		to_chat(user, "There is no crystal here.")
		return
*/
	if(greeny)
		user.put_in_active_hand(remove_green())
	else if(reddy)
		user.put_in_active_hand(remove_red())
	else if(bluey)
		user.put_in_active_hand(remove_blue())
	else if(pinky)
		user.put_in_active_hand(remove_pink())

/obj/structure/crystal_holder/deconstruct(disassembled = TRUE)
	if(!(flags_1 & NODECONSTRUCT_1))
		if(greeny)
			new /obj/item/crystal/green(get_turf(src))
		if(reddy)
			new /obj/item/crystal/red(get_turf(src))
		if(bluey)
			new /obj/item/crystal/blue(get_turf(src))
		if(pinky)
			new /obj/item/crystal/pink(get_turf(src))
	qdel(src)

*/

/obj/structure/crystals_ground
	var/crystal_amount = 3

/obj/structure/crystals_ground/green
	name = "Green Crystals"
	desc = "Crystals sticking out of the ground."
	icon = 'modular_pod/icons/obj/things/things.dmi'
	icon_state = "green_crystals"
	anchored = TRUE
	density = FALSE
	plane = ABOVE_GAME_PLANE
	layer = FLY_LAYER
	light_range = 1
	light_power = 1
	light_color = "#00dd78"

/obj/structure/crystals_ground/green/attackby(obj/item/W, mob/living/carbon/user)
	if(istype(W, /obj/item/changeable_attacks/slashstab/knife/small/steel))
		if(W.hitsound)
			playsound(get_turf(src), 'modular_septic/sound/weapons/melee/hitree.ogg', 100, FALSE, FALSE)
		user.visible_message(span_notice("[user] begins to uproot [src] with [W]."),span_notice("You begin to uproot [src] with [W]."), span_hear("You hear the sound of uprooting."))
		user.changeNext_move(W.attack_delay)
		user.adjustFatigueLoss(W.attack_fatigue_cost)
		W.damageItem("SOFT")
		sound_hint()
		if(do_after(user, 1000/W.force, target = src))
			user.visible_message(span_notice("[user] uprooted [src] with the [W]."),span_notice("You uprooted [src] with the [W]."), span_hear("You hear the sound of uprooting."))
			user.changeNext_move(W.attack_delay)
			user.adjustFatigueLoss(W.attack_fatigue_cost)
			W.damageItem("HARD")
			sound_hint()
			for(var/i=1 to crystal_amount)
				new /obj/item/crystal/green(get_turf(src))
			qdel(src)

/obj/structure/crystals_ground/red
	name = "Red Crystals"
	desc = "Crystals sticking out of the ground."
	icon = 'modular_pod/icons/obj/things/things.dmi'
	icon_state = "red_crystals"
	anchored = TRUE
	density = FALSE
	plane = ABOVE_GAME_PLANE
	layer = FLY_LAYER
	light_range = 1
	light_power = 1
	light_color = "#ff460e"

/obj/structure/crystals_ground/red/attackby(obj/item/W, mob/living/carbon/user)
	if(istype(W, /obj/item/changeable_attacks/slashstab/knife/small/steel))
		if(W.hitsound)
			playsound(get_turf(src), 'modular_septic/sound/weapons/melee/hitree.ogg', 100, FALSE, FALSE)
		user.visible_message(span_notice("[user] begins to uproot [src] with [W]."),span_notice("You begin to uproot [src] with [W]."), span_hear("You hear the sound of uprooting."))
		user.changeNext_move(W.attack_delay)
		user.adjustFatigueLoss(W.attack_fatigue_cost)
		W.damageItem("SOFT")
		sound_hint()
		if(do_after(user, 1000/W.force, target = src))
			user.visible_message(span_notice("[user] uprooted [src] with the [W]."),span_notice("You uprooted [src] with the [W]."), span_hear("You hear the sound of uprooting."))
			user.changeNext_move(W.attack_delay)
			user.adjustFatigueLoss(W.attack_fatigue_cost)
			W.damageItem("HARD")
			sound_hint()
			for(var/i=1 to crystal_amount)
				new /obj/item/crystal/red(get_turf(src))
			qdel(src)

/obj/structure/crystals_ground/blue
	name = "Blue Crystals"
	desc = "Crystals sticking out of the ground."
	icon = 'modular_pod/icons/obj/things/things.dmi'
	icon_state = "blue_crystals"
	anchored = TRUE
	density = FALSE
	plane = ABOVE_GAME_PLANE
	layer = FLY_LAYER
	light_range = 1
	light_power = 1
	light_color = "#008eff"

/obj/structure/crystals_ground/blue/attackby(obj/item/W, mob/living/carbon/user)
	if(istype(W, /obj/item/changeable_attacks/slashstab/knife/small/steel))
		if(W.hitsound)
			playsound(get_turf(src), 'modular_septic/sound/weapons/melee/hitree.ogg', 100, FALSE, FALSE)
		user.visible_message(span_notice("[user] begins to uproot [src] with [W]."),span_notice("You begin to uproot [src] with [W]."), span_hear("You hear the sound of uprooting."))
		user.changeNext_move(W.attack_delay)
		user.adjustFatigueLoss(W.attack_fatigue_cost)
		W.damageItem("SOFT")
		sound_hint()
		if(do_after(user, 1000/W.force, target = src))
			user.visible_message(span_notice("[user] uprooted [src] with the [W]."),span_notice("You uprooted [src] with the [W]."), span_hear("You hear the sound of uprooting."))
			user.changeNext_move(W.attack_delay)
			user.adjustFatigueLoss(W.attack_fatigue_cost)
			W.damageItem("HARD")
			sound_hint()
			for(var/i=1 to crystal_amount)
				new /obj/item/crystal/blue(get_turf(src))
			qdel(src)

/obj/structure/crystals_ground/pink
	name = "Pink Crystals"
	desc = "Crystals sticking out of the ground."
	icon = 'modular_pod/icons/obj/things/things.dmi'
	icon_state = "pink_crystals"
	anchored = TRUE
	density = FALSE
	plane = ABOVE_GAME_PLANE
	layer = FLY_LAYER
	light_range = 1
	light_power = 1
	light_color = "#e252ea"

/obj/structure/crystals_ground/pink/attackby(obj/item/W, mob/living/carbon/user)
	if(istype(W, /obj/item/changeable_attacks/slashstab/knife/small/steel))
		if(W.hitsound)
			playsound(get_turf(src), 'modular_septic/sound/weapons/melee/hitree.ogg', 100, FALSE, FALSE)
		user.visible_message(span_notice("[user] begins to uproot [src] with [W]."),span_notice("You begin to uproot [src] with [W]."), span_hear("You hear the sound of uprooting."))
		user.changeNext_move(W.attack_delay)
		user.adjustFatigueLoss(W.attack_fatigue_cost)
		W.damageItem("SOFT")
		sound_hint()
		if(do_after(user, 1000/W.force, target = src))
			user.visible_message(span_notice("[user] uprooted [src] with the [W]."),span_notice("You uprooted [src] with the [W]."), span_hear("You hear the sound of uprooting."))
			user.changeNext_move(W.attack_delay)
			user.adjustFatigueLoss(W.attack_fatigue_cost)
			W.damageItem("HARD")
			sound_hint()
			for(var/i=1 to crystal_amount)
				new /obj/item/crystal/pink(get_turf(src))
			qdel(src)