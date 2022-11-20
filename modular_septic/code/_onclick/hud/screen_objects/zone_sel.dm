/atom/movable/screen/zone_sel
	screentip_flags = SCREENTIP_HOVERER_CLICKER

/atom/movable/screen/zone_sel/Initialize(mapload)
	. = ..()
	LAZYINITLIST(hover_overlays_cache[overlay_icon])

/atom/movable/screen/zone_sel/MouseMove(location, control, params)
	. = ..()
	if(isobserver(usr))
		return

	var/list/modifiers = params2list(params)
	var/icon_x = text2num(LAZYACCESS(modifiers, ICON_X))
	var/icon_y = text2num(LAZYACCESS(modifiers, ICON_Y))
	var/choice = get_zone_at(icon_x, icon_y)
	if(!choice)
		vis_contents -= hover_overlays_cache[overlay_icon][hovering]
		hovering = null
		return
	if(choice == hovering)
		return
	vis_contents -= hover_overlays_cache[overlay_icon][hovering]
	hovering = choice

	var/obj/effect/overlay/zone_sel/overlay_object = hover_overlays_cache[overlay_icon][choice]
	if(!overlay_object)
		overlay_object = new
		overlay_object.icon = overlay_icon
		overlay_object.icon_state = "[choice]"
		hover_overlays_cache[overlay_icon][choice] = overlay_object
	vis_contents += overlay_object

/atom/movable/screen/zone_sel/MouseExited(location, control, params)
	. = ..()
	if(!isobserver(usr) && hovering)
		vis_contents -= hover_overlays_cache[overlay_icon][hovering]
		hovering = null

/atom/movable/screen/zone_sel/return_screentip(mob/user, params)
	if(flags_1 & NO_SCREENTIPS_1)
		return ""

	var/list/modifiers = params2list(params)
	var/icon_x = text2num(LAZYACCESS(modifiers, ICON_X))
	var/icon_y = text2num(LAZYACCESS(modifiers, ICON_Y))
	var/parsed_zone = get_zone_at(icon_x, icon_y)
	if(!parsed_zone)
		return SCREENTIP_OBJ(uppertext(name))
	parsed_zone = parse_zone(parsed_zone)
	return SCREENTIP_OBJ(uppertext(parsed_zone))

/atom/movable/screen/zone_sel/big
	name = "zone doll"
	icon = 'modular_septic/icons/hud/quake/screen_quake_32x64.dmi'
	overlay_icon = 'modular_septic/icons/hud/quake/screen_quake_32x64.dmi'

/atom/movable/screen/zone_sel/big/set_selected_zone(choice, mob/user)
	if(user != hud?.mymob)
		return

	if(choice != hud.mymob.zone_selected)
		hud.mymob.zone_selected = choice
		hud.enhanced_sel?.vis_contents.Cut()
		hud.enhanced_sel?.update_appearance()
		update_appearance()

	if(isliving(hud.mymob))
		var/mob/living/living_mob = hud.mymob
		//Update the hand shit
		living_mob.hand_index_to_zone[living_mob.active_hand_index] = living_mob.zone_selected

	return TRUE

/atom/movable/screen/zone_sel/big/get_zone_at(icon_x, icon_y)
	switch(icon_y)
		if(5) //Feet
			switch(icon_x)
				if(7 to 13)
					return BODY_ZONE_PRECISE_R_FOOT
				if(19 to 25)
					return BODY_ZONE_PRECISE_L_FOOT
		if(6) //Feet
			switch(icon_x)
				if(7 to 14)
					return BODY_ZONE_PRECISE_R_FOOT
				if(18 to 25)
					return BODY_ZONE_PRECISE_L_FOOT
		if(7) //Feet
			switch(icon_x)
				if(8 to 14)
					return BODY_ZONE_PRECISE_R_FOOT
				if(18 to 24)
					return BODY_ZONE_PRECISE_L_FOOT
		if(9, 10) //Feet
			switch(icon_x)
				if(10 to 14)
					return BODY_ZONE_PRECISE_R_FOOT
				if(18 to 22)
					return BODY_ZONE_PRECISE_L_FOOT
		if(11 to 20) //Legs
			switch(icon_x)
				if(10 to 14)
					return BODY_ZONE_R_LEG
				if(18 to 22)
					return BODY_ZONE_L_LEG
		if(21 to 24) //Legs
			switch(icon_x)
				if(11 to 15)
					return BODY_ZONE_R_LEG
				if(19 to 23)
					return BODY_ZONE_L_LEG
		if(25) //Legs and groin
			switch(icon_x)
				if(10 to 13)
					return BODY_ZONE_R_LEG
				if(14 to 18)
					return BODY_ZONE_PRECISE_GROIN
				if(19 to 22)
					return BODY_ZONE_L_LEG
		if(26) //Legs and groin
			switch(icon_x)
				if(10 to 12)
					return BODY_ZONE_R_LEG
				if(13 to 19)
					return BODY_ZONE_PRECISE_GROIN
				if(20 to 22)
					return BODY_ZONE_L_LEG
		if(27) //Groin
			switch(icon_x)
				if(10 to 22)
					return BODY_ZONE_PRECISE_GROIN
		if(28) //Groin, hands
			switch(icon_x)
				if(7, 8)
					return BODY_ZONE_PRECISE_R_HAND
				if(10 to 22)
					return BODY_ZONE_PRECISE_GROIN
				if(24, 25)
					return BODY_ZONE_PRECISE_L_HAND
		if(29) //Groin, hands
			switch(icon_x)
				if(6 to 9)
					return BODY_ZONE_PRECISE_R_HAND
				if(10 to 22)
					return BODY_ZONE_PRECISE_GROIN
				if(23 to 26)
					return BODY_ZONE_PRECISE_L_HAND
		if(30) //Groin, vitals, hands
			switch(icon_x)
				if(6 to 9)
					return BODY_ZONE_PRECISE_R_HAND
				if(11, 12)
					return BODY_ZONE_PRECISE_GROIN
				if(13 to 19)
					return BODY_ZONE_PRECISE_VITALS
				if(20, 21)
					return BODY_ZONE_PRECISE_GROIN
				if(23 to 26)
					return BODY_ZONE_PRECISE_L_HAND
		if(31) //Vitals, hands
			switch(icon_x)
				if(6 to 9)
					return BODY_ZONE_PRECISE_R_HAND
				if(11 to 21)
					return BODY_ZONE_PRECISE_VITALS
				if(23 to 26)
					return BODY_ZONE_PRECISE_L_HAND
		if(32, 33) //Vitals, hands
			switch(icon_x)
				if(6 to 8)
					return BODY_ZONE_PRECISE_R_HAND
				if(11 to 21)
					return BODY_ZONE_PRECISE_VITALS
				if(24 to 26)
					return BODY_ZONE_PRECISE_L_HAND
		if(34) //Chest, vitals, arms
			switch(icon_x)
				if(6 to 8)
					return BODY_ZONE_R_ARM
				if(11, 12)
					return BODY_ZONE_PRECISE_VITALS
				if(13 to 19)
					return BODY_ZONE_CHEST
				if(20, 21)
					return BODY_ZONE_PRECISE_VITALS
				if(24 to 26)
					return BODY_ZONE_L_ARM
		if(34 to 38) //Chest, arms
			switch(icon_x)
				if(6 to 9)
					return BODY_ZONE_R_ARM
				if(12 to 22)
					return BODY_ZONE_CHEST
				if(23 to 26)
					return BODY_ZONE_L_ARM
		if(39 to 41) //Chest, arms
			switch(icon_x)
				if(6 to 10)
					return BODY_ZONE_R_ARM
				if(11 to 21)
					return BODY_ZONE_CHEST
				if(22 to 26)
					return BODY_ZONE_L_ARM
		if(42) //Chest, arms
			switch(icon_x)
				if(7 to 10)
					return BODY_ZONE_R_ARM
				if(11 to 21)
					return BODY_ZONE_CHEST
				if(22 to 25)
					return BODY_ZONE_L_ARM
		if(43,44) //Chest, arms
			switch(icon_x)
				if(7 to 11)
					return BODY_ZONE_R_ARM
				if(12 to 20)
					return BODY_ZONE_CHEST
				if(21 to 25)
					return BODY_ZONE_L_ARM
		if(45) //Chest, arms, neck
			switch(icon_x)
				if(8 to 12)
					return BODY_ZONE_R_ARM
				if(13, 14)
					return BODY_ZONE_CHEST
				if(15 to 17)
					return BODY_ZONE_PRECISE_NECK
				if(18, 19)
					return BODY_ZONE_CHEST
				if(20 to 24)
					return BODY_ZONE_L_ARM
		if(46) //Arms, neck
			switch(icon_x)
				if(9 to 12)
					return BODY_ZONE_R_ARM
				if(13 to 19)
					return BODY_ZONE_PRECISE_NECK
				if(20 to 23)
					return BODY_ZONE_L_ARM
		if(47) //Arms, neck
			switch(icon_x)
				if(10, 11)
					return BODY_ZONE_R_ARM
				if(12 to 20)
					return BODY_ZONE_PRECISE_NECK
				if(21, 22)
					return BODY_ZONE_L_ARM
		if(48) //Neck
			switch(icon_x)
				if(11 to 21)
					return BODY_ZONE_PRECISE_NECK
		if(49) //Head, neck
			switch(icon_x)
				if(12, 13)
					return BODY_ZONE_PRECISE_NECK
				if(14 to 18)
					return BODY_ZONE_HEAD
				if(19, 20)
					return BODY_ZONE_PRECISE_NECK
		if(50) //Head
			switch(icon_x)
				if(14 to 18)
					return BODY_ZONE_HEAD
		if(51,52) //Head
			switch(icon_x)
				if(13 to 19)
					return BODY_ZONE_HEAD
		if(53 to 55) //Head
			switch(icon_x)
				if(12 to 20)
					return BODY_ZONE_HEAD
		if(56, 57) //Head
			switch(icon_x)
				if(13 to 19)
					return BODY_ZONE_HEAD
		if(58) //Head
			switch(icon_x)
				if(14 to 18)
					return BODY_ZONE_HEAD
		if(59)
			switch(icon_x)
				if(15 to 17)
					return BODY_ZONE_HEAD
