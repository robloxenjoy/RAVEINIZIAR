TOGGLE_CHECKBOX(/datum/verbs/menu/settings, toggle_fullscreen)()
	set name = "Toggle Fullscreen"
	set category = "Preferences"
	set desc = "Toggles fullscreen."
	usr.client.prefs.septictoggles ^= TOGGLE_FULLSCREEN
	usr.client.prefs.save_preferences()
	to_chat(src, "Fullscreen [usr.client.prefs.septictoggles & TOGGLE_FULLSCREEN ? "enabled" : "disabled"].")
	usr.client.fullscreen()
	SSblackbox.record_feedback("nested tally", "fullscreen toggle", 1, list("Toggle Fullscreen", "[usr.client.prefs.septictoggles & TOGGLE_FULLSCREEN ? "Enabled" : "Disabled"]"))
/datum/verbs/menu/settings/toggle_fullscreen/Get_checked(client/C)
	return C.prefs.septictoggles & TOGGLE_FULLSCREEN
