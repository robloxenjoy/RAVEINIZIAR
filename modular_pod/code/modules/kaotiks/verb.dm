//simple verb to open the fucking menu
/client/verb/bobuxmenu()
	set category = "OOC"
	set name = "Kaotik System"
	set desc = "Buy kaotik thinqs."

	if(!SSbobux || !length(SSbobux.all_bobux_rewards))
		to_chat(usr, "<span class='warning'>The kaotik subsystem hasn't initialized yet! Please wait a bit.</span>")
		return

	SSbobux.ShowChoices(usr)
