#define DEFAULT_WHO_CELLS_PER_ROW 4

/client/verb/who()
	set name = "Кто?"
	set category = "OOC"

	var/msg = "<b>Текущее кол-во игроков:</b>\n"

	var/list/Lines = list()
	var/columns_per_row = DEFAULT_WHO_CELLS_PER_ROW

	if(holder)
		for(var/client/client in GLOB.clients)
			var/entry = "[client.key]"
			if(client.holder && client.holder.fakekey)
				entry += " <i>(как [client.holder.fakekey])</i>"
			entry += " ([round(client.avgping, 1)]мс)"
			Lines += entry
	else
		for(var/client/client in GLOB.clients)
			if(client.holder && client.holder.fakekey)
				Lines += "[client.holder.fakekey] ([round(client.avgping, 1)]мс)"
			else
				Lines += "[client.key] ([round(client.avgping, 1)]мс)"

	var/num_lines = 0
	msg += "<table style='width: 100%; table-layout: fixed'><tr>"
	for(var/line in sort_list(Lines))
		msg += "<td>[line]</td>"

		num_lines += 1
		if (num_lines == columns_per_row)
			num_lines = 0
			msg += "</tr><tr>"
	msg += "</tr></table>"

	msg += "<b>Всего игроков: [length(Lines)]</b>"
	to_chat(src, "<span class='infoplain'>[msg]</span>")

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
