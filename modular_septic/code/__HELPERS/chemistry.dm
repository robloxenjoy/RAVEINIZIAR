/proc/mix_color_from_reagent_list(list/reagent_list)
	var/mixcolor
	var/vol_counter = 0
	var/vol_temp
	var/cached_color

	var/datum/reagent/raw_reagent //Faster declaration
	for(var/reagent_type in reagent_list)
		raw_reagent = reagent_type //Not initialized
		vol_temp = reagent_list[reagent_type]
		vol_counter += vol_temp
		cached_color = initial(raw_reagent.color)

		if(!mixcolor)
			mixcolor = cached_color
		else if (length(mixcolor) >= length(cached_color))
			mixcolor = BlendRGB(mixcolor, cached_color, vol_temp/vol_counter)
		else
			mixcolor = BlendRGB(cached_color, mixcolor, vol_temp/vol_counter)

	return sanitize_hexcolor(mixcolor, 8, TRUE)
