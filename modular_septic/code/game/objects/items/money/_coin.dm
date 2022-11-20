/obj/item/money/coin
	name = "coin"
	desc = "My life is like a videogame, trying hard to beat the stage, all while i am still collecting coins."
	drop_sound = 'modular_septic/sound/items/coin_drop.wav'
	flags_1 = CONDUCT_1
	custom_materials = list(/datum/material/iron = 400)
	is_coin = TRUE
	var/list/sides = list("heads","tails")
	var/side
	COOLDOWN_DECLARE(flip_cooldown)

/obj/item/money/coin/Initialize(mapload)
	. = ..()
	if(!LAZYLEN(sides))
		stack_trace("[src] ([type]) has no sides!")
	side = pick(sides)
	update_appearance()

/obj/item/money/coin/attack_self(mob/user, modifiers)
	. = ..()
	if(!COOLDOWN_FINISHED(src, flip_cooldown))
		return
	COOLDOWN_START(src, flip_cooldown, 1 SECONDS)
	icon_state = "[base_icon_state]_[side]_flip"
	side = pick(sides)
	playsound(src, 'modular_septic/sound/items/coin_flip.wav', 60)
	user.visible_message(span_notice("[user] flips [src]..."), \
		span_notice("I flip [src]..."), \
		span_hear("I hear a metal object being flung."))
	sleep(1 SECONDS)
	balloon_alert_to_viewers("[capitalize(side)]!")
	visible_message(span_notice("[src] lands on [side]."), blind_message = span_hear("I hear a metal object falling down."))
	update_appearance()

/obj/item/money/coin/throw_impact(atom/hit_atom, datum/thrownthing/throwingdatum)
	. = ..()
	if(!COOLDOWN_FINISHED(src, flip_cooldown))
		return
	COOLDOWN_START(src, flip_cooldown, 1 SECONDS)
	side = pick(sides)
	update_appearance()
	balloon_alert_to_viewers("[capitalize(side)]!")
	visible_message(span_warning("[src] lands on [side]."))

/obj/item/money/coin/update_icon_state()
	. = ..()
	icon_state = "[base_icon_state]_[side]"
