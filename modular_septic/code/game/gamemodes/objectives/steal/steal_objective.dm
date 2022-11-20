/datum/objective/steal/find_target(dupe_search_range)
	var/list/datum/mind/owners = get_owners()
	if(!dupe_search_range)
		dupe_search_range = get_owners()
	var/approved_targets = list()
	for(var/datum/objective_item/possible_item in GLOB.possible_items)
		if(possible_item.disabled)
			continue
		if(!is_unique_objective(possible_item.targetitem,dupe_search_range))
			continue
		for(var/datum/mind/mind_owner in owners)
			if(mind_owner.current.mind.assigned_role.title in possible_item.excludefromjob)
				continue
		approved_targets += possible_item
	if(length(approved_targets))
		return set_target(pick(approved_targets))
	return set_target(null)
