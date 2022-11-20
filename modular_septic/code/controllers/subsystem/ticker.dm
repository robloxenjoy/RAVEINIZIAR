/datum/controller/subsystem/ticker/Shutdown()
	round_end_sound = SSstation.announcer.get_rand_goodbye_sound()
	return ..()

/datum/controller/subsystem/ticker/PostSetup()
	. = ..()
	for(var/i in GLOB.player_list)
		if(!ismob(i))
			continue
		var/mob/attribute_guy = i
		if(!attribute_guy.attributes)
			continue
		//update the hud please
		attribute_guy.attributes.update_attributes()
