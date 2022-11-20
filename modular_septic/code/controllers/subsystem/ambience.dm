/datum/controller/subsystem/ambience/process_ambience_client(client/to_process)
	if(isnull(to_process) || isnewplayer(to_process.mob))
		ambience_listening_clients -= to_process
		return

	if(ambience_listening_clients[to_process] > world.time)
		return //Not ready for the next sound

	var/area/current_area = get_area(to_process.mob)

	if(!current_area) //Something's gone horribly wrong
		stack_trace("[key_name(to_process)] has somehow ended up in nullspace. WTF did you do")
		ambience_listening_clients -= to_process
		return

	var/sound = pick(current_area.ambientsounds)

	SEND_SOUND(to_process.mob, sound(sound, repeat = 0, wait = 0, volume = 45, channel = CHANNEL_AMBIENCE))

	ambience_listening_clients[to_process] = world.time + rand(current_area.min_ambience_cooldown, current_area.max_ambience_cooldown)
