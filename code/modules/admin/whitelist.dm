#define WHITELISTFILE "[global.config.directory]/whitelist.txt"
#define FRAGGOTSFILE "[global.config.directory]/fraggots.txt"

GLOBAL_LIST(whitelist)
GLOBAL_PROTECT(whitelist)

GLOBAL_LIST(fraggots)
GLOBAL_PROTECT(fraggots)

/proc/load_whitelist()
	GLOB.whitelist = list()
	for(var/line in world.file2list(WHITELISTFILE))
		if(!line)
			continue
		if(findtextEx(line,"#",1,2))
			continue
		GLOB.whitelist += ckey(line)

	if(!GLOB.whitelist.len)
		GLOB.whitelist = null

/proc/check_whitelist(ckey)
	if(!GLOB.whitelist)
		return FALSE
	. = (ckey in GLOB.whitelist)

/proc/load_fraggots()
	GLOB.fraggots = list()
	for(var/line in world.file2list(FRAGGOTSFILE))
		if(!line)
			continue
		if(findtextEx(line,"#",1,2))
			continue
		GLOB.fraggots += ckey(line)

	if(!GLOB.fraggots.len)
		GLOB.fraggots = null

/proc/check_fraggots(ckey)
	if(!GLOB.fraggots)
		return FALSE
	. = (ckey in GLOB.fraggots)

#undef WHITELISTFILE
#undef FRAGGOTSFILE