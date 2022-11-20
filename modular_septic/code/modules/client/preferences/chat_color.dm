/// The color of your runechat and say CSS
/datum/preference/color/chat_color
	category = PREFERENCE_CATEGORY_NON_CONTEXTUAL
	savefile_key = "chat_color"
	savefile_identifier = PREFERENCE_CHARACTER

/datum/preference/color/chat_color/create_informed_default_value(datum/preferences/preferences)
	. = ..()
	var/name = preferences.read_preference(/datum/preference/name/real_name)
	if(name)
		. = colorize_string(name, 0.85, 0.85, FALSE)
	return colorize_string(random_string(10, GLOB.alphabet_upper), 0.85, 0.85, FALSE)

/datum/preference/color/chat_color/apply_to_human(mob/living/carbon/human/target, value, datum/preferences/preferences)
	//chat color is updated on say, we don't need to update much else
	var/list/hsv_color = rgb2num(value, COLORSPACE_HSV)
	var/dark_value = rgb(hsv_color[1], max(0, hsv_color[2]-40), max(0, hsv_color[3]-40), space = COLORSPACE_HSV)
	GLOB.name_to_chat_color["[target.real_name]"] = value
	GLOB.name_to_chat_color_darkened["[target.real_name]"] = dark_value
	target.chat_color = value
	target.chat_color_darkened = dark_value
	target.chat_color_name = target.real_name
