//bobux...
/datum/admins/proc/show_bobux_panel(mob/M in GLOB.mob_list)
	set category = "Admin"
	set desc = "Edit mobs's kaotik info"
	set name = "Show kaotiks panel"

	if(!istype(M))
		to_chat(usr, "This can only be used on instances of type /mob")
		return

	if(!M.mind)
		to_chat(usr, "This mob has no mind!")
		return

	M.mind.bobux_panel()
	SSblackbox.record_feedback("tally", "admin_verb", 1, "Traitor Panel") //If you are copy-pasting this, ensure the 2nd parameter is unique to the new proc!

/datum/admins/proc/destroykaotiks(mob/M in GLOB.mob_list)
	set category = "Admin"
	set desc = "Destroy them"
	set name = "Разрушить каотики"

//	message_admins("[noob] has destroyed the kaotik system!")
//	log_admin("[noob] has destroyed the kaotik system!")
	var/list/bogged = flist("data/player_saves/")
	for(var/fuck in bogged)
		if(copytext(fuck, -1) != "/")
			continue
		var/list/bogged_again = flist("data/player_saves/[fuck]")
		for(var/fucked in bogged_again)
			if(copytext(fucked, -1) != "/")
				continue
			var/savefile/S = new /savefile("data/player_saves/[fuck][fucked]preferences.sav")
			if(!S)
				continue
			S.cd = "/"
			WRITE_FILE(S["bobux_amount"], 0)
	for(var/client/C in GLOB.clients)
		C.prefs?.adjust_bobux(-C.prefs.bobux_amount)
	for(var/datum/preferences/prefs in world)
		prefs.load_preferences()

//	SSblackbox.record_feedback("tally", "admin_verb", 1, "Traitor Panel")

/datum/mind/proc/bobux_panel()
	if(!length(SSbobux.all_bobux_rewards))
		alert("Not before round-start!", "0 Kaotiks")
		return
	if(QDELETED(src))
		alert("Can't!", "0 Kaotiks")
		return
	if(!SSbobux.working)
		return
	var/datum/preferences/prefs = current?.client?.prefs
	if(!prefs)
		alert("Can't with [key]!", "0 Kaotiks")
		return

	var/list/bobux_rewards = bobux_bought.Copy()
	for(var/chungus in bobux_rewards)
		bobux_rewards -= chungus
		var/datum/bobux_reward/chungoose = chungus
		bobux_rewards |= initial(chungoose.name)
	var/list/out = list(
		"<B><span class='bobux'>[key]</span></B><br>\
		<B>Bobux amount:</B> [prefs.bobux_amount ? prefs.bobux_amount : "No Kaotiks"]<br>\
		<a href='?src=[REF(src)];bobux=set'>Set</a> \
		<a href='?src=[REF(src)];bobux=add'>Add</a> \
		<a href='?src=[REF(src)];bobux=remove'>Remove</a><br>\
		<B>Bobux rewards bought:</B> [english_list(bobux_rewards, "Nothing", ", ")].</B>"
		)
	var/datum/browser/panel = new(usr, "bobuxpanel", "", 300, 400)
	panel.set_content(out.Join())
	panel.open()
	return

//bobux...
/datum/admins/proc/show_rank_panel(mob/M in GLOB.mob_list)
	set category = "Admin"
	set desc = "Edit mobs's rankinfo"
	set name = "Show rank panel"

	if(!istype(M))
		to_chat(usr, "This can only be used on instances of type /mob")
		return

	if(!M.mind)
		to_chat(usr, "This mob has no mind!")
		return

	M.mind.rank_panel()
	SSblackbox.record_feedback("tally", "admin_verb", 1, "Traitor Panel") //If you are copy-pasting this, ensure the 2nd parameter is unique to the new pr

/datum/mind/proc/rank_panel()
	if(QDELETED(src))
		alert("Can't!", "CRAZY RANK")
		return
	if(!SSbobux.working)
		return
	var/datum/preferences/prefs = current?.client?.prefs
	if(!prefs)
		alert("Can't with [key]!", "CRAZY RANK")
		return

	var/list/out = list(
		"<B><span class='bobux'>[key]</span></B><br>\
		<B>Rank:</B> [prefs.rank_crazy ? prefs.rank_crazy : "No rank"]<br>\
		<a href='?src=[REF(src)];bobux=set'>Set</a> \
		<a href='?src=[REF(src)];bobux=add'>Add</a> \
		<a href='?src=[REF(src)];bobux=remove'>Remove</a><br>\
		<B>Retarded chungus:</B> Chungus.</B>"
		)
	var/datum/browser/panel = new(usr, "rankcrazy", "", 300, 400)
	panel.set_content(out.Join())
	panel.open()
	return
