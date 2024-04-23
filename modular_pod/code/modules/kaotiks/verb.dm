//simple verb to open the fucking menu
/client/verb/bobuxmenu()
	set category = "OOC"
	set name = "Каотичная Система"
	set desc = "Покупка штучек."

	if(!SSbobux || !length(SSbobux.all_bobux_rewards))
		to_chat(usr, "<span class='warning'>Каотичная Система не прогрузилась. Ждём.</span>")
		return

	SSbobux.ShowChoices(usr)
