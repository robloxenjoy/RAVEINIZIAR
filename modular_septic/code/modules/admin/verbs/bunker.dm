/client/proc/cmd_add_key_to_bunker(playerckey as text)
	set category = "Admin"
	set name = "Add ckey to bunker"
	if(!holder)
		to_chat(src,
			type = MESSAGE_TYPE_ADMINPM,
			html = span_danger("Error: Add-to-bunker: Only administrators may use this command."),
			confidential = TRUE)
		return
	if(!length(playerckey))
		to_chat(usr, span_alert("Invalid key."))
		return
	var/required_living_minutes = ((CONFIG_GET(number/panic_bunker_living) || 5) + 1)
	var/datum/preferences/keyprefs = new()
	keyprefs.load_path(playerckey)
	if(keyprefs.load_preferences())
		if(!keyprefs.exp)
			keyprefs.exp = list()
		LAZYINITLIST(GLOB.exp_to_update)
		GLOB.exp_to_update.Add(list(list(
			"job" = EXP_TYPE_LIVING,
			"ckey" = playerckey,
			"minutes" = required_living_minutes)))
		keyprefs.exp[EXP_TYPE_LIVING] = required_living_minutes
		SSblackbox.update_exp_db()
		to_chat(usr, span_notice("[playerckey] added to bunker ([required_living_minutes] min playtime)."))
	else
		to_chat(usr, span_alert("Invalid key."))
	qdel(keyprefs)

/client/proc/cmd_remove_key_from_bunker(playerckey as text)
	set category = "Admin"
	set name = "Remove ckey from bunker"
	if(!holder)
		to_chat(src,
			type = MESSAGE_TYPE_ADMINPM,
			html = span_danger("Error: Remove-from-bunker: Only administrators may use this command."),
			confidential = TRUE)
		return
	if(!length(playerckey))
		to_chat(usr, span_alert("Invalid key."))
		return
	var/new_playime = 0
	var/datum/preferences/keyprefs = new()
	keyprefs.load_path(playerckey)
	if(keyprefs.load_preferences())
		if(!keyprefs.exp)
			keyprefs.exp = list()
		LAZYINITLIST(GLOB.exp_to_update)
		GLOB.exp_to_update.Add(list(list(
			"job" = EXP_TYPE_LIVING,
			"ckey" = playerckey,
			"minutes" = new_playime)))
		keyprefs.exp[EXP_TYPE_LIVING] = new_playime
		SSblackbox.update_exp_db()
		to_chat(usr, span_notice("[playerckey] removed from bunker ([new_playime] min playtime)."))
	else
		to_chat(usr, span_alert("Invalid key."))
	qdel(keyprefs)
