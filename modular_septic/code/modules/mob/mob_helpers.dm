/proc/shake_camera_up(mob/shaken, amount = 1, loops = 1, duration_in = 0, duration_out = 0)
	if(!shaken?.client || ((duration_in <= 0) && (duration_out <= 0)))
		return

	var/client/mob_client = shaken.client
	for(var/i in 1 to loops)
		animate(mob_client, pixel_y = mob_client.pixel_y + amount, duration_in)
		animate(mob_client, pixel_y = mob_client.pixel_y - amount, duration_out)
