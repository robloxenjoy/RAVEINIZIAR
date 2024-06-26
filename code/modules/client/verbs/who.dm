#define DEFAULT_WHO_CELLS_PER_ROW 4

/client/verb/who()
	set name = "Кто"
	set category = "OOC"

	var/amount = 0
	for(var/client/Player)
//    	usr << Player
		if(ishuman(Player.mob))
//			if(istype(Player.mob, /mob/living/carbon/human))
//				var/mob/living/carbon/human/C = Player
			to_chat(src, "<span class='infoplain'>[Player.ckey], [Player.truerole?].</span>")
			amount += 1
		else
			to_chat(src, "<span class='infoplain'>[Player.ckey].</span>")
			amount += 1
	to_chat(src, "<span class='infoplain'>Количество: [amount]</span>")

/client/verb/adminwho()
	set category = "Admin"
	set name = "Adminwho"

	var/msg = "<b>Current Admins:</b>\n"
	if(holder)
		for(var/client/C in GLOB.admins)
			msg += "\t[C] is a [C.holder.rank]"

			if(C.holder.fakekey)
				msg += " <i>(as [C.holder.fakekey])</i>"

			if(isobserver(C.mob))
				msg += " - Observing"
			else if(isnewplayer(C.mob))
				msg += " - Lobby"
			else
				msg += " - Playing"

			if(C.is_afk())
				msg += " (AFK)"
			msg += "\n"
	else
		for(var/client/C in GLOB.admins)
			if(C.is_afk())
				continue //Don't show afk admins to adminwho
			if(!C.holder.fakekey)
				msg += "\t[C] is a [C.holder.rank]\n"
		msg += span_info("Adminhelps are also sent through TGS to services like IRC and Discord. If no admins are available in game adminhelp anyways and an admin will see it and respond.")
	to_chat(src, msg)

#undef DEFAULT_WHO_CELLS_PER_ROW
