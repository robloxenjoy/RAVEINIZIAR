/atom/movable/screen/pressure
	name = "pressure"
	icon = 'modular_septic/icons/hud/quake/screen_quake.dmi'
	icon_state = "pressure2"
	base_icon_state = "pressure"
	screen_loc = ui_pressure
	var/pressure_index = 2

/atom/movable/screen/pressure/update_icon_state()
	. = ..()
	icon_state = "[base_icon_state][pressure_index]"

/atom/movable/screen/pressure/Click(location, control, params)
	. = ..()
	switch(pressure_index)
		if(4)
			to_chat(usr, div_infobox(span_userdanger("The air pressure here feels crushing!")))
		if(3)
			to_chat(usr, div_infobox(span_warning("The air pressure here feels dangerously high.")))
		if(2)
			to_chat(usr, div_infobox(span_notice("The air pressure here feels comfortable.")))
		if(1)
			to_chat(usr, div_infobox(span_warning("The air pressure here feels dangerously low.")))
		if(0)
			to_chat(usr, div_infobox(span_userdanger("There's barely any air here!")))

/atom/movable/screen/pressure/proc/update_pressure(new_pressure = 2)
	if(icon_state == "[base_icon_state][new_pressure]")
		return
	pressure_index = new_pressure
	update_appearance()
