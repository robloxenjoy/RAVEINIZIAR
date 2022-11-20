/atom/movable/screen/give
	name = "give"
	icon = 'modular_septic/icons/hud/quake/screen_quake.dmi'
	icon_state = "act_give"
	screen_loc = ui_give

/atom/movable/screen/give/Click(location, control, params)
	. = ..()
	if(iscarbon(usr))
		var/mob/living/carbon/user = usr
		user.give()
