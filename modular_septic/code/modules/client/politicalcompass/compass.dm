#define POLITICAL_VERSION_MAX 1
#define POLITICAL_VERSION_MIN 1

/datum/political_compass
	var/path
	var/savefile_version = POLITICAL_VERSION_MAX
	var/classification = ""
	var/client/owner
	// 0 always equals center
	/// Left/right
	var/right_axis = 0
	/// Lib/auth
	var/auth_axis = 0
	/// Progressive/conservative
	var/prog_axis = 0
	/// List of questions associated with given answer - Not global
	var/list/questions_answered = list()

	var/static/max_rightaxis = 16
	var/static/min_rightaxis = -16
	var/static/max_authaxis = 15
	var/static/min_authaxis = -15
	var/static/max_progaxis = 16
	var/static/min_progaxis = -16
	/// List of questions associated with possible answers
	var/static/list/list/all_questions = list(
		"Freedom of business is the best practical way a society can prosper." = list("Agree", "Disagree"),
		"Charity is a better way of helping those in need than social welfare." = list("Agree", "Disagree"),
		"Wages are always fair, as employers know best what a worker's labour is worth." = list("Agree", "Disagree"),
		"It is human nature to be greedy." = list("Agree", "Disagree"),
		"\"Exploitation\" is an outdated term, as the struggles of 1800s capitalism doesn't exist anymore." = list("Agree", "Disagree"),
		"Communism is an ideal that can never work in practice." = list("Agree", "Disagree"),
		"Taxation of the wealthy is a bad idea, society would be better off without it." = list("Agree", "Disagree"),
		"The harder you work, the more you progress up the social ladder." = list("Agree", "Disagree"),
		"Organisations and corporations cannot be trusted and need regulating by the government." = list("Agree", "Disagree"),
		"A government that provides for everyone is an inherently good idea." = list("Agree", "Disagree"),
		"The current welfare system should be expanded to further combat inequality." = list("Agree", "Disagree"),
		"Land should not be a commodity to be bought and sold." = list("Agree", "Disagree"),
		"All industry and the bank should be nationalised." = list("Agree", "Disagree"),
		"Class is the primary division of society." = list("Agree", "Disagree"),
		"Economic inequality is too high in the world." = list("Agree", "Disagree"),
		"Sometimes it is right that the government may spy on its citizens to combat extremists and terrorists." = list("Agree", "Disagree"),
		"Authority figures, if morally correct, are a good thing for society." = list("Agree", "Disagree"),
		"Strength is necessary for any government to succeed." = list("Agree", "Disagree"),
		"Only the government can fairly and effectively regulate organisations." = list("Agree", "Disagree"),
		"Society requires structure and bureaucracy in order to function." = list("Agree", "Disagree"),
		"Mandatory IDs should be used to ensure public safety." = list("Agree", "Disagree"),
		"In times of crisis, safety becomes more important than civil liberties." = list("Agree", "Disagree"),
		"If you have nothing to hide, you have nothing to fear." = list("Agree", "Disagree"),
		"The government should be less involved in the day to day life of its citizens." = list("Agree", "Disagree"),
		"Without democracy, a society is nothing." = list("Agree", "Disagree"),
		"Jury nullification should be legal." = list("Agree", "Disagree"),
		"The smaller the government, the freer the people." = list("Agree", "Disagree"),
		"The government should, at most, provide emergency services and law enforcement." = list("Agree", "Disagree"),
		"The police was not made to protect the people, but to uphold the status-quo by force." = list("Agree", "Disagree"),
		"State schools are a bad idea because our state shouldn't be influencing our children." = list("Agree", "Disagree"),
		"Two consenting individuals should be able to do whatever they want with each other, even if it makes me uncomfortable." = list("Agree", "Disagree"),
		"An individual's body is their own property, and they should be able to do anything they desire to it." = list("Agree", "Disagree"),
		"A person should be able to worship whomever or whatever they want." = list("Agree", "Disagree"),
		"Nudism is perfectly natural." = list("Agree", "Disagree"),
		"Animals deserve certain universal rights." = list("Agree", "Disagree"),
		"Gender is a social construct, not a natural state of affairs." = list("Agree", "Disagree"),
		"Laws based on cultural values, rather than ethical ones, aren't justice." = list("Agree", "Disagree"),
		"Autonomy of body extends even to minors, the mentally ill, and serious criminals." = list("Agree", "Disagree"),
		"Homosexuality is against my values." = list("Agree", "Disagree"),
		"Transgender individuals should not be able to adopt children." = list("Agree", "Disagree"),
		"Drugs are harmful and should be banned." = list("Agree", "Disagree"),
		"The death penalty should exist for certain crimes." = list("Agree", "Disagree"),
		"Victimless crimes should still be punished." = list("Agree", "Disagree"),
		"One cannot be moral without religion." = list("Agree", "Disagree"),
		"Parents should hold absolute power over their children, as they are older and more experienced." = list("Agree", "Disagree"),
		"Multiculturalism is bad." = list("Agree", "Disagree"),
	)
	/// List of questions associated with answer valus (axis:value)
	var/static/list/list/questions_values = list(
		"Freedom of business is the best practical way a society can prosper." = list("right_axis1" =  1, "right_axis2" = -1),
		"Charity is a better way of helping those in need than social welfare." = list("right_axis1" =  1, "right_axis2" = -1),
		"Wages are always fair, as employers know best what a worker's labour is worth." = list("right_axis1" =  1, "right_axis2" = -1),
		"It is human nature to be greedy." = list("right_axis1" =  1, "right_axis2" = -1),
		"\"Exploitation\" is an outdated term, as the struggles of 1800s capitalism doesn't exist anymore." = list("right_axis1" =  1, "right_axis2" = -1),
		"Communism is an ideal that can never work in practice." = list("right_axis1" =  1, "right_axis2" = -1),
		"Taxation of the wealthy is a bad idea, society would be better off without it." = list("right_axis1" =  1, "right_axis2" = -1),
		"The harder you work, the more you progress up the social ladder." = list("right_axis1" =  1, "right_axis2" = -1),
		"Organisations and corporations cannot be trusted and need regulating by the government." = list("right_axis2" = -1, "right_axis1" =  1),
		"A government that provides for everyone is an inherently good idea." = list("right_axis2" = -1, "right_axis1" =  1),
		"The current welfare system should be expanded to further combat inequality." = list("right_axis2" = -1, "right_axis1" =  1),
		"Land should not be a commodity to be bought and sold." = list("right_axis2" = -1, "right_axis1" =  1),
		"All industry and the bank should be nationalised." = list("right_axis2" = -1, "right_axis1" =  1),
		"Class is the primary division of society." = list("right_axis2" = -1, "right_axis1" =  1),
		"Economic inequality is too high in the world." = list("right_axis2" = -1, "right_axis1" =  1),
		"Sometimes it is right that the government may spy on its citizens to combat extremists and terrorists." = list("auth_axis2" = 1, "auth_axis1" = -1),
		"Authority figures, if morally correct, are a good thing for society." = list("auth_axis2" = 1, "auth_axis1" = -1),
		"Strength is necessary for any government to succeed." = list("auth_axis2" = 1, "auth_axis1" = -1),
		"Only the government can fairly and effectively regulate organisations." = list("auth_axis2" = 1, "auth_axis1" = -1),
		"Society requires structure and bureaucracy in order to function." = list("auth_axis2" = 1, "auth_axis1" = -1),
		"Mandatory IDs should be used to ensure public safety." = list("auth_axis2" = 1, "auth_axis1" = -1),
		"In times of crisis, safety becomes more important than civil liberties." = list("auth_axis2" = 1, "auth_axis1" = -1),
		"If you have nothing to hide, you have nothing to fear." = list("auth_axis2" = 1, "auth_axis1" = -1),
		"The government should be less involved in the day to day life of its citizens." = list("auth_axis1" = -1, "auth_axis2" = 1),
		"Without democracy, a society is nothing." = list("auth_axis1" = -1, "auth_axis2" = 1),
		"Jury nullification should be legal." = list("auth_axis1" = -1, "auth_axis2" = 1),
		"The smaller the government, the freer the people." = list("auth_axis1" = -1, "auth_axis2" = 1),
		"The government should, at most, provide emergency services and law enforcement." = list("auth_axis1" = -1, "auth_axis2" = 1),
		"The police was not made to protect the people, but to uphold the status-quo by force." = list("auth_axis1" = -1, "auth_axis2" = 1),
		"State schools are a bad idea because our state shouldn't be influencing our children." = list("auth_axis1" = -1, "auth_axis2" = 1),
		"Two consenting individuals should be able to do whatever they want with each other, even if it makes me uncomfortable." = list("prog_axis2" = 1, "prog_axis1" = -1),
		"An individual's body is their own property, and they should be able to do anything they desire to it." = list("prog_axis2" = 1, "prog_axis1" = -1),
		"A person should be able to worship whomever or whatever they want." = list("prog_axis2" = 1, "prog_axis1" = -1),
		"Nudism is perfectly natural." = list("prog_axis2" = 1, "prog_axis1" = -1),
		"Animals deserve certain universal rights." = list("prog_axis2" = 1, "prog_axis1" = -1),
		"Gender is a social construct, not a natural state of affairs." = list("prog_axis2" = 1, "prog_axis1" = -1),
		"Laws based on cultural values, rather than ethical ones, aren't justice." = list("prog_axis2" = 1, "prog_axis1" = -1),
		"Autonomy of body extends even to minors, the mentally ill, and serious criminals." = list("prog_axis2" = 1, "prog_axis1" = -1),
		"Homosexuality is against my values." = list("prog_axis1" = -1, "prog_axis2" = 1),
		"Transgender individuals should not be able to adopt children." = list("prog_axis1" = -1, "prog_axis2" = 1),
		"Drugs are harmful and should be banned." = list("prog_axis1" = -1, "prog_axis2" = 1),
		"The death penalty should exist for certain crimes." = list("prog_axis1" = -1, "prog_axis2" = 1),
		"Victimless crimes should still be punished." = list("prog_axis1" = -1, "prog_axis2" = 1),
		"One cannot be moral without religion." = list("prog_axis1" = -1, "prog_axis2" = 1),
		"Parents should hold absolute power over their children, as they are older and more experienced." = list("prog_axis1" = -1, "prog_axis2" = 1),
		"Multiculturalism is bad." = list("prog_axis1" = -1, "prog_axis2" = 1),
	)

/datum/political_compass/proc/calculate()
	right_axis = 0
	auth_axis = 0
	prog_axis = 0
	for(var/question in questions_answered)
		var/list/qlist = all_questions[question]
		if(!LAZYLEN(qlist))
			continue
		var/answer = questions_answered[question]
		if(!answer)
			continue
		var/aindex = qlist.Find(answer)
		if(!aindex)
			continue
		var/list/values = questions_values[question]
		if(!LAZYLEN(values))
			continue
		var/axis = LAZYACCESS(values, aindex)
		if(!axis)
			continue
		var/value = LAZYACCESS(values, axis)
		if(!value)
			continue
		switch(axis)
			if("right_axis1", "right_axis2")
				right_axis += value
			if("auth_axis1", "auth_axis2")
				auth_axis += value
			if("prog_axis1", "prog_axis2")
				prog_axis += value

/datum/political_compass/proc/get_result()
	if(!length(questions_answered))
		return "Apolitical Retard"
	var/progressive = "Centrist"
	var/authoritarian = "Centrist"
	var/rightist = "Centrist"
	var/final = ""
	switch(prog_axis/max_progaxis * 100)
		if(-20 to 20)
			progressive = "Centrist"
		if(-100 to -20)
			progressive = "Traditional"
		if(20 to 100)
			progressive = "Progressive"
	switch(auth_axis/max_authaxis * 100)
		if(-20 to 20)
			authoritarian = "Centrist"
		if(-100 to -20)
			authoritarian = "Libertarian"
		if(20 to 100)
			authoritarian = "Authoritarian"
	switch(right_axis/max_rightaxis * 100)
		if(-20 to 20)
			rightist = "Centrist"
		if(-100 to -20)
			rightist = "Left"
		if(20 to 100)
			rightist = "Right"
	final = "[progressive] [authoritarian] [rightist]"
	if(final == "Centrist Centrist Centrist")
		final = "Enlightened Centrist"
	return final

/datum/political_compass/proc/get_flag()
	if(!length(questions_answered))
		return
	if(isnull(classification))
		return "truecenter"
	var/authoritarian = "center"
	var/rightist = "center"
	var/icon_state = ""
	switch(auth_axis/max_authaxis * 100)
		if(-20 to 20)
			authoritarian = "center"
		if(-100 to -20)
			authoritarian = "lib"
		if(20 to 100)
			authoritarian = "auth"
	switch(right_axis/max_rightaxis * 100)
		if(-20 to 20)
			rightist = "center"
		if(-100 to -20)
			rightist = "left"
		if(20 to 100)
			rightist = "right"
	if((rightist == "center") && (authoritarian == "center"))
		return "truecenter"
	icon_state = "[authoritarian][rightist]"
	return icon_state

/datum/political_compass/proc/get_color()
	if(!length(questions_answered))
		return
	if(isnull(classification))
		return COLOR_VERY_LIGHT_GRAY
	var/flag = get_flag()
	switch(flag)
		if("libright")
			return COLOR_VIVID_YELLOW
		if("libleft")
			return COLOR_VIBRANT_LIME
		if("authright")
			return COLOR_DARK_CYAN
		if("authleft")
			return COLOR_MOSTLY_PURE_RED
		if("centerright")
			return COLOR_BLUE
		if("centerleft")
			return COLOR_GREEN
		if("authcenter")
			return COLOR_CYAN
		if("libcenter")
			return COLOR_VIOLET
		if("truecenter")
			return COLOR_VERY_LIGHT_GRAY
		else
			return COLOR_VERY_LIGHT_GRAY

/datum/political_compass/proc/load_path()
	if(!owner?.ckey)
		return
	var/ckey = owner.ckey
	path = "data/player_saves/[ckey[1]]/[ckey]/political.sav"

/datum/political_compass/proc/load_save()
	if(!path)
		return FALSE
	if(!fexists(path))
		return FALSE
	var/savefile/save = new /savefile(path)
	if(!save)
		return FALSE
	save.cd = "/"

	var/needs_update = savefile_needs_update(save)
	if(needs_update == -2) //fatal, can't load any data
		var/bacpath = "[path].updatebac" //todo: if the savefile version is higher then the server, check the backup, and give the player a prompt to load the backup
		if (fexists(bacpath))
			fdel(bacpath) //only keep 1 version of backup
		fcopy(save, bacpath) //byond helpfully lets you use a savefile for the first arg.
		return FALSE
	READ_FILE(save["questions_answered"], questions_answered)
	questions_answered = SANITIZE_LIST(questions_answered)
	if(needs_update >= 0)
		update_savefile(savefile_version, save)

/datum/political_compass/proc/save_save()
	if(!path)
		return FALSE
	var/savefile/save = new /savefile(path)
	if(!save)
		return FALSE
	save.cd = "/"

	WRITE_FILE(save["savefile_version"], POLITICAL_VERSION_MAX)
	WRITE_FILE(save["questions_answered"], questions_answered)

/datum/political_compass/proc/savefile_needs_update(savefile/save)
	var/savefile_version
	READ_FILE(save["savefile_version"], savefile_version)

	if(savefile_version < POLITICAL_VERSION_MIN)
		save.dir.Cut()
		return -2
	if(savefile_version < POLITICAL_VERSION_MAX)
		return savefile_version
	return -1

/datum/political_compass/proc/update_savefile(savefile_version = POLITICAL_VERSION_MAX, savefile/save)
	return

#undef POLITICAL_VERSION_MAX
#undef POLITICAL_VERSION_MIN
