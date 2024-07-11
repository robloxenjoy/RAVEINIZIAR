/client/ooc(msg as text)
	set name = "OOC" //Gave this shit a shorter name so you only have to time out "ooc" rather than "ooc message" to use it --NeoFite
	set category = "OOC"

	if(GLOB.say_disabled) //This is here to try to identify lag problems
		to_chat(usr, span_danger("Speech is currently admin-disabled."))
		return

	if(!mob)
		return

	if(!holder)
		if(!GLOB.ooc_allowed)
			to_chat(src, span_danger("OOC is globally muted."))
			return
		if(!GLOB.dooc_allowed && (mob.stat == DEAD))
			to_chat(usr, span_danger("OOC for dead mobs has been turned off."))
			return
		if(prefs.muted & MUTE_OOC)
			to_chat(src, span_danger("You cannot use OOC (muted)."))
			return
	if(is_banned_from(ckey, "OOC"))
		to_chat(src, span_danger("You have been banned from OOC."))
		return
	if(should_not_say)
		to_chat(src, span_danger("Тебе не нужно разговаривать, ты еблан."))
		return
	if(QDELETED(src))
		return

	msg = copytext_char(sanitize(msg), 1, MAX_MESSAGE_LEN)

	var/raw_msg = msg
	if(!raw_msg)
		return

	msg = emoji_parse(raw_msg)
/*
	if(SSticker.HasRoundStarted() && (msg[1] in list(".",";",":","#") || findtext_char(msg, "say", 1, 5)))
		if(tgui_alert(usr,"Your message \"[raw_msg]\" looks like it was meant for in game communication, say it in OOC?", "Meant for OOC?", list("Yes", "No")) != "Yes")
			return
*/
	if(!holder)
		if(handle_spam_prevention(msg,MUTE_OOC))
			return

	if(!(prefs?.chat_toggles & CHAT_OOC))
		to_chat(src, span_danger("You have OOC muted."))
		return

	var/raw_msg_without_spaces = replacetext(raw_msg, " ", "")
	if((length(msg) >= 3) && ((length(raw_msg)-length(raw_msg_without_spaces))/length(raw_msg) >= 0.5) )
		to_chat(src, span_warning("Most of your message was just empty space."))
		return

	mob.log_talk(raw_msg, LOG_OOC)

	var/datum/asset/spritesheet/sheet = get_asset_datum(/datum/asset/spritesheet/chat)
	var/keyname = key
	if(sheet.icon_tag("donator-[ckey]"))
		keyname = "[sheet.icon_tag("donator-[ckey]")] [keyname]"
//	if(SSdonators.donator_to_ooc_color[ckey])
//		keyname = "<font color='[SSdonators.donator_to_ooc_color[ckey]]'>[keyname]</font>"
	else if(CONFIG_GET(string/ipstack_api_key))
		switch(country)
			if("Brazil")
				keyname = "[sheet.icon_tag("ooc-whatsapp")] <font color='[GLOB.brazil_ooc_color]'>[keyname]</font>"
			if("Niger")
				keyname = "[sheet.icon_tag("ooc-niger")] <font color='[GLOB.niger_ooc_color]'>[keyname]</font>"
				msg = "[msg] <span class='lowestpain'>- I hate niger's economic policies.</span>"
			if("Ukraine", "Russia", "Poland")
				keyname = "[sheet.icon_tag("ooc-hohol")] <font color='[GLOB.ukraine_ooc_color]'>[keyname]</font>"
				msg = "[msg] <span class='lowestpain'>- Putin is our king!</span>"
	var/pol_flag = political_compass?.get_flag()
	if(pol_flag)
		keyname = "[sheet.icon_tag("ooc-[pol_flag]")] <font color='[political_compass.get_color()]'>[keyname]</font>"

	var/ooccolor = prefs.read_preference(/datum/preference/color/ooc_color)
	if(prefs.unlock_content)
		if(prefs.toggles & MEMBER_PUBLIC)
			keyname = "<font color='[ooccolor ? ooccolor : GLOB.normal_ooc_colour]'>[icon2html('icons/member_content.dmi', world, "blag")] [keyname]</font>"
	if(prefs.hearted)
		keyname = "[sheet.icon_tag("emoji-heart")] [keyname]"
	//The linkify span classes and linkify=TRUE below make ooc text get clickable chat href links if you pass in something resembling a url
	for(var/client/player as anything in GLOB.clients)
		if(player.prefs?.chat_toggles & CHAT_OOC)
			if(holder?.fakekey in player.prefs.ignoring)
				continue
			if(holder)
				if(!holder.fakekey || player.holder)
					if(check_rights_for(src, R_ADMIN))
						to_chat(player, span_adminooc("[CONFIG_GET(flag/allow_admin_ooccolor) && ooccolor ? "<font color=[ooccolor]>" :"" ]<span class='prefix'>OOC:</span> <EM>[keyname][holder.fakekey ? "/([holder.fakekey])" : ""]:</EM> <span class='message linkify'>[msg]</span>"))
					else
						to_chat(player, span_adminobserverooc("<span class='prefix'>OOC:</span> <EM>[keyname][holder.fakekey ? "/([holder.fakekey])" : ""]:</EM> <span class='message linkify'>[msg]</span>"))
				else
					if(GLOB.OOC_COLOR)
						to_chat(player, span_ooc("<font color='[GLOB.OOC_COLOR]'><b><span class='prefix'>OOC:</span> <EM>[holder.fakekey ? holder.fakekey : key]:</EM> <span class='message linkify'>[msg]</span></b></font>"))
					else
						to_chat(player, span_ooc("<span class='prefix'>OOC:</span> <EM>[holder.fakekey ? holder.fakekey : key]:</EM> <span class='message linkify'>[msg]</span>"))
			else if(!(key in player.prefs.ignoring))
				if(GLOB.OOC_COLOR)
					to_chat(player, span_ooc("<font color='[GLOB.OOC_COLOR]'><b><span class='prefix'>OOC:</span> <EM>[keyname]:</EM> <span class='message linkify'>[msg]</span></b></font>"))
				else
					to_chat(player, span_ooc("<span class='prefix'>OOC:</span> <EM>[keyname]:</EM> <span class='message linkify'>[msg]</span>"))
