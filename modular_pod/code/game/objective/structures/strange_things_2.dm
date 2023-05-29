/obj/structure/beast/gargotor
	name = "Gargotor"
	desc = "Good old Gargotor."
	icon = 'modular_pod/icons/obj/things/things.dmi'
	icon_state = "gargotor"
	plane = ABOVE_GAME_PLANE
	layer = FLY_LAYER
	anchored = 1
	var/crystal = FALSE
	var/crystalGreen = FALSE
	var/crystalRed = FALSE
	var/crystalBlue = FALSE
	var/crystalPink = FALSE

/obj/structure/beast/gargotor/attackby(obj/item/I, mob/living/carbon/user, params)
	. = ..()
	if(istype(I, /obj/item/crystal/green))
		if(crystal)
			to_chat(user, span_notice("The crystal is already here!"))
			return
		user.visible_message(span_notice("[user] inserts green crystal in Gargotor."),span_notice("You insert green crystal in Gargotor."), span_hear("You hear the sound of inserting."))
		sound_hint()
		playsound(get_turf(src), 'modular_pod/sound/eff/thingg.wav', 100 , FALSE, FALSE)
		crystal = TRUE
		crystalGreen = TRUE
	else if(istype(I, /obj/item/crystal/red))
		if(crystal)
			to_chat(user, span_notice("The crystal is already here!"))
			return
		user.visible_message(span_notice("[user] inserts red crystal in Gargotor."),span_notice("You insert red crystal in Gargotor."), span_hear("You hear the sound of inserting."))
		sound_hint()
		playsound(get_turf(src), 'modular_pod/sound/eff/thingg.wav', 100 , FALSE, FALSE)
		crystal = TRUE
		crystalRed = TRUE
	else if(istype(I, /obj/item/crystal/blue))
		if(crystal)
			to_chat(user, span_notice("The crystal is already here!"))
			return
		user.visible_message(span_notice("[user] inserts blue crystal in Gargotor."),span_notice("You insert blue crystal in Gargotor."), span_hear("You hear the sound of inserting."))
		sound_hint()
		playsound(get_turf(src), 'modular_pod/sound/eff/thingg.wav', 100 , FALSE, FALSE)
		crystal = TRUE
		crystalBlue = TRUE
	else if(istype(I, /obj/item/crystal/pink))
		if(crystal)
			to_chat(user, span_notice("The crystal is already here!"))
			return
		user.visible_message(span_notice("[user] inserts pink crystal in Gargotor."),span_notice("You insert pink crystal in Gargotor."), span_hear("You hear the sound of inserting."))
		sound_hint()
		playsound(get_turf(src), 'modular_pod/sound/eff/thingg.wav', 100 , FALSE, FALSE)
		crystal = TRUE
		crystalPink = TRUE
	else if(istype(I, /obj/item/shard/crystal/green))
		if(crystalGreen)
			new /obj/item/stack/medical/gauze/improvised/one(get_turf(user))
			qdel(I)
			crystalGreen = FALSE
			crystal = FALSE
			sound_hint()
			playsound(get_turf(src), 'modular_pod/sound/eff/thingg.wav', 100 , FALSE, FALSE)
	else if(istype(I, /obj/item/shard/crystal/green))
		if(crystalBlue)
			new /obj/item/stack/medical/suture/one(get_turf(user))
			qdel(I)
			crystalBlue = FALSE
			crystal = FALSE
			sound_hint()
			playsound(get_turf(src), 'modular_pod/sound/eff/thingg.wav', 100 , FALSE, FALSE)
	else if(istype(I, /obj/item/shard/crystal/green))
		if(crystalRed)
			new /obj/item/stack/medical/mesh/one(get_turf(user))
			qdel(I)
			crystalRed = FALSE
			crystal = FALSE
			sound_hint()
			playsound(get_turf(src), 'modular_pod/sound/eff/thingg.wav', 100 , FALSE, FALSE)
	else if(istype(I, /obj/item/shard/crystal/green))
		if(crystalPink)
			new /obj/item/stack/medical/splint/one(get_turf(user))
			qdel(I)
			crystalPink = FALSE
			crystal = FALSE
			sound_hint()
			playsound(get_turf(src), 'modular_pod/sound/eff/thingg.wav', 100 , FALSE, FALSE)
	else if(istype(I, /obj/item/shard/crystal/blue))
		if(crystalRed)
			new /obj/item/clothing/shoes/laceup(get_turf(user))
			qdel(I)
			crystalRed = FALSE
			crystal = FALSE
			sound_hint()
			playsound(get_turf(src), 'modular_pod/sound/eff/thingg.wav', 100 , FALSE, FALSE)
	else if(istype(I, /obj/item/shard/crystal/blue))
		if(crystalPink)
			new /obj/item/clothing/pants/venturer(get_turf(user))
			qdel(I)
			crystalPink = FALSE
			crystal = FALSE
			sound_hint()
			playsound(get_turf(src), 'modular_pod/sound/eff/thingg.wav', 100 , FALSE, FALSE)
	else if(istype(I, /obj/item/shard/crystal/blue))
		if(crystalGreen)
			new /obj/item/clothing/under/venturerclassic(get_turf(user))
			qdel(I)
			crystalGreen = FALSE
			crystal = FALSE
			sound_hint()
			playsound(get_turf(src), 'modular_pod/sound/eff/thingg.wav', 100 , FALSE, FALSE)
	else if(istype(I, /obj/item/shard/crystal/blue))
		if(crystalBlue)
			new /obj/item/knife/combat/goldenmisericorde(get_turf(user))
			qdel(I)
			crystalBlue = FALSE
			crystal = FALSE
			sound_hint()
			playsound(get_turf(src), 'modular_pod/sound/eff/thingg.wav', 100 , FALSE, FALSE)

/obj/structure/beast/gargotor/attack_hand(mob/living/carbon/user, list/modifiers)
	. = ..()
	if(.)
		return
	if(user.a_intent == INTENT_GRAB)
		if(crystal)
			if(crystalBlue)
				new /obj/item/crystal/blue(get_turf(user))
				playsound(get_turf(src), 'modular_pod/sound/eff/crystalHERE.wav', 100 , FALSE, FALSE)
				sound_hint()
				crystal = FALSE
				crystalBlue = FALSE
			else if(crystalRed)
				new /obj/item/crystal/red(get_turf(user))
				playsound(get_turf(src), 'modular_pod/sound/eff/crystalHERE.wav', 100 , FALSE, FALSE)
				sound_hint()
				crystal = FALSE
				crystalRed = FALSE
			else if(crystalGreen)
				new /obj/item/crystal/green(get_turf(user))
				playsound(get_turf(src), 'modular_pod/sound/eff/crystalHERE.wav', 100 , FALSE, FALSE)
				sound_hint()
				crystal = FALSE
				crystalGreen = FALSE
			else if(crystalPink)
				new /obj/item/crystal/pink(get_turf(user))
				playsound(get_turf(src), 'modular_pod/sound/eff/crystalHERE.wav', 100 , FALSE, FALSE)
				sound_hint()
				crystal = FALSE
				crystalPink = FALSE

/obj/structure/beast/gargotor/examine(mob/user)
	. = ..()
	if(crystalBlue)
		. += "<span class='notice'>Here is blue crystal.</span>"
	else if(crystalGreen)
		. += "<span class='notice'>Here is green crystal.</span>"
	else if(crystalPink)
		. += "<span class='notice'>Here is pink crystal.</span>"
	else if(crystalRed)
		. += "<span class='notice'>Here is red crystal.</span>"

/obj/item/seeding/midnightberryseeds
	name = "Seeds"
	desc = "Midnightberry seeds!"
	icon = 'modular_pod/icons/obj/things/things.dmi'
	icon_state = "seeds"

/obj/item/stupidbottles/bluebottle
	name = "Blue Bottle"
	desc = "Interesting mixture."
	icon = 'modular_pod/icons/obj/things/things.dmi'
	icon_state = "bluebottle"
	var/empty = FALSE

/obj/item/stupidbottles/bluebottle/examine(mob/user)
	. = ..()
	if(empty)
		. += "<span class='notice'>Its empty.</span>"