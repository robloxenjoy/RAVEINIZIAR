/atom/movable/screen/stats
	name = "stats"
	icon = 'modular_septic/icons/hud/quake/screen_quake_32x64.dmi'
	icon_state = "stats"
	base_icon_state = "stats"
	screen_loc = ui_stats
	screentip_flags = SCREENTIP_HOVERER
	var/static/overlay_x = 0
	var/static/overlay_y = 0
	var/static/list/stat_to_y_offset = list(
		STAT_INTELLIGENCE = 0,
		STAT_ENDURANCE = 10,
		STAT_DEXTERITY = 20,
		STAT_STRENGTH = 30,
	) //This is dumb. Stat's path = stat's offset.
	var/list/stat_to_value = list(
		STAT_INTELLIGENCE = "00",
		STAT_ENDURANCE = "00",
		STAT_DEXTERITY = "00",
		STAT_STRENGTH = "00",
	) //Stat's path to it's value - easier than getting it always
	var/list/raw_stat_to_value = list(
		STAT_INTELLIGENCE = "00",
		STAT_ENDURANCE = "00",
		STAT_DEXTERITY = "00",
		STAT_STRENGTH = "00",
	) //Stat's path to it's value - easier than getting it always
	var/list/list/stat_to_number_overlays = list()
	var/list/image/all_number_overlays = list()

/atom/movable/screen/stats/Click(location, control, params)
	. = ..()
	var/list/modifiers = params2list(params)
	var/icon_y = text2num(LAZYACCESS(modifiers, ICON_Y))
	if(icon_y >= 19)
		if(LAZYACCESS(modifiers, SHIFT_CLICK))
			usr.attributes?.ui_interact(usr)
		else
			usr.attributes?.print_stats(usr)
	else
		usr.choose_effort()

/atom/movable/screen/stats/return_screentip(mob/user, params)
	if(flags_1 & NO_SCREENTIPS_1)
		return ""

	var/list/modifiers = params2list(params)
	var/icon_y = text2num(LAZYACCESS(modifiers, ICON_Y))
	switch(icon_y)
		if(0 to 18)
			return SCREENTIP_OBJ("EFFORT")
		if(19 to 28)
			return SCREENTIP_OBJ("INTELLIGENCE")
		if(29 to 38)
			return SCREENTIP_OBJ("ENDURANCE")
		if(39 to 48)
			return SCREENTIP_OBJ("DEXTERITY")
		if(49 to 59)
			return SCREENTIP_OBJ("STRENGTH")
	return SCREENTIP_OBJ(uppertext(name))

/atom/movable/screen/stats/update_icon_state()
	. = ..()
	if(hud?.mymob && HAS_TRAIT(hud.mymob, TRAIT_EFFORT_ACTIVE))
		icon_state = "[base_icon_state]_active"
	else
		icon_state = base_icon_state

/atom/movable/screen/stats/update_overlays()
	. = ..()
	. |= all_number_overlays

/atom/movable/screen/stats/Initialize(mapload)
	. = ..()
	regen_overlays()
	update_appearance()

/atom/movable/screen/stats/proc/update_stats()
	if(!hud?.mymob?.attributes)
		return FALSE
	for(var/stat_path in stat_to_value)
		stat_to_value[stat_path] = stat_number_to_string(GET_MOB_ATTRIBUTE_VALUE(hud.mymob, stat_path))
		raw_stat_to_value[stat_path] = stat_number_to_string(GET_MOB_ATTRIBUTE_VALUE_RAW(hud.mymob, stat_path))
	regen_overlays()
	update_appearance()

/atom/movable/screen/stats/proc/regen_overlays()
	cut_overlays()
	QDEL_LIST(all_number_overlays)
	all_number_overlays = list()
	for(var/stat_path in stat_to_value)
		var/num_value = text2num(stat_to_value[stat_path])
		var/raw_num_value = text2num(raw_stat_to_value[stat_path])
		var/y_off = stat_to_y_offset[stat_path]
		var/left = copytext(stat_to_value[stat_path], 1, 2)
		var/right = copytext(stat_to_value[stat_path], 2)
		var/image/a = image(icon, src, "a[left]")
		var/image/b = image(icon, src, "b[right]")
		a.pixel_x = b.pixel_x = overlay_x
		a.pixel_y = b.pixel_y = overlay_y + y_off
		if(num_value > raw_num_value)
			// green to blue color matrix
			a.color = list(1,0,0,0, 0,0,1,0, 0,1,0,0, 0,0,0,1, 0,0,0,0)
			b.color = a.color
		else if(num_value < raw_num_value)
			// green to red color matrix
			a.color = list(0,1,0,0, 1,0,0,0, 0,0,1,0, 0,0,0,1, 0,0,0,0)
			b.color = a.color
		stat_to_number_overlays[stat_path] = list(a, b)
		all_number_overlays |= stat_to_number_overlays[stat_path]

	if(length(all_number_overlays))
		return all_number_overlays

/atom/movable/screen/stats/proc/stat_number_to_string(value)
	value = clamp(CEILING(value, 1), 0, 99)
	. = "[value]"
	if(length(.) < 2)
		. = "0[.]"
