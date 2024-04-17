/mob/living/carbon/proc/shit(intentional = FALSE)
	var/list/intestines = getorganslotlist(ORGAN_SLOT_INTESTINES)
	var/intestinal_efficiency = getorganslotefficiency(ORGAN_SLOT_INTESTINES)
	if(!LAZYLEN(intestines))
		if(intentional)
			to_chat(src, span_warning("У меня нет кишок."))
		return
	if(intestinal_efficiency < ORGAN_FAILING_EFFICIENCY)
		if(intentional)
			to_chat(src, span_userdanger("Мои кишки спазмируют пытаясь хоть чё-то высрать!"))
		return
	var/collective_shit_amount = 0
	for(var/obj/item/organ/intestines/intestine as anything in intestines)
		collective_shit_amount += intestine.reagents.get_reagent_amount(/datum/reagent/consumable/shit)
	if(collective_shit_amount < 10)
		if(intentional)
			to_chat(src, span_warning("Мне щас не нужно срать."))
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
		visible_message(span_notice("<b>[src]</b> срёт в [toiler]."), \
					span_notice("Я сру в [toiler]."))
	else
		visible_message(span_notice("<b>[src]</b> срёт на [loc]."), \
					span_notice("Я сру на [loc]."))
	playsound(loc, 'modular_septic/sound/effects/poo.ogg', 75)

/mob/living/carbon/proc/piss(intentional = FALSE)
	var/list/bladders = getorganslotlist(ORGAN_SLOT_BLADDER)
	var/collective_piss_amount = 0
	for(var/obj/item/organ/bladder/bladder as anything in bladders)
		collective_piss_amount += bladder.reagents.get_reagent_amount(/datum/reagent/consumable/piss)
	if(collective_piss_amount < 15)
		if(intentional)
			to_chat(src, span_warning("Ссать мне щас не нужно."))
		return
	var/turf/pissed = get_turf(src)
	//try to evacuate 40u out of each bladder
	var/obj/structure/toilet/toiler = locate() in loc
	var/obj/structure/urinal/urinel = locate() in loc
	if(urinel)
		visible_message(span_notice("<b>[src]</b> ссыт в [urinel]."), \
					span_notice("Я ссу в [urinel]."))
		for(var/obj/item/organ/bladder/bladder as anything in bladders)
			var/amount = min(40, bladder.reagents.get_reagent_amount(/datum/reagent/consumable/piss) - bladder.food_reagents[/datum/reagent/consumable/piss])
			bladder.reagents.remove_reagent(/datum/reagent/consumable/piss, amount)
	else if(toiler)
		visible_message(span_notice("<b>[src]</b> ссыт в [toiler]."), \
					span_notice("Я ссу в [toiler]."))
		for(var/obj/item/organ/bladder/bladder as anything in bladders)
			var/amount = min(40, bladder.reagents.get_reagent_amount(/datum/reagent/consumable/piss) - bladder.food_reagents[/datum/reagent/consumable/piss])
			bladder.reagents.remove_reagent(/datum/reagent/consumable/piss, amount)
	else
		for(var/obj/item/organ/bladder/bladder as anything in bladders)
			var/amount = min(40, bladder.reagents.get_reagent_amount(/datum/reagent/consumable/piss) - bladder.food_reagents[/datum/reagent/consumable/piss])
			bladder.reagents.remove_reagent(/datum/reagent/consumable/piss, amount)
			pissed.add_liquid(/datum/reagent/consumable/piss, amount)
		visible_message(span_notice("<b>[src]</b> ссыт на [pissed]."), \
					span_notice("Я ссу на [pissed]."))
	playsound(loc, 'modular_septic/sound/effects/pee.ogg', 75)

/mob/living/carbon/proc/defecate()
	set name = "Посрать"
	set category = "IC.Гигиена"
	set desc = "Answer the call of nature."

	shit(TRUE)

/mob/living/carbon/proc/urinate()
	set name = "Поссать"
	set category = "IC.Гигиена"
	set desc = "Answer the call of nature."

	piss(TRUE)
