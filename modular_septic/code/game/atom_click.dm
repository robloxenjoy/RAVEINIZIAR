/atom/tool_act(mob/living/user, obj/item/tool, tool_type, list/modifiers)
	var/act_result
	var/signal_result
	if(LAZYACCESS(modifiers, MIDDLE_CLICK))
		signal_result = SEND_SIGNAL(src, COMSIG_ATOM_TERTIARY_TOOL_ACT(tool_type), user, tool)
		if(signal_result & COMPONENT_BLOCK_TOOL_ATTACK) // The COMSIG_ATOM_TOOL_ACT signal is blocking the act
			return TOOL_ACT_SIGNAL_BLOCKING
		switch(tool_type)
			if(TOOL_CROWBAR)
				act_result = crowbar_act_secondary(user, tool)
			if(TOOL_MULTITOOL)
				act_result = multitool_act_secondary(user, tool)
			if(TOOL_SCREWDRIVER)
				act_result = screwdriver_act_secondary(user, tool)
			if(TOOL_WRENCH)
				act_result = wrench_act_secondary(user, tool)
			if(TOOL_WIRECUTTER)
				act_result = wirecutter_act_secondary(user, tool)
			if(TOOL_WELDER)
				act_result = welder_act_secondary(user, tool)
			if(TOOL_ANALYZER)
				act_result = analyzer_act_secondary(user, tool)
	else if(LAZYACCESS(modifiers, RIGHT_CLICK))
		signal_result = SEND_SIGNAL(src, COMSIG_ATOM_SECONDARY_TOOL_ACT(tool_type), user, tool)
		if(signal_result & COMPONENT_BLOCK_TOOL_ATTACK) // The COMSIG_ATOM_TOOL_ACT signal is blocking the act
			return TOOL_ACT_SIGNAL_BLOCKING
		switch(tool_type)
			if(TOOL_CROWBAR)
				act_result = crowbar_act_secondary(user, tool)
			if(TOOL_MULTITOOL)
				act_result = multitool_act_secondary(user, tool)
			if(TOOL_SCREWDRIVER)
				act_result = screwdriver_act_secondary(user, tool)
			if(TOOL_WRENCH)
				act_result = wrench_act_secondary(user, tool)
			if(TOOL_WIRECUTTER)
				act_result = wirecutter_act_secondary(user, tool)
			if(TOOL_WELDER)
				act_result = welder_act_secondary(user, tool)
			if(TOOL_ANALYZER)
				act_result = analyzer_act_secondary(user, tool)
	else
		var/list/processing_recipes = list() //List of recipes that can be mutated by sending the signal
		signal_result = SEND_SIGNAL(src, COMSIG_ATOM_TOOL_ACT(tool_type), user, tool, processing_recipes)
		if(signal_result & COMPONENT_BLOCK_TOOL_ATTACK) // The COMSIG_ATOM_TOOL_ACT signal is blocking the act
			return TOOL_ACT_SIGNAL_BLOCKING
		if(processing_recipes.len)
			process_recipes(user, tool, processing_recipes)
		if(QDELETED(tool))
			return TRUE
		switch(tool_type)
			if(TOOL_CROWBAR)
				act_result = crowbar_act(user, tool)
			if(TOOL_MULTITOOL)
				act_result = multitool_act(user, tool)
			if(TOOL_SCREWDRIVER)
				act_result = screwdriver_act(user, tool)
			if(TOOL_WRENCH)
				act_result = wrench_act(user, tool)
			if(TOOL_WIRECUTTER)
				act_result = wirecutter_act(user, tool)
			if(TOOL_WELDER)
				act_result = welder_act(user, tool)
			if(TOOL_ANALYZER)
				act_result = analyzer_act(user, tool)
	if(act_result) // A tooltype_act has completed successfully
		return TOOL_ACT_TOOLTYPE_SUCCESS

/atom/proc/attack_hand_tertiary(mob/living/user, list/modifiers)
	if(SEND_SIGNAL(src, COMSIG_ATOM_ATTACK_HAND_TERTIARY, user, modifiers) & COMPONENT_CANCEL_ATTACK_CHAIN)
		return TERTIARY_ATTACK_CANCEL_ATTACK_CHAIN
	// for tertiary attacks, we cancel the attack by default

	return TERTIARY_ATTACK_CANCEL_ATTACK_CHAIN

/// Called on an object when a tool with crowbar capabilities is used to middle click an object
/atom/proc/crowbar_act_tertiary(mob/living/user, obj/item/tool)
	return

/// Called on an object when a tool with multitool capabilities is used to middle click an object
/atom/proc/multitool_act_tertiary(mob/living/user, obj/item/tool)
	return

/// Called on an object when a tool with screwdriver capabilities is used to middle click an object
/atom/proc/screwdriver_act_tertiary(mob/living/user, obj/item/tool)
	return

/// Called on an object when a tool with wrench capabilities is used to middle click an object
/atom/proc/wrench_act_tertiary(mob/living/user, obj/item/tool)
	return

/// Called on an object when a tool with wirecutter capabilities is used to middle click an object
/atom/proc/wirecutter_act_tertiary(mob/living/user, obj/item/tool)
	return

/// Called on an object when a tool with welder capabilities is used to middle click an object
/atom/proc/welder_act_tertiary(mob/living/user, obj/item/tool)
	return

/// Called on an object when a tool with analyzer capabilities is used to middle click an object
/atom/proc/analyzer_act_tertiary(mob/living/user, obj/item/tool)
	return
