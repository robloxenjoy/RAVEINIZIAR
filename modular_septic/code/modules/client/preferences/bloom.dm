/// Whether or not to toggle bloom
/datum/preference/toggle/bloom
	category = PREFERENCE_CATEGORY_GAME_PREFERENCES
	savefile_key = "bloom"
	savefile_identifier = PREFERENCE_PLAYER

/datum/preference/toggle/bloom/apply_to_client(client/client, value)
	var/atom/movable/screen/plane_master/game_world_bloom/game_world_bloom = locate() in client?.screen
	var/atom/movable/screen/plane_master/game_world_upper_bloom/game_world_upper_bloom = locate() in client?.screen
	game_world_bloom?.backdrop(client.mob)
	game_world_upper_bloom?.backdrop(client.mob)

