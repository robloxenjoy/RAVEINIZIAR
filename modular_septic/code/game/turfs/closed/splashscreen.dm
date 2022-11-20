/turf/closed/indestructible/splashscreen/handle_generic_titlescreen_sizes()
	var/icon/size_check = icon(SStitle.icon, icon_state)
	var/width = size_check.Width()
	if(width == 480) // 480x480 is nonwidescreen
		pixel_x = 0
	else if(width == 608) // 608x480 is widescreen
		pixel_x = -64
	else  // 704x512 is ultrawide
		pixel_x = -128
		pixel_y = -32
