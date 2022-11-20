/world/update_status()
	var/list/features = list()
	var/s = ""
	var/hostedby
	var/tagline
	var/fluff
	if(config)
		var/server_name = CONFIG_GET(string/servername)
		if (server_name)
			s += "<b>[server_name]</b> &#8212; "
		hostedby = CONFIG_GET(string/hostedby)
		tagline = CONFIG_GET(string/servertagline)
		fluff = CONFIG_GET(string/flufftagline)
	s += "<b>[station_name()]</b>"
	s += " ("
	s += "<a href='https://discord.gg/YrN2nNbhvP'>Discord</a>"
	s += ")\]"
	s += "<br>"
	if(tagline)
		s += "[tagline]<br>"
	if(fluff)
		s += "<i>[fluff]</i><br>"

	var/map = SSmapping?.config?.map_name

	if(map)
		features += "[capitalize_like_old_man(map)]"

	if(!GLOB.enter_allowed)
		features += "Closed"

	var/players = length(GLOB.clients)

	var/popcaptext = ""
	var/popcap = min(CONFIG_GET(number/extreme_popcap), CONFIG_GET(number/hard_popcap), CONFIG_GET(number/soft_popcap))
	if (popcap)
		popcaptext = "/[popcap]"

	if(players > 1)
		features += "[players][popcaptext] players"
	else if(players == 1)
		features += "[players][popcaptext] player"

	game_state = (CONFIG_GET(number/extreme_popcap) && players >= CONFIG_GET(number/extreme_popcap)) //tells the hub if we are full

	if(hostedby)
		features += "Hosted by <b>[hostedby]</b>"

	if(LAZYLEN(features))
		s += "\[[jointext(features, " | ")]"

	status = s
