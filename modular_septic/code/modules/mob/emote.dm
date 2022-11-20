/datum/emote/run_emote(mob/user, params, type_override, intentional = FALSE)
	. = TRUE
	if(!can_run_emote(user, TRUE, intentional))
		return FALSE

	var/msg = select_message_type(user, message, intentional)
	if(params && message_param)
		msg = select_param(user, params)

	msg = replace_pronoun(user, msg)

	if(!msg)
		return

	user.log_message(msg, LOG_EMOTE)
	var/dchatmsg = "<span style='color: [user.chat_color];'><b>[user]</b></span> [msg]"

	var/tmp_sound = get_sound(user)
	if(tmp_sound && (!only_forced_audio || !intentional) && !TIMER_COOLDOWN_CHECK(user, type))
		TIMER_COOLDOWN_START(user, type, audio_cooldown)
		playsound(user, tmp_sound, 50, vary)

	var/user_turf = get_turf(user)
	if(user.client)
		for(var/mob/ghost as anything in GLOB.dead_mob_list)
			if(!ghost.client || isnewplayer(ghost))
				continue
			if(ghost.client.prefs?.chat_toggles & CHAT_GHOSTSIGHT && !(ghost in viewers(user_turf, null)))
				ghost.show_message("<span class='emote'>[FOLLOW_LINK(ghost, user)] [dchatmsg]</span>")

	if(emote_type == EMOTE_AUDIBLE)
		user.audible_message(msg, audible_message_flags = EMOTE_MESSAGE)
		user.sound_hint()
	else
		user.visible_message(msg, visible_message_flags = EMOTE_MESSAGE)

	SEND_SIGNAL(user, COMSIG_MOB_EMOTED(key))
