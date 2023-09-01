/obj/structure/beast/gargotor
	name = "Gargotor"
	desc = "Good old Gargotor."
	icon = 'modular_pod/icons/obj/things/things.dmi'
	icon_state = "gargotor"
	plane = ABOVE_GAME_PLANE
	layer = FLY_LAYER
	anchored = 1
	density = 1
//	var/crystal = FALSE
//	var/crystalGreen = FALSE
//	var/crystalRed = FALSE
//	var/crystalBlue = FALSE
//	var/crystalPink = FALSE
/*
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
		playsound(get_turf(src), 'modular_pod/sound/eff/thingg.ogg', 100 , FALSE, FALSE)
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
		playsound(get_turf(src), 'modular_pod/sound/eff/thingg.ogg', 100 , FALSE, FALSE)
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
		playsound(get_turf(src), 'modular_pod/sound/eff/thingg.ogg', 100 , FALSE, FALSE)
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
		playsound(get_turf(src), 'modular_pod/sound/eff/thingg.ogg', 100 , FALSE, FALSE)
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
			playsound(get_turf(src), 'modular_pod/sound/eff/thingg.ogg', 100 , FALSE, FALSE)
	else if(istype(I, /obj/item/shard/crystal/green))
		if(crystalBlue)
			if(user.a_intent != INTENT_DISARM)
				return
			new /obj/item/stack/medical/suture/one(get_turf(user))
			qdel(I)
			crystalBlue = FALSE
			crystal = FALSE
			sound_hint()
			playsound(get_turf(src), 'modular_pod/sound/eff/thingg.ogg', 100 , FALSE, FALSE)
	else if(istype(I, /obj/item/shard/crystal/green))
		if(crystalRed)
			if(user.a_intent != INTENT_DISARM)
				return
			new /obj/item/stack/medical/mesh/one(get_turf(user))
			qdel(I)
			crystalRed = FALSE
			crystal = FALSE
			sound_hint()
			playsound(get_turf(src), 'modular_pod/sound/eff/thingg.ogg', 100 , FALSE, FALSE)
	else if(istype(I, /obj/item/shard/crystal/green))
		if(crystalPink)
			if(user.a_intent != INTENT_DISARM)
				return
			new /obj/item/stack/medical/splint/one(get_turf(user))
			qdel(I)
			crystalPink = FALSE
			crystal = FALSE
			sound_hint()
			playsound(get_turf(src), 'modular_pod/sound/eff/thingg.ogg', 100 , FALSE, FALSE)
	else if(istype(I, /obj/item/shard/crystal/blue))
		if(crystalRed)
			if(user.a_intent != INTENT_DISARM)
				return
			new /obj/item/clothing/shoes/laceup(get_turf(user))
			qdel(I)
			crystalRed = FALSE
			crystal = FALSE
			sound_hint()
			playsound(get_turf(src), 'modular_pod/sound/eff/thingg.ogg', 100 , FALSE, FALSE)
	else if(istype(I, /obj/item/shard/crystal/blue))
		if(crystalPink)
			if(user.a_intent != INTENT_DISARM)
				return
			new /obj/item/clothing/pants/venturer(get_turf(user))
			qdel(I)
			crystalPink = FALSE
			crystal = FALSE
			sound_hint()
			playsound(get_turf(src), 'modular_pod/sound/eff/thingg.ogg', 100 , FALSE, FALSE)
	else if(istype(I, /obj/item/shard/crystal/blue))
		if(crystalGreen)
			if(user.a_intent != INTENT_DISARM)
				return
			new /obj/item/clothing/under/venturerclassic(get_turf(user))
			qdel(I)
			crystalGreen = FALSE
			crystal = FALSE
			sound_hint()
			playsound(get_turf(src), 'modular_pod/sound/eff/thingg.ogg', 100 , FALSE, FALSE)
	else if(istype(I, /obj/item/shard/crystal/blue))
		if(crystalBlue)
			if(user.a_intent != INTENT_DISARM)
				return
			new /obj/item/knife/combat/goldenmisericorde(get_turf(user))
			qdel(I)
			crystalBlue = FALSE
			crystal = FALSE
			sound_hint()
			playsound(get_turf(src), 'modular_pod/sound/eff/thingg.ogg', 100 , FALSE, FALSE)
	else if(istype(I, /obj/item/shard/crystal/purple))
		if(crystalBlue)
			if(user.a_intent != INTENT_DISARM)
				return
			new /obj/item/stupidbottles/bluebottle(get_turf(user))
			qdel(I)
			crystalBlue = FALSE
			crystal = FALSE
			sound_hint()
			playsound(get_turf(src), 'modular_pod/sound/eff/thingg.ogg', 100 , FALSE, FALSE)

/obj/structure/beast/gargotor/attack_hand(mob/living/carbon/user, list/modifiers)
	. = ..()
	if(.)
		return
	if(user.a_intent == INTENT_GRAB)
		if(crystal)
			if(crystalBlue)
				new /obj/item/crystal/blue(get_turf(user))
				playsound(get_turf(src), 'modular_pod/sound/eff/crystalHERE.ogg', 100 , FALSE, FALSE)
				sound_hint()
				crystal = FALSE
				crystalBlue = FALSE
			else if(crystalRed)
				new /obj/item/crystal/red(get_turf(user))
				playsound(get_turf(src), 'modular_pod/sound/eff/crystalHERE.ogg', 100 , FALSE, FALSE)
				sound_hint()
				crystal = FALSE
				crystalRed = FALSE
			else if(crystalGreen)
				new /obj/item/crystal/green(get_turf(user))
				playsound(get_turf(src), 'modular_pod/sound/eff/crystalHERE.ogg', 100 , FALSE, FALSE)
				sound_hint()
				crystal = FALSE
				crystalGreen = FALSE
			else if(crystalPink)
				new /obj/item/crystal/pink(get_turf(user))
				playsound(get_turf(src), 'modular_pod/sound/eff/crystalHERE.ogg', 100 , FALSE, FALSE)
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
*/

/obj/item/seeding/midnightberryseeds
	name = "Seeds"
	desc = "Midnightberry seeds!"
	icon = 'modular_pod/icons/obj/things/things.dmi'
	icon_state = "seeds"
	w_class = WEIGHT_CLASS_SMALL

/obj/item/seeding/aguoseeds
	name = "Seeds"
	desc = "Aguo seeds!"
	icon = 'modular_pod/icons/obj/things/things.dmi'
	icon_state = "aguo_seeds"
	w_class = WEIGHT_CLASS_SMALL

/obj/item/stupidbottles/bluebottle
	name = "Blue Bottle"
	desc = "Interesting mixture."
	icon = 'modular_pod/icons/obj/things/things.dmi'
	icon_state = "bluebottle"
	var/empty = FALSE
	w_class = WEIGHT_CLASS_SMALL

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
	playsound(get_turf(src), 'modular_pod/sound/eff/open_trap.ogg', 100 , FALSE, FALSE)
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
	playsound(get_turf(src), 'modular_pod/sound/eff/close_trap.ogg', 100 , FALSE, FALSE)

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
			user.playsound_local(get_turf(user), 'modular_pod/sound/eff/difficult1.ogg', 15, FALSE)
			return
//		for(var/mob/living/carbon/human/H in range(user))
//			if(H != src && H >= 1 && (user in view(H)))
		playsound(src, 'modular_septic/sound/effects/homierip.ogg', 80, FALSE)
		var/mob/living/carbon/human/species/halbermensch/halber = new(get_turf(src))
		to_chat(user, span_notice("I have freed <b>[halber]</b> from socket!"))
//				halber.Unconscious(5 SECONDS)
//				halber.forceMove(get_turf(src))
		halber.fully_replace_character_name(halber.real_name, "Halbermensch")
		halber.remove_language(/datum/language/common, TRUE, TRUE, LANGUAGE_HALBER)
		halber.grant_language(/datum/language/aphasia, TRUE, TRUE, LANGUAGE_HALBER)
		halber.language_holder.selected_language = /datum/language/aphasia
		var/datum/component/babble/babble = halber.GetComponent(/datum/component/babble)
		if(!babble)
			halber.AddComponent(/datum/component/babble, 'modular_pod/sound/mobs_yes/babble/halber.ogg')
		else
			babble.babble_sound_override = 'modular_pod/sound/mobs_yes/babble/halber.ogg'
			babble.volume = BABBLE_DEFAULT_VOLUME
			babble.duration = BABBLE_DEFAULT_DURATION
		halber.height = HUMAN_HEIGHT_MEDIUM
		halber.attributes.update_attributes()
		ADD_TRAIT(halber, TRAIT_MISANTHROPE, "misanthrope")
		if(user.can_heartattack())
			user.set_heartattack(TRUE)
		halber.key = user.key
		priority_announce("HALBERMENSCH CREATED!", "WORLD", has_important_message = TRUE)
		SEND_SOUND(world, sound('modular_pod/sound/mus/new_halbermensch.ogg'))
//		playsound(get_turf(halber), 'modular_pod/sound/mus/new_halbermensch.ogg', 100)
		qdel(src)

/obj/item/craftorshit/thing/alchemy/squash
	name = "Squash"
	desc = "HMMM..."
	icon = 'modular_pod/icons/obj/items/otherobjects.dmi'
	icon_state = "squash"
	var/heart_here = FALSE
	var/guts_here = FALSE
	var/lung_here = FALSE
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
	if(istype(I, /obj/item/organ/intestines))
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
	if(istype(I, /obj/item/organ/lungs))
		if(user.a_intent == INTENT_DISARM)
			var/diceroll = user.diceroll(GET_MOB_SKILL_VALUE(user, SKILL_ALCHEMISTRY), context = DICE_CONTEXT_PHYSICAL)
			if(diceroll >= DICE_SUCCESS)
				user.visible_message(span_notice("[user] connects the lungs"),span_notice("You connect the lungs."), span_hear("You hear a strange sound."))
				sound_hint()
				user.changeNext_move(10)
				lung_here = TRUE
				var/obj/item/organ/lungs/lungs = I
				qdel(lungs)
			else
				var/obj/item/organ/lungs/lungs = I
				qdel(lungs)
				sound_hint()
				user.changeNext_move(10)
				new /obj/item/craftorshit/thing/retarded/alchemical(get_turf(src))
/*
/obj/item/craftorshit/thing/alchemy/squash/Initialize(mapload)
	. = ..()
	if((heart_here) && (guts_here) && (lung_here))
		ready = TRUE
*/

/obj/item/craftorshit/thing/alchemy/squash/attack_foot(mob/living/carbon/human/user, list/modifiers)
	. = ..()
	if(.)
		return
	user.visible_message(span_notice("[user] kicks the [src]."),span_notice("You kick the [src]."), span_hear("You hear the sound of kicking."))
	user.changeNext_move(CLICK_CD_MELEE)
	user.adjustFatigueLoss(10)
	sound_hint()
	if((heart_here) && (guts_here) && (lung_here))
		ready = TRUE

/obj/item/craftorshit/thing/alchemy/squash/attack_self_tertiary(mob/living/carbon/human/user, modifiers)
	. = ..()
	if(.)
		return
	if(user.special_attack != SPECIAL_ATK_NONE)
		return
	if(user.a_intent == INTENT_HELP)
		if(ready)
			user.visible_message(span_notice("<b>[user]</b> begins to compile the socket."), \
						span_notice("I begin to compile the socket."), \
						span_hear("I hear a strange sound."))
			user.changeNext_move(CLICK_CD_MELEE)
			playsound(loc, 'modular_pod/sound/eff/flesh_slap_second.ogg', 50, TRUE)
			var/durationn = (50 SECONDS - (GET_MOB_SKILL_VALUE(user, SKILL_ALCHEMISTRY)))
			if(!do_after(user, durationn, target = src))
				to_chat(user, span_danger(xbox_rage_msg()))
				user.playsound_local(get_turf(user), 'modular_pod/sound/eff/difficult1.ogg', 15, FALSE)
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
	if(guts_here)
		. += "<span class='notice'>Infestines are connected.</span>"
	if(lung_here)
		. += "<span class='notice'>Lung is connected.</span>"

/*
		var/obj/structure/halber_socket/socket
		var/mob/living/carbon/human/species/halbermensch/halber = new(socket.loc)
		halber.fully_replace_character_name(halber.real_name, "Halbermensch")
		var/datum/component/babble/babble = halber.GetComponent(/datum/component/babble)
		if(!babble)
			halber.AddComponent(/datum/component/babble, 'modular_pod/sound/mobs_yes/babble/halber.ogg')
		else
			babble.babble_sound_override = 'modular_pod/sound/mobs_yes/babble/halber.ogg'
			babble.volume = BABBLE_DEFAULT_VOLUME
			babble.duration = BABBLE_DEFAULT_DURATION

		halber.height = HUMAN_HEIGHT_MEDIUM
		halber.attributes.update_attributes()
		halber.playsound_local(halber, 'modular_pod/sound/mus/new_halbermensch.ogg', 100)
		halber.key = key
		qdel(socket)
	else
*/

/obj/structure/accepter
	name = "Accepter"
	desc = "Put in this crystals."
	icon = 'modular_pod/icons/obj/things/things.dmi'
	icon_state = "accepter"
	plane = ABOVE_GAME_PLANE
	layer = FLY_LAYER
	anchored = 1
	density = 1
	obj_flags = NONE
	max_integrity = 1000
	var/moneymoney = 0

/obj/structure/accepter/attackby(obj/item/I, mob/living/carbon/user, params)
	. = ..()
	if(istype(I, /obj/item/crystal))
		if(user.a_intent != INTENT_DISARM)
			return
		user.visible_message(span_notice("[user] inserts crystal in Accepter."),span_notice("You insert crystal in Accepter."), span_hear("You hear the sound of inserting."))
		sound_hint()
		playsound(get_turf(src), 'modular_pod/sound/eff/thingg.ogg', 100 , FALSE, FALSE)
		qdel(I)
		moneymoney += 20
	if(istype(I, /obj/item/shard/crystal))
		if(user.a_intent != INTENT_DISARM)
			return
		user.visible_message(span_notice("[user] inserts crystal shard in Accepter."),span_notice("You insert crystal shard in Accepter."), span_hear("You hear the sound of inserting."))
		sound_hint()
		playsound(get_turf(src), 'modular_pod/sound/eff/thingg.ogg', 100 , FALSE, FALSE)
		qdel(I)
		moneymoney += 5

/obj/structure/accepter/attack_hand(mob/living/carbon/user, list/modifiers)
	. = ..()
	if(.)
		return
	if(user.a_intent == INTENT_GRAB)
		if(moneymoney > 0)
			var/thing = tgui_input_list(user, "You want something cheap or expensive?",, list("Cheap", "Expensive"))
			if(!thing)
				return
			if(thing == "Cheap")
				if(moneymoney < 10)
					return
				cheap_find(user)
			if(thing == "Expensive")
				if(moneymoney < 20)
					return
				expensive_find(user)

/obj/structure/accepter/proc/cheap_find(mob/living/carbon/user)
	var/thingy = stripped_input(user, "You want something cheap?", "I want...")
	if(!thingy)
		return
	if(get_dist(src, user) >= 2)
		return
	if(moneymoney < 10)
		return
	switch(thingy)
		if("beer")
			new /obj/item/reagent_containers/food/drinks/bottle/beer(get_turf(user))
			moneymoney -= 10
			playsound(get_turf(src), 'modular_pod/sound/eff/crystalHERE.ogg', 100 , FALSE, FALSE)
//		if("beef")
//			new /obj/item/food/canned/beef(get_turf(user))
//			moneymoney -= 10
//			playsound(get_turf(src), 'modular_pod/sound/eff/crystalHERE.ogg', 100 , FALSE, FALSE)
		if("water")
			new /obj/item/reagent_containers/food/drinks/waterbottle(get_turf(user))
			moneymoney -= 10
			playsound(get_turf(src), 'modular_pod/sound/eff/crystalHERE.ogg', 100 , FALSE, FALSE)
		if("gauze")
			new /obj/item/stack/medical/gauze(get_turf(user))
			moneymoney -= 10
			playsound(get_turf(src), 'modular_pod/sound/eff/crystalHERE.ogg', 100 , FALSE, FALSE)
		if("blue bottle")
			new /obj/item/stupidbottles/bluebottle(get_turf(user))
			moneymoney -= 10
			playsound(get_turf(src), 'modular_pod/sound/eff/crystalHERE.ogg', 100 , FALSE, FALSE)
		if("aguo seeds")
			new /obj/item/seeding/aguoseeds(get_turf(user))
			moneymoney -= 10
			playsound(get_turf(src), 'modular_pod/sound/eff/crystalHERE.ogg', 100 , FALSE, FALSE)
		else
			return

/obj/structure/accepter/proc/expensive_find(mob/living/carbon/user)
	var/thingy = stripped_input(user, "You want something expensive?", "I want...")
	if(!thingy)
		return
	if(get_dist(src, user) >= 2)
		return
	if(moneymoney < 20)
		return
	switch(thingy)
		if("blue clothes")
			new /obj/item/clothing/under/venturerclassic(get_turf(user))
			moneymoney -= 20
			playsound(get_turf(src), 'modular_pod/sound/eff/crystalHERE.ogg', 100 , FALSE, FALSE)
		if("blue pants")
			new /obj/item/clothing/pants/venturer(get_turf(user))
			moneymoney -= 20
			playsound(get_turf(src), 'modular_pod/sound/eff/crystalHERE.ogg', 100 , FALSE, FALSE)
		if("golden misericorde")
			new /obj/item/knife/combat/goldenmisericorde(get_turf(user))
			moneymoney -= 20
			playsound(get_turf(src), 'modular_pod/sound/eff/crystalHERE.ogg', 100 , FALSE, FALSE)
		if("pinker caller")
			if(moneymoney < 300)
				return
			new /obj/item/pinker_caller(get_turf(user))
			moneymoney -= 300
			playsound(get_turf(src), 'modular_pod/sound/eff/crystalHERE.ogg', 100 , FALSE, FALSE)
		else
			return

/obj/structure/accepter/examine(mob/user)
	. = ..()
	if(moneymoney)
		. += "<span class='notice'>Here is [moneymoney] savings!</span>"

/obj/structure/accepterblack
	name = "Black Accepter"
	desc = "Illegal version. Put in this crystals."
	icon = 'modular_pod/icons/obj/things/things.dmi'
	icon_state = "black_accepter"
	plane = ABOVE_GAME_PLANE
	layer = FLY_LAYER
	anchored = 1
	density = 1
	obj_flags = NONE
	max_integrity = 1000
	var/moneymoney = 0

/obj/structure/accepterblack/attackby(obj/item/I, mob/living/carbon/user, params)
	. = ..()
	if(istype(I, /obj/item/crystal))
		if(user.a_intent != INTENT_DISARM)
			return
		user.visible_message(span_notice("[user] inserts crystal in Black Accepter."),span_notice("You insert crystal in Black Accepter."), span_hear("You hear the sound of inserting."))
		sound_hint()
		playsound(get_turf(src), 'modular_pod/sound/eff/thingg.ogg', 100 , FALSE, FALSE)
		qdel(I)
		moneymoney += 20
	if(istype(I, /obj/item/shard/crystal))
		if(user.a_intent != INTENT_DISARM)
			return
		user.visible_message(span_notice("[user] inserts crystal shard in Black Accepter."),span_notice("You insert crystal shard in Black Accepter."), span_hear("You hear the sound of inserting."))
		sound_hint()
		playsound(get_turf(src), 'modular_pod/sound/eff/thingg.ogg', 100 , FALSE, FALSE)
		qdel(I)
		moneymoney += 5

/obj/structure/accepterblack/attack_hand(mob/living/carbon/user, list/modifiers)
	. = ..()
	if(.)
		return
	if(user.a_intent == INTENT_GRAB)
		if(moneymoney > 0)
			var/thing = tgui_input_list(user, "What you want?",, list("Guns", "Ammo", "Other"))
			if(!thing)
				return
			if(thing == "Guns")
				if(moneymoney < 100)
					return
				guns_find(user)
			if(thing == "Ammo")
				if(moneymoney < 50)
					return
				ammo_find(user)
			if(thing == "Other")
				if(moneymoney < 50)
					return
				other_find(user)

/obj/structure/accepterblack/proc/guns_find(mob/living/carbon/user)
	var/thingy = stripped_input(user, "Which gun you want?", "I want...")
	if(!thingy)
		return
	if(get_dist(src, user) >= 2)
		return
	if(moneymoney < 100)
		return
	switch(thingy)
		if("paralyzer V350")
			new /obj/item/gun/ballistic/revolver/remis/paralyzer/empty(get_turf(user))
			moneymoney -= 100
			playsound(get_turf(src), 'modular_pod/sound/eff/crystalHERE.ogg', 100 , FALSE, FALSE)
		if("bombeiro 22lr pistol")
			if(moneymoney < 150)
				return
			new /obj/item/gun/ballistic/automatic/pistol/remis/ppk/empty(get_turf(user))
			moneymoney -= 150
			playsound(get_turf(src), 'modular_pod/sound/eff/crystalHERE.ogg', 100 , FALSE, FALSE)
		else
			return

/obj/structure/accepterblack/proc/ammo_find(mob/living/carbon/user)
	var/thingy = stripped_input(user, "Which ammo you want?", "I want...")
	if(!thingy)
		return
	if(get_dist(src, user) >= 2)
		return
	if(moneymoney < 50)
		return
	switch(thingy)
		if("paralyzer rounds")
			new /obj/item/ammo_box/magazine/ammo_stack/pulser/loaded(get_turf(user))
			moneymoney -= 50
			playsound(get_turf(src), 'modular_pod/sound/eff/crystalHERE.ogg', 100 , FALSE, FALSE)
		if("22lr rounds")
			if(moneymoney < 70)
				return
			new /obj/item/ammo_box/magazine/ammo_stack/c22lr/loaded(get_turf(user))
			moneymoney -= 70
			playsound(get_turf(src), 'modular_pod/sound/eff/crystalHERE.ogg', 100 , FALSE, FALSE)
		if("22lr magazine")
			if(moneymoney < 70)
				return
			new /obj/item/ammo_box/magazine/ppk22lr/empty(get_turf(user))
			moneymoney -= 70
			playsound(get_turf(src), 'modular_pod/sound/eff/crystalHERE.ogg', 100 , FALSE, FALSE)
		else
			return

/obj/structure/accepterblack/proc/other_find(mob/living/carbon/user)
	var/thingy = stripped_input(user, "Which thing you want?", "I want...")
	if(!thingy)
		return
	if(get_dist(src, user) >= 2)
		return
	if(moneymoney < 50)
		return
	switch(thingy)
		if("carbonylmethamphetamine pill")
			new /obj/item/reagent_containers/pill/carbonylmethamphetamine(get_turf(user))
			moneymoney -= 50
			playsound(get_turf(src), 'modular_pod/sound/eff/crystalHERE.ogg', 100 , FALSE, FALSE)
		if("morphine syringe")
			new /obj/item/reagent_containers/syringe/morphine(get_turf(user))
			moneymoney -= 50
			playsound(get_turf(src), 'modular_pod/sound/eff/crystalHERE.ogg', 100 , FALSE, FALSE)
		if("iron pickaxe")
			new /obj/item/melee/hehe/pickaxe/iron(get_turf(user))
			moneymoney -= 50
			playsound(get_turf(src), 'modular_pod/sound/eff/crystalHERE.ogg', 100 , FALSE, FALSE)
		if("square lockpick")
			new /obj/item/akt/lockpick/square(get_turf(user))
			moneymoney -= 50
			playsound(get_turf(src), 'modular_pod/sound/eff/crystalHERE.ogg', 100 , FALSE, FALSE)
		if("triangle lockpick")
			if(moneymoney < 60)
				return
			new /obj/item/akt/lockpick/square/triangle(get_turf(user))
			moneymoney -= 60
			playsound(get_turf(src), 'modular_pod/sound/eff/crystalHERE.ogg', 100 , FALSE, FALSE)
		else
			return

/obj/structure/accepterblack/examine(mob/user)
	. = ..()
	if(moneymoney)
		. += "<span class='notice'>Here is [moneymoney] savings!</span>"

/obj/structure/village_screamer
	name = "Village Screamer"
	desc = "THE SCREAM!"
	icon = 'modular_pod/icons/obj/things/things.dmi'
	icon_state = "village_screamer"
	plane = ABOVE_GAME_PLANE
	layer = FLY_LAYER
	anchored = 1
	density = 1
	obj_flags = NONE
	max_integrity = 1000
	var/can_scream = TRUE
	var/timeout = 100 SECONDS

/obj/structure/village_screamer/attack_hand(mob/living/carbon/user, list/modifiers)
	. = ..()
	if(.)
		return
	if(user.a_intent == INTENT_GRAB)
		var/thing = tgui_input_list(user, "You want to scream something?",, list("Yes", "No"))
		if(!thing)
			return
		if(thing == "Yes")
			if(!can_scream)
				return
			scream(user)
		else
			return

/obj/structure/village_screamer/proc/scream(mob/living/carbon/user)
	var/thingy = stripped_input(user, "What you want to scream?", "")
	if(!thingy)
		return
	if(get_dist(src, user) >= 2)
		return
	if(!can_scream)
		return
	priority_announce(thingy, "[user.real_name]", has_important_message = TRUE)
	SEND_SOUND(world, sound('modular_pod/sound/mus/announce.ogg'))
	can_scream = FALSE
	addtimer(CALLBACK(src, .proc/cann_scream), timeout)

/obj/structure/village_screamer/proc/cann_scream()
	if(QDELETED(src))
		return
	can_scream = TRUE

/obj/structure/eyecrazy
	name = "Eye"
	desc = "Eye of Time."
	icon = 'modular_pod/icons/obj/things/things.dmi'
	icon_state = "eye"
	obj_flags = NONE
	anchored = TRUE
	density = FALSE
	plane = FLOOR_PLANE
	layer = LATTICE_LAYER
	mouse_opacity = MOUSE_OPACITY_TRANSPARENT
	light_range = 5
	light_power = 1
	light_color = "#00ff00"

/obj/structure/table/stoney
	name = "Stone Table"
	desc = "So hard."
	icon = 'modular_pod/icons/obj/things/things.dmi'
	icon_state = "table_stone"
	smoothing_flags = NONE
	smoothing_groups = null
	canSmoothWith = null
	frame = null

/obj/structure/table/oldwood
	name = "Table"
	desc = "Old."
	icon = 'modular_pod/icons/obj/things/things.dmi'
	icon_state = "table_old"
	smoothing_flags = NONE
	smoothing_groups = null
	canSmoothWith = null
	frame = null

/obj/structure/table/fine
	name = "Table"
	desc = "Fine."
	icon = 'modular_pod/icons/obj/things/things.dmi'
	icon_state = "table_fine"
	smoothing_flags = NONE
	smoothing_groups = null
	canSmoothWith = null
	frame = null

/obj/structure/table/cursedwood
	name = "Table"
	desc = "Cursed wood..."
	icon = 'modular_pod/icons/obj/things/things.dmi'
	icon_state = "table_cursed"
	smoothing_flags = NONE
	smoothing_groups = null
	canSmoothWith = null
	frame = null

/obj/structure/column
	name = "Stone Column"
	desc = "So hard."
	icon = 'modular_pod/icons/obj/things/things.dmi'
	icon_state = "column"
	plane = ABOVE_GAME_PLANE
	layer = FLY_LAYER
	anchored = 1
	density = 1
//	obj_flags = NONE
	max_integrity = 350

/obj/structure/column/wooden
	name = "Wooden Column"
	desc = "It supports."
	icon = 'modular_pod/icons/obj/things/things.dmi'
	icon_state = "support"
	plane = ABOVE_GAME_PLANE
	layer = FLY_LAYER
	anchored = 1
	density = 1
//	obj_flags = NONE
	max_integrity = 300