/client/New(TopicData)
	var/funny = CONFIG_GET(string/bantroll)
	var/list/isbanned = world.IsBanned(key, address, computer_id, connection)
	var/reconnecting = FALSE
	if(GLOB.player_details[ckey])
		reconnecting = TRUE
	. = ..()
	if(length(isbanned) && !check_rights(R_ADMIN))
		var/list/ban_details = is_banned_from_with_details(ckey, address, computer_id, "Server")
		for(var/i in ban_details)
			var/expires = "This is a permanent ban."
			if(i["expiration_time"])
				expires = " The ban is for [DisplayTimeText(text2num(i["duration"]) MINUTES)] and expires on [i["expiration_time"]] (server time)."
			var/desc = {"You, or another user of this computer or connection ([i["key"]]) is banned from playing here.
			The ban reason is: [i["reason"]]
			This ban (BanID #[i["id"]]) was applied by [i["admin_key"]] on [i["bantime"]] during round ID [i["round_id"]].
			[expires]"}
			to_chat_immediate(src, span_danger("<b>You are not invited!</b>"))
			to_chat_immediate(src, span_warning("[desc]"))
			break
		if(funny)
			DIRECT_OUTPUT(src, link(funny))
		qdel(src)
		return
	if(CONFIG_GET(string/ipstack_api_key))
		country = SSipstack.check_ip(address)
		if(country == DEFAULT_CLIENT_COUNTRY)
			message_admins(span_adminnotice("GeoIP for [key_name_admin(src)] was invalid!"))
		else if(country == "Brazil")
			message_admins(span_adminnotice("[key_name_admin(src)] is a based Brazilian!"))
	if(mob)
		broadcast_connection(reconnecting ? "reconnected to the server" : "connected the server")
	political_compass = new()
	political_compass.owner = src
	political_compass.load_path()
	political_compass.load_save()
	political_compass.update()
	winset(src, null, "input.focus=false")

/client/Destroy()
	. = ..()
	if(mob)
		broadcast_connection(connection_string = "disconnected from the server")
	QDEL_NULL(droning_sound)
	last_droning_sound = null
	QDEL_NULL(political_compass)
	QDEL_NULL(attribute_editor)
	QDEL_NULL(nobody_wants_to_learn_matrix_math)
//	QDEL_NULL(particool)

/client/proc/broadcast_connection(connection_string = "connected to the server")
	var/bling_bling = prefs?.donator_rank
	for(var/client/player as anything in GLOB.clients)
		if(player.prefs)
			var/datum/preferences/prefs = player.prefs
			if(!(prefs.chat_toggles & CHAT_LOGIN_LOGOUT))
				continue
		if(bling_bling)
			to_chat(player, "<span class='oocplain'><span class='bling'><span class='prefix'>SERVER:</span> <b>[key]</b> has [connection_string].</span></span>")
		else
			to_chat(player, "<span class='oocplain'><span style='color: [GLOB.connection_ooc_color]; font-weight: bold;'><span class='prefix'>SERVER:</span> <b>[key]</b> has [connection_string].</span>")

/client/proc/broadcast_epicbunkerfail()
	var/bling_bling = prefs?.donator_rank
	for(var/client/player as anything in GLOB.clients)
		if(player.prefs)
			var/datum/preferences/prefs = player.prefs
			if(!(prefs.chat_toggles & CHAT_LOGIN_LOGOUT))
				continue
		if(bling_bling)
			to_chat(player, "<span class='oocplain'><span class='bling'><span class='prefix'>SERVER:</span> Epic connection fail. Laugh at <b>[key]</b>.</span></span>")
		else
			to_chat(player, "<span class='oocplain'><span style='color: [GLOB.connection_ooc_color]; font-weight: bold;'><span class='prefix'>SERVER:</span> Epic connection fail. Laugh at <b>[key]</b>.</span></span>")

/client/proc/bruh_moment()
	var/sound/bruh = sound('modular_septic/sound/memeshit/bruh.ogg', FALSE, 0, CHANNEL_LOBBYMUSIC, 100)
	to_chat(src, span_cultlarge("Bruh."))
	SEND_SOUND(src, bruh)

/client/proc/bruh_and_kick()
	stop_client_sounds()
	bruh_moment()
	QDEL_IN(src, 4 SECONDS)
/*
/client/proc/is_donator()
	var/datum/db_query/query_check_donator = SSdbcore.NewQuery({"
		SELECT
			rank,
		FROM [format_table_name("donators")]
		WHERE ckey = :ckey
	"}, list("ckey" = src.ckey))
	if(!query_check_donator.warn_execute())
		qdel(query_check_donator)
		return
	. = list()
	while(query_check_donator.NextRow())
		. += list(list("rank" = query_check_donator.item[1]))
	qdel(query_check_donator)
	for(var/list/funny_list as anything in .)
		if(LAZYACCESS(funny_list, "rank"))
			return funny_list["rank"]
*/