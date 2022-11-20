/atom/movable/screen/surrender
	name = "surrender"
	icon = 'modular_septic/icons/hud/quake/screen_quake.dmi'
	icon_state = "act_surrender"
	screen_loc = ui_surrender

/atom/movable/screen/surrender/Click(location, control, params)
	. = ..()
	if(isliving(usr))
		var/mob/living/user = usr
		user.emote("surrender")
