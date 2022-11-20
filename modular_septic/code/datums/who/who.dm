//This datum is used solely to manage the "who" verb tgui
/datum/who

/datum/who/ui_interact(mob/user, datum/tgui/ui)
	ui = SStgui.try_update_ui(user, src, ui)
	if(!ui)
		ui = new(user, src, "WhoMenu")
		ui.open()

/datum/who/ui_state(mob/user)
	return GLOB.always_state

/datum/who/ui_data(mob/user)
	var/list/data = list()

	data["clients"] = list()
	var/mob/dead/observer/observer_user
	var/datum/admins/holder = user.client.holder
	if(isobserver(user))
		observer_user = user
		if(!observer_user.started_as_observer && !observer_user.client.holder)
			observer_user = null
	var/client/player //faster declaration
	for(var/thing in GLOB.clients)
		var/list/this_player = list()
		player = thing
		//KEY
		if(holder?.fakekey)
			if(observer_user)
				this_player["key"] = "[player.key] (as [player.holder.fakekey])"
			else
				this_player["key"] = "[player.holder.fakekey]"
		else
			this_player["key"] = "[player.key]"
		//STATUS
		if(isnewplayer(player.mob))
			this_player["status"] = "In Lobby"
		else
			if(observer_user)
				var/status = "Playing as [player.mob ? player.mob.real_name : "NULL"]"
				switch(player.mob?.stat)
					if(UNCONSCIOUS, HARD_CRIT)
						status += " (Unconscious)"
					if(DEAD)
						if(isobserver(player.mob))
							var/mob/dead/observer/observer_player = player.mob
							if(observer_player.started_as_observer)
								status += " (Observing)"
							else
								status += " (Observing, Dead)"
						else
							status += " (Dead)"
				this_player["status"] = status
			else
				this_player["status"] = "Playing"
		//JOB
		if(isnewplayer(player.mob) || isobserver(player.mob))
			this_player["job"] = "N/A"
			if(observer_user && holder)
				this_player["mob_ref"] = "[REF(player.mob)]"
		else
			var/job = "[player.mob?.job ? player.mob.job : "None"]"
			if(observer_user)
				if(is_special_character(player.mob))
					job += " (Antagonist)"
				if(holder)
					this_player["mob_ref"] = "[REF(player.mob)]"
			this_player["job"] = job
		//PING
		this_player["ping"] = "[CEILING(player.avgping, 1)]ms"
		//COUNTRY
		this_player["country"] = "[player.country]"

		data["clients"] += list(this_player)
	data["total_clients"] = LAZYLEN(GLOB.clients)

	return data

/datum/who/ui_act(action, list/params, datum/tgui/ui, datum/ui_state/state)
	. = ..()
	switch(action)
		if("admin_more_info")
			var/mob_ref = params["mob_ref"]
			usr?.client?.holder.Topic("?_src_=holder;[HrefToken(TRUE)];adminmoreinfo=[mob_ref]", list("admin_token" = "[RawHrefToken(TRUE)]", "adminmoreinfo" = "[mob_ref]"))
