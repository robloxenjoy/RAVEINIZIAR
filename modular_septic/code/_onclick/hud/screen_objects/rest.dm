//resting
/atom/movable/screen/rest
	name = "rest"
	icon = 'modular_septic/icons/hud/quake/screen_quake.dmi'
	icon_state = "act_rest"
	base_icon_state = "act_rest"
	screen_loc = ui_rest

/atom/movable/screen/rest/update_icon_state()
	. = ..()
	var/mob/living/user = hud?.mymob
	if(!istype(user))
		return
	if(user.resting)
		icon_state = "[base_icon_state]_on"
	else
		icon_state = base_icon_state
