/// Whether or not frills are displayed over floors
/datum/preference/toggle/frills_over_floors
	category = PREFERENCE_CATEGORY_GAME_PREFERENCES
	savefile_key = "frillsoverfloors"
	savefile_identifier = PREFERENCE_PLAYER

/datum/preference/toggle/frills_over_floors/apply_to_client(client/client, value, datum/preferences/preferences)
	var/atom/movable/screen/plane_master/frill/plane_master = locate() in client?.screen
	if(!plane_master)
		return

	plane_master.backdrop(client.mob)
