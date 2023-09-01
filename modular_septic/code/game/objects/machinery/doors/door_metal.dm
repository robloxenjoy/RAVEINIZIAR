#define DOOR_CLOSE_WAIT 60

/obj/machinery/door/metal_door
	name = "Metal Door"
	desc = "A broad metal door with a lock for keys, usually not locked, If It is, a nice firm kick from a friendly orange-suited protagonist would do the trick."
	icon = 'modular_septic/icons/obj/structures/metal_door.dmi'
	base_icon_state = "metal"
	icon_state = "metal1"
	var/doorOpen = 'modular_septic/sound/doors/door_metal_open.ogg'
	var/doorClose = 'modular_septic/sound/doors/door_metal_close.ogg'
	var/doorDeni = list('modular_septic/sound/doors/door_metal_try1.ogg', 'modular_septic/sound/doors/door_metal_try2.ogg')
	var/kickfailure = 'modular_septic/sound/doors/door_metal_freeman_impersonator.ogg'
	var/kicksuccess = 'modular_septic/sound/doors/smod_freeman.ogg'
	var/kickcriticalsuccess = 'modular_septic/sound/doors/smod_freeman_extreme.ogg'

	var/obj/structure/metal_door_frame/door_frame
	var/obj/structure/metal_door/thrown_door

	var/kicking_cooldown_duration = 0.8 SECONDS
	var/open_cooldown_duration = 2 SECONDS
	var/lock_level = 2
	var/hardnesslock = 48

	COOLDOWN_DECLARE(kicking_cooldown)
	COOLDOWN_DECLARE(open_cooldown)
	auto_align = FALSE
	key_worthy = TRUE
	locked = TRUE

/obj/machinery/door/metal_door/north
	dir = NORTH
	pixel_x = -16
	pixel_y = -8

/obj/machinery/door/metal_door/south
	dir = SOUTH
	pixel_x = -16
	pixel_y = -8

/obj/machinery/door/metal_door/east
	dir = EAST
	pixel_x = -16

/obj/machinery/door/metal_door/west
	dir = WEST
	pixel_x = -16

/obj/machinery/door/metal_door/open(mob/user)
	if(!COOLDOWN_FINISHED(src, open_cooldown))
		return
	if(!density)
		return 1
	if(operating)
		return
	if(locked)
		playsound(src, doorDeni, 70, FALSE)
		sound_hint()
		COOLDOWN_START(src, open_cooldown, open_cooldown_duration)
		if(user)
			user.visible_message(span_danger("[user] shakes the handle of the [src]."), \
								span_notice("It's locked!"))
		return
	operating = TRUE
	do_animate("opening")
	set_opacity(0)
	set_density(FALSE)
	flags_1 &= ~PREVENT_CLICK_UNDER_1
	layer = initial(layer)
	update_appearance()
	set_opacity(0)
	operating = FALSE
	air_update_turf(TRUE, FALSE)
	update_freelook_sight()
	if(autoclose)
		autoclose_in(DOOR_CLOSE_WAIT)
	playsound(src, doorOpen, 65, FALSE)
	COOLDOWN_START(src, open_cooldown, open_cooldown_duration)
	return 1

/obj/machinery/door/metal_door/close()
	if(!COOLDOWN_FINISHED(src, open_cooldown))
		return
	if(density)
		return TRUE
	if(operating || welded)
		return
	if(safe)
		for(var/atom/movable/M in get_turf(src))
			if(M.density && M != src) //something is blocking the door
				if(autoclose)
					autoclose_in(DOOR_CLOSE_WAIT)
				return
	operating = TRUE
	do_animate("closing")
	layer = closingLayer
	set_density(TRUE)
	flags_1 |= PREVENT_CLICK_UNDER_1
	update_appearance()
	if(visible && !glass)
		set_opacity(1)
	operating = FALSE
	air_update_turf(TRUE, TRUE)
	update_freelook_sight()
	if(!can_crush)
		return TRUE
	if(safe)
		CheckForMobs()
	else
		crush()
	playsound(src, doorClose, 65, FALSE)
	COOLDOWN_START(src, open_cooldown, open_cooldown_duration)
	return TRUE

/obj/structure/metal_door_frame
	name = "Metal Door Frame"
	desc = "Someone broke down this fucking door, now where is it?"
	icon = 'modular_septic/icons/obj/structures/metal_door.dmi'
	base_icon_state = "metal_broken"
	icon_state = "metal_broken"
	density = FALSE
	opacity = FALSE
	plane = GAME_PLANE_ABOVE_WINDOW
	layer = OPEN_DOOR_LAYER
	move_resist = MOVE_FORCE_VERY_STRONG

/obj/structure/metal_door
	name = "Metal Door"
	desc = "A door lying on the floor, the hinges are broken and It's broken and useless, just like you."
	icon = 'modular_septic/icons/obj/structures/metal_door.dmi'
	base_icon_state = "metal_freeman_evidence"
	icon_state = "metal_freeman_evidence"
	density = FALSE
	anchored = FALSE
	throwforce = 75
	var/state_variation = 2

/obj/structure/metal_door/Initialize(mapload)
	. = ..()
	if(state_variation)
		icon_state = "[base_icon_state][rand(1, 2)]"

/obj/machinery/door/metal_door/attack_foot(mob/user)
	. = ..()
	gordan_freeman_speedrunner(user, src)

/obj/machinery/door/metal_door/proc/imbatublow(mob/living/user, atom/source)
	var/turf/doorturf = get_turf(src)
	var/flying_dir = get_dir(user, source.loc)
	var/turf/freeman = get_ranged_target_turf(user, flying_dir, 3)
	doorturf.pollute_turf(/datum/pollutant/dust, 250)
	generate_door_combo()
	thrown_door.throw_at(freeman, range = 4, speed = 2)
	sound_hint()
	playsound(src, kickcriticalsuccess, 100, FALSE, 5)
	door_frame.dir = dir
	qdel(src)

/obj/machinery/door/metal_door/proc/generate_door_combo()
	var/turf/doorturf = get_turf(src)
	door_frame = new /obj/structure/metal_door_frame(doorturf)
	thrown_door = new /obj/structure/metal_door(doorturf)

/obj/machinery/door/metal_door/proc/gordan_freeman_speedrunner(mob/living/user)
	if(!isliving(usr) || !usr.Adjacent(src) || usr.incapacitated())
		return
	if(key_worthy)
		return
	if(!COOLDOWN_FINISHED(src, kicking_cooldown))
		return
	if(!(GET_MOB_ATTRIBUTE_VALUE(user, STAT_STRENGTH) > 11))
		playsound(src, kickfailure, 75, FALSE, 2)
		src.visible_message(span_danger("[user] kicks the [src]!"))
		to_chat(user, span_userdanger("I kick the [src], but It's too hard!"))
		sound_hint()
		COOLDOWN_START(src, kicking_cooldown, kicking_cooldown_duration)
		return
	if(user.diceroll(GET_MOB_ATTRIBUTE_VALUE(user, STAT_STRENGTH)+1) <= DICE_FAILURE)
		playsound(src, kickfailure, 75, FALSE, 2)
		src.visible_message(span_danger("[user] kicks the [src]!"))
		to_chat(user, span_danger("I kick the [src]!"))
		sound_hint()
		COOLDOWN_START(src, kicking_cooldown, kicking_cooldown_duration)
		return
	else if(GET_MOB_ATTRIBUTE_VALUE(user, STAT_STRENGTH) > 18)
		playsound(src, kicksuccess, 100, FALSE, 5)
		src.visible_message(span_bigdanger("[user] kicks the [src] straight off it's hinges!"))
		to_chat(user, span_bolddanger("I kick the [src] straight off it's hinges!"))
		sound_hint()
		locked = FALSE
		imbatublow(user, src)
		return
	else
		playsound(src, kicksuccess, 90, FALSE, 2)
		sound_hint()
		src.visible_message(span_danger("[user] kicks the [src] open!"))
		to_chat(user, span_danger("I kick the [src] down."))
		locked = FALSE
		open()
		COOLDOWN_START(src, kicking_cooldown, kicking_cooldown_duration)

/obj/machinery/door/metal_door/try_door_unlock(user)
	if(allowed(user))
		if(locked)
			unlock()
		else
			lock()
	return TRUE

/obj/machinery/door/metal_door/attackby(obj/item/I, mob/living/user, params)
	. = ..()

	if(istype(I, /obj/item/storage/belt/keychain))
		for (var/obj/item/key/podpol/KK in I.contents)
			if(KK.door_allowed(src) && key_worthy)
				if(locked)
					visible_message("<span class = 'notice'>[user] unlocks [src].</span>")
					playsound(src, 'modular_septic/sound/effects/keys_use.ogg', 75, FALSE)
					locked = FALSE
				else
					visible_message("<span class = 'notice'>[user] locks [src].</span>")
					playsound(src, 'modular_septic/sound/effects/keys_use.ogg', 75, FALSE)
					locked = TRUE
			else
				to_chat(user, span_warning("No matching key."))
				playsound(src, 'modular_septic/sound/effects/keys_remove.ogg', 75, FALSE)

	if(istype(I, /obj/item/akt/lockpick/square))
		if(density)
			if(user.a_intent == INTENT_DISARM)
				user.changeNext_move(CLICK_CD_GRABBING)
				sound_hint()
				src.visible_message(span_steal("[user] starts lockpicking [src]!"),span_steal("You start to lockpick [src]."), span_hear("You hear the sound of lockpicking."))
				playsound(src, 'modular_pod/sound/eff/lockpicking3.ogg', 70, FALSE, 3)
				var/durationn = (hardnesslock/(GET_MOB_SKILL_VALUE(user, SKILL_LOCKPICKING)) * 2)
				if(!do_after(user, durationn*10, target=src))
					to_chat(user, span_danger(xbox_rage_msg()))
					user.playsound_local(get_turf(user), 'modular_pod/sound/eff/difficult1.ogg', 15, FALSE)
					return
				if(lock_level <= 1)
					var/diceroll = user.diceroll(GET_MOB_SKILL_VALUE(user, SKILL_LOCKPICKING), context = DICE_CONTEXT_PHYSICAL)
					playsound(src, 'modular_pod/sound/eff/lockpicking2.ogg', 70, FALSE, 3)
					if(diceroll == DICE_CRIT_SUCCESS)
						src.visible_message(span_steal("[user] lockpicked [src]!"),span_steal("You lockpicked [src]."), span_hear("You hear the sound of lockpicking."))
						user.changeNext_move(CLICK_CD_GRABBING)
						playsound(src, 'modular_septic/sound/effects/movedoor.ogg', 70, FALSE, 4)
						open()
						return
					if(diceroll == DICE_SUCCESS)
						src.visible_message(span_steal("[user] lockpicked [src]!"),span_steal("You lockpicked [src]."), span_hear("You hear the sound of lockpicking."))
						user.changeNext_move(CLICK_CD_GRABBING)
						var/obj/item/akt/lockpick/square/SQ = I
						SQ.damageItem("MEDIUM")
						playsound(src, 'modular_septic/sound/effects/movedoor.ogg', 70, FALSE, 4)
						open()
						return
					if(diceroll <= DICE_FAILURE)
						src.visible_message(span_steal("[user] tried to lockpick [src], but failed!"),span_steal("You failed to lockpick [src]."), span_hear("You hear the sound of failed lockpicking."))
						user.changeNext_move(CLICK_CD_GRABBING)
						var/obj/item/akt/lockpick/square/SQ = I
						SQ.damageItem("HARD")
						return
				else
					to_chat(user, span_steal("Here is a strong lock!"))
					return

	if(istype(I, /obj/item/akt/lockpick/square/triangle))
		if(density)
			if(user.a_intent == INTENT_DISARM)
				user.changeNext_move(CLICK_CD_GRABBING)
				sound_hint()
				src.visible_message(span_steal("[user] starts lockpicking [src]!"),span_steal("You start to lockpick [src]."), span_hear("You hear the sound of lockpicking."))
				playsound(src, 'modular_pod/sound/eff/lockpicking3.ogg', 70, FALSE, 3)
				var/durationn = (hardnesslock/(GET_MOB_SKILL_VALUE(user, SKILL_LOCKPICKING)) * 2)
				if(!do_after(user, durationn*10, target=src))
					to_chat(user, span_danger(xbox_rage_msg()))
					user.playsound_local(get_turf(user), 'modular_pod/sound/eff/difficult1.ogg', 15, FALSE)
					return
				if(lock_level >= 2)
					var/diceroll = user.diceroll(GET_MOB_SKILL_VALUE(user, SKILL_LOCKPICKING), context = DICE_CONTEXT_PHYSICAL)
					playsound(src, 'modular_pod/sound/eff/lockpicking2.ogg', 70, FALSE, 3)
					if(diceroll == DICE_CRIT_SUCCESS)
						src.visible_message(span_steal("[user] lockpicked [src]!"),span_steal("You lockpicked [src]."), span_hear("You hear the sound of lockpicking."))
						user.changeNext_move(CLICK_CD_GRABBING)
						playsound(src, 'modular_septic/sound/effects/movedoor.ogg', 70, FALSE, 4)
						open()
						return
					if(diceroll == DICE_SUCCESS)
						src.visible_message(span_steal("[user] lockpicked [src]!"),span_steal("You lockpicked [src]."), span_hear("You hear the sound of lockpicking."))
						user.changeNext_move(CLICK_CD_GRABBING)
						var/obj/item/akt/lockpick/square/triangle/TR = I
						TR.damageItem("MEDIUM")
						playsound(src, 'modular_septic/sound/effects/movedoor.ogg', 70, FALSE, 4)
						open()
						return
					if(diceroll <= DICE_FAILURE)
						src.visible_message(span_steal("[user] tried to lockpick [src], but failed!"),span_steal("You failed to lockpick [src]."), span_hear("You hear the sound of failed lockpicking."))
						user.changeNext_move(CLICK_CD_GRABBING)
						var/obj/item/akt/lockpick/square/triangle/TR = I
						TR.damageItem("HARD")
						sound_hint()
						return
				else
					to_chat(user, span_steal("Here is a weak lock!"))
					return