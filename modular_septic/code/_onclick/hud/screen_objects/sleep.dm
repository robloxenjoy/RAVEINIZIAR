/atom/movable/screen/sleeping
	name = "sleep"
	icon = 'modular_septic/icons/hud/quake/screen_quake.dmi'
	icon_state = "act_sleep"
	base_icon_state = "act_sleep"
	screen_loc = ui_sleep

/atom/movable/screen/sleeping/Click(location, control, params)
	. = ..()
	if(iscarbon(usr))
		var/mob/living/carbon/C = usr
		if(HAS_TRAIT(C, TRAIT_TRYINGTOSLEEP))
			REMOVE_TRAIT(C, TRAIT_TRYINGTOSLEEP, "trynasleep")
		else
			if(C.getShock() >= PAIN_NO_SLEEP * (GET_MOB_ATTRIBUTE_VALUE(C, STAT_ENDURANCE)/ATTRIBUTE_MIDDLING))
				to_chat(C, span_warning("[fail_msg()] I can't sleep while... [span_userdanger("IN PAIN!")]"))
				return
			ADD_TRAIT(C, TRAIT_TRYINGTOSLEEP, "trynasleep")
		update_appearance()

/atom/movable/screen/sleeping/update_icon_state()
	. = ..()
	if(!iscarbon(hud?.mymob))
		return
	var/mob/living/carbon/C = hud?.mymob
	if(HAS_TRAIT(C, TRAIT_TRYINGTOSLEEP))
		icon_state = "[base_icon_state]_on"
	else
		if(C.IsSleeping() || C.IsUnconscious())
			icon_state = "[base_icon_state]_waking"
		else
			icon_state = base_icon_state

/atom/movable/screen/sleeping/update_name(updates)
	. = ..()
	if(!iscarbon(hud?.mymob))
		return
	var/mob/living/carbon/C = hud?.mymob
	if(HAS_TRAIT(C, TRAIT_TRYINGTOSLEEP))
		name = "sleeping"
	else
		if(C.IsSleeping() || C.IsUnconscious())
			name = "waking up"
		else
			name = "sleep"
