/atom/movable/screen/intent_select
	name = "intent selection"
	icon = 'modular_septic/icons/hud/quake/screen_quake.dmi'
	icon_state = INTENT_HELP
	screentip_flags = SCREENTIP_HOVERER_CLICKER
	screen_loc = ui_intents

/atom/movable/screen/intent_select/Click(location, control, params)
	var/mob/living/L = usr
	if(istype(L))
		L.a_intent_change(INTENT_HOTKEY_RIGHT)

/atom/movable/screen/intent_select/segmented/Click(location, control, params)
	var/mob/living/L = usr
	if(!istype(L))
		return
	var/_x = text2num(params2list(params)["icon-x"])
	var/_y = text2num(params2list(params)["icon-y"])

	if(_x<=16 && _y<=16)
		L.a_intent_change(INTENT_HARM)

	else if(_x<=16 && _y>=17)
		L.a_intent_change(INTENT_HELP)

	else if(_x>=17 && _y<=16)
		L.a_intent_change(INTENT_GRAB)

	else if(_x>=17 && _y>=17)
		L.a_intent_change(INTENT_DISARM)

/atom/movable/screen/intent_select/segmented/return_screentip(mob/user, params)
	if(flags_1 & NO_SCREENTIPS_1)
		return ""

	var/_x = text2num(params2list(params)["icon-x"])
	var/_y = text2num(params2list(params)["icon-y"])
	if(_x<=16 && _y<=16)
		return SCREENTIP_OBJ("HARM INTENT")

	else if(_x<=16 && _y>=17)
		return SCREENTIP_OBJ("HELP INTENT")

	else if(_x>=17 && _y<=16)
		return SCREENTIP_OBJ("GRAB INTENT")

	else if(_x>=17 && _y>=17)
		return SCREENTIP_OBJ("DISARM INTENT")
