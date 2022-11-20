//pain guy
/atom/movable/screen/human/pain
	name = "pain"
	icon = 'modular_septic/icons/hud/quake/screen_quake.dmi'
	icon_state = "pain0"
	base_icon_state = "pain"
	screen_loc = ui_pain

/atom/movable/screen/human/pain/Click(location, control, params)
	. = ..()
	var/list/modifiers = params2list(params)
	var/shift_click = LAZYACCESS(modifiers, SHIFT_CLICK)
	var/mob/living/carbon/carbon_user = usr
	if(istype(carbon_user))
		carbon_user.print_pain(shift_click)
