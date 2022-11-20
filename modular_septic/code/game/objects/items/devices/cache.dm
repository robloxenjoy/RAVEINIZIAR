#define CACHE_CLOSED 1
#define CACHE_CLOSING 2
#define CACHE_OPEN 3
#define CACHE_OPENING 4

/obj/machinery/cache
	name = "Wall-mounted Cache"
	desc = "A cache meant for securing goods in a nice, steel-reinforced package."
	icon = 'modular_septic/icons/obj/structures/efn.dmi'
	icon_state = "cache"
	base_icon_state = "cache"
	plane = GAME_PLANE_UPPER
	layer = WALL_OBJ_LAYER
	density = FALSE
	resistance_flags = INDESTRUCTIBLE | LAVA_PROOF | FIRE_PROOF | UNACIDABLE | ACID_PROOF | FREEZE_PROOF
	// Determines If people can reach inside and use the cache.
	var/locked = TRUE
	var/buttonsound = 'modular_septic/sound/efn/cache_button.ogg'
	var/cacheOpen = 'modular_septic/sound/efn/cache_open.ogg'
	var/cacheClose = 'modular_septic/sound/efn/cache_close.ogg'
	var/cachecoverBreak = 'modular_septic/sound/efn/cache_cover_open.ogg'
	var/state = CACHE_CLOSED
	var/cover_open = FALSE
	var/firsthack = 'modular_septic/sound/efn/cache_elec1.ogg'
	var/secondhack = 'modular_septic/sound/efn/cache_elec2.ogg'

/obj/machinery/cache/update_overlays()
	. = ..()
	switch(state)
		if(CACHE_CLOSED)
			. += "[base_icon_state]_closed"
		if(CACHE_CLOSING)
			. += "[base_icon_state]_closing"
		if(CACHE_OPEN)
			. += "[base_icon_state]_opened"
		if(CACHE_OPENING)
			. += "[base_icon_state]_opening"
	if(cover_open)
		. += "[base_icon_state]_insides"

/obj/machinery/cache/Initialize(mapload)
	. = ..()
	update_appearance()
	if(locked)
		SEND_SIGNAL(src, COMSIG_TRY_STORAGE_SET_LOCKSTATE, TRUE)

/obj/machinery/cache/goated_with_the_sauce

/obj/machinery/cache/goated_with_the_sauce/Initialize(mapload)
	. = ..()
	new /obj/effect/spawner/random/lootshoot/clothing(src)
	if(prob(80))
		new /obj/effect/spawner/random/lootshoot(src)
	if(prob(30))
		new /obj/effect/spawner/random/lootshoot/clothing(src)
	if(prob(5))
		new /obj/effect/spawner/random/lootshoot/rare(src)

/obj/machinery/cache/goated_with_the_sauce/north
	pixel_y = 30

/obj/machinery/cache/ComponentInitialize()
	. = ..()
	AddComponent(/datum/component/storage/concrete)
	var/datum/component/storage/STR = GetComponent(/datum/component/storage)
	STR.max_w_class = 12

/obj/machinery/cache/attack_hand_secondary(mob/living/user, list/modifiers)
	. = SECONDARY_ATTACK_CANCEL_ATTACK_CHAIN
	playsound(src, buttonsound, 75, FALSE)
	if(locked)
		user.visible_message(span_notice("[user] presses the lock button, but It only buzzes!"), \
		span_notice("[fail_msg()] The damn thing is fucking locked!"))
		return
	else
		user.visible_message(span_notice("[user] presses the lock button"), \
		span_notice("I press the lock button on the [src]."))
		open_cache()

/obj/machinery/cache/attack_hand_tertiary(mob/living/user, list/modifiers)
	. = ..()
	if(cover_open)
		to_chat(user, span_warning("[fail_msg()] It's already fucking broken I don't need to break it!"))
		return
	if(!do_after(user, 2 SECONDS, src))
		to_chat(user, span_warning("[fail_msg()]"))
		return
	if(GET_MOB_ATTRIBUTE_VALUE(user, STAT_STRENGTH) > 11)
		user.visible_message(span_danger("[user] rips the protective cover off the [src]!") , \
			span_warning("I rip the protective cover off of the [src]!"))
		open_cover()
	else
		to_chat(user, span_warning("[fail_msg()] The cover is firm!"))
	return COMPONENT_TERTIARY_CANCEL_ATTACK_CHAIN

/obj/machinery/cache/attack_hand(mob/living/user, list/modifiers)
	. = ..()
	if(!cover_open)
		to_chat(user, span_warning("The cover is not open."))
		return
	if(!locked)
		to_chat(user, span_warning("[src] has already been successfully hacked."))
		return
	if(GET_MOB_SKILL_VALUE(user, SKILL_ELECTRONICS) <= 4)
		to_chat(user, span_danger("I literally don't know how any of this shit works."))
		return
	to_chat(user, span_warning("I begin hacking."))
	if(!do_after(user, 1.2 SECONDS, src))
		to_chat(user, span_warning("I failed."))
		return
	to_chat(user, span_warning("I take apart the stupid wires."))
	playsound(src, firsthack, 70, FALSE)
	do_sparks(1, FALSE, src)
	if(!do_after(user, 1.2 SECONDS, src))
		to_chat(user, span_warning("I failed."))
		return
	to_chat("I successfully hotwire the [src]!")
	playsound(src, secondhack, 70, FALSE)
	do_sparks(2, FALSE, src)
	locked = FALSE

/obj/machinery/cache/attacked_by(obj/item/weapon, mob/living/user)
	if(weapon.tool_behaviour == TOOL_CROWBAR)
		if(cover_open)
			to_chat(user, span_warning("[fail_msg()] It's already fucking broken I don't need to break it!"))
			return
		if(!do_after(user, 1.2 SECONDS, src))
			to_chat(user, span_warning("[fail_msg()]"))
			return
		if(GET_MOB_ATTRIBUTE_VALUE(user, STAT_STRENGTH) > 7)
			user.visible_message(span_danger("[user] rips the protective cover off the [src] with the [weapon]!") , \
				span_warning("I rip the protective cover off of the [src] with the [weapon]!"))
			open_cover()
		else
			to_chat(user, span_warning("[fail_msg()] The cover is too firm for me!"))
		return
	return ..()

/obj/machinery/cache/proc/open_cover(mob/living/user)
	if(state == CACHE_OPENING || state == CACHE_CLOSING)
		to_chat(user, span_notice("[fail_msg()] It's doing It's thing!"))
		return
	cover_open = TRUE
	playsound(src, cachecoverBreak, 35, FALSE)
	update_appearance(UPDATE_ICON)

/obj/machinery/cache/proc/open_cache(mob/living/user)
	if(state == CACHE_OPENING || state == CACHE_CLOSING)
		to_chat(user, span_notice("[fail_msg()] It's doing It's thing!"))
		return
	var/nice
	if(prob(20))
		nice = "nice"
	if(state == CACHE_CLOSED)
		visible_message(span_achievementgood("[src] slides open with a [nice] hiss!"))
		SEND_SIGNAL(src, COMSIG_TRY_STORAGE_SET_LOCKSTATE, FALSE)
		playsound(src, cacheOpen, 85, FALSE)
		INVOKE_ASYNC(src, .proc/open)
	else
		visible_message(span_danger("[src] slides closed with a [nice] hiss!"))
		SEND_SIGNAL(src, COMSIG_TRY_STORAGE_SET_LOCKSTATE, TRUE)
		SEND_SIGNAL(src, COMSIG_TRY_STORAGE_HIDE_FROM, usr)
		playsound(src, cacheClose, 85, FALSE)
		INVOKE_ASYNC(src, .proc/close)

/obj/machinery/cache/proc/open()
	state = CACHE_OPENING
	update_appearance(UPDATE_ICON)
	sleep(6)
	state = CACHE_OPEN
	update_appearance(UPDATE_ICON)

/obj/machinery/cache/proc/close()
	state = CACHE_CLOSING
	update_appearance(UPDATE_ICON)
	sleep(6)
	state = CACHE_CLOSED
	update_appearance(UPDATE_ICON)

#undef CACHE_CLOSED
#undef CACHE_CLOSING
#undef CACHE_OPEN
#undef CACHE_OPENING
