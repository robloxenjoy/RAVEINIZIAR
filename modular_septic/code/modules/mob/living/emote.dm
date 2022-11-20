// Tilt
/datum/emote/living/tilt
	key = "tilt"
	key_third_person = "tilts"
	message = "tilts their head."
// Sneeze
/datum/emote/living/sneeze/get_sound(mob/living/user)
	if(ishuman(user))
		if(user.gender != FEMALE)
			return "modular_septic/sound/emotes/sneeze_male[rand(1,3)].ogg"
		else
			return "modular_septic/sound/emotes/sneeze_female[rand(1,2)].ogg"
	else
		return ..()

// Choking
/datum/emote/living/choke/get_sound(mob/living/user)
	if(ishuman(user))
		if(user.gender != FEMALE)
			return "modular_septic/sound/emotes/choke_male1.ogg"
		else
			return "modular_septic/sound/emotes/choke_female1.ogg"
	else
		return ..()

// Burping
/datum/emote/living/burp/get_sound(mob/living/user)
	if(ishuman(user))
		if(user.gender != FEMALE)
			return "modular_septic/sound/emotes/burp_male1.ogg"
		else
			return "modular_septic/sound/emotes/burp_female1.ogg"
	else
		return ..()

// Snoring
/datum/emote/living/snore/get_sound(mob/living/user)
	if(ishuman(user))
		return "modular_septic/sound/emotes/snore[rand(1, 7)].ogg"
	else
		return ..()

// Sniffing
/datum/emote/living/sniff/run_emote(mob/user, params, type_override, intentional)
	. = ..()
	if(.)
		var/turf/open/current_turf = get_turf(user)
		if(istype(current_turf) && current_turf.pollution)
			if(iscarbon(user))
				var/mob/living/carbon/carbon_user = user
				if(carbon_user.internal) //Breathing from internals means we cant smell
					return
				carbon_user.next_smell = world.time + SMELL_COOLDOWN
			current_turf.pollution.smell_act(user)

/datum/emote/living/sniff/get_sound(mob/living/user)
	if(ishuman(user))
		if(user.gender != FEMALE)
			return "modular_septic/sound/emotes/snore_male1.ogg"
		else
			return "modular_septic/sound/emotes/sniff_female1.ogg"
	else
		return ..()

// Sigh
/datum/emote/living/sigh/get_sound(mob/living/user)
	if(ishuman(user))
		if(user.gender != FEMALE)
			return "modular_septic/sound/emotes/sigh_male1.ogg"
		else
			return "modular_septic/sound/emotes/sigh_female[rand(1,2)].ogg"
	else
		return ..()

// Snore
/datum/emote/living/carbon/clap/get_sound(mob/living/user)
	if(ishuman(src))
		return "modular_septic/sound/emotes/snore[rand(1,7)].ogg"
	else
		return ..()

// Yawn
/datum/emote/living/yawn/get_sound(mob/living/user)
	if(ishuman(user))
		if(user.gender != FEMALE)
			return "modular_septic/sound/emotes/yawn_male[rand(1,2)].ogg"
		else
			return "modular_septic/sound/emotes/yawn_female[rand(1,3)].ogg"
	else
		return ..()

// Laughing sound
/datum/emote/living/laugh/get_sound(mob/living/user)
	if(ishuman(user))
		if(user.gender != FEMALE)
			return "modular_septic/sound/emotes/laugh_male[rand(1,5)].ogg"
		else
			return "modular_septic/sound/emotes/laugh_female[rand(1,5)].ogg"
	else
		return ..()

// Normal screaming
/datum/emote/living/scream/get_sound(mob/living/user)
	if(ishuman(user))
		if(user.gender != FEMALE)
			return "modular_septic/sound/emotes/terror_scream_male[rand(1,2)].ogg"
		else
			return "modular_septic/sound/emotes/terror_scream_female[rand(1,3)].ogg"
	else
		return ..()

// Falling down screaming
/datum/emote/living/fallscream
	key = "fallscream"
	key_third_person = "fallscreams"
	message = "screams!"
	emote_type = EMOTE_AUDIBLE
	muzzle_ignore = FALSE
	hands_use_check = FALSE

/datum/emote/living/fallscream/get_sound(mob/living/user)
	if(ishuman(user))
		if(user.gender != FEMALE)
			return "modular_septic/sound/emotes/falling_down_male[rand(1,3)].ogg"
		else
			return "modular_septic/sound/emotes/falling_down_female1.ogg"
	else
		return ..()

// Agony screaming
/datum/emote/living/agonyscream
	key = "agonyscream"
	key_third_person = "agonyscreams"
	message = "screams in agony!"
	emote_type = EMOTE_AUDIBLE
	muzzle_ignore = FALSE
	hands_use_check = FALSE

/datum/emote/living/agonyscream/get_sound(mob/living/user)
	if(ishuman(user))
		if(user.on_fire)
			if(user.gender != FEMALE)
				return "modular_septic/sound/emotes/agony_male[rand(1,15)].ogg"
			else
				return "modular_septic/sound/emotes/agony_female[rand(1,8)].ogg"
		else
			if(user.gender != FEMALE)
				return "modular_septic/sound/emotes/pain_scream_male[rand(1,3)].ogg"
			else
				return "modular_septic/sound/emotes/pain_scream_female[rand(1,7)].ogg"
	else
		return ..()

// Death scream - I swear this aint the same as death rattle
/datum/emote/living/deathscream
	key = "deathscream"
	key_third_person = "deathscreams"
	message = "screams!"
	emote_type = EMOTE_AUDIBLE
	muzzle_ignore = FALSE
	hands_use_check = FALSE

/datum/emote/living/deathscream/get_sound(mob/living/user)
	if(ishuman(user))
		if(user.gender != FEMALE)
			return "modular_septic/sound/emotes/death_scream_male[rand(1,5)].ogg"
		else
			return "modular_septic/sound/emotes/death_scream_female[rand(1,4)].ogg"
	else
		return ..()

// Death rattle, kinda like deathgasp i guess
/datum/emote/living/deathrattle
	key = "deathrattle"
	key_third_person = "deathrattles"
	message = "makes a disgusting noise."
	emote_type = EMOTE_AUDIBLE
	muzzle_ignore = TRUE
	hands_use_check = FALSE

/datum/emote/living/deathrattle/get_sound(mob/living/user)
	if(ishuman(user))
		return "modular_septic/sound/emotes/deathgasp.ogg"
	else
		return ..()

/datum/emote/living/deathgasp
	message = "makes a disgusting noise."

/datum/emote/living/crackaddict
	key = "crackaddict"
	key_third_person = "joyful laughs"
	message = "feels joyful."
	emote_type = EMOTE_AUDIBLE
	muzzle_ignore = TRUE
	hands_use_check = FALSE

/datum/emote/living/crackaddict/get_sound(mob/living/user)
	if(ishuman(user))
		return "modular_septic/sound/emotes/crack_addict.wav"
	else
		return ..()

// Fuck it deathgasp does the same sound
/datum/emote/living/deathgasp/get_sound(mob/living/user)
	if(ishuman(user))
		return "modular_septic/sound/emotes/deathgasp.ogg"
	else
		return ..()

// Grunting, moaning, and groaning all make the same sound
/datum/emote/living/grunt
	key = "grunt"
	key_third_person = "grunts"
	message = "grunts."
	emote_type = EMOTE_AUDIBLE

/datum/emote/living/grunt/get_sound(mob/living/user)
	if(ishuman(user))
		if(user.gender != FEMALE)
			return "modular_septic/sound/emotes/moan_male[rand(1, 8)].ogg"
		else
			return "modular_septic/sound/emotes/moan_female[rand(1, 8)].ogg"
	else
		return ..()

/datum/emote/living/groan/get_sound(mob/living/user)
	if(ishuman(user))
		if(user.gender != FEMALE)
			return "modular_septic/sound/emotes/moan_male[rand(1, 8)].ogg"
		else
			return "modular_septic/sound/emotes/moan_female[rand(1, 8)].ogg"
	else
		return ..()

// Gasping
/datum/emote/living/gasp/get_sound(mob/living/user)
	if(ishuman(user))
		if(user.gender != FEMALE)
			return "modular_septic/sound/emotes/gasp_male[rand(1, 7)].ogg"
		else
			return "modular_septic/sound/emotes/gasp_female[rand(1, 13)].ogg"
	else
		return ..()

// Throat gargling
/datum/emote/living/gargle
	key = "gargle"
	key_third_person = "gargles"
	message = "gargles their throat!"
	emote_type = EMOTE_AUDIBLE
	muzzle_ignore = TRUE
	hands_use_check = FALSE

/datum/emote/living/gargle/get_sound(mob/living/user)
	if(ishuman(user))
		return "modular_septic/sound/emotes/throat[rand(1, 3)].ogg"
	else
		return ..()

// Crying
/datum/emote/living/whimper/get_sound(mob/living/user)
	if(ishuman(user))
		if(user.gender != FEMALE)
			return "modular_septic/sound/emotes/whimper_male[rand(1, 3)].ogg"
		else
			return "modular_septic/sound/emotes/whimper_female[rand(1, 3)].ogg"
	else
		return ..()

/datum/emote/living/carbon/human/cry/get_sound(mob/living/user)
	if(ishuman(user))
		if(user.gender != FEMALE)
			return "modular_septic/sound/emotes/cry_male[rand(1, 4)].ogg"
		else
			return "modular_septic/sound/emotes/cry_female[rand(1, 6)].ogg"
	else
		return ..()

// Coughing makes a sound too
/datum/emote/living/cough/get_sound(mob/living/user)
	if(ishuman(user))
		if(user.gender != FEMALE)
			return "modular_septic/sound/emotes/cough_male[rand(1, 16)].ogg"
		else
			return "modular_septic/sound/emotes/cough_female[rand(1, 12)].ogg"
	else
		return ..()

// Sagging i guess
/datum/emote/living/sag
	key = "sag"
	key_third_person = "sags"
	message = "sag%s on the floor, they won't regain their conciousness soon."
	emote_type = EMOTE_AUDIBLE
	muzzle_ignore = TRUE
	hands_use_check = FALSE

/datum/emote/living/sag/get_sound(mob/living/user)
	if(ishuman(user))
		if(user.gender != FEMALE)
			return "modular_septic/sound/emotes/deathgasp.ogg"
		else
			return "modular_septic/sound/emotes/deathgasp.ogg"
	else
		return ..()

// These are for when your lungs are fucked and you try to audibly emote
/datum/emote/living/quietnoise
	key = "quietnoise"
	key_third_person = "quietnoises"
	message = "makes a quiet noise."
	emote_type = EMOTE_AUDIBLE
	muzzle_ignore = TRUE
	hands_use_check = FALSE

/datum/emote/living/loudnoise
	key = "loudnoise"
	key_third_person = "loudnoises"
	message = "makes a loud noise!"
	emote_type = EMOTE_AUDIBLE
	muzzle_ignore = TRUE
	hands_use_check = FALSE

// Oooo sex
/datum/emote/living/sexymoan
	key = "sexymoan"
	key_third_person = "sexymoans"
	message = "moans!"
	emote_type = EMOTE_AUDIBLE
	muzzle_ignore = TRUE
	hands_use_check = FALSE
	mob_type_allowed_typecache = /mob/living/carbon/human

/datum/emote/living/sexymoan/get_sound(mob/living/user)
	if(ishuman(user))
		if(user.gender != FEMALE)
			return "modular_septic/sound/sexo/moan_m[rand(1, 7)].ogg"
		else
			return "modular_septic/sound/sexo/moan_f[rand(1, 7)].ogg"
	else
		return ..()

/datum/emote/living/sexymoan/run_emote(mob/living/carbon/human/user, params, type_override, intentional)
	. = TRUE
	if(!can_run_emote(user, TRUE, intentional))
		return FALSE
	var/msg = select_message_type(user, message, intentional)
	if(params && message_param)
		msg = select_param(user, params)

	msg = pick("moans!", "moans in pleasure!")

	if(!msg)
		return

	user.log_message(msg, LOG_EMOTE)
	var/dchatmsg = span_horny("<b>[user]</b> [msg]")

	var/tmp_sound = get_sound(user)
	if(tmp_sound && (!only_forced_audio || !intentional) && !TIMER_COOLDOWN_CHECK(user, type))
		TIMER_COOLDOWN_START(user, type, audio_cooldown)
		playsound(user, tmp_sound, 50, vary)

	var/user_turf = get_turf(user)
	for(var/mob/ghost in GLOB.dead_mob_list)
		if(!ghost.client || isnewplayer(ghost))
			continue
		if(ghost.stat == DEAD && ghost.client && user.client && (ghost.client.prefs.chat_toggles & CHAT_GHOSTSIGHT) && !(ghost in viewers(user_turf, null)))
			ghost.show_message("<span class='emote'>[FOLLOW_LINK(ghost, user)] [dchatmsg]</span>")

	if(emote_type == EMOTE_AUDIBLE)
		user.audible_message(span_horny("<span class='emote'><b>[user]</b> [msg]</span>"))
	else
		user.visible_message(span_horny("<span class='emote'><b>[user]</b> [msg]</span>"))
	var/list/hearers = get_hearers_in_view(DEFAULT_MESSAGE_RANGE, user)
	for(var/mob/hearer in hearers)
		if(user.runechat_prefs_check(hearer, NONE) && hearer.can_hear())
			hearer.create_chat_message(src, raw_message = msg, runechat_flags = NONE)
		hearer.show_message(message, MSG_AUDIBLE, null, MSG_VISUAL)

// Le quake jump has arrive
/datum/emote/living/jumpgrunt
	key = "jumpgrunt"
	key_third_person = "jumpgrunts"
	message = "grunts!"
	emote_type = EMOTE_AUDIBLE
	muzzle_ignore = TRUE
	hands_use_check = FALSE

/datum/emote/living/jumpgrunt/get_sound(mob/living/user)
	if(ishuman(user))
		if(user.gender != FEMALE)
			return "modular_septic/sound/emotes/jump_male[rand(1,2)].ogg"
		else
			return "modular_septic/sound/emotes/jump_female1.ogg"
	else
		return ..()

// Fatigue emote
/datum/emote/living/fatiguegrunt
	key = "fatiguegrunt"
	key_third_person = "fatiguegrunts"
	message = "grunts!"
	emote_type = EMOTE_AUDIBLE
	muzzle_ignore = TRUE
	hands_use_check = FALSE

/datum/emote/living/fatiguegrunt/get_sound(mob/living/user)
	if(ishuman(user))
		if(user.gender != FEMALE)
			return "modular_septic/sound/emotes/fatigue_male[rand(1, 3)].ogg"
		else
			return "modular_septic/sound/emotes/fatigue_female[rand(1,4)].ogg"
	else
		return ..()

// Hem
/datum/emote/living/hem
	key = "hem"
	key_third_person = "hems"
	message = "hems."
	emote_type = EMOTE_AUDIBLE
	muzzle_ignore = TRUE
	hands_use_check = FALSE

/datum/emote/living/hem/get_sound(mob/living/user)
	if(ishuman(user))
		if(user.gender != FEMALE)
			return "modular_septic/sound/emotes/hem_male1.ogg"
		else
			return "modular_septic/sound/emotes/hem_female1.ogg"
	else
		return ..()

// Dancing
/datum/emote/living/dance
	key = "dance"
	key_third_person = "dances"
	message = "dances around happily."
	muzzle_ignore = TRUE
	hands_use_check = FALSE
	cooldown = 2 SECONDS

/datum/emote/living/dance/run_emote(mob/user, params, type_override, intentional)
	. = TRUE
	if(!can_run_emote(user, TRUE, intentional))
		return FALSE
	if((user.movement_type & FLOATING) || HAS_TRAIT(user, TRAIT_FLOORED) || HAS_TRAIT(user, TRAIT_INCAPACITATED) \
		|| HAS_TRAIT_NOT_FROM(user, TRAIT_DANCING, EMOTE_TRAIT))
		return FALSE

	var/static/list/possible_affirmative_messages = list(
		"starts dancing!",
		"busts a move!",
		"busts a groove!",
		"boogies!",
		"rocks it out!",
		"goes with the flow!",
		"shakes it harder than brownian motion!",
		"slams it on the dance floor!",
		"jujus on that beat!",
		"ghost rides the whip!",
		"breaks it down sexual style!",
		"does the macarena!",
		"does the gangnam style!",
		"does the harlem shake!",
		"does the mario!",
		"does the whip AND nae nae!",
		"does the stanky leg!",
		"default dances!",
		"goes on pack watch!",
		"starts flossing!",
		"starts mario partying!",
		"starts dance dance revolutioning!",
		"super mans that hoe!",
		"blesses the rains down in africa!",
		"tunak tunak tuns!",
		"relaxa no crack!",
		"dança kuduro!",
	)
	var/static/list/possible_negative_messages = list(
		"stops dancing!",
		"sobers up!",
		"stops boogying!",
		"loses the flow!",
		"breaks the breakdance!",
		"is no longer goated with the sauce!",
		"fixes it up celibate style!",
		"stops packing!",
		"goes limper than an old man's dick!",
		"no longer has a loose foot!",
	)
	var/is_intentionally_dancing = HAS_TRAIT_FROM(user, TRAIT_DANCING, EMOTE_TRAIT)
	var/msg = is_intentionally_dancing ? pick(possible_negative_messages) : pick(possible_affirmative_messages)
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

	if(!is_intentionally_dancing)
		user.AddElement(/datum/element/dancing, EMOTE_TRAIT)
	else
		user.RemoveElement(/datum/element/dancing, EMOTE_TRAIT)
	SEND_SIGNAL(user, COMSIG_MOB_EMOTED(key))
