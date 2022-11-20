/proc/setup_interactions()
	. = list()
	for(var/category in INTERACTION_CATEGORY_ORDER)
		for(var/thing in subtypesof(/datum/interaction))
			var/datum/interaction/new_interaction = thing
			if(!initial(new_interaction.name) || (initial(new_interaction.category) != category))
				continue
			new_interaction = new thing()
			.[new_interaction.name] = new_interaction
