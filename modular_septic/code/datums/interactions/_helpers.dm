// ALWAYS use INVOKE_ASYNC() when calling this! Please.
/mob/proc/do_fucking_animation(fuckdir = NONE)
	if(fuckdir)
		setDir(fuckdir)

	var/pixel_x_diff = 0
	var/pixel_y_diff = 0
	if(fuckdir & NORTH)
		pixel_y_diff = 8
	else if(fuckdir & SOUTH)
		pixel_y_diff = -8

	if(fuckdir & EAST)
		pixel_x_diff = 8
	else if(fuckdir & WEST)
		pixel_x_diff = -8

	if(pixel_x_diff == 0 && pixel_y_diff == 0)
		pixel_x_diff = rand(-3,3)
		pixel_y_diff = rand(-3,3)
		animate(src, pixel_x = pixel_x + pixel_x_diff, pixel_y = pixel_y + pixel_y_diff, time = 2)
		sleep(2)
		animate(src, pixel_x = base_pixel_x, pixel_y = base_pixel_y, time = 2)
		sleep(2)
		return

	animate(src, pixel_x = pixel_x + pixel_x_diff, pixel_y = pixel_y + pixel_y_diff, time = 2)
	sleep(2)
	animate(src, pixel_x = base_pixel_x, pixel_y = base_pixel_y, time = 2)
	sleep(2)
