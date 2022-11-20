/datum/interaction
	var/name = ""
	var/desc = "FUCK FUCK FUCK"
	var/category = "SHIT"
	var/message
	var/target_message
	var/user_message
	var/blind_message
	var/button_icon = "exclamation-circle" //fontawesome icon shown on the interface

	var/message_range = DEFAULT_MESSAGE_RANGE

	var/sounds
	var/sound_volume = 65
	var/sound_extrarange = 0
	var/sound_vary = 0

	var/usage = INTERACT_OTHER
	var/interaction_flags = INTERACTION_RESPECT_COOLDOWN

	var/user_cooldown_duration = 0
	var/target_cooldown_duraction = 0
	var/user_sex_cooldown_duration = 0
	var/target_sex_cooldown_duraction = 0
	var/user_climax_cooldown_duration = 30 SECONDS
	var/target_climax_cooldown_duration = 30 SECONDS

	var/arousal_gain_user = AROUSAL_GAIN_NONE
	var/arousal_gain_target = AROUSAL_GAIN_NONE
	var/lust_gain_user = LUST_GAIN_NONE
	var/lust_gain_target = LUST_GAIN_NONE

	var/maximum_distance = 1
	var/maximum_tk_distance = 7
	var/user_hands_required = 0
	var/target_hands_required = 0
	var/list/user_types_allowed = list(/mob/living/carbon/human)
	var/list/target_types_allowed = list(/mob/living/carbon/human)

/datum/interaction/proc/allow_interaction(datum/component/interactable/user, datum/component/interactable/target, silent = TRUE, check_cooldown = TRUE)
	. = FALSE
	if(!user || !target)
		return FALSE
	switch(usage)
		if(INTERACT_SELF)
			if(user.parent != target.parent)
				if(!silent)
					to_chat(user.parent, span_warning("I can only do that to myself."))
				return FALSE
		if(INTERACT_OTHER)
			if(user.parent == target.parent)
				if(!silent)
					to_chat(user.parent, span_warning("I can only do that on other people."))
				return FALSE
	if(check_cooldown && !cooldown_checks(user, target))
		return FALSE
	var/mob/mob_user = user.parent
	var/mob/living/carbon/human/human_user = user.parent
	var/atom/atom_target = target.parent
/*
	if((human_user && human_user.ckey == "MoonMagick") && (atom_target && !atom_target.ckey == "BaJlepa") || (human_user && human_user.ckey == "BaJlepa") && (atom_target && !atom_target.ckey == "MoonMagick"))
		to_chat(human_user, span_warning("What the fuck?"))
		return FALSE

	if((human_user && !human_user.ckey == "BaJlepa") && (atom_target && atom_target.ckey == "MoonMagick") || (human_user && !human_user.ckey == "MoonMagick") && (atom_target && atom_target.ckey == "BaJlepa"))
		to_chat(human_user, span_warning("Fuck you."))
		return FALSE

	if((human_user && human_user.ckey == "MoonMagick") && (atom_target && atom_target.ckey == "BaJlepa") || (human_user && human_user.ckey == "BaJlepa") && (atom_target && atom_target.ckey == "MoonMagick"))
		return TRUE
*/
	if(user != target)
		//Adjacency check
		if((interaction_flags & INTERACTION_NEEDS_PHYSICAL_CONTACT) && !mob_user.Adjacent(atom_target) && !(istype(human_user) && human_user.dna.check_mutation(TK)))
			if(!silent)
				to_chat(mob_user, span_warning("I need physical contact to do this."))
			return FALSE
		//TK or distance check
		if((get_dist(atom_target, mob_user) > maximum_distance) && !(istype(human_user) && human_user.dna.check_mutation(TK)))
			if(!silent)
				to_chat(mob_user, span_warning("I need to get closer."))
			return FALSE
		else if((get_dist(atom_target, mob_user) > maximum_tk_distance) && (istype(human_user) && human_user.dna.check_mutation(TK)))
			if(!silent)
				to_chat(mob_user, span_warning("I need to get closer"))
			return FALSE
		//Checks that are target specific
		if(!evaluate_target(user, target, silent))
			return FALSE
	//Checks that are user specific
	if(!evaluate_user(user, target, silent))
		return FALSE
	return TRUE

/datum/interaction/proc/cooldown_checks(datum/component/interactable/user, datum/component/interactable/target)
	return (COOLDOWN_FINISHED(user, next_interaction) && COOLDOWN_FINISHED(target, next_interaction))

/datum/interaction/proc/evaluate_user(datum/component/interactable/user, datum/component/interactable/target, silent = FALSE,)
	. = TRUE
	//Type check
	if(!is_type_in_list(user.parent, user_types_allowed))
		if(!silent)
			to_chat(user.parent, span_warning("Not possible with me."))
		return FALSE
	//Hand check
	var/mob/living/living_user = user.parent
	if(user_hands_required && (!istype(living_user) || (living_user.num_hands < user_hands_required)))
		if(!silent)
			to_chat(living_user, span_warning("I don't have enough hands."))
		return FALSE

/datum/interaction/proc/evaluate_target(datum/component/interactable/user, datum/component/interactable/target, silent = FALSE)
	. = TRUE
	//Type check
	if(!is_type_in_list(target.parent, target_types_allowed))
		if(!silent)
			to_chat(user.parent, span_warning("Not possible with them."))
		return FALSE
	//Hand check
	var/mob/living/living_target = target.parent
	if(target_hands_required && !(istype(living_target) || (living_target.num_hands < target_hands_required)))
		if(!silent)
			to_chat(user.parent, span_warning("They don't have enough hands"))
		return FALSE

/datum/interaction/proc/do_interaction(datum/component/interactable/user, datum/component/interactable/target)
	var/mob/mob_user = user.parent
	var/message_index = 0
	if(islist(message))
		message_index = rand(1, length(message))
	var/msg
	if(message)
		if(message_index)
			msg = message[message_index]
		else
			msg = message
		msg = replacetext(msg, "%USER", "<b>[user.parent]</b>")
		msg = replacetext(msg, "%TARGET", "<b>[target.parent]</b>")
	var/target_msg
	if(target_message && ismob(target.parent))
		if(message_index)
			target_msg = target_message[message_index]
		else
			target_msg = target_message
		target_msg = replacetext(target_msg, "%USER", "<b>[user.parent]</b>")
		target_msg = replacetext(target_msg, "%TARGET", "<b>[target.parent]</b>")
	var/user_msg
	if(user_message)
		if(message_index)
			user_msg = user_message[message_index]
		else
			user_msg = user_message
		user_msg = replacetext(user_msg, "%USER", "<b>[user.parent]</b>")
		user_msg = replacetext(user_msg, "%TARGET", "<b>[target.parent]</b>")
	var/blind_msg
	if(blind_message)
		if(message_index)
			blind_msg = blind_message[message_index]
		else
			blind_msg = blind_message
		blind_msg = replacetext(blind_msg, "%USER", "<b>[user.parent]</b>")
		blind_msg = replacetext(blind_msg, "%TARGET", "<b>[target.parent]</b>")
	mob_user.face_atom(target.parent)
	if(!(interaction_flags & INTERACTION_AUDIBLE))
		mob_user.visible_message(message = msg, \
					self_message = user_msg, \
					blind_message = blind_msg, \
					ignored_mobs = (target_msg ? target.parent : null))
		if(target_msg)
			to_chat(target.parent, target_msg)
	else
		mob_user.audible_message(message = msg, self_message = user_msg, deaf_message = blind_msg, hearing_distance = message_range)
	if(sounds)
		playsound(mob_user, pick(sounds), sound_volume, sound_vary, sound_extrarange)
	return TRUE

/datum/interaction/proc/after_interact(datum/component/interactable/user, datum/component/interactable/target)
	var/mob/living/carbon/human/humie_user = user.parent
	if(user_cooldown_duration)
		COOLDOWN_START(user, next_interaction, user_cooldown_duration)
	if(user_sex_cooldown_duration)
		COOLDOWN_START(user, next_sexual_interaction, user_sex_cooldown_duration)
	if(istype(humie_user) && (humie_user.stat < DEAD))
		if(arousal_gain_user)
			humie_user.adjust_arousal(arousal_gain_user)
		if(CHECK_BITFIELD(interaction_flags, INTERACTION_USER_LUST))
			if(lust_gain_user)
				humie_user.adjust_lust(lust_gain_user)
				if((humie_user.lust >= LUST_CLIMAX) && CHECK_BITFIELD(interaction_flags, INTERACTION_USER_CLIMAX))
					handle_user_climax(user, target)
			handle_user_lust(user, target)
	var/mob/living/carbon/human/humie_target = target.parent
	if(user != target)
		if(target_cooldown_duraction)
			COOLDOWN_START(target, next_interaction, target_cooldown_duraction)
		if(target_sex_cooldown_duraction)
			COOLDOWN_START(target, next_sexual_interaction, target_sex_cooldown_duraction)
		if(istype(humie_target) && (humie_target.stat < DEAD))
			if(arousal_gain_target)
				humie_target.adjust_arousal(arousal_gain_target)
			if(CHECK_BITFIELD(interaction_flags, INTERACTION_TARGET_LUST))
				if(lust_gain_target)
					humie_target.adjust_lust(lust_gain_target)
					if((humie_target.lust >= LUST_CLIMAX) && CHECK_BITFIELD(interaction_flags, INTERACTION_TARGET_CLIMAX))
						handle_target_climax(user, target)
				handle_target_lust(user, target)
	user.last_interaction_as_user = src
	user.last_interaction_as_user_time = world.time
	if(user.clear_user_interaction_timer)
		deltimer(user.clear_user_interaction_timer)
		user.clear_user_interaction_timer = null
	user.clear_user_interaction_timer = addtimer(CALLBACK(user, /datum/component/interactable/.proc/clear_user_interaction), 30 SECONDS, TIMER_STOPPABLE)
	target.last_interaction_as_target = src
	target.last_interaction_as_target_time = world.time
	if(target.clear_target_interaction_timer)
		deltimer(target.clear_target_interaction_timer)
		target.clear_target_interaction_timer = null
	target.clear_target_interaction_timer = addtimer(CALLBACK(user, /datum/component/interactable/.proc/clear_target_interaction), 30 SECONDS, TIMER_STOPPABLE)
	return TRUE

//Generic behavior for user cumming
/datum/interaction/proc/handle_user_climax(datum/component/interactable/user, datum/component/interactable/target)
	var/mob/living/carbon/human/human_user = user.parent
	if(human_user.getorganslot(ORGAN_SLOT_PENIS))
		human_user.visible_message(span_love("<b>[human_user]</b> cums on [human_user.loc]!"),\
								span_userlove("I cum on [human_user.loc]!"))
	else if(human_user.getorganslot(ORGAN_SLOT_VAGINA))
		human_user.visible_message(span_love("<b>[human_user]</b> squirts on [human_user.loc]!"),\
								span_userlove("I squirt on [human_user.loc]!"))
	else
		human_user.visible_message(span_love("<b>[human_user]</b> climaxes on [human_user.loc]!"),\
								span_userlove("I climax on [human_user.loc]!"))
	if(!human_user.Process_Spacemove(REVERSE_DIR(human_user.dir)))
		human_user.newtonian_move(REVERSE_DIR(human_user.dir))
	for(var/obj/item/organ/genital/genital in human_user.internal_organs)
		if(CHECK_BITFIELD(genital.genital_flags, GENITAL_CAN_CLIMAX))
			genital.handle_climax(get_turf(human_user), TOUCH)
	human_user.adjust_arousal(-AROUSAL_LEVEL_HORNY)
	human_user.set_lust(0)
	human_user.SetStun(25)
	human_user.set_drugginess(25)
	SEND_SIGNAL(human_user, COMSIG_ADD_MOOD_EVENT, "goodsex", /datum/mood_event/goodsex)
	return TRUE

//Generic behavior for target cumming
/datum/interaction/proc/handle_target_climax(datum/component/interactable/user, datum/component/interactable/target)
	var/mob/living/carbon/human/human_target = target.parent
	if(human_target.getorganslot(ORGAN_SLOT_PENIS))
		human_target.visible_message(span_love("<b>[human_target]</b> cums on [human_target.loc]!"),\
								span_userlove("I cum on [human_target.loc]!"))
	else if(human_target.getorganslot(ORGAN_SLOT_VAGINA))
		human_target.visible_message(span_love("<b>[human_target]</b> squirts on [human_target.loc]!"),\
								span_userlove("I squirt on [human_target.loc]!"))
	else
		human_target.visible_message(span_love("<b>[human_target]</b> climaxes on [human_target.loc]!"),\
								span_userlove("I climax on [human_target.loc]!"))
	if(!human_target.Process_Spacemove(REVERSE_DIR(human_target.dir)))
		human_target.newtonian_move(REVERSE_DIR(human_target.dir))
	for(var/obj/item/organ/genital/genital in human_target.internal_organs)
		if(CHECK_BITFIELD(genital.genital_flags, GENITAL_CAN_CLIMAX))
			genital.handle_climax(get_turf(human_target), TOUCH)
	human_target.adjust_arousal(-AROUSAL_LEVEL_HORNY)
	human_target.set_lust(0)
	human_target.SetStun(25)
	human_target.set_drugginess(25)
	SEND_SIGNAL(human_target, COMSIG_ADD_MOOD_EVENT, "goodsex", /datum/mood_event/goodsex)
	return TRUE

//Moaning, etc
/datum/interaction/proc/handle_user_lust(datum/component/interactable/user, datum/component/interactable/target)
	var/mob/living/carbon/human/humie_user = user.parent
	if(prob(5 + humie_user.lust))
		switch(humie_user.a_intent)
			if(INTENT_HELP)
				var/list/sexo_messages = list(span_horny("<b>[humie_user]</b> shivers in arousal."),
						span_horny("<b>[humie_user]</b> moans quietly."),
						span_horny("<b>[humie_user]</b> breathes out a soft moan."),
						span_horny("<b>[humie_user]</b> gasps."),
						span_horny("<b>[humie_user]</b> shudders softly"))
				var/list/sexo_messages_self = list(span_horny("I shiver in arousal."),
						span_horny("I moan quietly."),
						span_horny("I breathe out a soft moan."),
						span_horny("I gasp."),
						span_horny("I shudder softly"))
				var/message_index = rand(1, length(sexo_messages))
				humie_user.visible_message(sexo_messages[message_index], sexo_messages_self[message_index])
			//todo: lust messages based on intent, CBA to do it now
			else
				var/list/sexo_messages = list(span_horny("<b>[humie_user]</b> shivers in arousal."),
						span_horny("<b>[humie_user]</b> moans quietly."),
						span_horny("<b>[humie_user]</b> breathes out a soft moan."),
						span_horny("<b>[humie_user]</b> gasps."),
						span_horny("<b>[humie_user]</b> shudders softly"))
				var/list/sexo_messages_self = list(span_horny("I shiver in arousal."),
						span_horny("I moan quietly."),
						span_horny("I breathe out a soft moan."),
						span_horny("I gasp."),
						span_horny("I shudder softly"))
				var/message_index = rand(1, length(sexo_messages))
				humie_user.visible_message(sexo_messages[message_index], sexo_messages_self[message_index])
		if(humie_user.lust < 5)
			humie_user.set_lust(5)
	return TRUE

//Moaning, etc
/datum/interaction/proc/handle_target_lust(datum/component/interactable/user, datum/component/interactable/target)
	var/mob/living/carbon/human/humie_target = target.parent
	if(prob(5 + humie_target.lust))
		switch(humie_target.a_intent)
			if(INTENT_HELP)
				var/list/sexo_messages = list(span_horny("<b>[humie_target]</b> shivers in arousal."),
						span_horny("<b>[humie_target]</b> moans quietly."),
						span_horny("<b>[humie_target]</b> breathes out a soft moan."),
						span_horny("<b>[humie_target]</b> gasps."),
						span_horny("<b>[humie_target]</b> shudders softly"))
				var/list/sexo_messages_self = list(span_horny("I shiver in arousal."),
						span_horny("I moan quietly."),
						span_horny("I breathe out a soft moan."),
						span_horny("I gasp."),
						span_horny("I shudder softly"))
				var/message_index = rand(1, length(sexo_messages))
				humie_target.visible_message(sexo_messages[message_index], sexo_messages_self[message_index])
			//todo: lust messages based on intent, CBA to do it now
			else
				var/list/sexo_messages = list(span_horny("<b>[humie_target]</b> shivers in arousal."),
						span_horny("<b>[humie_target]</b> moans quietly."),
						span_horny("<b>[humie_target]</b> breathes out a soft moan."),
						span_horny("<b>[humie_target]</b> gasps."),
						span_horny("<b>[humie_target]</b> shudders softly"))
				var/list/sexo_messages_self = list(span_horny("I shiver in arousal."),
						span_horny("I moan quietly."),
						span_horny("I breathe out a soft moan."),
						span_horny("I gasp."),
						span_horny("I shudder softly"))
				var/message_index = rand(1, length(sexo_messages))
				humie_target.visible_message(sexo_messages[message_index], sexo_messages_self[message_index])
		if(humie_target.lust < 5)
			humie_target.set_lust(5)
	return TRUE
