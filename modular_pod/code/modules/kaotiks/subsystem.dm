//subsystem to handle topic shit as well as other miscellaneous stuff
SUBSYSTEM_DEF(bobux)
	name = "Kaotiks"
	init_order = INIT_ORDER_DEFAULT
	flags = SS_NO_FIRE
	var/list/datum/bobux_reward/all_bobux_rewards = list()
	var/list/datum/bobux_reward/bobux_rewards_buyable = list()
	var/working = TRUE

/datum/controller/subsystem/bobux/Initialize(start_timeofday)
	. = ..()
	for(var/fuck in subtypesof(/datum/bobux_reward))
		var/datum/bobux_reward/fucker = new fuck()
		all_bobux_rewards |= fucker
		if(!initial(fucker.unbuyable))
			bobux_rewards_buyable |= fucker

/datum/controller/subsystem/bobux/proc/adjust_bobux(client/noob, amount, message)
	//makes life easier
	if(ismob(noob))
		var/mob/M = noob
		noob = M.client
	if(!noob || !noob.prefs)
		return
	return noob.prefs.adjust_bobux(amount, message)

/datum/controller/subsystem/bobux/proc/ShowChoices(client/noob)
	//fuck
	if(ismob(noob))
		var/mob/M = noob
		noob = M.client
	if(!noob || !noob.prefs)
		return FALSE
	var/list/dat = GetDat(noob)
	winshow(noob, "kaotik_window", TRUE)
	var/datum/browser/popup = new(noob, "kaotik_window", "<div align='center'>Kaotiks</div>", 400, 800)
	popup.set_content(dat.Join())
	popup.open(FALSE)
	onclose(noob.mob, "kaotik_window", src)

/datum/controller/subsystem/bobux/proc/GetDat(client/noob)
	var/list/dat = list()
	var/datum/preferences/pref_source = noob.prefs
	if(SSmapping.config?.war_gamemode)
		dat += "<center><b>War Phase: [GLOB.phase_of_war]</b></center><br>"
	dat += "<center><b>[GLOB.world_deaths_crazy] deaths in the world!</b></center><br>"
	dat += "<center><b>Kaotiks Menu</b></center><br>"
	var/crazynuma
	switch(pref_source.rank_crazy)
		if(1)
			crazynuma = "-"
		if(2)
			crazynuma = "*"
		if(3)
			crazynuma = "+"
		if(4)
			crazynuma = "++"
		if(5)
			crazynuma = "+++"
	dat += "<center>My rank: <b>[crazynuma]</b></center><br>"
	dat += "<center>My kaotiks: <b>[pref_source.bobux_amount]</b></center><br>"
	dat += "<center><a href='?src=\ref[src];task=close'>Awesome</a></center>"
	dat += "<hr>"
	for(var/aaa in bobux_rewards_buyable)
		var/datum/bobux_reward/comicao = aaa
		dat += "<span class='bobux'><b>[comicao.name]</b></span><br>"
		dat += "[comicao.desc]</span><br>"
		dat += "<a href='?src=\ref[src];task=buy;id=[comicao.id]'>Buy</a> ([comicao.cost] kaotiks)"
		dat += "<hr>"
	return dat

/datum/controller/subsystem/bobux/Topic(href, href_list)
	. = ..()
	switch(href_list["task"])
		if("close")
			usr << browse(null, "window=kaotik_window")
		if("buy")
			if(SSmapping.config?.prison_gamemode)
				return
			var/id = href_list["id"]
			var/datum/bobux_reward/noob
			for(var/fuck in bobux_rewards_buyable)
				var/datum/bobux_reward/ronaldo = fuck
				if(ronaldo.id == id)
					noob = ronaldo
					break
			if(noob)
				noob.buy(usr)
