/atom/movable/screen/healths
	icon = 'modular_septic/icons/hud/quake/screen_quake.dmi'
	screen_loc = ui_pulse

/atom/movable/screen/healths/Click(location, control, params)
	. = ..()
	if(iscarbon(usr))
		var/mob/living/carbon/carbon_user = usr
		carbon_user.check_pulse(carbon_user)
