/atom/movable/screen/nutrition
	name = "nutrition"
	icon = 'modular_septic/icons/hud/quake/screen_quake.dmi'
	icon_state = "nutrition3"
	base_icon_state = "nutrition"
	screen_loc = ui_nutrition
	var/nutrition_index = 3

/atom/movable/screen/nutrition/update_icon_state()
	. = ..()
	icon_state = "[base_icon_state][nutrition_index]"

/atom/movable/screen/nutrition/Click(location, control, params)
	. = ..()
	if(!isliving(usr))
		to_chat(usr, div_infobox(span_notice("I don't need food.")))
		return
	var/mob/living/living_user = usr
	switch(living_user.nutrition)
		if(NUTRITION_LEVEL_FULL to INFINITY)
			to_chat(usr, div_infobox(span_notice("I'm completely stuffed!")))
		if(NUTRITION_LEVEL_WELL_FED to NUTRITION_LEVEL_FULL)
			to_chat(usr, div_infobox(span_notice("I'm well fed!")))
		if(NUTRITION_LEVEL_FED to NUTRITION_LEVEL_WELL_FED)
			to_chat(usr, div_infobox(span_notice("I'm not hungry.")))
		if(NUTRITION_LEVEL_HUNGRY to NUTRITION_LEVEL_FED)
			to_chat(usr, div_infobox(span_warning("I could use a bite to eat.")))
		if(NUTRITION_LEVEL_STARVING to NUTRITION_LEVEL_HUNGRY)
			to_chat(usr, div_infobox(span_danger("I feel quite hungry.")))
		if(0 to NUTRITION_LEVEL_STARVING)
			to_chat(usr, div_infobox(span_userdanger("I'm starving!")))

/atom/movable/screen/nutrition/proc/update_nutrition(new_nutri = 3)
	if(nutrition_index == new_nutri)
		return
	nutrition_index = new_nutri
	update_appearance()
