/// Update the mouse pointer of the attached client in this mob
/mob/update_mouse_pointer()
	if(!client)
		return
	client.mouse_pointer_icon = initial(client.mouse_pointer_icon)
	if(cursor_icon)
		client.mouse_pointer_icon = cursor_icon
	if(examine_cursor_icon && client.keys_held["Shift"])
		//mouse shit is hardcoded, make this non hard-coded once we make mouse modifiers bindable
		client.mouse_pointer_icon = examine_cursor_icon
	if(istype(loc, /obj/vehicle/sealed))
		var/obj/vehicle/sealed/E = loc
		if(E.mouse_pointer)
			client.mouse_pointer_icon = E.mouse_pointer
	if(client.mouse_override_icon)
		client.mouse_pointer_icon = client.mouse_override_icon
