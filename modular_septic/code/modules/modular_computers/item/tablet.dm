/obj/item/modular_computer/tablet
	icon = 'modular_septic/icons/obj/items/modular_tablet.dmi'
	light_system = MOVABLE_LIGHT_DIRECTIONAL

/obj/item/modular_computer/tablet/set_flashlight_color(color)
	if(!has_light || !color)
		return FALSE
	comp_light_color = color
	set_light_color(color)
	return TRUE

/obj/item/modular_computer/toggle_flashlight()
	if(!has_light)
		return FALSE
	set_light_on(!light_on)
	if((light_system != MOVABLE_LIGHT) && (light_system != MOVABLE_LIGHT_DIRECTIONAL))
		if(light_on)
			set_light(comp_light_luminosity, 1, comp_light_color)
		else
			set_light(0)
	return TRUE
