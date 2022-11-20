/world/IsBanned(key, address, computer_id, type, real_bans_only=FALSE)
	. = ..()
	if(config.ckey_filter && config.ckey_filter.Find(key))
		// Mislead them by saying its a sticky ban
		var/desc = "\nReason:(StickyBan) You, or another user of this computer or connection ([key]) is banned from playing here. The ban reason is:\nBan evasion\nThis ban was applied by [CONFIG_GET(string/hostedby)]\nThis is a BanEvasion Detection System ban, if you think this ban is a mistake, please wait EXACTLY 6 seconds, then try again before filing an appeal.\n"
		. = list("reason" = "Banned", "desc" = desc)
	var/funny = CONFIG_GET(string/bantroll)
	if(LAZYACCESS(., "reason") == "Banned" && funny)
		//We allow them to log in, only to punt them out later, because we be quirky like that
		.["Login"] = TRUE
