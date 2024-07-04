/mob/living/start_pulling(atom/movable/AM, state, force = pull_force, supress_message = FALSE)
	if(!AM || !src)
		return FALSE
	if(!(AM.can_be_pulled(src, state, force)))
		return FALSE
	if(throwing || !(mobility_flags & MOBILITY_PULL))
		return FALSE
	if(SEND_SIGNAL(src, COMSIG_LIVING_TRY_PULL, AM, force) & COMSIG_LIVING_CANCEL_PULL)
		return FALSE

	AM.add_fingerprint(src)

	// If we're pulling something then drop what we're currently pulling and pull this instead.
	if(pulling)
		// Are we trying to pull something we are already pulling? Then just stop here, no need to continue.
		if(AM == pulling)
			return
		stop_pulling()

	changeNext_move(CLICK_CD_PULLING)
	if(AM.pulledby)
		if(!supress_message)
			AM.visible_message(span_danger("<b>[src]</b> pulls <b>[AM]</b> from <b>[AM.pulledby]</b>'s grip."), \
							span_danger("<b>[src]</b> pulls me from <b>[AM.pulledby]</b>'s grip."), \
							ignored_mobs = src)
			to_chat(src, span_notice("I pull <b>[AM]</b> from <b>[AM.pulledby]</b>'s grip!"))
		log_combat(AM, AM.pulledby, "pulled from", src)
		AM.pulledby.stop_pulling() //an object can't be pulled by two mobs at once.

	pulling = AM
	AM.set_pulledby(src)

	SEND_SIGNAL(src, COMSIG_LIVING_START_PULL, AM, state, force)

	if(!supress_message)
		var/sound_to_play = 'sound/weapons/thudswoosh.ogg'
		if(ishuman(src))
			var/mob/living/carbon/human/H = src
			if(H.dna.species.grab_sound)
				sound_to_play = H.dna.species.grab_sound
			if(HAS_TRAIT(H, TRAIT_STRONG_GRABBER))
				sound_to_play = null
		if(sound_to_play)
			playsound(src.loc, sound_to_play, 50, TRUE, -1)

	update_pull_hud_icon()
	if(ismob(AM))
		var/mob/M = AM
		log_combat(src, M, "grabbed", addition="passive grab")
		if(!supress_message && !(iscarbon(AM) && HAS_TRAIT(src, TRAIT_STRONG_GRABBER)))
			M.visible_message(span_warning("<b>[src]</b> хватает <b>[M]</b> пассивно!"), \
							span_userdanger("<b>[src]</b> хватает меня пассивно!"), \
							ignored_mobs = src)
			to_chat(src, span_notice("Я хватаю <b>[M]</b> пассивно!"))
		M.LAssailant = WEAKREF(src)
		if(isliving(M))
			var/mob/living/L = M

			SEND_SIGNAL(M, COMSIG_LIVING_GET_PULLED, src)
			//Share diseases that are spread by touch
			for(var/thing in diseases)
				var/datum/disease/D = thing
				if(D.spread_flags & DISEASE_SPREAD_CONTACT_SKIN)
					L.ContactContractDisease(D)

			for(var/thing in L.diseases)
				var/datum/disease/D = thing
				if(D.spread_flags & DISEASE_SPREAD_CONTACT_SKIN)
					ContactContractDisease(D)
			update_pull_movespeed()
		set_pull_offsets(M, state)

/mob/living/grabbedby(mob/living/carbon/user, instant = FALSE, biting_grab = FALSE, forced = FALSE, grabsound = TRUE, silent = FALSE, forced_zone)
	//unconscious users cant grab
	if(user.stat >= UNCONSCIOUS)
		return FALSE
	if(user == src)
		attempt_self_grab(biting_grab)
		return FALSE
//	if(anchored || !isturf(user.loc))
//		return FALSE
	if(anchored)
		return FALSE
	if(!user.pulling || (user.pulling != src))
		var/helpful = IS_HELP_INTENT(user, null)
		user.start_pulling(src, supress_message = !helpful || biting_grab)
		if(helpful)
			return
	if(!(status_flags & CANPUSH) || HAS_TRAIT(src, TRAIT_PUSHIMMUNE))
		to_chat(user, span_warning("<b>[src]</b> can't be grabbed more aggressively!"))
		return FALSE
	if((user.grab_state >= GRAB_PASSIVE) && HAS_TRAIT(user, TRAIT_PACIFISM))
		to_chat(user, span_warning("I don't want to risk hurting <b>[src]</b>!"))
		return FALSE
	grippedby(user, instant, biting_grab, forced, grabsound, silent, forced_zone)

/mob/living/grippedby(mob/living/carbon/user, instant = FALSE, biting_grab = FALSE, forced = FALSE, grabsound = TRUE, silent = FALSE, forced_zone)
	// We need to be pulled
	if(src != user && (!user.pulling || (user.pulling != src)))
		return
	var/obj/item/grab/active_grab = user.get_active_held_item()
	if(active_grab)
		return
	active_grab = new()
	user.put_in_active_hand(active_grab, FALSE)
	if(QDELETED(active_grab))
		return
	user.changeNext_move(CLICK_CD_GRABBING)
	active_grab.registergrab(src, user, null, instant, FALSE)
	for(var/obj/item/grab/grabber in (user.held_items | user.get_item_by_slot(ITEM_SLOT_MASK)))
		grabber.update_grab_mode()
	active_grab.display_grab_message()

/mob/living/resist_grab(moving_resist)
	. = TRUE
	if(pulledby.grab_state || body_position == LYING_DOWN || HAS_TRAIT(src, TRAIT_GRABWEAKNESS))
		var/altered_grab_state = pulledby.grab_state
		if((body_position == LYING_DOWN || HAS_TRAIT(src, TRAIT_GRABWEAKNESS)) && pulledby.grab_state < GRAB_KILL) //If prone, resisting out of a grab is equivalent to 1 grab state higher. won't make the grab state exceed the normal max, however
			altered_grab_state++
		var/resist_chance = BASE_GRAB_RESIST_CHANCE /// see defines/combat.dm, this should be baseline 60%
		resist_chance = (resist_chance/altered_grab_state) ///Resist chance divided by the value imparted by your grab state. It isn't until you reach neckgrab that you gain a penalty to escaping a grab.
		if(prob(resist_chance))
			adjustFatigueLoss(5)
			visible_message(span_danger("<b>[src]</b> breaks free of <b>[pulledby]</b>'s grip!"), \
							span_danger("You break free of <b>[pulledby]</b>'s grip!"), \
							ignored_mobs = pulledby)
			to_chat(pulledby, span_warning("<b>[src]</b> breaks free of your grip!"))
			log_combat(pulledby, src, "broke grab")
			pulledby.stop_pulling()
			return FALSE
		else
			adjustFatigueLoss(5)//failure to escape still imparts a pretty serious penalty
			visible_message(span_danger("<b>[src]</b> struggles as they fail to break free of [pulledby]'s grip!"), \
							span_warning("You struggle as you fail to break free of [pulledby]'s grip!"), \
							ignored_mobs = pulledby)
			to_chat(pulledby, span_danger("<b>[src]</b> struggles as they fail to break free of your grip!"))
		if(moving_resist && client) //we resisted by trying to move
			client.move_delay = world.time + CLICK_CD_RESIST * 2
	else
		pulledby.stop_pulling()
		return FALSE

/mob/living/proc/attempt_self_grab()
	return
