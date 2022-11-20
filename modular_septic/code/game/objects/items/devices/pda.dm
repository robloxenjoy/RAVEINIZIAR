
#define PDA_SCANNER_NONE 0
#define PDA_SCANNER_MEDICAL 1
#define PDA_SCANNER_FORENSICS 2 //unused
#define PDA_SCANNER_REAGENT 3
#define PDA_SCANNER_GAS 5
#define PDA_SPAM_DELAY 2 MINUTES

//add whatsapp
/obj/item/pda
	icon = 'modular_septic/icons/obj/items/pda.dmi'
	desc = "A portable microcomputer by MOKIA Systems, LTD. Functionality determined by a preprogrammed ROM cartridge."
	carry_weight = 500 GRAMS
	ttone = "zap"

/obj/item/pda/send_message(mob/living/user, list/obj/item/pda/targets, everyone)
	var/message = msg_input(user)
	if(!message || !targets.len)
		return
	if((last_text && world.time < last_text + 10) || (everyone && last_everyone && world.time < last_everyone + PDA_SPAM_DELAY))
		return

	var/list/filter_result = is_ic_filtered_for_pdas(message)
	if (filter_result)
		REPORT_CHAT_FILTER_TO_USER(user, filter_result)
		return

	var/list/soft_filter_result = is_soft_ic_filtered_for_pdas(message)
	if (soft_filter_result)
		if(tgui_alert(usr,"Your message contains \"[soft_filter_result[CHAT_FILTER_INDEX_WORD]]\". \"[soft_filter_result[CHAT_FILTER_INDEX_REASON]]\", Are you sure you want to send it?", "Soft Blocked Word", list("Yes", "No")) != "Yes")
			return
		message_admins("[ADMIN_LOOKUPFLW(usr)] has passed the soft filter for \"[soft_filter_result[CHAT_FILTER_INDEX_WORD]]\" they may be using a disallowed term in PDA messages. Message: \"[html_encode(message)]\"")
		log_admin_private("[key_name(usr)] has passed the soft filter for \"[soft_filter_result[CHAT_FILTER_INDEX_WORD]]\" they may be using a disallowed term in PDA messages. Message: \"[message]\"")

	if(prob(1))
		message += "\nSent from my PDA"
	// Send the signal
	var/list/string_targets = list()
	for (var/obj/item/pda/P in targets)
		if (P.owner && P.ownjob)  // != src is checked by the UI
			string_targets += "[P.owner] ([P.ownjob])"
	for (var/obj/machinery/computer/message_monitor/M in targets)
		// In case of "Reply" to a message from a console, this will make the
		// message be logged successfully. If the console is impersonating
		// someone by matching their name and job, the reply will reach the
		// impersonated PDA.
		string_targets += "[M.customsender] ([M.customjob])"
	if (!string_targets.len)
		return

	var/datum/signal/subspace/messaging/pda/signal = new(src, list(
		"name" = "[owner]",
		"job" = "[ownjob]",
		"message" = message,
		"targets" = string_targets,
		"emojis" = allow_emojis,
	))
	if (picture)
		signal.data["photo"] = picture
	signal.send_to_receivers()

	// If it didn't reach, note that fact
	if (!signal.data["done"])
		to_chat(user, span_notice("ERROR: Server isn't responding."))
		if(!silent)
			playsound(src, 'sound/machines/terminal_error.ogg', 15, TRUE)
		return

	var/target_text = signal.format_target()
	if(allow_emojis)
		message = emoji_parse(message)//already sent- this just shows the sent emoji as one to the sender in the to_chat
		signal.data["message"] = emoji_parse(signal.data["message"])

	// Log it in our logs
	tnote += "<i><b>&rarr; To [target_text]:</b></i><br>[signal.format_message()]<br>"
	// Show it to ghosts
	var/ghost_message = span_name("[owner] </span><span class='game say'>PDA Message</span> --> [span_name("[target_text]")]: <span class='message'>[signal.format_message()]")
	for(var/mob/M in GLOB.player_list)
		if(isobserver(M) && (M.client?.prefs.chat_toggles & CHAT_GHOSTPDA))
			to_chat(M, "[FOLLOW_LINK(M, user)] [ghost_message]")
	// Log in the talk log
	user.log_talk(message, LOG_PDA, tag="PDA: [initial(name)] to [target_text]")
	to_chat(user, span_info("PDA message sent to [target_text]: \"[message]\""))
	if(!silent)
		playsound(src, 'modular_septic/sound/effects/Mobile_sms_send.wav', 15, TRUE)
	// Reset the photo
	picture = null
	last_text = world.time
	if (everyone)
		last_everyone = world.time


/obj/item/pda/receive_message(datum/signal/subspace/messaging/pda/signal)
	tnote += "<i><b>&larr; From <a href='byond://?src=[REF(src)];choice=Message;target=[REF(signal.source)]'>[signal.data["name"]]</a> ([signal.data["job"]]):</b></i><br>[signal.format_message()]<br>"

	if (!silent)
		if(HAS_TRAIT(SSstation, STATION_TRAIT_PDA_GLITCHED))
			playsound(src, pick('sound/machines/twobeep_voice1.ogg', 'sound/machines/twobeep_voice2.ogg'), 50, TRUE)
		else if(ttone != "zap")
			playsound(src, 'sound/machines/twobeep_high.ogg', 50, TRUE)
		else
			playsound(src, 'modular_septic/sound/effects/Mobile_sms.ogg', 15, FALSE)
		audible_message(span_infoplain("[icon2html(src, hearers(src))] *[ttone]*"), null, 3)
	//Search for holder of the PDA.
	var/mob/living/L = null
	if(loc && isliving(loc))
		L = loc
	//Maybe they are a pAI!
	else
		L = get(src, /mob/living/silicon)

	if(L && (L.stat == CONSCIOUS || L.stat == SOFT_CRIT))
		var/reply = "(<a href='byond://?src=[REF(src)];choice=Message;skiprefresh=1;target=[REF(signal.source)]'>Reply</a>)"
		var/hrefstart
		var/hrefend
		if (isAI(L))
			hrefstart = "<a href='?src=[REF(L)];track=[html_encode(signal.data["name"])]'>"
			hrefend = "</a>"

		if(signal.data["automated"])
			reply = "\[Automated Message\]"

		var/inbound_message = signal.format_message()
		if(signal.data["emojis"] == TRUE)//so will not parse emojis as such from pdas that don't send emojis
			inbound_message = emoji_parse(inbound_message)

		to_chat(L, span_infoplain("[icon2html(src)] <b>PDA message from [hrefstart][signal.data["name"]] ([signal.data["job"]])[hrefend], </b>[inbound_message] [reply]"))

	update_appearance()
	if(istext(icon_alert))
		icon_alert = mutable_appearance(initial(icon), icon_alert)
		add_overlay(icon_alert)

/obj/item/pda/Topic(href, href_list)
	..()
	var/mob/living/U = usr
	//Looking for master was kind of pointless since PDAs don't appear to have one.

	if(!href_list["close"] && usr.canUseTopic(src, BE_CLOSE, FALSE, NO_TK))
		add_fingerprint(U)
		U.set_machine(src)

		switch(href_list["choice"])

//BASIC FUNCTIONS===================================

			if("Refresh")//Refresh, goes to the end of the proc.
				if(!silent)
					playsound(src, 'modular_septic/sound/effects/phone_press.ogg', 15, TRUE)

			if ("Toggle_Font")
				//CODE REVISION 2
				font_index = (font_index + 1) % 4

				switch(font_index)
					if (MODE_MONO)
						font_mode = FONT_MONO
					if (MODE_SHARE)
						font_mode = FONT_SHARE
					if (MODE_ORBITRON)
						font_mode = FONT_ORBITRON
					if (MODE_VT)
						font_mode = FONT_VT
				if(!silent)
					playsound(src, 'modular_septic/sound/effects/phone_press.ogg', 15, TRUE)
			if ("Change_Color")
				var/new_color = input("Please enter a color name or hex value (Default is \'#808000\').",background_color)as color
				background_color = new_color

			if ("Toggle_Underline")
				underline_flag = !underline_flag
				if(!silent)
					playsound(src, 'modular_septic/sound/effects/phone_press.ogg', 15, TRUE)

			if("Return")//Return
				if(mode<=9)
					mode = 0
				else
					mode = round(mode/10)
					if(mode==4 || mode == 5)//Fix for cartridges. Redirects to hub.
						mode = 0
				if(!silent)
					playsound(src, 'modular_septic/sound/effects/phone_press.ogg', 15, TRUE)
			if ("Authenticate")//Checks for ID
				id_check(U)
			if("UpdateInfo")
				ownjob = id.assignment
				update_label()
				if(!silent)
					playsound(src, 'sound/machines/terminal_processing.ogg', 15, TRUE)
					addtimer(CALLBACK(GLOBAL_PROC, .proc/playsound, src, 'sound/machines/terminal_success.ogg', 15, TRUE), 1.3 SECONDS)
			if("Eject")//Ejects the cart, only done from hub.
				eject_cart(U)
				if(!silent)
					playsound(src, 'sound/machines/terminal_eject.ogg', 50, TRUE)

//MENU FUNCTIONS===================================

			if("0")//Hub
				mode = 0
				if(!silent)
					playsound(src, 'modular_septic/sound/effects/phone_press.ogg', 15, TRUE)
			if("1")//Notes
				mode = 1
				if(!silent)
					playsound(src, 'modular_septic/sound/effects/phone_press.ogg', 15, TRUE)
			if("2")//Messenger
				mode = 2
				if(!silent)
					playsound(src, 'modular_septic/sound/effects/phone_press.ogg', 15, TRUE)
			if("21")//Read messeges
				mode = 21
				if(!silent)
					playsound(src, 'modular_septic/sound/effects/phone_press.ogg', 15, TRUE)
			if("3")//Atmos scan
				mode = 3
				if(!silent)
					playsound(src, 'modular_septic/sound/effects/phone_press.ogg', 15, TRUE)
			if("4")//Redirects to hub
				mode = 0
				if(!silent)
					playsound(src, 'modular_septic/sound/effects/phone_press.ogg', 15, TRUE)


//MAIN FUNCTIONS===================================

			if("Light")
				toggle_light(U)
				if(!silent)
					playsound(src, 'modular_septic/sound/effects/phone_press.ogg', 15, TRUE)
			if("Medical Scan")
				if(scanmode == PDA_SCANNER_MEDICAL)
					scanmode = PDA_SCANNER_NONE
				else if((!isnull(cartridge)) && (cartridge.access & CART_MEDICAL))
					scanmode = PDA_SCANNER_MEDICAL
				if(!silent)
					playsound(src, 'modular_septic/sound/effects/phone_press.ogg', 15, TRUE)
			if("Reagent Scan")
				if(scanmode == PDA_SCANNER_REAGENT)
					scanmode = PDA_SCANNER_NONE
				else if((!isnull(cartridge)) && (cartridge.access & CART_REAGENT_SCANNER))
					scanmode = PDA_SCANNER_REAGENT
			if("Honk")
				if ( !(last_noise && world.time < last_noise + 20) )
					playsound(src, 'sound/items/bikehorn.ogg', 50, TRUE)
					last_noise = world.time
			if("Trombone")
				if ( !(last_noise && world.time < last_noise + 20) )
					playsound(src, 'sound/misc/sadtrombone.ogg', 50, TRUE)
					last_noise = world.time
			if("Gas Scan")
				if(scanmode == PDA_SCANNER_GAS)
					scanmode = PDA_SCANNER_NONE
				else if((!isnull(cartridge)) && (cartridge.access & CART_ATMOS))
					scanmode = PDA_SCANNER_GAS
				if(!silent)
					playsound(src, 'modular_septic/sound/effects/phone_press.ogg', 15, TRUE)
			if("Drone Phone")
				var/alert_s = input(U,"Alert severity level","Ping Drones",null) as null|anything in list("Low","Medium","High","Critical")
				var/area/A = get_area(U)
				if(A && alert_s && !QDELETED(U))
					var/msg = span_boldnotice("NON-DRONE PING: [U.name]: [alert_s] priority alert in [A.name]!")
					_alert_drones(msg, TRUE, U)
					to_chat(U, msg)
					if(!silent)
						playsound(src, 'sound/machines/terminal_success.ogg', 15, TRUE)
			if("Drone Access")
				var/mob/living/simple_animal/drone/drone_user = U
				if(isdrone(U) && drone_user.shy)
					to_chat(U, span_warning("Your laws prevent this action."))
					return
				var/new_state = text2num(href_list["drone_blacklist"])
				GLOB.drone_machine_blacklist_enabled = new_state
				if(!silent)
					playsound(src, 'modular_septic/sound/effects/phone_press.ogg', 15, TRUE)


//NOTEKEEPER FUNCTIONS===================================

			if ("Edit")
				var/n = stripped_multiline_input(U, "Please enter message", name, note)
				if (in_range(src, U) && loc == U)
					if (mode == 1 && n)
						note = n
						notehtml = parsemarkdown(n, U)
						notescanned = FALSE
				else
					U << browse(null, "window=pda")
					return

//MESSENGER FUNCTIONS===================================

			if("Toggle Messenger")
				toff = !toff
			if("Toggle Ringer")//If viewing texts then erase them, if not then toggle silent status
				silent = !silent
			if("Clear")//Clears messages
				tnote = null
			if("Ringtone")
				var/t = stripped_input(U, "Please enter new ringtone", name, ttone, 20)
				if(in_range(src, U) && loc == U && t)
					if(SEND_SIGNAL(src, COMSIG_PDA_CHANGE_RINGTONE, U, t) & COMPONENT_STOP_RINGTONE_CHANGE)
						U << browse(null, "window=pda")
						return
					else
						ttone = t
				else
					U << browse(null, "window=pda")
					return
			if("Message")
				create_message(U, locate(href_list["target"]) in GLOB.PDAs)

			if("Sorting Mode")
				sort_by_job = !sort_by_job

			if("MessageAll")
				if(cartridge?.spam_enabled)
					send_to_all(U)

			if("cart")
				if(cartridge)
					cartridge.special(U, href_list)
				else
					U << browse(null, "window=pda")
					return

//SYNDICATE FUNCTIONS===================================

			if("Toggle Door")
				if(cartridge && cartridge.access & CART_REMOTE_DOOR)
					for(var/obj/machinery/door/poddoor/M in GLOB.machines)
						if(M.id == cartridge.remote_door_id)
							if(M.density)
								M.open()
							else
								M.close()

//pAI FUNCTIONS===================================

			if("pai")
				switch(href_list["option"])
					if("1") // Configure pAI device
						pai.attack_self(U)
					if("2") // Eject pAI device
						usr.put_in_hands(pai)
						to_chat(usr, span_notice("You remove the pAI from the [name]."))

//SKILL FUNCTIONS===================================

			if("SkillReward")
				var/type = text2path(href_list["skill"])
				var/datum/skill/S = GetSkillRef(type)
				var/datum/mind/mind = U.mind
				var/new_level = mind.get_skill_level(type)
				S.try_skill_reward(mind, new_level)

//LINK FUNCTIONS===================================

			else//Cartridge menu linking
				mode = max(text2num(href_list["choice"]), 0)

	else//If not in range, can't interact or not using the pda.
		U.unset_machine()
		U << browse(null, "window=pda")
		return

//EXTRA FUNCTIONS===================================

	if (mode == 2 || mode == 21)//To clear message overlays.
		update_appearance()

	if ((honkamt > 0) && (prob(60)))//For clown virus.
		honkamt--
		playsound(src, 'sound/items/bikehorn.ogg', 30, TRUE)

	if(U.machine == src && href_list["skiprefresh"]!="1")//Final safety.
		attack_self(U)//It auto-closes the menu prior if the user is not in range and so on.
	else
		U.unset_machine()
		U << browse(null, "window=pda")
	return
