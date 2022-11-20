/atom/movable/screen/bodytemperature
	name = "body temperature"
	icon = 'modular_septic/icons/hud/quake/screen_quake.dmi'
	icon_state = "bodytemp2"
	base_icon_state = "bodytemp"
	screen_loc = ui_bodytemperature
	var/temperature_index = 3

/atom/movable/screen/bodytemperature/update_icon_state()
	. = ..()
	icon_state = "[base_icon_state][clamp(CEILING(temperature_index/2, 1), 1, 3)]"

/atom/movable/screen/bodytemperature/Click(location, control, params)
	. = ..()
	switch(temperature_index)
		if(6)
			to_chat(usr, div_infobox(span_userdanger("I'm cooking alive!")))
		if(5)
			to_chat(usr, div_infobox(span_danger("I'm overheating!")))
		if(4)
			to_chat(usr, div_infobox(span_warning("I'm uncomfortably hot.")))
		if(3)
			to_chat(usr, div_infobox(span_notice("I'm at a comfortable temperature.")))
		if(2)
			to_chat(usr, div_infobox(span_warning("I'm uncomfortably cold.")))
		if(1)
			to_chat(usr, div_infobox(span_danger("I'm hypothermic!")))
		if(0)
			to_chat(usr, div_infobox(span_userdanger("I'm freezing!")))

/atom/movable/screen/bodytemperature/proc/update_temperature(new_temp = 3)
	if(temperature_index == new_temp)
		return
	temperature_index = new_temp
	update_appearance()
