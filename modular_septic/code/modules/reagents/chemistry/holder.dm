/datum/reagents/add_reagent_list(list/list_reagents, list/data, no_react = FALSE)
	for(var/r_id in list_reagents)
		var/amt = list_reagents[r_id]
		add_reagent(r_id, amt, data, no_react = no_react)

/datum/reagents/copy_to(obj/target, amount=1, multiplier=1, preserve_data=1, no_react=0)
	var/list/cached_reagents = reagent_list
	if(!target || !total_volume)
		return

	var/datum/reagents/R
	if(istype(target, /datum/reagents))
		R = target
	else
		if(!target.reagents)
			return
		R = target.reagents

	if(amount < 0)
		return

	amount = min(min(amount, total_volume), R.maximum_volume-R.total_volume)
	var/part = amount / total_volume
	var/trans_data = null
	for(var/datum/reagent/reagent as anything in cached_reagents)
		var/copy_amount = reagent.volume * part
		if(preserve_data)
			trans_data = reagent.data
		R.add_reagent(reagent.type, copy_amount * multiplier, trans_data, added_purity = reagent.purity, added_ph = reagent.ph, no_react = TRUE, ignore_splitting = reagent.chemical_flags & REAGENT_DONOTSPLIT)

	//pass over previous ongoing reactions before handle_reactions is called
	transfer_reactions(R)

	src.update_total()
	R.update_total()
	if(!no_react)
		R.handle_reactions()
		src.handle_reactions()
	return amount

/datum/reagents/proc/get_total_accelerant_quality()
	var/quality = 0
	for(var/i in reagent_list)
		var/datum/reagent/reagent = i
		quality += reagent.volume * reagent.accelerant_quality
	return quality
