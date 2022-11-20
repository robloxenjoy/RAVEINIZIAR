/datum/preference/toggle/fullscreen
	category = PREFERENCE_CATEGORY_GAME_PREFERENCES
	savefile_key = "fullscreenpref"
	savefile_identifier = PREFERENCE_PLAYER
	default_value = TRUE

/datum/preference/toggle/fullscreen/apply_to_client(client/client, value)
	client.do_fullscreen(value)
