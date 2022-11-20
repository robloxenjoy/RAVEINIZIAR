/atom/movable/screen/fixeye
	name = "fix eye"
	icon = 'modular_septic/icons/hud/quake/screen_quake.dmi'
	icon_state = "fixeye"
	base_icon_state = "fixeye"
	screen_loc = ui_fixeye
	var/fixed_eye = FALSE

/atom/movable/screen/fixeye/Click(location, control, params)
	. = ..()
	if(hud && usr == hud.mymob)
		SEND_SIGNAL(hud.mymob, COMSIG_FIXEYE_TOGGLE)

/atom/movable/screen/fixeye/update_name(updates)
	. = ..()
	if(fixed_eye)
		name = "unfix eye"
	else
		name = "fix eye"

/atom/movable/screen/fixeye/update_icon_state()
	. = ..()
	if(fixed_eye)
		icon_state = "[base_icon_state]_on"
	else
		icon_state = base_icon_state
