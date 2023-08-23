GLOBAL_LIST_EMPTY(child_enterporter)
GLOBAL_LIST_EMPTY(child_exiterporter)
GLOBAL_LIST_EMPTY(denominator_exiterporter)

/obj/structure/gptdfm
	name = "rapid-major-transportation-effect"
	desc = "Rapid teleportation area."
	icon = 'modular_septic/icons/obj/structures/gptdfm.dmi'
	icon_state = "child_transporter"
	density = FALSE
	resistance_flags = INDESTRUCTIBLE | FIRE_PROOF | ACID_PROOF | LAVA_PROOF
	anchored = TRUE
	var/gurby = list('modular_septic/sound/effects/teleporter/gurby1.ogg', 'modular_septic/sound/effects/teleporter/gurby2.ogg', 'modular_septic/sound/effects/teleporter/gurby3.ogg', 'modular_septic/sound/effects/teleporter/gurby4.ogg', 'modular_septic/sound/effects/teleporter/gurby5.ogg')
	var/gurby_escape = 'modular_septic/sound/effects/chadjack.ogg'
	var/gurby_unescape = 'modular_septic/sound/effects/soyjack.ogg'

/obj/structure/gptdfm/Initialize(mapload)
	. = ..()
	var/static/list/loc_connections = list(
		COMSIG_ATOM_ENTERED = .proc/on_entered,
	)
	AddElement(/datum/element/connect_loc, loc_connections)

/obj/structure/gptdfm/examine(mob/living/user)
	. = ..()
	playsound(user, gurby, 30, FALSE)

/obj/structure/gptdfm/proc/teleportation(mob/user, obj/structure/gptdfm/specific_location = pick(GLOB.child_exiterporter), leaving_message = "Time for my journey. I'm going to [specific_location.name].")
	to_chat(user, span_notice("[leaving_message]"))
	if(user.pulling)
		var/atom/movable/friend = user.pulling
		var/list/collective = list(friend)
		while(friend.pulling)
			collective += friend.pulling
			friend = friend.pulling
		mass_teleportation(user, collective, specific_location)
		return
	if(do_after(user, 5 SECONDS, target = user))
		do_teleport(user, specific_location, no_effects = TRUE, channel = TELEPORT_CHANNEL_BLUESPACE)
		playsound(user, gurby_unescape, 80, FALSE)
		user.flash_darkness(100)

/obj/structure/gptdfm/proc/mass_teleportation(mob/leader, list/mob/friends_list, specific_location)
	var/friend_message_composed = "<div class='infobox'>I'm bringing my PARTY along with me:"
	for(var/atom/friend as anything in friends_list)
		if(ismob(friend))
			to_chat(friend, span_notice("Our party has gathered, [leader] is taking us to [specific_location]..."))
		friend_message_composed += "\n[friend.name]"
	friend_message_composed += "</div>"
	to_chat(leader, span_notice("[friend_message_composed]"))
	friends_list += leader
	if(do_after(leader, 6 SECONDS, target = leader))
		playsound(leader, gurby_unescape, 80, FALSE)
		for(var/atom/friend as anything in friends_list)
			do_teleport(friend, specific_location, no_effects = TRUE, channel = TELEPORT_CHANNEL_BLUESPACE)
			if(iscarbon(friend))
				var/mob/living/carbon/carbon_friend = friend
				carbon_friend.flash_darkness(100)

/obj/structure/gptdfm/proc/on_entered(datum/source, mob/living/child_victim)
	SIGNAL_HANDLER
	if(!istype(child_victim))
		return
	INVOKE_ASYNC(src, .proc/teleportation, child_victim)

/obj/structure/gptdfm/entrance
	name = "An unEscape from Nevado"
	desc = "GTFIN!"

/obj/structure/gptdfm/entrance/Initialize(mapload)
	. = ..()
	GLOB.child_enterporter += src

/obj/structure/gptdfm/entrance/Destroy()
	. = ..()
	GLOB.child_enterporter -= src

/obj/structure/gptdfm/entrance/examine(mob/user)
	. = ..()
	. += span_info("Time to Escape from Nevado!")
	. += span_big(span_alert("What..."))

/obj/structure/gptdfm/exit
	name = "An Escape from Nevado"
	desc = "GTFO!"

/obj/structure/gptdfm/exit/Initialize(mapload)
	. = ..()
	name = "[pick("Leave","Escape","Depart","Getaway","Flee","Abandon")] from [rand(1,9)][rand(1,9)][rand(1,9)][rand(1,9)][rand(1,9)]"
	GLOB.child_exiterporter += src

/obj/structure/gptdfm/exit/Destroy()
	. = ..()
	GLOB.child_exiterporter -= src

/obj/structure/gptdfm/exit/examine(mob/user)
	. = ..()
	. += span_info("Back to the Safezone!")
	. += span_big(span_alert("Hmm..."))

/obj/structure/gptdfm/exit/teleportation(mob/user, obj/structure/gptdfm/specific_location = pick(GLOB.child_enterporter), leaving_message = "Time for my journey. I'm going to [specific_location.name].")
	leaving_message = "I'm going back to the safezone now."
	if(HAS_TRAIT(user, TRAIT_DENOMINATOR_ACCESS))
		leaving_message = "Establishing an exfil back to base."
		if(LAZYLEN(GLOB.denominator_exiterporter))
			specific_location = pick(GLOB.denominator_exiterporter)
		else
			to_chat(user, span_boldwarning("I can't make it back to my base. I'm stuck!"))
			return
	return ..()

/obj/structure/gptdfm/denominator
	name = "An unEscape from Nevado but for Denominators"
	desc = "GTFIN IDIOT!"

/obj/structure/gptdfm/denominator/Initialize(mapload)
	. = ..()
	GLOB.denominator_exiterporter += src

/obj/structure/gptdfm/denominator/Destroy()
	. = ..()
	GLOB.denominator_exiterporter -= src


