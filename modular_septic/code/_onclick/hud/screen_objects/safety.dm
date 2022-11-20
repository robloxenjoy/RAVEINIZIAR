/atom/movable/screen/safety
	name = "safety"
	icon = 'modular_septic/icons/hud/quake/screen_quake.dmi'
	icon_state = "safety"
	base_icon_state = "safety"
	screen_loc = ui_safety

/atom/movable/screen/safety/Click(location, control, params)
	. = ..()
	var/obj/item/gun/held_item = usr.get_active_held_item()
	if(istype(held_item))
		held_item.toggle_safety(usr)
	else if(held_item)
		to_chat(usr, span_warning("I am not holding a gun."))
	else
		to_chat(usr, span_warning("I am unarmed."))

/atom/movable/screen/safety/Initialize(mapload)
	. = ..()
	update_appearance()

/atom/movable/screen/safety/update_icon_state()
	. = ..()
	if(hud?.mymob)
		var/obj/item/gun/held_item = hud.mymob.get_active_held_item()
		if(istype(held_item))
			if(CHECK_MULTIPLE_BITFIELDS(held_item.safety_flags, GUN_SAFETY_HAS_SAFETY|GUN_SAFETY_ENABLED))
				icon_state = "[base_icon_state]_on"
			else
				icon_state = "[base_icon_state]_off"
		else
			icon_state = "[base_icon_state]_on"
	else
		icon_state = "[base_icon_state]_on"
