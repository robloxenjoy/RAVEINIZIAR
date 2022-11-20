/atom/movable/screen/enhanced_sel
	name = "enhanced zone"
	icon = 'modular_septic/icons/hud/quake/screen_quake_enhance.dmi'
	icon_state = "enhanced"
	base_icon_state = "enhanced"
	screen_loc = ui_enhancesel
	screentip_flags = SCREENTIP_HOVERER_CLICKER
	var/overlay_icon = 'modular_septic/icons/hud/quake/screen_quake_enhance.dmi'
	var/static/list/hover_overlays_cache = list()
	var/hovering

/obj/effect/overlay/enhanced_sel
	icon = 'modular_septic/icons/hud/quake/screen_quake_enhance.dmi'
	plane = ABOVE_HUD_PLANE
	alpha = 128
	mouse_opacity = MOUSE_OPACITY_TRANSPARENT
	anchored = TRUE

/atom/movable/screen/enhanced_sel/Initialize(mapload)
	. = ..()
	LAZYINITLIST(hover_overlays_cache[overlay_icon])

/atom/movable/screen/enhanced_sel/update_icon_state()
	. = ..()
	if(!hud?.mymob)
		icon_state = base_icon_state
		return
	icon_state = "[base_icon_state]_head"

/atom/movable/screen/enhanced_sel/update_overlays()
	. = ..()
	if(!(hud?.mymob?.zone_selected in ENHANCEABLE_BODYZONES))
		return
	. += mutable_appearance(overlay_icon, "[hud.mymob.zone_selected]")

/atom/movable/screen/enhanced_sel/Click(location, control,params)
	. = ..()
	if(isobserver(usr))
		return

	var/list/modifiers = params2list(params)
	var/icon_x = text2num(LAZYACCESS(modifiers, ICON_X))
	var/icon_y = text2num(LAZYACCESS(modifiers, ICON_Y))
	var/choice = get_zone_at(icon_x, icon_y)
	if (!choice)
		return 1

	return set_selected_zone(choice, usr)

/atom/movable/screen/enhanced_sel/return_screentip(mob/user, params)
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

/atom/movable/screen/enhanced_sel/MouseEntered(location, control, params)
	. = ..()
	MouseMove(location, control, params)

/atom/movable/screen/enhanced_sel/MouseMove(location, control, params)
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
	if(hovering == choice)
		return

	vis_contents -= hover_overlays_cache[overlay_icon][hovering]
	hovering = choice

	var/obj/effect/overlay/enhanced_sel/overlay_object = hover_overlays_cache[overlay_icon][choice]
	if(!overlay_object)
		overlay_object = new
		overlay_object.icon = overlay_icon
		overlay_object.icon_state = "[choice]"
		hover_overlays_cache[overlay_icon][choice] = overlay_object
	vis_contents += overlay_object

/atom/movable/screen/enhanced_sel/MouseExited(location, control, params)
	. = ..()
	if(!isobserver(usr) && hovering)
		vis_contents -= hover_overlays_cache[overlay_icon][hovering]
		hovering = null

/atom/movable/screen/enhanced_sel/proc/set_selected_zone(choice, mob/user)
	if(user != hud?.mymob)
		return

	if(choice != hud.mymob.zone_selected)
		hud.mymob.zone_selected = choice
		hud.zone_select?.update_appearance()
		update_appearance()

	if(isliving(hud.mymob))
		var/mob/living/living_mob = hud.mymob
		//Update the hand shit
		living_mob.hand_index_to_zone[living_mob.active_hand_index] = living_mob.zone_selected

	return TRUE

/atom/movable/screen/enhanced_sel/proc/get_zone_at(icon_x, icon_y)
	switch(icon_y)
		if(6) //Jaw
			switch(icon_x)
				if(13 to 19)
					return BODY_ZONE_PRECISE_MOUTH
		if(7) //Jaw
			switch(icon_x)
				if(12 to 20)
					return BODY_ZONE_PRECISE_MOUTH
		if(8, 9) //Jaw
			switch(icon_x)
				if(11 to 21)
					return BODY_ZONE_PRECISE_MOUTH
		if(10) //Jaw
			switch(icon_x)
				if(10 to 22)
					return BODY_ZONE_PRECISE_MOUTH
		if(11) //Jaw
			switch(icon_x)
				if(9 to 23)
					return BODY_ZONE_PRECISE_MOUTH
		if(12) //Jaw, face
			switch(icon_x)
				if(9, 10)
					return BODY_ZONE_PRECISE_MOUTH
				if(11 to 21)
					return BODY_ZONE_PRECISE_FACE
				if(22, 23)
					return BODY_ZONE_PRECISE_MOUTH
		if(13) //Face
			switch(icon_x)
				if(8 to 24)
					return BODY_ZONE_PRECISE_FACE
		if(14 to 16) //Face
			switch(icon_x)
				if(7 to 25)
					return BODY_ZONE_PRECISE_FACE
		if(17) //Face, eyes
			switch(icon_x)
				if(7 to 9)
					return BODY_ZONE_PRECISE_FACE
				if(10 to 13)
					return BODY_ZONE_PRECISE_R_EYE
				if(14 to 18)
					return BODY_ZONE_PRECISE_FACE
				if(19 to 22)
					return BODY_ZONE_PRECISE_L_EYE
				if(23 to 25)
					return BODY_ZONE_PRECISE_FACE
		if(18, 19) //Face, eyes
			switch(icon_x)
				if(7,8)
					return BODY_ZONE_PRECISE_FACE
				if(9 to 14)
					return BODY_ZONE_PRECISE_R_EYE
				if(15 to 17)
					return BODY_ZONE_PRECISE_FACE
				if(18 to 23)
					return BODY_ZONE_PRECISE_L_EYE
				if(24, 25)
					return BODY_ZONE_PRECISE_FACE
		if(20) //Face, eyes
			switch(icon_x)
				if(7 to 9)
					return BODY_ZONE_PRECISE_FACE
				if(10 to 13)
					return BODY_ZONE_PRECISE_R_EYE
				if(14 to 18)
					return BODY_ZONE_PRECISE_FACE
				if(19 to 22)
					return BODY_ZONE_PRECISE_L_EYE
				if(23 to 25)
					return BODY_ZONE_PRECISE_FACE
		if(21, 22) //Head, face
			switch(icon_x)
				if(7,8)
					return BODY_ZONE_HEAD
				if(9 to 23)
					return BODY_ZONE_PRECISE_FACE
				if(24,25)
					return BODY_ZONE_HEAD
		if(23) //Head, face
			switch(icon_x)
				if(7 to 9)
					return BODY_ZONE_HEAD
				if(10 to 13)
					return BODY_ZONE_PRECISE_FACE
				if(14 to 18)
					return BODY_ZONE_HEAD
				if(19 to 22)
					return BODY_ZONE_PRECISE_FACE
				if(23 to 25)
					return BODY_ZONE_HEAD
		if(24) //Head
			switch(icon_x)
				if(7 to 25)
					return BODY_ZONE_HEAD
		if(25) //Head
			switch(icon_x)
				if(8 to 24)
					return BODY_ZONE_HEAD
		if(26) //Head
			switch(icon_x)
				if(9 to 23)
					return BODY_ZONE_HEAD
		if(27) //Head
			switch(icon_x)
				if(10 to 22)
					return BODY_ZONE_HEAD
		if(28)
			switch(icon_x)
				if(12 to 20)
					return BODY_ZONE_HEAD
