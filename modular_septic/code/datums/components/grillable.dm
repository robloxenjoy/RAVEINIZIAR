/datum/component/grillable
	var/pollutant_type

/datum/component/grillable/Initialize(cook_result, required_cook_time, positive_result, use_large_steam_sprite, pollutant_type)
	if(!isitem(parent)) //Only items support grilling at the moment
		return COMPONENT_INCOMPATIBLE

	src.cook_result = cook_result
	src.required_cook_time = required_cook_time
	src.positive_result = positive_result
	src.use_large_steam_sprite = use_large_steam_sprite
	src.pollutant_type = pollutant_type

	RegisterSignal(parent, COMSIG_ITEM_GRILLED, .proc/OnGrill)
	RegisterSignal(parent, COMSIG_PARENT_EXAMINE, .proc/OnExamine)

/datum/component/grillable/OnGrill(datum/source, atom/used_grill, delta_time = 1)
	. = COMPONENT_HANDLED_GRILLING

	if(pollutant_type)
		var/turf/parent_turf = get_turf(parent)
		parent_turf.pollute_turf(pollutant_type, 10)
	current_cook_time += delta_time * 10 //turn it into ds
	if(current_cook_time >= required_cook_time)
		FinishGrilling(used_grill)
	else if(!currently_grilling) //We havn't started grilling yet
		StartGrilling(used_grill)
