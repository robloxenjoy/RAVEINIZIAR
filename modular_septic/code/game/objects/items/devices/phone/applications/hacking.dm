/datum/simcard_application/hacking
	name = "FLESHWORM.gak"
	var/cock_type
	var/unlockable_flags = HACKER_CAN_FIREWALL
	var/level_progress = 0
	var/ability_pool = list("PING", "VITAL", "DDOS", "VIRUS", "MINDJACK")
	var/datum/weakref/hacker
	var/infection_type = /datum/simcard_virus/memz
	var/ping_range = 9
	var/infective = FALSE

/datum/simcard_application/hacking/install(obj/item/simcard/new_parent)
	. = ..()
	// we install a firewall on the parent!
	if(new_parent)
		new_parent.firewall_maxhealth = max(new_parent.firewall_maxhealth, 100)
		new_parent.firewall_health = new_parent.firewall_maxhealth

/datum/simcard_application/hacking/execute(mob/living/user)
	. = ..()
	if(!hacker)
		cock_type = (user.gender != FEMALE ? pick("KNOB", "DICK", "PENIS", "WEINER", "JOHNSON") : pick("FANNY", "CUNNY", "CUNT", "VAGINA", "VEGANA"))
		hacker = WEAKREF(user)
		to_chat(user, span_notice("[icon2html(parent, user)] [cock_type] SCANNED AND SAVED. WELCOME, [user.real_name]."))
		playsound(parent.parent, 'modular_septic/sound/efn/phone_subtlealert.ogg', 65, FALSE)
	else if(hacker != WEAKREF(user))
		to_chat(user, span_danger("[icon2html(parent, user)] INVALID [cock_type] DETECTED. ACCESS DENIED!"))
		playsound(parent.parent, 'modular_septic/sound/efn/phone_firewall.ogg', 65, FALSE)
		return
	var/datum/simcard_virus/punjabi_virus = infection_type
	var/static/list/antiviruses = list(
		"Protogen",
		"Norten",
		"McOffee",
		"Magrosoft Defender",
		"Aghast",
		"MalwareFights",
		"Crapersky",
		"ShitDefender",
	)
	var/antivirus_chosen = pick(antiviruses)
	var/random_press_sound = pick('modular_septic/sound/effects/phone_press.ogg', 'modular_septic/sound/effects/phone_press2.ogg', 'modular_septic/sound/effects/phone_press3.ogg', 'modular_septic/sound/effects/phone_press4.ogg')
	playsound(parent.parent, random_press_sound, 65, FALSE)
	to_chat(user, div_infobox(span_notice("[icon2html(parent, user)] <b>BINARY INTEGRITY:</b> [CEILING((parent.firewall_health/max(1, parent.firewall_maxhealth)) * 100, 0.1)]%\n\
								[icon2html(parent, user)] MY CALL VIRUS IS [infective ? "ENABLED" : "DISABLED"]\n\
								[icon2html(parent, user)] MY PROGRESS TO A NEW ABILITY IS [level_progress]/100\n\
								[icon2html(parent, user)] MY [uppertext(antivirus_chosen)] IS [parent.virus_immunity ? "ENABLED" : "DISABLED"]")))
	var/antivirus_option = "Toggle [antivirus_chosen] Antivirus"
	var/virus_option = "Toggle \"[initial(punjabi_virus.name)]\" Infection"
	var/ping_option = "Ping"
	var/list/options = list()
	if(unlockable_flags & HACKER_CAN_FIREWALL)
		options += antivirus_option
	if(unlockable_flags & HACKER_CAN_PING)
		options += ping_option
	if(unlockable_flags & HACKER_CAN_VIRUS)
		options += virus_option
	var/input = tgui_input_list(user, "What do you want to do today, hacker?", "FLESHWORM", options)
	if(input == antivirus_option)
		toggle_firewall(user, antivirus_chosen)
	else if(input == ping_option)
		ping(user)
	else if(input == virus_option)
		toggle_infectivity(user)

/datum/simcard_application/hacking/proc/ddos_niggas(mob/living/user)
	var/input = tgui_input_list(user, "Who needs a lesson in humility?", "DDoS NIGGAS", GLOB.active_public_simcard_list)
	if(!input)
		to_chat(user, span_warning("Nevermind."))
		return
	var/obj/item/simcard/friend = GLOB.active_public_simcard_list[input]
	if(!friend?.parent)
		to_chat(user, span_warning("[icon2html(parent, user)] [xbox_rage_msg()] INVALID TARGET!!! FUCK YOU!!!"))
		return
	if(friend.parent.phone_flags & PHONE_GLITCHING)
		to_chat(user, span_warning("[icon2html(friend, user)] TARGET IS ALREADY GLITCHED."))
		return
	friend.parent.start_glitching()
	to_chat(user, span_notice("[icon2html(friend, user)] SUCCESSFUL DoS ATTACK."))
	playsound(parent.parent, 'modular_septic/sound/efn/phone_jammer.ogg', 65, FALSE)

/datum/simcard_application/hacking/proc/toggle_infectivity(mob/living/user, antivirus)
	infective = !infective
	to_chat(user, span_danger("[icon2html(parent, user)] INFECTIVITY TOGGLED [infective ? "ON" : "OFF"]."))
	playsound(parent.parent, 'modular_septic/sound/efn/phone_firewall.ogg', 65, FALSE)

/datum/simcard_application/hacking/proc/toggle_firewall(mob/living/user, antivirus)
	parent.virus_immunity = !parent.virus_immunity
	if(parent.virus_immunity)
		to_chat(user, span_notice("[icon2html(parent, user)] [uppertext(antivirus)] ANTIVIRUS ENABLED."))
	else
		to_chat(user, span_warning("[icon2html(parent, user)] [uppertext(antivirus)] ANTIVIRUS DISABLED."))
	playsound(parent.parent, 'modular_septic/sound/efn/phone_firewall.ogg', 65, FALSE)

/datum/simcard_application/hacking/proc/ping(mob/living/user, radius = ping_range)
	if(!user || !parent)
		return
	var/turf/hacker_turf = get_turf(parent)
	//should not happen
	if(!hacker_turf)
		return
	playsound(parent.parent, 'modular_septic/sound/efn/phone_jammer.ogg', 65, FALSE)
	to_chat(user, span_notice("[icon2html(parent, user)] Pinging all users in radius of <b>[radius]</b>."))
	var/list/near_phones = list()
	var/turf/simcard_turf
	var/obj/item/simcard/simcard
	for(var/username in GLOB.simcard_list_by_username)
		simcard = GLOB.simcard_list_by_username[username]
		if(simcard == parent)
			continue
		simcard_turf = get_turf(simcard)
		if(!simcard_turf || (simcard_turf.z != hacker_turf.z) || (get_dist(simcard_turf, hacker_turf) > radius))
			continue
		var/ping_screams = pick('modular_septic/sound/efn/virus_scream.ogg', 'modular_septic/sound/efn/virus_scream2.ogg', 'modular_septic/sound/efn/virus_scream3.ogg')
		playsound(simcard, ping_screams, rand(5, 8), FALSE)
		near_phones[username] = simcard
	if(!length(near_phones))
		to_chat(user, span_notice("[icon2html(parent, user)] Clear. No users detected in immediate area."))
		playsound(parent.parent, 'modular_septic/sound/efn/phone_subtlealert.ogg', 25, FALSE)
		return
	var/tooth = pick("bluetooth", "redtooth", "greentooth", "whitetooth", "cyantooth", "pinktooth", "<u>wifisteal.com</u>", "<u>mobverify.com</u>")
	to_chat(user, span_boldnotice("Phones detected via [tooth]. I can dial them from here."))
	if(unlockable_flags & (HACKER_CAN_DDOS | HACKER_CAN_MINDJACK))
		to_chat(user, span_boldnotice("I can hack them, too."))
	var/title = "Immediate Users"
	var/message = "Some guys really shouldn't have phones."
	if(ishuman(user))
		var/mob/living/carbon/human/nigga = user
		if(nigga.dna?.species?.id == SPECIES_INBORN)
			title = "POTENTIAL FRIENDSHIPS"
			message = uppertext(message)
	var/ping_input = tgui_input_list(user, title, message, near_phones)
	if(ping_input && near_phones[ping_input])
		var/obj/item/simcard/victim_card = near_phones[ping_input]
		if(!victim_card?.parent)
			to_chat(user, span_warning("[fail_msg()] What? FUCK!"))
			return
		var/list/hacker_options = list("Call without malice")
		hacker_options |= hacking_additions()
		var/hacker_input = tgui_input_list(user, "SPECIAL ACTIONS", "GET READY FOR THIS ONE, GAKSTERS!", hacker_options)
		switch(hacker_input)
			if("DDOS")
				ping_ability(user, victim_card, "DDOS")
			if("MINDJACK")
				ping_ability(user, victim_card, "MINDJACK")
			if("Call without malice")
				parent.parent.start_calling(victim_card.parent)
				return
	else if(ping_input)
		to_chat(user, span_warning("That's not a real phone, I can't just do that, how did I do that?"))

/datum/simcard_application/hacking/proc/ping_ability(mob/living/user, obj/item/simcard/victim_card, option)
	if(!option || !parent?.parent || !victim_card?.parent)
		return
	switch(option)
		if("DDOS")
			if(!victim_card?.parent)
				to_chat(user, span_warning("INVALID TARGET!"))
				return
			if(victim_card.parent.phone_flags & PHONE_GLITCHING)
				to_chat(user, span_warning("This phone is already under attack."))
				return
			victim_card?.parent.start_glitching()
			to_chat(user, span_boldnotice("Successful Denial-of-Service Attack."))
			playsound(parent.parent, 'modular_septic/sound/efn/phone_jammer.ogg', 65, FALSE)
		if("MINDJACK")
			parent.parent.start_calling(victim_card.parent, mindjack = TRUE)

/datum/simcard_application/hacking/proc/ability_description(selected_ability)
	var/ability_text = "ERROR!"
	switch(selected_ability)
		if("PING")
			var/free_wifi = pick("virtual private", "wired", "telegraph", "radio", "smoke", "voodoo", "stereographic", "hydraulic", "sewer", "dial-up", "eco")
			ability_text = "You have the ability to \"ping\" other phones through a [free_wifi] system, shows you If any active sim cards are in your vicinity."
		if("VITAL")
			var/static/list/bad_statuses = list(
				"CRUSHED BY A ROCK", \
				"DECEASED", \
				"DISINTEGRATED", \
				"NO LONGER WITH US", \
				"RESTING IN PEACE", \
				"RIPBOZO PACKWATCH", \
				"CRANIALLY DEPRESSURIZED", \
				"HAVING THEIR LIFE INSURANCE COLLECTED", \
				"BEING REMEMBERED FONDLY", \
				"MURDERED BY BITCOIN ASSASSIN", \
				"STABBED FIFTY FUCKING TIMES, I CAN'T BELIEVE IT", \
				"PAYING FOR THEIR COUNTLESS SINS", \
				"ANSWERING TO GOD", \
			)
			var/bad_status = pick(bad_statuses)
			if(prob(1))
				bad_status = "REPORTED TO HOSTCHAT"
			ability_text = "You have the ability to see If a phone has a user, as well as If that user is LIVING or [bad_status]."
		if("DDOS")
			ability_text = "You have the ability to temporarily stall phones who are foolishly located on the public board."
		if("VIRUS")
			ability_text = "You have the ability to toggle MEMZ invectivity, \
							which infects any user that comes onto a paired connection with you with a \
							destructive virus that has a possibility to explode their phone fatally."
		if("MINDJACK")
			ability_text = "You have the ability to call others using the call menu with a special nural link, \
							connects you to the user's brain and you assume their conciousness in place with yours, keeping them hostage with your own mind. \
							If any of the paired minds die, everyone connected will suffer a very high probability of a fatal anyurism."
	return ability_text

/datum/simcard_application/hacking/proc/hacking_additions()
	var/list/hacker_abilities = list()
	if(unlockable_flags & HACKER_CAN_DDOS)
		hacker_abilities |= "DDOS"
	if(unlockable_flags & HACKER_CAN_MINDJACK)
		hacker_abilities |= "MINDJACK"
	return hacker_abilities

/datum/simcard_application/hacking/proc/check_level_up(mob/living/user, ability, silent = FALSE)
	if(!length(ability_pool))
		to_chat(user, span_warning("I have already unlocked everything."))
		return
	if(level_progress < 100)
		if(!silent)
			var/funnymessage = "\nKeep it up, champ!"
			var/progressmessage = "LEVEL PROGRESS [level_progress]/100."
			if(prob(1))
				progressmessage = "LEL PROGRESS [level_progress]/100."
			if(prob(5))
				progressmessage += funnymessage
			to_chat(user, div_infobox(span_warning("[progressmessage]")))
			playsound(parent.parent, list('modular_septic/sound/efn/progress_check1.ogg', 'modular_septic/sound/efn/progress_check2.ogg', 'modular_septic/sound/efn/progress_check3.ogg'), 40, FALSE)
		return
	var/selected_ability = pick(ability_pool)
	switch(selected_ability)
		if("PING")
			unlockable_flags |= HACKER_CAN_PING
		if("VITAL")
			unlockable_flags |= HACKER_CAN_VITAL
		if("DDOS")
			unlockable_flags |= HACKER_CAN_DDOS
		if("VIRUS")
			unlockable_flags |= HACKER_CAN_VIRUS
		if("MINDJACK")
			unlockable_flags |= HACKER_CAN_MINDJACK
	var/unlocked_everything = " <b>I have unlocked everything.</b>"
	var/unlocked_message = "I've unlocked [selected_ability]!"
	ability_pool -= selected_ability
	if(!length(ability_pool))
		unlocked_message += unlocked_everything
	to_chat(user, span_notice("[unlocked_message]"))
	to_chat(user, span_info(div_infobox(ability_description(selected_ability))))
	level_progress = initial(level_progress)
	var/unlock_sounding = pick('modular_septic/sound/efn/hacker_phone_unlock1.ogg', 'modular_septic/sound/efn/hacker_phone_unlock2.ogg')
	playsound(parent.parent, unlock_sounding, 40, FALSE)
