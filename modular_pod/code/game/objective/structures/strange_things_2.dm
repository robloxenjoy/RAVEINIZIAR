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