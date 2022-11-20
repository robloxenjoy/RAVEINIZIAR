/mob/verb/examinate(atom/examinify as mob|obj|turf in view())
	set name = "Examine"
	set category = "IC"

	if(isturf(examinify) && !(sight & SEE_TURFS) && !(examinify in view(client ? client.view : world.view, src)))
		return

	if(is_blind() && !blind_examine_check(examinify)) //blind people see things differently (through touch)
		return

	face_atom(examinify)
	var/flags = SEND_SIGNAL(src, COMSIG_MOB_EXAMINATE, examinify)
	if(flags & COMPONENT_NO_EXAMINATE)
		return
	else if(flags & COMPONENT_EXAMINATE_BLIND)
		to_chat(src, span_warning("Something is there but i can't see it!"))
		return
	var/atom/distance_referee = examinify
	if(isitem(examinify))
		var/obj/item/examinify_item = examinify
		if(examinify_item.stored_in)
			distance_referee = examinify_item.stored_in
	var/too_far_away = !isnull(examinify.maximum_examine_distance) && (get_dist(src, distance_referee) > examinify.maximum_examine_distance)
	if(!isobserver(src) && too_far_away)
		to_chat(src, span_warning("It's too far away."))
		return
	var/list/result
	var/examine_more = FALSE
	if(client)
		LAZYINITLIST(client.recent_examines)
		var/ref_to_atom = ref(examinify)
		var/examine_time = LAZYACCESS(client.recent_examines, ref_to_atom)
		if(examine_time && (world.time - examine_time < EXAMINE_MORE_WINDOW))
			examine_more = TRUE
			result = examinify.examine_more(src)
			if(!LAZYLEN(result))
				result = list(span_notice("<i>I examine [examinify] closer, but find nothing of interest...</i>"))
			handle_eye_contact(examinify)
		else
			result = examinify.examine(src)
			client.recent_examines[ref_to_atom] = world.time // set the value to when the examine cooldown ends
			addtimer(CALLBACK(src, .proc/clear_from_recent_examines, ref_to_atom), RECENT_EXAMINE_MAX_WINDOW)
			handle_eye_contact(examinify)
	else
		result = examinify.examine(src) // if a tree is examined but no client is there to see it, did the tree ever really exist?

	if(!examine_more)
		var/list/examine_chaser = examinify.examine_chaser(src)
		if(LAZYLEN(examine_chaser))
			result += examine_chaser
		var/list/topic_examine = examinify.topic_examine(src)
		if(LAZYLEN(topic_examine))
			result += div_infobox("[topic_examine.Join(" | ")]")

	if(result)
		to_chat(src, span_infoplain(div_infobox("[result.Join("\n")]")))

/mob/proc/open_peeper()
	set name = "Open Peeper"
	set desc = "This opens the peeper panel."
	set category = "Peeper"

	hud_used?.peeper?.show_peeper(src)

/mob/proc/close_peeper()
	set name = "Close Peeper"
	set desc = "This closes the peeper panel."
	set category = "Peeper"

	hud_used?.peeper?.hide_peeper(src)
