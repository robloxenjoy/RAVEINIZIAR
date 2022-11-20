/atom/movable/screen/tab_loadout
	name = "tab loadout"
	icon = 'modular_septic/icons/hud/quake/peeper.dmi'
	icon_state = "close"
	plane = PEEPER_PLANE
	layer = PEEPER_TAB_LOADOUT_LAYER
	/// Tab we are associated with
	var/datum/peeper_tab/mytab
	/// Does this move the loadout index up or down?
	var/loadout_up = FALSE

/atom/movable/screen/tab_loadout/Click(location, control, params)
	. = ..()
	if(!mytab)
		return
	if(loadout_up)
		mytab.loadout_up()
	else
		mytab.loadout_down()

/atom/movable/screen/tab_loadout/up
	name = "peeper loadout up"
	icon_state = "tab_up"
	loadout_up = TRUE

/atom/movable/screen/tab_loadout/down
	name = "peeper loadout down"
	icon_state = "tab_down"
	loadout_up = FALSE

/atom/movable/screen/tab_loadout/up/emotes
	screen_loc = ui_peeper_emote_loadout_up

/atom/movable/screen/tab_loadout/down/emotes
	screen_loc = ui_peeper_emote_loadout_down

/atom/movable/screen/tab_loadout/up/actions
	screen_loc = ui_peeper_action_loadout_up

/atom/movable/screen/tab_loadout/down/actions
	screen_loc = ui_peeper_action_loadout_down
