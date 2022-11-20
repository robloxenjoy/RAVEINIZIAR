/atom/movable/screen/teach
	name = "teach"
	icon = 'modular_septic/icons/hud/quake/screen_quake.dmi'
	icon_state = "act_teach"
	base_icon_state = "act_teach"
	screen_loc = ui_teach
/*
/atom/movable/screen/teach/Click(location, control, params)
	. = ..()
	SEND_SIGNAL(usr, COMSIG_ELEMENT_TRY_TEACHING)

/atom/movable/screen/teach/update_icon_state()
	. = ..()
	if(hud?.mymob && (SEND_SIGNAL(hud.mymob, COMSIG_ELEMENT_CHECK_TEACHING) || SEND_SIGNAL(hud.mymob, COMSIG_ELEMENT_CHECK_TAUGHT)))
		icon_state = "[base_icon_state]_on"
	else
		icon_state = base_icon_state
*/
