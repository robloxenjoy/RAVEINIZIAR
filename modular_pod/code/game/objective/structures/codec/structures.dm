/obj/structure/codec/lampala
	name = "Лампа"
	desc = "А нахуя нам видеть это всё?"
	icon = 'modular_pod/icons/obj/things/things.dmi'
	icon_state = "lampala"
	plane = GAME_PLANE_BLOOM
	layer = FLY_LAYER
	density = TRUE
	anchored = TRUE
	light_range = 4
	light_power = 1
	light_color = "#faf5e9"

/obj/structure/codec/svetilka
	name = "Светилище"
	desc = "Освещает комнату и просвещает твою гнилую душёнку."
	icon = 'modular_pod/icons/obj/things/things.dmi'
	icon_state = "svetilka"
	plane = GAME_PLANE_BLOOM
	layer = FLY_LAYER
	density = TRUE
	anchored = TRUE
	light_range = 4
	light_power = 1
	light_color = "#f9619f"

/obj/structure/codec/firething
	name = "Светилище"
	desc = "Это правда греет?"
	icon = 'modular_pod/icons/obj/things/things_3.dmi'
	icon_state = "lighter"
	plane = GAME_PLANE_BLOOM
	layer = FLY_LAYER
	density = TRUE
	anchored = TRUE
	light_range = 4
	light_power = 2
	light_color = "#ffb04a"

/obj/structure/codec/bulb/green
	name = "Лампочка"
	desc = "Как будет не светит, а наоборот."
	icon = 'modular_pod/icons/obj/things/things_2.dmi'
	icon_state = "bulb_green"
	plane = GAME_PLANE_BLOOM
	layer = FLY_LAYER
	density = FALSE
	anchored = TRUE
	light_range = 3
	light_power = 1
	light_color = "#cbe395"

/obj/structure/codec/window
	max_integrity = 800
	integrity_failure = 0.1
	pass_flags = LETPASSTHROW
	plane = ABOVE_GAME_PLANE
	layer = FLY_LAYER
	density = TRUE
	anchored = TRUE
	opacity = FALSE
	var/open = FALSE
	var/opaque_closed = FALSE
	var/can_walk = TRUE
	var/can_touch = TRUE
	var/knocksound = 'sound/effects/Glassknock.ogg'

/obj/structure/codec/window/green
	name = "Окно"
	desc = "Может быть это грязь на нём. А может, оно просто зелёное."
	icon = 'modular_pod/icons/obj/things/things_2.dmi'
	icon_state = "window_green-closed"
	base_icon_state = "window_green"

/obj/structure/codec/window/red
	name = "Окно"
	desc = "На нём не видно крови, но она там есть."
	icon = 'modular_pod/icons/obj/things/things_2.dmi'
	icon_state = "window_va-closed"
	base_icon_state = "window_va"
	opaque_closed = TRUE

/obj/structure/codec/window/proc/toggle()
	open = !open
	if(can_walk)
		if(open)
			set_density(FALSE)
			set_opacity(FALSE)
		else
			set_density(TRUE)
			if(opaque_closed)
				set_opacity(TRUE)

	update_appearance()

/obj/structure/codec/window/update_icon_state()
	icon_state = "[base_icon_state]-[open ? "open" : "closed"]"
	return ..()

/obj/structure/codec/window/attack_hand_secondary(mob/living/user, list/modifiers)
	. = ..()
	if(can_touch)
		if(user.a_intent == INTENT_GRAB)
//		playsound(loc, 'sound/effects/curtain.ogg', 50, TRUE)
			toggle()

/obj/structure/codec/window/attack_hand(mob/living/user, list/modifiers)
	. = ..()
	if(.)
		return
	if(user.a_intent != INTENT_GRAB)
		user.visible_message(span_notice("[user] стучит по [src]."), \
			span_notice("Я стучу по [src]."))
		user.changeNext_move(CLICK_CD_WRENCH)
		playsound(src, knocksound, 50, TRUE)

/obj/structure/codec/window/CanPass(atom/movable/mover, border_dir)
	. = ..()
	if(open)
		if(istype(mover) && (mover.pass_flags & PASSTABLE))
			return TRUE
		if(mover.throwing)
			return TRUE
	return ..()

#define DOOR_CLOSE_WAIT 60

/obj/machinery/codec/door
	name = "Дверь"
	desc = "Лучше не открывать."
	icon = 'modular_pod/icons/obj/things/things_2.dmi'
	icon_state = "door_blue1"
	base_icon_state = "door_blue"
	opacity = TRUE
	density = TRUE
	plane = ABOVE_GAME_PLANE
	layer = FLY_LAYER
	var/doorOpen = 'modular_septic/sound/doors/door_metal_open.ogg'
	var/doorClose = 'modular_septic/sound/doors/door_metal_close.ogg'
	var/doorDeni = list('modular_septic/sound/doors/door_metal_try1.ogg', 'modular_septic/sound/doors/door_metal_try2.ogg')
	COOLDOWN_DECLARE(key_cooldown)
	var/key_cooldown_duration = 1 SECONDS
	var/key_worthy = FALSE
	var/open_cooldown_duration = 2 SECONDS
	COOLDOWN_DECLARE(open_cooldown)
	var/locked = FALSE
	var/autoclose = FALSE
	var/visible = TRUE

/obj/machinery/codec/door/proc/open(mob/user)
	if(!COOLDOWN_FINISHED(src, open_cooldown))
		return
	if(!density)
		return 1
	if(locked)
		playsound(src, doorDeni, 70, FALSE)
		sound_hint()
		COOLDOWN_START(src, open_cooldown, open_cooldown_duration)
		if(user)
			user.visible_message(span_danger("[user] трясёт ручку [src]."), \
								span_notice("Заперто!"))
		return
	set_opacity(0)
	set_density(FALSE)
	flags_1 &= ~PREVENT_CLICK_UNDER_1
//	layer = initial(layer)
	update_appearance()
	set_opacity(0)
	air_update_turf(TRUE, FALSE)
	if(autoclose)
		autoclose_in(DOOR_CLOSE_WAIT)
	playsound(src, doorOpen, 65, FALSE)
	COOLDOWN_START(src, open_cooldown, open_cooldown_duration)
	return 1

/obj/machinery/codec/door/proc/close()
	if(!COOLDOWN_FINISHED(src, open_cooldown))
		return
	if(density)
		return TRUE
	for(var/atom/movable/M in get_turf(src))
		if(M.density && M != src) //something is blocking the door
			if(autoclose)
				autoclose_in(DOOR_CLOSE_WAIT)
			return
	set_density(TRUE)
	flags_1 |= PREVENT_CLICK_UNDER_1
	update_appearance()
	if(visible)
		set_opacity(1)
	air_update_turf(TRUE, TRUE)
	playsound(src, doorClose, 65, FALSE)
	COOLDOWN_START(src, open_cooldown, open_cooldown_duration)
	return TRUE

/obj/machinery/codec/door/proc/try_door_unlock(user)
	if(allowed(user))
		if(locked)
			unlock()
		else
			lock()
	return TRUE

/obj/machinery/codec/door/attackby(obj/item/I, mob/living/user, params)
	. = ..()
	if(!COOLDOWN_FINISHED(src, key_cooldown))
		to_chat(user, span_warning("Нужно успокоиться."))
		return
	if(istype(I, /obj/item/key) && key_worthy)
		var/obj/item/key/key = I
		if(key.door_allowed(src)) //I...?
			if(!locked)
				locked = TRUE
			else
				locked = FALSE
			to_chat(user, span_notice("Я использую [I] на [src]."))
			playsound(src, 'modular_septic/sound/effects/keys_use.ogg', 75, FALSE)
		else
			to_chat(user, span_warning("Не то."))
			playsound(src, 'modular_septic/sound/effects/keys_remove.ogg', 75, FALSE)
		add_fingerprint(user)
		sound_hint()
		COOLDOWN_START(src, key_cooldown, key_cooldown_duration)
		return TRUE

	if(istype(I, /obj/item/storage/belt/keychain))
		for (var/obj/item/key/podpol/KK in I.contents)
			if(KK.door_allowed(src) && key_worthy)
				if(locked)
					visible_message("<span class = 'notice'>[user] отпирает [src].</span>")
					playsound(src, 'modular_septic/sound/effects/keys_use.ogg', 75, FALSE)
					locked = FALSE
				else
					visible_message("<span class = 'notice'>[user] запирает [src].</span>")
					playsound(src, 'modular_septic/sound/effects/keys_use.ogg', 75, FALSE)
					locked = TRUE
			else
				to_chat(user, span_warning("Не подходит."))
				playsound(src, 'modular_septic/sound/effects/keys_remove.ogg', 75, FALSE)
	return ..()

/obj/machinery/codec/door/allowed(mob/M, obj/item/key/key)
	if(key?.door_allowed(src))
		return TRUE
	return ..()

/obj/machinery/codec/door/attack_hand(mob/user, list/modifiers)
	. = ..()
	if(.)
		return
	if(density)
		open()
	else
		close()

/obj/machinery/codec/door/update_icon_state()
	icon_state = "[base_icon_state][density]"
	return ..()

/obj/machinery/codec/door/proc/autoclose()
	if(!QDELETED(src) && !density && !locked && autoclose)
		close()

/obj/machinery/codec/door/proc/autoclose_in(wait)
	addtimer(CALLBACK(src, .proc/autoclose), wait, TIMER_UNIQUE | TIMER_NO_HASH_WAIT | TIMER_OVERRIDE)

/obj/machinery/codec/door/proc/lock()
	return

/obj/machinery/codec/door/proc/unlock()
	return

/obj/machinery/codec/door/red
	name = "Дверь"
	desc = "ОБЫЧНАЯ!"
	icon_state = "door_red1"
	base_icon_state = "door_red"

#undef DOOR_CLOSE_WAIT

/obj/structure/sign/poster/contraband/codec/o
	name = "Гедвяница"
	desc = "Считалось символом язычества, обозначающий падающее солнце как конец света. Теперь же это символ других фанатиков, и я думаю, мы знаем про каких фанатиков мы говорим."
	icon = 'modular_pod/icons/obj/things/things_3.dmi'
	icon_state = "poster_o"

/obj/structure/sign/poster/contraband/codec/ring
	name = "Кольцо"
	desc = "Это меня пугает!"
	icon = 'modular_pod/icons/obj/things/things_3.dmi'
	icon_state = "symb_1"
	rvat = FALSE

/obj/structure/sign/poster/contraband/codec/strong
	name = "Лик"
	desc = "Восславь силу в себе."
	icon = 'modular_pod/icons/obj/things/things_3.dmi'
	icon_state = "eviln"
	rvat = FALSE

/obj/structure/sign/poster/contraband/codec/painting/m
	name = "Картина"
	desc = "Пошлятина."
	icon = 'modular_pod/icons/obj/things/things_3.dmi'
	icon_state = "painting_1"
	rvat = FALSE