//simple verb to open the fucking menu
/client/verb/bobuxmenu()
	set category = "OOC"
	set name = "Система Ультр"
	set desc = "Покупка штучек."

	if(!SSbobux || !length(SSbobux.all_bobux_rewards))
		to_chat(usr, "<span class='warning'>Система ультр не прогрузилась. Ждём.</span>")
		return

	SSbobux.ShowChoices(usr)
