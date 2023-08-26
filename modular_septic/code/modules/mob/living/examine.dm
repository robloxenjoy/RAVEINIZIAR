/// Things that happen when we examine an atom, duh
/mob/living/on_examine_atom(atom/examined, examine_more = FALSE)
	if(!client || (!DirectAccess(examined) && get_dist(src, examined) > EYE_CONTACT_RANGE) || (stat >= UNCONSCIOUS) || is_blind())
		return

	if(!HAS_TRAIT(src, TRAIT_FLUORIDE_STARE))
		if(!ismob(examined))
			visible_message(span_emote(span_notice("<span style='color: [chat_color];'><b>[src]</b></span> looks at [examined].")), \
							span_notice("I look at [examined]."), \
							vision_distance = EYE_CONTACT_RANGE)
		else
			var/mob/mob_examined = examined
			visible_message(span_emote(span_notice("<span style='color: [chat_color];'><b>[src]</b></span> looks at \
							<span style='color: [mob_examined.chat_color];'><b>[examined]</b></span>.")), \
							span_notice("I look at <b>[examined]</b>."), \
							vision_distance = EYE_CONTACT_RANGE)
	else
		if(!ismob(examined))
			visible_message(span_emote(span_notice("<span style='color: [chat_color];'><b>[src]</b></span> fluoride stares [examined].")), \
						span_notice("I fluoride stare <b>[examined]</b>."), \
						vision_distance = EYE_CONTACT_RANGE)
		else
			var/mob/mob_examined = examined
			examined.playsound_local(examined, 'modular_pod/sound/eff/Stare.ogg', 40, FALSE)
			visible_message(span_emote(span_notice("<span style='color: [chat_color];'><b>[src]</b></span> fluoride stares \
						<span style='color: [mob_examined.chat_color];'><b>[examined]</b></span>.")), \
						span_notice("I fluoride stare <b>[examined]</b>."), \
						vision_distance = EYE_CONTACT_RANGE)
	if(HAS_TRAIT(src, TRAIT_HORROR_STARE))
		if(!ismob(examined))
			visible_message(span_emote(span_notice("<span style='color: [chat_color];'><b>[src]</b></span> horror stares [examined].")), \
						span_notice("I horror stare <b>[examined]</b>."), \
						vision_distance = EYE_CONTACT_HORROR_RANGE)
		else
			var/mob/mob_examined = examined
			visible_message(span_emote(span_notice("<span style='color: [chat_color];'><b>[src]</b></span> horror stares \
						<span style='color: [mob_examined.chat_color];'><b>[examined]</b></span>.")), \
						span_notice("I horror stare <b>[examined]</b>."), \
						vision_distance = EYE_CONTACT_HORROR_RANGE)
