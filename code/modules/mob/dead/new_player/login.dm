/var/obj/effect/lobby_image = new/obj/effect/lobby_image()

/obj/effect/lobby_image
	name = "Подпол"
	desc = "MMO-Roguelike."
	icon = 'icons/misc/fullscreen.dmi'
	icon_state = "podpolt"
	screen_loc = "WEST,SOUTH"
	plane = 300

/obj/effect/lobby_image/New()
	if(prob(70))
		icon_state = "podpolt"
		world.lobbyworld = "normal"
	else
		icon_state = "podpolcrazy"
		world.lobbyworld = "crazy"
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

	to_chat(src, span_bigdanger("В OOC кнопка Играть - разберёшься."))
	to_chat(src, span_bigdanger("Дискорд сервер - https://discord.gg/zX7RCNqzvm"))

	if(SSticker.current_state < GAME_STATE_SETTING_UP)
		var/tl = SSticker.GetTimeLeft()
		to_chat(src, span_warning("Всё начнётся через... [tl > 0 ? "[DisplayTimeText(tl)]" : "скоро"]."))
	to_chat(src, span_dead("Смертей в мире: [GLOB.world_deaths_crazy]"))
