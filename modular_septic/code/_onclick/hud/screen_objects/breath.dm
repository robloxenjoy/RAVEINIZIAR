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
			to_chat(usr, span_userdanger("I am holding my breath."))
			return
		switch(breath_index)
			if(3)
				to_chat(usr, div_infobox(span_notice("I can breathe just fine.")))
			if(2)
				to_chat(usr, div_infobox(span_danger("I am having some difficulty breathing.")))
			if(1, 0)
				to_chat(usr, div_infobox(span_userdanger("I can't breathe!")))
	else
		if(HAS_TRAIT_FROM(usr, TRAIT_HOLDING_BREATH, "trynahold"))
			REMOVE_TRAIT(usr, TRAIT_HOLDING_BREATH, "trynahold")
			to_chat(usr, span_notice("I stop holding my breath."))
		else
			ADD_TRAIT(usr, TRAIT_HOLDING_BREATH, "trynahold")
			to_chat(usr, span_userdanger("I start holding my breath."))

/atom/movable/screen/breath/proc/update_breath(new_breath = 3)
	if(breath_index == new_breath)
		return
	breath_index = new_breath
	update_appearance()
