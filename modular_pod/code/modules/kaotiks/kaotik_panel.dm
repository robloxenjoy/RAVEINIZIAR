//bobux...
/datum/admins/proc/show_bobux_panel(mob/M in GLOB.mob_list)
	set category = "Admin"
	set desc = "Edit mobs's kaotik info"
	set name = "Show Kaotik Panel"

	if(!istype(M))
		to_chat(usr, "This can only be used on instances of type /mob")
		return

	if(!M.mind)
		to_chat(usr, "This mob has no mind!")
		return

	M.mind.bobux_panel()
	SSblackbox.record_feedback("tally", "admin_verb", 1, "Traitor Panel") //If you are copy-pasting this, ensure the 2nd parameter is unique to the new proc!

/datum/mind/proc/bobux_panel()
	if(!length(SSbobux.all_bobux_rewards))
		alert("Not before round-start!", "0 Bobux")
		return
	if(QDELETED(src))
		alert("This mind doesn't have a mob, or is deleted! For some reason!", "0 Kaotik")
		return
	var/datum/preferences/prefs = current?.client?.prefs
	if(!prefs)
		alert("Unable to find preferences for [key]!", "0 Kaotik")
		return
	
	var/list/bobux_rewards = bobux_bought.Copy()
	for(var/chungus in bobux_rewards)
		bobux_rewards -= chungus
		var/datum/bobux_reward/chungoose = chungus
		bobux_rewards |= initial(chungoose.name)
	var/list/out = list(
		"<B><span class='bobux'>[key]</span></B><br>\
		<B>Bobux amount:</B> [prefs.bobux_amount ? prefs.bobux_amount : "No Kaotik"]<br>\
		<a href='?src=[REF(src)];bobux=set'>Set</a> \
		<a href='?src=[REF(src)];bobux=add'>Add</a> \
		<a href='?src=[REF(src)];bobux=remove'>Remove</a><br>\
		<B>Bobux rewards bought:</B> [english_list(bobux_rewards, "Nothing", ", ")].</B>"
		)
	var/datum/browser/panel = new(usr, "bobuxpanel", "", 300, 400)
	panel.set_content(out.Join())
	panel.open()
	return
