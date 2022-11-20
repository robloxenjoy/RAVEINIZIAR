/mob/living/proc/lay_to_rest(msg_to_rester = DEFAULT_REST_TARGET_MSG, msg_to_observer = DEFAULT_REST_OBSERVER_MSG(src), forced)
	if(!mind)
		return
	var/mob/dead/observer/our_ghost = grab_ghost(FALSE)
	if(!our_ghost)
		return
	our_ghost.can_rest = TRUE
	if(HAS_TRAIT(mind, TRAIT_NOLAYTOREST) && !forced)
		to_chat(our_ghost, span_warning("My vessel has been laid to rest, yet I still cannot leave the mortal plane... I am stuck down here."))
	else
		to_chat(our_ghost, span_notice("[msg_to_rester]"))
	for(var/mob/viewer in fov_viewers(world.view, src))
		to_chat(viewer, span_nicegreen("[msg_to_observer]"))
		SEND_SIGNAL(viewer, COMSIG_ADD_MOOD_EVENT, "properburial", /datum/mood_event/proper_burial)
