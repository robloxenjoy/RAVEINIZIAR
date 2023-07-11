/obj/structure/beast/gargotor
	name = "Gargotor"
	desc = "Good old Gargotor."
	icon = 'modular_pod/icons/obj/things/things.dmi'
	icon_state = "gargotor"
	plane = ABOVE_GAME_PLANE
	layer = FLY_LAYER
	anchored = 1
	density = 1
	var/crystal = FALSE
	var/crystalGreen = FALSE
	var/crystalRed = FALSE
	var/crystalBlue = FALSE
	var/crystalPink = FALSE

/obj/structure/beast/gargotor/attackby(obj/item/I, mob/living/carbon/user, params)
	. = ..()
	if(istype(I, /obj/item/crystal/green))
		if(user.a_intent != INTENT_DISARM)
			return
		if(crystal)
			to_chat(user, span_notice("The crystal is already here!"))
			return
		user.visible_message(span_notice("[user] inserts green crystal in Gargotor."),span_notice("You insert green crystal in Gargotor."), span_hear("You hear the sound of inserting."))
		sound_hint()
		playsound(get_turf(src), 'modular_pod/sound/eff/thingg.wav', 100 , FALSE, FALSE)
		qdel(I)
		crystal = TRUE
		crystalGreen = TRUE
	else if(istype(I, /obj/item/crystal/red))
		if(user.a_intent != INTENT_DISARM)
			return
		if(crystal)
			to_chat(user, span_notice("The crystal is already here!"))
			return
		user.visible_message(span_notice("[user] inserts red crystal in Gargotor."),span_notice("You insert red crystal in Gargotor."), span_hear("You hear the sound of inserting."))
		sound_hint()
		playsound(get_turf(src), 'modular_pod/sound/eff/thingg.wav', 100 , FALSE, FALSE)
		qdel(I)
		crystal = TRUE
		crystalRed = TRUE
	else if(istype(I, /obj/item/crystal/blue))
		if(user.a_intent != INTENT_DISARM)
			return
		if(crystal)
			to_chat(user, span_notice("The crystal is already here!"))
			return
		user.visible_message(span_notice("[user] inserts blue crystal in Gargotor."),span_notice("You insert blue crystal in Gargotor."), span_hear("You hear the sound of inserting."))
		sound_hint()
		playsound(get_turf(src), 'modular_pod/sound/eff/thingg.wav', 100 , FALSE, FALSE)
		qdel(I)
		crystal = TRUE
		crystalBlue = TRUE
	else if(istype(I, /obj/item/crystal/pink))
		if(user.a_intent != INTENT_DISARM)
			return
		if(crystal)
			to_chat(user, span_notice("The crystal is already here!"))
			return
		user.visible_message(span_notice("[user] inserts pink crystal in Gargotor."),span_notice("You insert pink crystal in Gargotor."), span_hear("You hear the sound of inserting."))
		sound_hint()
		playsound(get_turf(src), 'modular_pod/sound/eff/thingg.wav', 100 , FALSE, FALSE)
		qdel(I)
		crystal = TRUE
		crystalPink = TRUE
	else if(istype(I, /obj/item/shard/crystal/green))
		if(crystalGreen)
			if(user.a_intent != INTENT_DISARM)
				return
			new /obj/item/stack/medical/gauze/improvised/one(get_turf(user))
			qdel(I)
			crystalGreen = FALSE
			crystal = FALSE
			sound_hint()
			playsound(get_turf(src), 'modular_pod/sound/eff/thingg.wav', 100 , FALSE, FALSE)
	else if(istype(I, /obj/item/shard/crystal/green))
		if(crystalBlue)
			if(user.a_intent != INTENT_DISARM)
				return
			new /obj/item/stack/medical/suture/one(get_turf(user))
			qdel(I)
			crystalBlue = FALSE
			crystal = FALSE
			sound_hint()
			playsound(get_turf(src), 'modular_pod/sound/eff/thingg.wav', 100 , FALSE, FALSE)
	else if(istype(I, /obj/item/shard/crystal/green))
		if(crystalRed)
			if(user.a_intent != INTENT_DISARM)
				return
			new /obj/item/stack/medical/mesh/one(get_turf(user))
			qdel(I)
			crystalRed = FALSE
			crystal = FALSE
			sound_hint()
			playsound(get_turf(src), 'modular_pod/sound/eff/thingg.wav', 100 , FALSE, FALSE)
	else if(istype(I, /obj/item/shard/crystal/green))
		if(crystalPink)
			if(user.a_intent != INTENT_DISARM)
				return
			new /obj/item/stack/medical/splint/one(get_turf(user))
			qdel(I)
			crystalPink = FALSE
			crystal = FALSE
			sound_hint()
			playsound(get_turf(src), 'modular_pod/sound/eff/thingg.wav', 100 , FALSE, FALSE)
	else if(istype(I, /obj/item/shard/crystal/blue))
		if(crystalRed)
			if(user.a_intent != INTENT_DISARM)
				return
			new /obj/item/clothing/shoes/laceup(get_turf(user))
			qdel(I)
			crystalRed = FALSE
			crystal = FALSE
			sound_hint()
			playsound(get_turf(src), 'modular_pod/sound/eff/thingg.wav', 100 , FALSE, FALSE)
	else if(istype(I, /obj/item/shard/crystal/blue))
		if(crystalPink)
			if(user.a_intent != INTENT_DISARM)
				return
			new /obj/item/clothing/pants/venturer(get_turf(user))
			qdel(I)
			crystalPink = FALSE
			crystal = FALSE
			sound_hint()
			playsound(get_turf(src), 'modular_pod/sound/eff/thingg.wav', 100 , FALSE, FALSE)
	else if(istype(I, /obj/item/shard/crystal/blue))
		if(crystalGreen)
			if(user.a_intent != INTENT_DISARM)
				return
			new /obj/item/clothing/under/venturerclassic(get_turf(user))
			qdel(I)
			crystalGreen = FALSE
			crystal = FALSE
			sound_hint()
			playsound(get_turf(src), 'modular_pod/sound/eff/thingg.wav', 100 , FALSE, FALSE)
	else if(istype(I, /obj/item/shard/crystal/blue))
		if(crystalBlue)
			if(user.a_intent != INTENT_DISARM)
				return
			new /obj/item/knife/combat/goldenmisericorde(get_turf(user))
			qdel(I)
			crystalBlue = FALSE
			crystal = FALSE
			sound_hint()
			playsound(get_turf(src), 'modular_pod/sound/eff/thingg.wav', 100 , FALSE, FALSE)
	else if(istype(I, /obj/item/shard/crystal/purple))
		if(crystalBlue)
			if(user.a_intent != INTENT_DISARM)
				return
			new /obj/item/stupidbottles/bluebottle(get_turf(user))
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

/obj/structure/traphehe/spikes
	name = "Spikes"
	desc = "Don't step on this."
	icon = 'modular_pod/icons/obj/things/things.dmi'
	icon_state = "trap_spikes"
	resistance_flags = FIRE_PROOF
	max_integrity = 50
	density = FALSE
	anchored = TRUE
	var/activated = FALSE

/obj/structure/traphehe/spikes/Initialize(mapload)
	. = ..()
	update_appearance()
	var/static/list/loc_connections = list(
		COMSIG_ATOM_ENTERED = .proc/dont_step,
	)
	AddElement(/datum/element/connect_loc, loc_connections)

/obj/structure/traphehe/spikes/proc/dont_step(datum/source, atom/movable/AM, thrown_at = FALSE)
	SIGNAL_HANDLER
	if(!isturf(loc) || !isliving(AM))
		return
	var/mob/living/L = AM
	if(!thrown_at && L.movement_type & (FLYING|FLOATING)) //don't close the trap if they're flying/floating over it.
		return

	activated = TRUE
	playsound(get_turf(src), 'modular_pod/sound/eff/open_trap.wav', 100 , FALSE, FALSE)
	if(!thrown_at)
		L.visible_message(span_danger("[L] triggers \the [src]."), \
				span_userdanger("You trigger \the [src]!"))
	else
		L.visible_message(span_danger("\The [src] ensnares [L]!"), \
				span_userdanger("\The [src] ensnares you!"))
	if(iscarbon(L))
		var/mob/living/carbon/C = L
		if(C.body_position == STANDING_UP)
			var/obj/item/bodypart/l_foot/lfoot = C.get_bodypart_nostump(BODY_ZONE_PRECISE_L_FOOT)
			if(lfoot)
				C.apply_damage((rand(35, 45) - GET_MOB_ATTRIBUTE_VALUE(C, STAT_ENDURANCE)), BRUTE, BODY_ZONE_PRECISE_L_FOOT, wound_bonus = 5, sharpness = SHARP_POINTY)
			var/obj/item/bodypart/r_foot/rfoot = C.get_bodypart_nostump(BODY_ZONE_PRECISE_R_FOOT)
			if(rfoot)
				C.apply_damage((rand(35, 45) - GET_MOB_ATTRIBUTE_VALUE(C, STAT_ENDURANCE)), BRUTE, BODY_ZONE_PRECISE_R_FOOT, wound_bonus = 5, sharpness = SHARP_POINTY)
		else
			var/obj/item/bodypart/chest/cchest = C.get_bodypart_nostump(BODY_ZONE_CHEST)
			if(cchest)
				C.apply_damage((rand(35, 45) - GET_MOB_ATTRIBUTE_VALUE(C, STAT_ENDURANCE)), BRUTE, BODY_ZONE_CHEST, wound_bonus = 5, sharpness = SHARP_POINTY)
			var/obj/item/bodypart/vitals/vvitals = C.get_bodypart_nostump(BODY_ZONE_PRECISE_VITALS)
			if(vvitals)
				C.apply_damage((rand(35, 45) - GET_MOB_ATTRIBUTE_VALUE(C, STAT_ENDURANCE)), BRUTE, BODY_ZONE_PRECISE_VITALS, wound_bonus = 5, sharpness = SHARP_POINTY)
	activated = FALSE
	playsound(get_turf(src), 'modular_pod/sound/eff/close_trap.wav', 100 , FALSE, FALSE)

/obj/structure/halber_socket
	name = "Socket"
	desc = "WHAT IS IT!!!"
	icon = 'modular_pod/icons/obj/things/things.dmi'
	icon_state = "socket"
	plane = ABOVE_GAME_PLANE
	layer = FLY_LAYER
	density = TRUE
	anchored = TRUE
	var/cracked = TRUE
	var/ready = TRUE

/obj/structure/halber_socket/attack_hand(mob/living/carbon/user, list/modifiers)
	. = ..()
	if(.)
		return
	if(user.incapacitated() || !cracked || !ready)
		return
	if(user.a_intent == INTENT_GRAB)
		user.visible_message(span_notice("[user] begins to pull out the Halbermensch."),span_notice("You begin to pull out the Halbermensch."), span_hear("You hear a strange sound."))
		sound_hint()
		if(!do_after(user, 10 SECONDS, target = src))
			to_chat(user, span_danger(xbox_rage_msg()))
			user.playsound_local(get_turf(user), 'modular_pod/sound/eff/difficult1.wav', 15, FALSE)
			return
		playsound(src, 'modular_septic/sound/effects/homierip.ogg', 80, FALSE)
		var/mob/living/carbon/human/species/halbermensch/halber = new(get_turf(src))
		to_chat(user, span_notice("I have freed <b>[halber]</b> from socket!"))
		halber.Unconscious(5 SECONDS)
		halber.forceMove(get_turf(user))
		halber.fully_replace_character_name(halber.real_name, "Halbermensch")
		halber.remove_language(/datum/language/common, TRUE, TRUE, LANGUAGE_HALBER)
		halber.grant_language(/datum/language/aphasia, TRUE, TRUE, LANGUAGE_HALBER)
		halber.language_holder.selected_language = /datum/language/aphasia
		var/datum/component/babble/babble = halber.GetComponent(/datum/component/babble)
		if(!babble)
			halber.AddComponent(/datum/component/babble, 'modular_pod/sound/mobs_yes/babble/halber.wav')
		else
			babble.babble_sound_override = 'modular_pod/sound/mobs_yes/babble/halber.wav'
			babble.volume = BABBLE_DEFAULT_VOLUME
			babble.duration = BABBLE_DEFAULT_DURATION
		halber.height = HUMAN_HEIGHT_MEDIUM
		halber.attributes.update_attributes()
		if(user.can_heartattack())
			user.set_heartattack(TRUE)
		halber.key = user.key
		playsound(get_turf(halber), 'modular_pod/sound/mus/new_halbermensch.ogg', 100)
		qdel(src)

/obj/item/craftorshit/thing/alchemy/squash
	name = "Squash"
	desc = "HMMM..."
	icon = 'modular_pod/icons/obj/items/otherobjects.dmi'
	icon_state = "squash"
	var/heart_here = FALSE
	var/guts_here = FALSE
	var/lungs_here = FALSE
	var/ready = FALSE

/obj/item/craftorshit/thing/alchemy/squash/attackby(obj/item/I, mob/living/carbon/user, params)
	. = ..()
	if(istype(I, /obj/item/organ/heart))
		if(user.a_intent == INTENT_DISARM)
			var/diceroll = user.diceroll(GET_MOB_SKILL_VALUE(user, SKILL_ALCHEMISTRY), context = DICE_CONTEXT_PHYSICAL)
			if(diceroll >= DICE_SUCCESS)
				user.visible_message(span_notice("[user] connects the heart."),span_notice("You connect the heart."), span_hear("You hear a strange sound."))
				sound_hint()
				user.changeNext_move(10)
				heart_here = TRUE
				var/obj/item/organ/heart/heart = I
				qdel(heart)
			else
				var/obj/item/organ/heart/heart = I
				qdel(heart)
				sound_hint()
				user.changeNext_move(10)
				new /obj/item/craftorshit/thing/retarded/alchemical(get_turf(src))
	else if(istype(I, /obj/item/organ/intestines))
		if(user.a_intent == INTENT_DISARM)
			var/diceroll = user.diceroll(GET_MOB_SKILL_VALUE(user, SKILL_ALCHEMISTRY), context = DICE_CONTEXT_PHYSICAL)
			if(diceroll >= DICE_SUCCESS)
				user.visible_message(span_notice("[user] connects the infestines."),span_notice("You connect the infestines."), span_hear("You hear a strange sound."))
				sound_hint()
				user.changeNext_move(10)
				guts_here = TRUE
				var/obj/item/organ/infestines/guts = I
				qdel(guts)
			else
				var/obj/item/organ/infestines/guts = I
				qdel(guts)
				sound_hint()
				user.changeNext_move(10)
				new /obj/item/craftorshit/thing/retarded/alchemical(get_turf(src))
	else if(istype(I, /obj/item/organ/lungs))
		if(user.a_intent == INTENT_DISARM)
			var/diceroll = user.diceroll(GET_MOB_SKILL_VALUE(user, SKILL_ALCHEMISTRY), context = DICE_CONTEXT_PHYSICAL)
			if(diceroll >= DICE_SUCCESS)
				user.visible_message(span_notice("[user] connects the lungs"),span_notice("You connect the lungs."), span_hear("You hear a strange sound."))
				sound_hint()
				user.changeNext_move(10)
				lungs_here = TRUE
				var/obj/item/organ/lungs/lungs = I
				qdel(lungs)
			else
				var/obj/item/organ/lungs/lungs = I
				qdel(lungs)
				sound_hint()
				user.changeNext_move(10)
				new /obj/item/craftorshit/thing/retarded/alchemical(get_turf(src))

/obj/item/craftorshit/thing/alchemy/squash/Initialize(mapload)
	. = ..()
	if((heart_here) && (guts_here) && (lungs_here))
		ready = TRUE

/obj/item/craftorshit/thing/alchemy/squash/attack_self_tertiary(mob/living/carbon/human/user, modifiers)
	. = ..()
	if(.)
		return
	if(user.a_intent == INTENT_HELP)
		if(ready)
			user.visible_message(span_notice("<b>[user]</b> begins to compile the socket."), \
						span_notice("I begin to compile the socket."), \
						span_hear("I hear a strange sound."))
			user.changeNext_move(CLICK_CD_MELEE)
			playsound(loc, 'modular_pod/sound/eff/flesh_slap_second.wav', 50, TRUE)
			var/durationn = (50 SECONDS - (GET_MOB_SKILL_VALUE(user, SKILL_ALCHEMISTRY)))
			if(!do_after(user, durationn, target = src))
				to_chat(user, span_danger(xbox_rage_msg()))
				user.playsound_local(get_turf(user), 'modular_pod/sound/eff/difficult1.wav', 15, FALSE)
				return
			var/diceroll = user.diceroll(GET_MOB_SKILL_VALUE(user, SKILL_ALCHEMISTRY), context = DICE_CONTEXT_PHYSICAL)
			if(diceroll >= DICE_SUCCESS)
				to_chat(user, span_notice("You compile the socket..."))
				sound_hint()
				user.changeNext_move(CLICK_CD_MELEE)
				user.Immobilize(1 SECONDS)
				playsound(loc, 'modular_pod/sound/eff/creepy.ogg', 50, TRUE)
				new /obj/structure/halber_socket(get_turf(user))
				qdel(src)
			else
				to_chat(user, span_notice("NOTHING SUCCEEDED! NOTHING!"))
				sound_hint()
				user.changeNext_move(CLICK_CD_MELEE)
				user.Immobilize(1 SECONDS)

/obj/item/craftorshit/thing/alchemy/squash/examine(mob/user)
	. = ..()
	if(heart_here)
		. += "<span class='notice'>Heart is connected.</span>"
	else if(guts_here)
		. += "<span class='notice'>Infestines are connected.</span>"
	else if(lungs_here)
		. += "<span class='notice'>Lungs are connected.</span>"

/*
		var/obj/structure/halber_socket/socket
		var/mob/living/carbon/human/species/halbermensch/halber = new(socket.loc)
		halber.fully_replace_character_name(halber.real_name, "Halbermensch")
		var/datum/component/babble/babble = halber.GetComponent(/datum/component/babble)
		if(!babble)
			halber.AddComponent(/datum/component/babble, 'modular_pod/sound/mobs_yes/babble/halber.wav')
		else
			babble.babble_sound_override = 'modular_pod/sound/mobs_yes/babble/halber.wav'
			babble.volume = BABBLE_DEFAULT_VOLUME
			babble.duration = BABBLE_DEFAULT_DURATION

		halber.height = HUMAN_HEIGHT_MEDIUM
		halber.attributes.update_attributes()
		halber.playsound_local(halber, 'modular_pod/sound/mus/new_halbermensch.ogg', 100)
		halber.key = key
		qdel(socket)
	else
*/