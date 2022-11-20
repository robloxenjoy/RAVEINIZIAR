/atom/movable/screen/peeper_tab_switch
	name = "Peeper Tab Switch"
	desc = "Switches to a tab that does something."
	icon = 'modular_septic/icons/hud/quake/peeper.dmi'
	icon_state = "tab"
	plane = PEEPER_PLANE
	layer = PEEPER_LOADOUT_LAYER
	maptext_height = 32
	maptext_width = 40
	maptext_x = -4
	/// Tab we are associated with
	var/datum/peeper_tab/mytab
	/// We do the maptext on a vis_contents object because we don't want the filter to apply to maptext
	var/atom/movable/maptext_holder/peeper_tab_switch/maptext_holder

/atom/movable/screen/peeper_tab_switch/New(datum/peeper_tab/peeper_tab)
	. = ..()
	if(peeper_tab)
		mytab = peeper_tab
		if(peeper_tab.name)
			name = "Switch to [peeper_tab.name] tab"
			maptext_holder = new()
			maptext_holder.maptext_height = maptext_height
			maptext_holder.maptext_width = maptext_width
			maptext_holder.maptext_y = maptext_y
			maptext_holder.maptext_x = maptext_x
			maptext_holder.maptext = MAPTEXT_PEEPER("<span style='text-align: center;'>[peeper_tab.name]</span>")
			vis_contents += maptext_holder
		desc = peeper_tab.desc
		icon = peeper_tab.icon
		icon_state = peeper_tab.icon_state

/atom/movable/screen/peeper_tab_switch/Destroy()
	. = ..()
	if(maptext_holder)
		vis_contents -= maptext_holder
		qdel(maptext_holder)
	maptext_holder = null
	if(mytab?.switch_button == src)
		mytab.switch_button = null
		mytab.mypeeper?.update_tab_switches()
	mytab = null

/atom/movable/screen/peeper_tab_switch/Click(location, control, params)
	. = ..()
	mytab?.mypeeper?.change_tab(mytab)

/atom/movable/screen/peeper_tab_switch/MouseEntered(location, control, params)
	. = ..()
	add_filter("hover_outline", 1, list("type" = "outline", "size" = 0.5, "color" = COLOR_THEME_QUAKE_GREEN))

/atom/movable/screen/peeper_tab_switch/MouseExited(location, control, params)
	. = ..()
	remove_filter("hover_outline")
