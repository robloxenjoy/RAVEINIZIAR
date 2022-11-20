/atom/movable/screen/lookdown
	name = "look down"
	icon = 'modular_septic/icons/hud/quake/screen_quake.dmi'
	icon_state = "act_lookdown"
	screen_loc = ui_lookdown

/atom/movable/screen/lookdown/Click(location, control, params)
	. = ..()
	if(isliving(usr))
		var/mob/living/user = usr
		user.look_down()
