/atom/movable/screen/pull
	icon = 'modular_septic/icons/hud/quake/screen_quake.dmi'
	icon_state = "act_pull"
	base_icon_state = "act_pull"
	screen_loc = ui_pull

/atom/movable/screen/pull/update_name(updates)
	. = ..()
	if(hud?.mymob?.pulling)
		name = "stop pulling"
	else
		name = "pull"

/atom/movable/screen/pull/update_icon_state()
	. = ..()
	if(hud?.mymob?.pulling)
		icon_state = "[base_icon_state]_on"
	else
		icon_state = base_icon_state
