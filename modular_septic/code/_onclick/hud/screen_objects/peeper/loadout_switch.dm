/atom/movable/screen/peeper_loadout
	name = "peeper loadout"
	icon = 'modular_septic/icons/hud/quake/peeper.dmi'
	icon_state = "close"
	plane = PEEPER_PLANE
	layer = PEEPER_LOADOUT_LAYER
	/// Does this move the loadout index up or down?
	var/loadout_up = FALSE

/atom/movable/screen/peeper_loadout/Click(location, control, params)
	. = ..()
	if(!hud?.peeper)
		return
	if(loadout_up)
		hud.peeper.loadout_up()
	else
		hud.peeper.loadout_down()

/atom/movable/screen/peeper_loadout/up
	name = "peeper loadout up"
	icon_state = "loadout_up"
	loadout_up = TRUE
	screen_loc = ui_peeper_loadout_up

/atom/movable/screen/peeper_loadout/down
	name = "peeper loadout down"
	icon_state = "loadout_down"
	loadout_up = FALSE
	screen_loc = ui_peeper_loadout_down
