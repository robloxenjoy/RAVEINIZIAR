/datum/map_config
	/// Surface z levels that spawn ruins
	var/surface_ruin_levels = 0
	/// Surface z levels that don't spawn ruins
	var/surface_empty_levels = 0
	/// Cave z levels that spawn ruins
	var/cave_ruin_levels = 0
	/// Cave z levels that don't spawn ruins
	var/cave_empty_levels = 0
	/// Short text box explaining the lore for the currnet map
	var/map_lore = null
	/// Alternative command name for this map only
	var/command_name = "VOICE"
	/// This is only used by test maps, if true everyone spawns nakey
	var/everyone_is_fucking_naked = FALSE
	/// Combat maps get a skill modifier for every job
	var/combat_map = FALSE

	var/war_gamemode = FALSE
	var/prison_gamemode = FALSE
	/// Custom overflow role, currently only used by combat test map
	var/overflow_role
	/// This is used for test maps, to allow people to respawn.
	var/respawn_allowed
	/// A list of roundstart rulesets forced by this map, if there is one
	var/list/dynamic_forced_roundstart_rulesets

/datum/map_config/LoadConfig(filename, error_if_missing)
	. = ..()
	if(!.)
		return
	var/json = file(filename)
	if(!json)
		log_world("Could not open map_config: [filename]")
		return

	json = file2text(json)
	if(!json)
		log_world("map_config is not text: [filename]")
		return

	json = json_decode(json)
	if(!json)
		log_world("map_config is not json: [filename]")
		return

	if("map_lore" in json)
		map_lore = json["map_lore"]

	if("command_name" in json)
		command_name = json["command_name"]
		change_command_name(command_name)

	if("surface_ruin_levels" in json)
		surface_ruin_levels = json["surface_ruin_levels"]

	if("surface_empty_levels" in json)
		surface_empty_levels = json["surface_empty_levels"]

	if("cave_ruin_levels" in json)
		cave_ruin_levels = json["cave_ruin_levels"]

	if("cave_empty_levels" in json)
		cave_empty_levels = json["cave_empty_levels"]

	if("overflow_role" in json)
		overflow_role = json["overflow_role"]
		if(overflow_role)
			log_admin("Current map ([map_name]) sets [overflow_role] as the overflow role.")
			message_admins("Current map ([map_name]) sets [overflow_role] as the overflow role.")

	if("everyone_is_fucking_naked" in json)
		everyone_is_fucking_naked = json["everyone_is_fucking_naked"]
		if(everyone_is_fucking_naked)
			log_admin("Current map ([map_name]) makes everyone fucking naked!")
			message_admins("Current map ([map_name]) makes everyone fucking naked!")

	if("combat_map" in json)
		combat_map = json["combat_map"]
		if(combat_map)
			log_admin("Current map ([map_name]) is a combat map.")
			message_admins("Current map ([map_name]) is a combat map.")
/*
	if("war_gamemode" in json)
		war_gamemode = json["war_gamemode"]
*/
	if("war_gamemode" in json)
		war_gamemode = json["war_gamemode"]

	if("prison_gamemode" in json)
		prison_gamemode = json["prison_gamemode"]

	if("respawn_allowed" in json)
		respawn_allowed = json["respawn_allowed"]
		if(respawn_allowed)
			log_admin("Current map ([map_name]) allows anyone to respawn when dead, by default.")
			message_admins("Current map ([map_name]) allows anyone to respawn when dead, by default.")
		else
			log_admin("Current map ([map_name]) does not allow anyone to respawn when dead, by default.")
			message_admins("Current map ([map_name]) does not allow anyone to respawn when dead, by default.")
		CONFIG_SET(flag/norespawn, !respawn_allowed)

	if("dynamic_forced_roundstart_rulesets" in json)
		if(!islist(json["dynamic_forced_roundstart_rulesets"]))
			log_world("map_config dynamic_forced_roundstart_rulesets is not a list!")
		else
			dynamic_forced_roundstart_rulesets = list()
			for(var/ruleset_path_text in json["dynamic_forced_roundstart_rulesets"])
				dynamic_forced_roundstart_rulesets -= ruleset_path_text
				var/ruleset_path = text2path(ruleset_path_text)
				if(!ispath(ruleset_path, /datum/dynamic_ruleset/roundstart))
					log_world("map_config dynamic_forced_roundstart_rulesets contains invalid ruleset [ruleset_path_text]!")
					continue
				dynamic_forced_roundstart_rulesets |= ruleset_path
			if(LAZYLEN(dynamic_forced_roundstart_rulesets))
				for(var/ruleset_path in dynamic_forced_roundstart_rulesets)
					var/already_exists = FALSE
					for(var/datum/dynamic_ruleset/roundstart/ruleset_existing in GLOB.dynamic_forced_roundstart_ruleset)
						if(istype(ruleset_existing, ruleset_path))
							already_exists = TRUE
					if(!already_exists)
						GLOB.dynamic_forced_roundstart_ruleset |= new ruleset_path
				var/english_rulesets = english_list(dynamic_forced_roundstart_rulesets)
				log_admin("Current map ([map_name]) forces roundstart rulesets ([english_rulesets]).")
				message_admins("Current map ([map_name]) forces roundstart rulesets ([english_rulesets]).")

	if("station_name" in json)
		set_station_name(json["station_name"])
