/mob/living/carbon/human/shit(intentional = FALSE)
	var/list/intestines = getorganslotlist(ORGAN_SLOT_INTESTINES)
	var/intestinal_efficiency = getorganslotefficiency(ORGAN_SLOT_INTESTINES)
	if(!LAZYLEN(intestines))
		if(intentional)
			to_chat(src, span_warning("I have no bowels."))
		return
	if(intestinal_efficiency < ORGAN_FAILING_EFFICIENCY)
		if(intentional)
			to_chat(src, span_userdanger("My bowels dilate in agonizing pain as they try to shit their contents out!"))
		return
	var/collective_shit_amount = 0
	for(var/obj/item/organ/intestines/intestine as anything in intestines)
		collective_shit_amount += intestine.reagents.get_reagent_amount(/datum/reagent/consumable/shit)
	if(collective_shit_amount < 10)
		if(intentional)
			to_chat(src, span_warning("I don't need to shit."))
		return
	var/obj/structure/toilet/toiler = locate() in loc
	var/obj/item/bodypart/groin = get_bodypart(BODY_ZONE_PRECISE_GROIN)
	var/list/clothing_on_groin = clothingonpart(groin)
	var/shit_pants = (groin ? LAZYLEN(clothing_on_groin) : FALSE)
	if(src in toiler?.buckled_mobs)
		shit_pants = FALSE
	if(shit_pants)
		SEND_SIGNAL(src, COMSIG_ADD_MOOD_EVENT, "shat_self", /datum/mood_event/shat_self)
		for(var/obj/item/organ/intestines/intestine as anything in intestines)
			var/amount = min(40, intestine.reagents.get_reagent_amount(/datum/reagent/consumable/shit) - intestine.food_reagents[/datum/reagent/consumable/shit])
			intestine.reagents.remove_reagent(/datum/reagent/consumable/shit, amount)
			var/datum/reagents/reactant_holder = new(1000)
			reactant_holder.add_reagent(/datum/reagent/consumable/shit, amount)
			reactant_holder.expose(src, TOUCH, show_message = FALSE)
			for(var/obj/item/shitted in clothing_on_groin)
				reactant_holder.expose(shitted, TOUCH, show_message = FALSE)
				break
			qdel(reactant_holder)
		playsound(loc, 'modular_septic/sound/effects/poo.ogg', 75)
		to_chat(src, span_warning("I shit on myself..."))
		return
	//we'll try to shit a maximum of 40u from each bowel
	var/obj/item/shit/stool = new(loc)
	stool.add_shit_DNA(get_blood_dna_list())
	stool.reagents.remove_all(INFINITY)
	for(var/obj/item/organ/intestines/intestine as anything in intestines)
		var/amount = min(40, intestine.reagents.get_reagent_amount(/datum/reagent/consumable/shit) - intestine.food_reagents[/datum/reagent/consumable/shit])
		intestine.reagents.trans_id_to(stool, /datum/reagent/consumable/shit, amount, preserve_data = TRUE)
	if(toiler)
		//mess gone
		qdel(stool)
		visible_message("<span class='notice'><b>[src]</b> shits on [toiler].</span>", \
					"<span class='notice'>I take a shit on [toiler].")
	else
		visible_message("<span class='notice'><b>[src]</b> shits on [loc].</span>", \
					"<span class='notice'>I take a shit on [loc].")
	playsound(loc, 'modular_septic/sound/effects/poo.ogg', 75)

/mob/living/carbon/human/piss(intentional = FALSE)
	var/list/bladders = getorganslotlist(ORGAN_SLOT_BLADDER)
	var/collective_piss_amount = 0
	for(var/obj/item/organ/bladder/bladder as anything in bladders)
		collective_piss_amount += bladder.reagents.get_reagent_amount(/datum/reagent/consumable/piss)
	if(collective_piss_amount < 10)
		if(intentional)
			to_chat(src, span_warning("I don't need to piss."))
		return
	var/obj/structure/toilet/toiler = locate() in loc
	var/obj/structure/urinal/urinel = locate() in loc
	var/obj/item/bodypart/groin = get_bodypart(BODY_ZONE_PRECISE_GROIN)
	var/list/clothing_on_groin = clothingonpart(groin)
	var/piss_pants = (groin ? LAZYLEN(clothing_on_groin) : FALSE)
	if((src in toiler?.buckled_mobs) || (urinel && (getorganslotefficiency(ORGAN_SLOT_PENIS) >= ORGAN_FAILING_EFFICIENCY)))
		piss_pants = FALSE
	var/turf/pissed = get_turf(src)
	if(piss_pants)
		SEND_SIGNAL(src, COMSIG_ADD_MOOD_EVENT, "pee_self", /datum/mood_event/pissed_self)
		for(var/obj/item/organ/bladder/bladder as anything in bladders)
			var/amount = min(40, bladder.reagents.get_reagent_amount(/datum/reagent/consumable/piss) - bladder.food_reagents[/datum/reagent/consumable/piss])
			bladder.reagents.remove_reagent(/datum/reagent/consumable/piss, amount)
			pissed.add_liquid(/datum/reagent/consumable/piss, amount)
			var/datum/reagents/reactant_holder = new(1000)
			reactant_holder.add_reagent(/datum/reagent/consumable/piss, amount)
			reactant_holder.expose(src, TOUCH, show_message = FALSE)
			for(var/obj/item/pissedd in clothing_on_groin)
				reactant_holder.expose(pissed, TOUCH, show_message = FALSE)
				break
			qdel(reactant_holder)
		playsound(loc, 'modular_septic/sound/effects/pee.ogg', 75)
		to_chat(src, span_warning("I piss on myself..."))
		return
	//try to evacuate 40u out of each bladder
	if(urinel)
		visible_message("<span class='notice'><b>[src]</b> pisses on [urinel].</span>", \
					"<span class='notice'>I take a piss on [urinel].")
		for(var/obj/item/organ/bladder/bladder as anything in bladders)
			var/amount = min(40, bladder.reagents.get_reagent_amount(/datum/reagent/consumable/piss) - bladder.food_reagents[/datum/reagent/consumable/piss])
			bladder.reagents.remove_reagent(/datum/reagent/consumable/piss, amount)
	else if(toiler)
		visible_message("<span class='notice'><b>[src]</b> pisses on [toiler].</span>", \
					"<span class='notice'>I take a piss on [toiler].")
		for(var/obj/item/organ/bladder/bladder as anything in bladders)
			var/amount = min(40, bladder.reagents.get_reagent_amount(/datum/reagent/consumable/piss) - bladder.food_reagents[/datum/reagent/consumable/piss])
			bladder.reagents.remove_reagent(/datum/reagent/consumable/piss, amount)
	else
		for(var/obj/item/organ/bladder/bladder as anything in bladders)
			var/amount = min(40, bladder.reagents.get_reagent_amount(/datum/reagent/consumable/piss) - bladder.food_reagents[/datum/reagent/consumable/piss])
			bladder.reagents.remove_reagent(/datum/reagent/consumable/piss, amount)
			pissed.add_liquid(/datum/reagent/consumable/piss, amount)
		visible_message("<span class='notice'><b>[src]</b> pisses on [pissed].</span>", \
					"<span class='notice'>I take a piss on [pissed].")
	playsound(loc, 'modular_septic/sound/effects/pee.ogg', 75)
