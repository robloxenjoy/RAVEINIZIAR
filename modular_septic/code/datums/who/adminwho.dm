//This datum is used solely to manage the "adminwho" verb tgui
/datum/adminwho

/datum/adminwho/ui_interact(mob/user, datum/tgui/ui)
	ui = SStgui.try_update_ui(user, src, ui)
	if(!ui)
		ui = new(user, src, "AdminWhoMenu")
		ui.open()

/datum/adminwho/ui_state(mob/user)
	return GLOB.always_state

/datum/adminwho/ui_data(mob/user)
	var/list/data = list()

	var/datum/admins/holder = user.client.holder
	var/list/admins = list()
	var/client/admin //faster declaration
	for(var/thing in GLOB.admins)
		var/list/this_admin = list()
		admin = thing
		//Don't show fakemins to plebs
		if(admin.holder.fakekey && !holder)
			continue
		//Don't show afk admins to plebs
		if(admin.is_afk() && !holder)
			continue
		//KEY
		var/key = "[admin.key]"
		if(admin.holder.fakekey && holder)
			key += " (as [admin.holder.fakekey])"
		if(admin.is_afk() && holder)
			key += " \[AFK\]"
		this_admin["key"] = key
		//RANK
		this_admin["rank"] = "[admin.holder.rank.name]"

		admins += list(this_admin)
	data["admins"] = admins
	data["total_admins"] = length(admins)
	return data
