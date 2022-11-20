/proc/get_typing_indicator(bubble_icon = "default")
	var/image/indicator = image(icon = 'modular_septic/icons/mob/talk.dmi', icon_state = bubble_icon)
	return indicator

/proc/get_ssd_indicator(bubble_icon = "default")
	var/image/indicator = image(icon = 'modular_septic/icons/mob/ssd.dmi', icon_state = bubble_icon)
	return indicator
