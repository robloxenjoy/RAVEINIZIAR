//this is to ensure gibbing drops the chest, which i think is cool
/mob/living/carbon/spread_bodyparts()
	for(var/zone in ALL_BODYPARTS_ORDERED)
		var/obj/item/bodypart/bodypart = get_bodypart(zone)
		if(bodypart?.drop_limb())
			bodypart.throw_at(get_edge_target_turf(src,pick(GLOB.alldirs)),rand(1,3),5)
	var/obj/item/bodypart/chest = get_bodypart(BODY_ZONE_CHEST)
	if(chest)
		chest.drop_limb(TRUE)
		chest.throw_at(get_edge_target_turf(src,pick(GLOB.alldirs)),rand(1,3),5)

/mob/living/carbon/spill_organs(no_brain, no_organs, no_bodyparts)
	for(var/obj/item/organ/organ as anything in internal_organs)
		organ.plane = initial(organ.plane)
		organ.layer = initial(organ.layer)
		organ.mouse_opacity = initial(organ.mouse_opacity)
		if(organ.maptext)
			organ.maptext = ""
	return ..()

/mob/living/carbon/death(gibbed)
	. = ..()
	// We're dead - We can't have a pulse!
	pulse = PULSE_NONE
	for(var/thing in getorganslotlist(ORGAN_SLOT_HEART))
		var/obj/item/organ/heart/heart = thing
		heart.Stop()
	SEND_SIGNAL(src, COMSIG_ADD_MOOD_EVENT, "died", /datum/mood_event/died)
	if(!has_died)
//		if(iswillet(src))
//			return
		client?.prefs?.adjust_bobux(-10, "<span class='bobux'>I'm dead! -10 Kaotiks!</span>")
		GLOB.world_deaths_crazy += 1
		if(SSmapping.config?.war_gamemode)
			switch(GLOB.world_deaths_crazy)
				if(10 to 10)
					priority_announce("ARMOR AND OTHER ARE AVAILABLE FOR PURCHASE!", "Chaos", has_important_message = TRUE)
					SEND_SOUND(world, sound('modular_pod/sound/mus/announce.ogg'))
				if(20 to 20)
					priority_announce("GUNS ARE AVAILABLE FOR PURCHASE!", "Chaos", has_important_message = TRUE)
					SEND_SOUND(world, sound('modular_pod/sound/mus/announce.ogg'))
				if(30 to 30)
					priority_announce("SECOND WAR PHASE BEGINS!", "Chaos", has_important_message = TRUE)
					SEND_SOUND(world, sound('modular_pod/sound/mus/announce.ogg'))
					GLOB.phase_of_war = "Second"
				if(50 to 50)
					priority_announce("THIRD WAR PHASE BEGINS!", "Chaos", has_important_message = TRUE)
					SEND_SOUND(world, sound('modular_pod/sound/mus/announce.ogg'))
					GLOB.phase_of_war = "Third"
				if(200 to INFINITY)
					priority_announce("THE WAR IS OVER! VICTORY REMAINS A MYSTERY...", "Chaos", has_important_message = TRUE)
					SEND_SOUND(world, sound('modular_pod/sound/mus/announce.ogg'))
					SSticker.force_ending = 1

			for(var/mob/living/carbon/human/H in world)
				if(H != src)
					if(src in view(H))
						if(HAS_TRAIT(H, TRAIT_MISANTHROPE))
							SEND_SIGNAL(H, COMSIG_ADD_MOOD_EVENT, "saw_dead", /datum/mood_event/saw_dead/good)
						else
							if(pod_faction == H.pod_faction)
								SEND_SIGNAL(H, COMSIG_ADD_MOOD_EVENT, "saw_dead", /datum/mood_event/saw_dead/friend)
						if(pod_faction != H.pod_faction)
							var/somany = kaotiks_body
							H.client?.prefs?.adjust_bobux(somany, "<span class='bobux'>I saw a dying enemy! +[somany] Kaotiks!</span>")
							H.flash_kaosgain()
					else
						if(pod_faction != H.pod_faction)
							var/somany = kaotiks_body/2
							H.client?.prefs?.adjust_bobux(somany)
		else
			for(var/mob/living/carbon/human/H in world)
				if(H != src)
					if(src in view(H))
						if(HAS_TRAIT(H, TRAIT_MISANTHROPE))
							SEND_SIGNAL(H, COMSIG_ADD_MOOD_EVENT, "saw_dead", /datum/mood_event/saw_dead/good)
						else
							if(GET_MOB_SKILL_VALUE(H, SKILL_MEDICINE) < ATTRIBUTE_MIDDLING)
								SEND_SIGNAL(H, COMSIG_ADD_MOOD_EVENT, "saw_dead", /datum/mood_event/saw_dead)
							else
								SEND_SIGNAL(H, COMSIG_ADD_MOOD_EVENT, "saw_dead", /datum/mood_event/saw_dead/lesser)

		GLOB.new_people_crazy -= 1
		switch(truerole)
			if("Ladax")
				GLOB.kapnoe -= 1
			if("Kador")
				GLOB.aashol-= 1
//		GLOB.world_deaths_crazy_next = GLOB.world_deaths_crazy / 2

	if(is_merc_job(src))
		GLOB.mercenary_list -= 1
//	client?.prefs?.adjust_bobux(-1)
//	if(!iswillet(src))
//					H.flash_kaosgain()
//					H.client?.prefs?.adjust_bobux(10, "<span class='bobux'>I have seen a death of human! +10 kaotiks!</span>")

//				if(GET_MOB_SKILL_VALUE(H, SKILL_MEDICINE) < ATTRIBUTE_MIDDLING)
//					SEND_SIGNAL(H, COMSIG_ADD_MOOD_EVENT, "saw_dead", /datum/mood_event/saw_dead)
//				else
//					SEND_SIGNAL(H, COMSIG_ADD_MOOD_EVENT, "saw_dead", /datum/mood_event/saw_dead/lesser)
/*
	if(iswillet(src))
		for(var/mob/living/carbon/human/M in range(7, src))
			if(M != src && (src in view(M)))
				if(!iswillet(M))
					if(has_died)
						return
					M.client?.prefs?.adjust_bobux(10, "<span class='bobux'>I have seen a death of weak willet! +10 kaotiks!</span>")
*/
	has_died = TRUE


	// Shit yourself
	if(!QDELETED(src))
		if(prob(80))
			shit(FALSE)
		if(prob(80))
			piss(FALSE)

/mob/living/carbon/revive(full_heal, admin_revive, excess_healing)
	. = ..()
	// We are alive - We need our pulse back!
	set_heartattack(FALSE)
//	GLOB.world_deaths_crazy -= 1
	if(is_merc_job(src))
		GLOB.mercenary_list += 1
