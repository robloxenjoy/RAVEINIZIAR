/datum/controller/configuration
	/// For punctuation forcing
	var/static/regex/punctuation_filter_regex
	var/static/regex/punctuation_filter_bypass_regex
	/// Prevents "NiggaMaster420" from joining
	var/static/regex/ckey_filter
	/// Prevents characters with dumb names
	var/static/regex/name_filter

/datum/controller/configuration/LoadChatFilter()
	. = ..()
	if(!punctuation_filter_regex)
		log_config("Loading punctuation filter regex...")
		punctuation_filter_regex = LoadPunctuationFilter()
	if(!punctuation_filter_bypass_regex)
		log_config("Loading punctuation filter bypass regex...")
		punctuation_filter_bypass_regex = LoadPunctuationFilterBypass()
	if(!name_filter)
		log_config("Loading name filter regex...")
		ckey_filter = LoadNameFilter()
	if(!ckey_filter)
		log_config("Loading ckey filter regex...")
		ckey_filter = LoadCkeyFilter()

/datum/controller/configuration/proc/LoadInCharacterFilter()
	var/list/filter = list()
	if(!fexists("[directory]/in_character_filter.txt"))
		return
	log_config("Loading config file in_character_filter.txt...")
	for(var/line in world.file2list("[directory]/in_character_filter.txt"))
		if(!line)
			continue
		if(findtextEx(line,"#",1,2))
			continue
		filter += REGEX_QUOTE(line)
	return (length(filter) ? regex("\\b([jointext(filter, "|")])\\b", "gi") : null)

/datum/controller/configuration/proc/LoadPunctuationFilter()
	var/list/filter = list()
	if(!fexists("[directory]/septic/punctuation_filter.txt"))
		return
	log_config("Loading config file punctuation_filter.txt...")
	for(var/line in world.file2list("[directory]/septic/punctuation_filter.txt"))
		if(!line)
			continue
		if(findtextEx(line,"#",1,2))
			continue
		filter += REGEX_QUOTE(line)
	return (length(filter) ? regex("([jointext(filter, "|")])", "gi") : null)

/datum/controller/configuration/proc/LoadPunctuationFilterBypass()
	var/list/filter = list()
	if(!fexists("[directory]/septic/punctuation_filter_bypass.txt"))
		return
	log_config("Loading config file punctuation_filter_bypass.txt...")
	for(var/line in world.file2list("[directory]/septic/punctuation_filter_bypass.txt"))
		if(!line)
			continue
		if(findtextEx(line,"#",1,2))
			continue
		filter += REGEX_QUOTE(line)
	return (length(filter) ? regex("([jointext(filter, "|")])", "gi") : null)

/datum/controller/configuration/proc/LoadNameFilter()
	var/list/filter = list()
	if(!fexists("[directory]/septic/name_filter.txt"))
		return
	log_config("Loading config file name_filter.txt...")
	for(var/line in world.file2list("[directory]/septic/name_filter.txt"))
		if(!line)
			continue
		if(findtextEx(line,"#",1,2))
			continue
		filter += REGEX_QUOTE(line)
	return (length(filter) ? regex("\\b([jointext(filter, "|")])\\b", "gi") : null)

/datum/controller/configuration/proc/LoadCkeyFilter()
	var/list/filter = list()
	if(!fexists("[directory]/septic/ckey_filter.txt"))
		return
	log_config("Loading config file ckey_filter.txt...")
	for(var/line in world.file2list("[directory]/septic/ckey_filter.txt"))
		if(!line)
			continue
		if(findtextEx(line,"#",1,2))
			continue
		filter += REGEX_QUOTE(line)
	return (length(filter) ? regex("([jointext(filter, "|")])", "gi") : null)
