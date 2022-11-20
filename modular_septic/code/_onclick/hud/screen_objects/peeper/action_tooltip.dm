/atom/movable/screen/action_tooltip
	name = "action tooltip"
	icon = 'modular_septic/icons/hud/quake/peeper.dmi'
	icon_state = "blank"
	maptext = "N/A"
	maptext_height = 32
	maptext_width = 158
	maptext_x = 2
	plane = PEEPER_PLANE
	layer = PEEPER_ACTION_TOOLTIP_LAYER
	screen_loc = ui_peeper_action_tooltip

/atom/movable/screen/action_tooltip/Initialize(mapload)
	. = ..()
	update_maptext(maptext)

/atom/movable/screen/action_tooltip/proc/update_maptext(new_text = "N/A")
	if(!new_text)
		maptext = null
		return
	maptext = MAPTEXT_PEEPER_CYAN("<span style='vertical-align: middle;'>[new_text]</span>")
