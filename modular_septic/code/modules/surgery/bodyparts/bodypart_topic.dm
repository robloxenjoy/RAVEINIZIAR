/obj/item/bodypart/Topic(href, href_list)
	. = ..()
	if(href_list["gauze"])
		var/mob/living/carbon/carbon = usr
		if(!istype(carbon) || !carbon.canUseTopic(owner, TRUE, FALSE, FALSE) || !current_gauze)
			return
		if(DOING_INTERACTION_WITH_TARGET(carbon, src))
			to_chat(carbon, span_warning("I'm already interacting with [src.name]!"))
			return
		if(carbon == owner)
			owner.visible_message(span_warning("<b>[owner]</b> starts ripping off \the [current_gauze] off of [owner.p_their()] [src.name]."), \
								span_warning("I start ripping off \the [current_gauze] off of my [src.name]."))
			if(do_mob(usr, owner, 6 SECONDS) && current_gauze)
				owner.visible_message(span_warning("<b>[owner]</b> rips \the [current_gauze] off of [owner.p_their()] [src.name], destroying it in the process!"),
									span_warning("I rip \the [current_gauze] off of my [src.name], destroying it in the process!"))
				playsound(owner, 'modular_septic/sound/effects/clothripping.ogg', 40, 0, -4)
				remove_gauze(FALSE)
			else
				to_chat(owner, span_warning("I fail to rip \the [current_gauze] off of my [src.name].."))
		else
			if(do_mob(usr, owner, 3 SECONDS) && current_gauze)
				usr.visible_message(span_warning("<b>[usr]</b> rips \the [current_gauze] off of <b>[owner]</b>'s [src.name], destroying it in the process!"),
								span_warning("I rip \the [current_gauze] off of [owner]'s [src.name], destroying it in the process!"))
				playsound(owner, 'modular_septic/sound/effects/clothripping.ogg', 40, 0, -4)
				remove_gauze(FALSE)
			else
				to_chat(usr, span_warning("I fail to rip \the [current_gauze] off of <b>[owner]</b>'s [src.name].."))
	if(href_list["splint"])
		var/mob/living/carbon/carbon = usr
		if(!istype(carbon) || !carbon.canUseTopic(owner, TRUE, FALSE, FALSE) || !current_splint)
			return
		if(DOING_INTERACTION_WITH_TARGET(carbon, src))
			to_chat(carbon, span_warning("I'm already interacting with [src.name]!"))
			return
		if(carbon == owner)
			owner.visible_message(span_warning("<b>[owner]</b> starts ripping off \the [current_splint] off of [owner.p_their()] [src.name]!"), \
								span_warning("I start ripping off \the [current_splint] off of my [src.name]!"))
			if(do_mob(usr, owner, 6 SECONDS) && current_splint)
				owner.visible_message(span_warning("<b>[owner]</b> rips \the [current_splint] off of [owner.p_their()] [src.name], destroying it in the process!"),
									span_warning("I rip \the [current_splint] off of my [src.name], destroying it in the process!"))
				playsound(owner, 'modular_septic/sound/effects/clothripping.ogg', 40, 0, -4)
				remove_splint(FALSE)
			else
				to_chat(owner, span_warning("I fail to rip \the [current_splint] off of my [src.name].."))
		else
			if(do_mob(usr, owner, 3 SECONDS) && current_splint)
				usr.visible_message(span_warning("<b>[usr]</b> rips \the [current_splint] off of <b>[owner]</b>'s [src.name], destroying it in the process!"),
								span_warning("I rip \the [current_splint] off of [owner]'s [src.name], destroying it in the process!"))
				playsound(owner, 'modular_septic/sound/effects/clothripping.ogg', 40, 0, -4)
				remove_splint(FALSE)
			else
				to_chat(usr, span_warning("I fail to rip \the [current_splint] off of <b>[owner]</b>'s [src.name].."))
