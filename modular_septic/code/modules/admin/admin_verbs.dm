/client/proc/toggle_rightclickmenu()
	set name = "Toggle Right Click Menu"
	set category = "Admin.Game"
	set desc = "Allows you to right click."
	if(!holder)
		return

	if(!check_rights_for(src, R_VAREDIT))
		to_chat(src, span_warning("Only niggas with var edit perms can use the right clicking menu."))
		return FALSE

	show_popup_menus = !show_popup_menus
	to_chat(src, span_warning("Right click context menu has been toggled [show_popup_menus ? "on" : "off"]."))

/client/proc/toggle_liquid_debug()
	set category = "Debug"
	set name = "Liquid Groups Color Debug"
	set desc = "Liquid Groups Color Debug."
	if(!holder)
		return
	GLOB.liquid_debug_colors = !GLOB.liquid_debug_colors

/client/proc/spawn_pollution()
	set category = "Admin.Fun"
	set name = "Spawn Pollution"
	set desc = "Spawns an amount of chosen pollutant at your current location."

	var/list/singleton_list = SSpollution.pollutant_singletons
	var/choice = tgui_input_list(usr, "What type of pollutant would you like to spawn?", "Spawn Pollution", singleton_list)
	if(!choice)
		return
	var/amount_choice = input("Amount of pollution:") as null|num
	if(!amount_choice)
		return
	var/turf/epicenter = get_turf(mob)
	epicenter.pollute_turf(choice, amount_choice)
	message_admins("[ADMIN_LOOKUPFLW(usr)] spawned pollution at [epicenter.loc] ([choice] - [amount_choice]).")
	log_admin("[key_name(usr)] spawned pollution at [epicenter.loc] ([choice] - [amount_choice]).")
