/obj/structure/ladder/examine(mob/user)
	. = ..()
	if(up && down)
		. += span_info("[src] can lead you upwards or downwards.")
	else if(up)
		. += span_info("[src] can lead you upwards.")
	else if(down)
		. += span_info("[src] can lead you downwards.")
	else
		. += span_info("[src] is like arguing with a woman - It leads you nowhere.")

/obj/structure/ladder/attack_hand(mob/user, list/modifiers)
	. = ..()
	if(.)
		return
	use(user, TRUE)

/obj/structure/ladder/attack_hand_secondary(mob/user, list/modifiers)
	. = ..()
	if(. == SECONDARY_ATTACK_CANCEL_ATTACK_CHAIN)
		return
	use(user, FALSE)
	return SECONDARY_ATTACK_CANCEL_ATTACK_CHAIN

/obj/structure/ladder/attack_paw(mob/user, list/modifiers)
	return use(user, !LAZYACCESS(modifiers, RIGHT_CLICK))

/obj/structure/ladder/attack_alien(mob/user, list/modifiers)
	return use(user, !LAZYACCESS(modifiers, RIGHT_CLICK))

/obj/structure/ladder/attack_larva(mob/user, list/modifiers)
	return use(user, !LAZYACCESS(modifiers, RIGHT_CLICK))

/obj/structure/ladder/attack_animal(mob/user, list/modifiers)
	return use(user, !LAZYACCESS(modifiers, RIGHT_CLICK))

/obj/structure/ladder/attack_slime(mob/user, list/modifiers)
	return use(user, !LAZYACCESS(modifiers, RIGHT_CLICK))

/obj/structure/ladder/attack_robot(mob/living/silicon/robot/user)
	return use(user, TRUE)

/obj/structure/ladder/attack_robot_secondary(mob/user, list/modifiers)
	use(user, FALSE)
	return SECONDARY_ATTACK_CANCEL_ATTACK_CHAIN

/obj/structure/ladder/attack_ghost(mob/dead/observer/user, list/modifiers)
	. = ..()
	if(.)
		return
	use(user, !LAZYACCESS(modifiers, RIGHT_CLICK), TRUE)

/obj/structure/ladder/proc/use(mob/user, going_up = TRUE, is_ghost = FALSE)
	if(!is_ghost)
		if(!in_range(src, user) || user.incapacitated())
			return
		add_fingerprint(user)
	if(!((going_up && up) || (!going_up && down))) //if you're going up and there's no up / if you're going down and there's no down
		to_chat(user, span_warning("This ladder does not go [going_up ? "up" : "down"]."))
		return

	travel(going_up, user, is_ghost, going_up ? up : down)
