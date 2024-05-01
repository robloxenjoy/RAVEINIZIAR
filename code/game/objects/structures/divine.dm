/obj/structure/sacrificealtar/hadot
	name = "Sacrificial Altar"
	desc = "Altar in honor of Hadot."
	icon = 'icons/obj/hand_of_god_structures.dmi'
	icon_state = "sacrificealtarhadot"
	anchored = TRUE
	density = FALSE
	can_buckle = 1

/obj/structure/sacrificealtar/hadot/AltClick(mob/living/carbon/human/user)
	..()
	if(!istype(user) || !user.canUseTopic(src, BE_CLOSE))
		return
	if(user.belief != "Hadot")
		return
	if(!has_buckled_mobs())
		return
	var/mob/living/carbon/human/L = locate() in buckled_mobs
	if(!L)
		return
	if(L.stat == DEAD)
		to_chat(user, span_warning("I don't want corpses."))
		return
	if(istype(L, /mob/living/carbon/human/species/weakwillet))
		to_chat(user, span_warning("I don't need this bastard, meow."))
		return
	if(L.belief == "Hadot")
		to_chat(user, span_warning("What are you doing! [L] is our brother!"))
		return
	if(do_after(user, 100, target = src))
		visible_message(span_danger("[L] is destroyed for the glory of Hadot."))
		L.gib()
//		var/result = rand(1, 2)
//		switch(result)
//			if(1)
		new /obj/item/podpol_weapon/sword(get_turf(user))
		visible_message(span_danger("This is my gift."))

/*
			if(2)
				if(!HAS_TRAIT(user, TRAIT_LYNXER))
					ADD_TRAIT(user, TRAIT_LYNXER, name)
					add_verb(user, /mob/living/carbon/human/verb/belynx)
					to_chat(user, span_achievementrare("Yes, now you can become a lynx!"))
				else
					new /obj/item/changeable_attacks/slashstab/sabre/small/steel(get_turf(user))
					visible_message(span_danger("This is my gift."))
*/

/obj/structure/sacrificealtar/gutted
	name = "Sacrificial Altar"
	desc = "Altar in honor of Gutted."
	icon = 'icons/obj/hand_of_god_structures.dmi'
	icon_state = "sacrificealtargutted"
	anchored = TRUE
	density = FALSE
	can_buckle = 1

/obj/structure/sacrificealtar/gutted/AltClick(mob/living/carbon/human/user)
	..()
	if(!istype(user) || !user.canUseTopic(src, BE_CLOSE))
		return
	if(user.belief != "Gutted")
		return
	if(!has_buckled_mobs())
		return
	var/mob/living/carbon/human/L = locate() in buckled_mobs
	if(!L)
		return
	if(L.stat == DEAD)
		to_chat(user, span_warning("Corpse? Very funny."))
		return
	if(istype(L, /mob/living/carbon/human/species/weakwillet))
		to_chat(user, span_warning("Ssss, get this out of here."))
		return
	if(do_after(user, 100, target = src))
		visible_message(span_danger("[L] is destroyed for the glory of Gutted."))
		L.gib()
//	var/result = rand(1, 2)
//	switch(result)
//		if(1)
		new /obj/item/bodypart/face/gutted(get_turf(user))
		visible_message(span_danger("For you."))

//		if(2)
//			new /obj/item/

/obj/structure/healingfountain
	name = "healing fountain"
	desc = "A fountain containing the waters of life."
	icon = 'icons/obj/hand_of_god_structures.dmi'
	icon_state = "fountain"
	anchored = TRUE
	density = TRUE
	var/time_between_uses = 1800
	var/last_process = 0

/obj/structure/healingfountain/attack_hand(mob/living/user, list/modifiers)
	. = ..()
	if(.)
		return
	if(last_process + time_between_uses > world.time)
		to_chat(user, span_notice("The fountain appears to be empty."))
		return
	last_process = world.time
	to_chat(user, span_notice("The water feels warm and soothing as you touch it. The fountain immediately dries up shortly afterwards."))
	user.reagents.add_reagent(/datum/reagent/medicine/omnizine/godblood,20)
	update_appearance()
	addtimer(CALLBACK(src, /atom/.proc/update_appearance), time_between_uses)

/obj/structure/healingfountain/update_icon_state()
	if(last_process + time_between_uses > world.time)
		icon_state = "fountain"
	else
		icon_state = "fountain-red"
	return ..()
