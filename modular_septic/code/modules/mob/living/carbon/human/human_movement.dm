/mob/living/carbon/human/CanAllowThrough(atom/movable/mover, border_dir)
	. = ..()
	if(.)
		return
	if(isitem(mover) && mover.throwing?.thrower && ishuman(mover.throwing.thrower))
		var/mob/living/carbon/human/human_thrower = mover.throwing.thrower
		if(human_thrower.diceroll(GET_MOB_SKILL_VALUE(human_thrower, SKILL_THROWING), context = DICE_CONTEXT_PHYSICAL) <= DICE_FAILURE)
			return TRUE

/mob/living/carbon/human/Move(NewLoc, direct)
	. = ..()
	//this is really dumb but hey, it works i guess
	if(body_position == STANDING_UP && loc == NewLoc && has_gravity(loc))
		if(shoes)
			SEND_SIGNAL(shoes, COMSIG_SHOES_STEP_ACTION)
		if(w_uniform)
			SEND_SIGNAL(w_uniform, COMSIG_SHOES_STEP_ACTION)
		if(wear_suit)
			SEND_SIGNAL(wear_suit, COMSIG_SHOES_STEP_ACTION)

////	RAIN OVERLAY CODE	////
/*
		var/x_offset = 0
		var/y_offset = 0
		switch(direct)
			if(NORTH)
				y_offset = 8
			if(SOUTH)
				y_offset = -8
			if(EAST)
				x_offset = 8
			if(WEST)
				x_offset = -8
		for(var/i = -7 to 7)
			var/turf/stalker/TF = locate(x+(x_offset ? x_offset : i), y+(y_offset ? y_offset : i), z)
			var/image/I = image('icons/stalker/structure/decor.dmi', TF, "rain", layer = 10)
			if(TF && TF.rained)
				if(!client.rain_overlays.Find("[TF.x],[TF.y],[TF.z]"))
					client.rain_overlays["[TF.x],[TF.y],[TF.z]"] = I
					client.images -= client.rain_overlays["[TF.x],[TF.y],[TF.z]"]
					client.images |= client.rain_overlays["[TF.x],[TF.y],[TF.z]"]

			var/turf/stalker/TB = locate(x-(x_offset ? ((x_offset > 0) ? x_offset+1 : x_offset-1) : i), y-(y_offset ? ((y_offset > 0) ? y_offset+1 : y_offset-1) : i), z)		//Yeah, I know it's unreadable, but anyway
			if(TB && TB.rained)
				client.images -= client.rain_overlays["[TB.x],[TB.y],[TB.z]"]
				client.rain_overlays.Remove("[TB.x],[TB.y],[TB.z]")
*/
