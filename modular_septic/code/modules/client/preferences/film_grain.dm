/datum/preference/toggle/filmgrain
	category = PREFERENCE_CATEGORY_GAME_PREFERENCES
	savefile_key = "filmgrainpref"
	savefile_identifier = PREFERENCE_PLAYER
	default_value = TRUE

/datum/preference/toggle/filmgrain/apply_to_client(client/client, value)
	if(client.mob?.hud_used)
		var/datum/hud/hud_used = client.mob.hud_used
		if(value && !hud_used.noise)
			hud_used.noise = new()
			hud_used.noise.hud = hud_used
			hud_used.noise.update_for_view(client.view)
			hud_used.screenoverlays |= hud_used.noise
			client.screen |= hud_used.noise
		else if(!value && hud_used.noise)
			client.screen -= hud_used.noise
			hud_used.screenoverlays -= hud_used.noise
			QDEL_NULL(hud_used.noise)
