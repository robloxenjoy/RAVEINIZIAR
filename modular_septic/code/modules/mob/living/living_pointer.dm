/mob/living/update_mouse_pointer()
	if(!client)
		return
	client.mouse_pointer_icon = initial(client.mouse_pointer_icon)
	if(cursor_icon)
		client.mouse_pointer_icon = cursor_icon
	if(examine_cursor_icon && client.keys_held["Shift"])
		client.mouse_pointer_icon = examine_cursor_icon
		if(combat_mode && examine_cursor_icon_combat)
			client.mouse_pointer_icon = examine_cursor_icon_combat
	else if(combat_mode && combat_cursor_icon)
		client.mouse_pointer_icon = combat_cursor_icon
	if(istype(loc, /obj/vehicle/sealed))
		var/obj/vehicle/sealed/sealed_loc = loc
		if(sealed_loc.mouse_pointer)
			client.mouse_pointer_icon = sealed_loc.mouse_pointer
	else
		var/obj/item/gun/held_gun = get_active_held_item()
		if(istype(held_gun) && held_gun.mouse_pointer_icon && !(held_gun.safety_flags & GUN_SAFETY_ENABLED))
			client.mouse_pointer_icon = held_gun.mouse_pointer_icon
	if(ranged_ability?.ranged_mousepointer)
		client.mouse_pointer_icon = ranged_ability.ranged_mousepointer
	if(client.mouse_override_icon)
		client.mouse_pointer_icon = client.mouse_override_icon
