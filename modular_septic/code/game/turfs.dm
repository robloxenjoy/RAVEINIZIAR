/turf/Initialize(mapload)
	. = ..()
	// god has forced me to not put this in /atom/proc/Initialize()
	if(frill_icon)
		AddElement(/datum/element/frill, frill_icon, frill_uses_icon_state, upper_frill_plane, upper_frill_layer, lower_frill_plane, lower_frill_layer)

/turf/attack_hand(mob/user, list/modifiers)
	. = ..()
	var/mob/living/living_user = user
	if(istype(living_user) && living_user.client && living_user.movement_locked && living_user.body_position == LYING_DOWN)
		if(living_user.a_intent == INTENT_GRAB)
			if(living_user.client.Move(src, get_dir(living_user, src)))
				user.visible_message(span_warning("<b>[user]</b> crawls on [src]."), \
									span_warning("I crawl on [src]."))
