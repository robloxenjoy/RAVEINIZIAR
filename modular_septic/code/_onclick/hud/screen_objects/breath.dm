/atom/movable/screen/breath
	name = "breath"
	icon = 'modular_septic/icons/hud/quake/screen_quake.dmi'
	icon_state = "breath3"
	base_icon_state = "breath"
	screen_loc = ui_breath
	var/breath_index = 3

/atom/movable/screen/breath/update_icon_state()
	. = ..()
	icon_state = "[base_icon_state][breath_index]"

/atom/movable/screen/breath/Click(location, control, params)
	. = ..()
	var/list/modifiers = params2list(params)
	if(LAZYACCESS(modifiers, SHIFT_CLICK))
		if(HAS_TRAIT_FROM(usr, TRAIT_HOLDING_BREATH, "trynahold"))
			to_chat(usr, span_userdanger("Я начинаю задерживать своё дыхание."))
			return
		switch(breath_index)
			if(3)
				to_chat(usr, div_infobox(span_notice("Я могу нормально дышать.")))
			if(2)
				to_chat(usr, div_infobox(span_danger("Есть некоторые трудности с дыханием.")))
			if(1, 0)
				to_chat(usr, div_infobox(span_userdanger("Я не могу дышать!")))
	else
		if(HAS_TRAIT_FROM(usr, TRAIT_HOLDING_BREATH, "trynahold"))
			REMOVE_TRAIT(usr, TRAIT_HOLDING_BREATH, "trynahold")
			to_chat(usr, span_notice("Я больше не задерживаю дыхание."))
		else
			ADD_TRAIT(usr, TRAIT_HOLDING_BREATH, "trynahold")
			to_chat(usr, span_userdanger("Я начинаю задерживать дыхание."))

/atom/movable/screen/breath/proc/update_breath(new_breath = 3)
	if(breath_index == new_breath)
		return
	breath_index = new_breath
	update_appearance()
