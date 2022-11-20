/mob/living/blind_examine_check(atom/examined_thing)
	//need to be next to something and awake
	if(!Adjacent(examined_thing) || incapacitated())
		to_chat(src, span_warning("Something is there, but i can't see it!"))
		return FALSE

	//you can examine things you're holding directly, but you can't examine other things if your hands are full
	var/active_item = get_active_held_item()
	if(active_item && !(examined_thing in held_items))
		to_chat(src, span_warning("My hands are too full to examine this!"))
		return FALSE

	//you can only initiate exaimines if you have a hand, it's not disabled, and only as many examines as you have hands
	var/obj/item/bodypart/active_hand = has_active_hand() ? get_active_hand() : null
	if(!active_hand || active_hand.bodypart_disabled || LAZYLEN(do_afters) >= usable_hands)
		to_chat(src, span_warning("I don't have a free hand to examine this!"))
		return FALSE

	//you can only queue up one examine on something at a time
	if(DOING_INTERACTION_WITH_TARGET(src, examined_thing))
		return FALSE

	to_chat(src, span_notice("I start feeling around for something..."))
	visible_message(span_notice("<b>[src]</b> begins feeling around for \the [examined_thing]..."))

	/// how long it takes for the blind person to find the thing they're examining
	var/examine_delay_length = rand(1 SECONDS, 2 SECONDS)
	if(client?.recent_examines && client?.recent_examines[ref(examined_thing)]) //easier to find things we just touched
		examine_delay_length = 0.33 SECONDS
	else if(isobj(examined_thing))
		examine_delay_length *= 1.5
	else if(ismob(examined_thing) && (examined_thing != src))
		examine_delay_length *= 2

	if((examine_delay_length > 0) && !do_after(src, examine_delay_length, target = examined_thing))
		to_chat(src, span_warning("I can't get a good feel for what is there."))
		return FALSE

	//now we touch the thing we're examining
	INVOKE_ASYNC(examined_thing, /atom/proc/attack_hand, src)
	if(!(examined_thing in src))
		inspect_atom(examined_thing)
	return TRUE
