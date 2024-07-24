//simple verb to open the fucking menu
/client/verb/bobuxmenu()
	set category = "OOC"
	set name = "Kaotik System"
	set desc = "Покупка штучек."

	if(!SSbobux || !length(SSbobux.all_bobux_rewards))
		to_chat(usr, "<span class='warning'>Kaotik System is not loaded. Wait.</span>")
		return

	SSbobux.ShowChoices(usr)
