/obj/structure/trickysign
	name = "loose warning sign"
	desc = "A sign depicting a symbol of pure warning and anxiety. It's loose enough to be pulled out of the ground If you're reliably strong or crazy enough."
	icon = 'modular_septic/icons/obj/structures/bizzare.dmi'
	icon_state = "tricky"
	anchored = TRUE
	density = TRUE
	///First timer for the meglomaniac text
	var/prickone_time = 1 SECONDS
	///Second timer for the meglomaniac text
	var/pricktwo_time = 2 SECONDS
	var/obj/item/trickysign/trickysign = /obj/item/trickysign

/obj/structure/trickysign/Initialize(mapload)
	. = ..()
	trickysign = new trickysign(src)

/obj/structure/trickysign/proc/check_for_no_sign()
	if(!trickysign)
		qdel(src)

/obj/structure/trickysign/attack_hand(mob/user, list/modifiers)
	. = ..()
	if(!isliving(usr) || !usr.Adjacent(src) || usr.incapacitated())
		return
	try_to_rip(user)

/obj/structure/trickysign/proc/try_to_rip(mob/user)
	to_chat(user, span_notice("You grab [src] firmly..."))
	if(!do_after(user, 3 SECONDS) || (GET_MOB_ATTRIBUTE_VALUE(user, STAT_STRENGTH) <= 11))
		var/message = pick(GLOB.whoopsie)
		to_chat(user, span_warning("[message] I fucking failed."))
		return
	user.transferItemToLoc(trickysign, user.loc)
	user.put_in_hands(trickysign)
	trickysign = null
	check_for_no_sign()
	playsound(user, 'modular_septic/sound/weapons/melee/sign_rip.wav', 70, FALSE)
	user.visible_message(span_danger("[user] rip the [src] straight out of the ground!"), \
					span_danger("I rip the [src] straight out of the ground."))
	if(!HAS_TRAIT(user, TRAIT_TRICKY))
		addtimer(CALLBACK(src, .proc/prick, user), prickone_time)
		ADD_TRAIT(user, TRAIT_TRICKY, MEGALOMANIAC_TRAIT)

/obj/structure/trickysign/proc/prick(mob/user)
	to_chat(user, span_bigdanger("\nLucky me now I have a fucking sign.\n"))
	to_chat(user, span_bigdanger("\nWhat the fuck are they going to do about it?\n"))
	SEND_SIGNAL(user, COMSIG_ADD_MOOD_EVENT, "tricky_madness", /datum/mood_event/tricky, user)
