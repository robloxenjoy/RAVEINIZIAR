///var/obj/effect/lobby_image = new/obj/effect/lobby_image()
/*
/obj/effect/lobby_image
	name = "Подпол"
	desc = "MMO-Roguelike."
	icon = 'icons/misc/podpolobby.dmi'
	icon_state = "podpolt"
	screen_loc = "WEST,SOUTH"
	plane = 300

/obj/effect/lobby_image/New()
	if(SSticker.lobbyworld == "normal")
		icon_state = "podpolt"
	else
		icon_state = "podpolcrazy"
*/
//	overlays += /obj/effect/lobby_grain
//	desc = vessel_name()

/mob/dead/new_player/Login()
	if(!client)
		return

	if(CONFIG_GET(flag/use_exp_tracking))
		client.set_exp_from_db()
		client.set_db_player_flags()
	if(!mind)
		mind = new /datum/mind(key)
		mind.active = TRUE
		mind.set_current(src)

	. = ..()
	if(!. || !client)
		return FALSE

	var/motd = global.config.motd
	if(motd)
		to_chat(src, "<div class=\"motd\">[motd]</div>", handle_whitespace=FALSE)
	if(SSmapping.config?.map_lore)
		var/map_loree = SSmapping.config?.map_lore
		to_chat(src, div_infobox(span_adminooc("[map_loree]")))
//		to_chat(src, "<div class=\"motd\">[map_loree]</div>", handle_whitespace=FALSE)

	if(GLOB.admin_notice)
		to_chat(src, span_notice("<b>Admin Notice:</b>\n \t [GLOB.admin_notice]"))

	var/spc = CONFIG_GET(number/soft_popcap)
	if(spc && living_player_count() >= spc)
		to_chat(src, span_notice("<b>Server Notice:</b>\n \t [CONFIG_GET(string/soft_popcap_message)]"))

	sight |= SEE_TURFS

	client.playtitlemusic()

	var/datum/asset/asset_datum = get_asset_datum(/datum/asset/simple/lobby)
	asset_datum.send(client)

	// Check if user should be added to interview queue
	if (!client.holder && CONFIG_GET(flag/panic_bunker) && CONFIG_GET(flag/panic_bunker_interview) && !(client.ckey in GLOB.interviews.approved_ckeys))
		var/required_living_minutes = CONFIG_GET(number/panic_bunker_living)
		var/living_minutes = client.get_exp_living(TRUE)
		if (required_living_minutes >= living_minutes)
			client.interviewee = TRUE
			register_for_interview()
			return

	to_chat(src, span_bigdanger("In OOC, the Play button - you'll figure it out."))
	to_chat(src, span_bigdanger("Discord Server - https://discord.gg/Ha4b7n2E5w"))
	if(GLOB.world_deaths_crazy > 0)
		to_chat(src, span_dead("War Phase: [GLOB.phase_of_war]"))
		to_chat(src, span_dead("Deaths in the world: [GLOB.world_deaths_crazy]"))

	if(SSticker.current_state < GAME_STATE_SETTING_UP)
		var/tl = SSticker.GetTimeLeft()
		to_chat(src, span_warning("Everything will start in... [tl > 0 ? "[DisplayTimeText(tl)]" : "soon"]."))
