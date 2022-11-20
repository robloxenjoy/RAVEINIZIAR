/mob/living/carbon/proc/shit(intentional = FALSE)
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
	//we'll try to shit a maximum of 40u from each bowel
	var/obj/item/shit/stool = new(loc)
	stool.add_shit_DNA(get_blood_dna_list())
	stool.reagents.remove_all(INFINITY)
	for(var/obj/item/organ/intestines/intestine as anything in intestines)
		intestine.reagents.trans_to(stool, 40, preserve_data = TRUE)
	var/obj/structure/toilet/toiler = locate() in loc
	if(toiler)
		//mess gone
		qdel(stool)
		visible_message(span_notice("<b>[src]</b> shits on [toiler]."), \
					span_notice("I take a shit on [toiler]."))
	else
		visible_message(span_notice("<b>[src]</b> shits on [loc]."), \
					span_notice("I take a shit on [loc]."))
	playsound(loc, 'modular_septic/sound/effects/poo.ogg', 75)

/mob/living/carbon/proc/piss(intentional = FALSE)
	var/list/bladders = getorganslotlist(ORGAN_SLOT_BLADDER)
	var/collective_piss_amount = 0
	for(var/obj/item/organ/bladder/bladder as anything in bladders)
		collective_piss_amount += bladder.reagents.get_reagent_amount(/datum/reagent/consumable/piss)
	if(collective_piss_amount < 15)
		if(intentional)
			to_chat(src, span_warning("I don't need to piss."))
		return
	var/turf/pissed = get_turf(src)
	//try to evacuate 40u out of each bladder
	var/obj/structure/toilet/toiler = locate() in loc
	var/obj/structure/urinal/urinel = locate() in loc
	if(urinel)
		visible_message(span_notice("<b>[src]</b> pisses on [urinel]."), \
					span_notice("I take a piss on [urinel]."))
		for(var/obj/item/organ/bladder/bladder as anything in bladders)
			var/amount = min(40, bladder.reagents.get_reagent_amount(/datum/reagent/consumable/piss) - bladder.food_reagents[/datum/reagent/consumable/piss])
			bladder.reagents.remove_reagent(/datum/reagent/consumable/piss, amount)
	else if(toiler)
		visible_message(span_notice("<b>[src]</b> pisses on [toiler]."), \
					span_notice("I take a piss on [toiler]."))
		for(var/obj/item/organ/bladder/bladder as anything in bladders)
			var/amount = min(40, bladder.reagents.get_reagent_amount(/datum/reagent/consumable/piss) - bladder.food_reagents[/datum/reagent/consumable/piss])
			bladder.reagents.remove_reagent(/datum/reagent/consumable/piss, amount)
	else
		for(var/obj/item/organ/bladder/bladder as anything in bladders)
			var/amount = min(40, bladder.reagents.get_reagent_amount(/datum/reagent/consumable/piss) - bladder.food_reagents[/datum/reagent/consumable/piss])
			bladder.reagents.remove_reagent(/datum/reagent/consumable/piss, amount)
			pissed.add_liquid(/datum/reagent/consumable/piss, amount)
		visible_message(span_notice("<b>[src]</b> pisses on [pissed]."), \
					span_notice("I take a piss on [pissed]."))
	playsound(loc, 'modular_septic/sound/effects/pee.ogg', 75)

/mob/living/carbon/proc/defecate()
	set name = "Defecate"
	set category = "IC.Hygiene"
	set desc = "Answer the call of nature."

	shit(TRUE)

/mob/living/carbon/proc/urinate()
	set name = "Urinate"
	set category = "IC.Hygiene"
	set desc = "Answer the call of nature."

	piss(TRUE)
