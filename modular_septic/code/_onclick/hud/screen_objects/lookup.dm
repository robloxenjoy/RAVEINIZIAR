/atom/movable/screen/lookup
	name = "look up"
	icon = 'modular_septic/icons/hud/quake/screen_quake.dmi'
	icon_state = "act_lookup"
	screen_loc = ui_lookup

/atom/movable/screen/lookup/Click(location, control, params)
	. = ..()
	if(isliving(usr))
		var/mob/living/user = usr
		user.look_up()
