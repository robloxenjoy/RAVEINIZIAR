//Item/mob information
/atom/movable/screen/info
	name = "examine"
	icon = 'modular_septic/icons/hud/quake/screen_quake_64x32.dmi'
	icon_state = "act_info"

/atom/movable/screen/info/Click(location, control, params)
	. = ..()
	if(ismob(usr))
		var/obj/item/thing = usr.get_active_held_item()
		if(thing)
			usr.examinate(thing)
		else
			usr.examinate(usr)
