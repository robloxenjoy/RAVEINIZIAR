/// Middleware to handle augmentations
/datum/preference_middleware/augments
	action_delegations = list(
		"add_augment" = .proc/add_augment,
		"remove_augment" = .proc/remove_augment,
		"set_augment_style" = .proc/set_augment_style,
	)

/datum/preference_middleware/augments/New(datum/preferences)
	. = ..()
	// Run this at least once to verify if everything is valid here
	if(src.preferences)
		get_ui_data()

/datum/preference_middleware/augments/on_new_character(mob/user)
	. = ..()
	if(preferences.tainted_character_profiles)
		preferences.augments = list()
		preferences.augment_styles = list()
	// Run this at least once to verify if everything is valid here
	get_ui_data()

/datum/preference_middleware/augments/get_ui_data(mob/user)
	var/list/data = list()

	// How?
	if(!islist(preferences.augments))
		preferences.augments = list()
	if(!islist(preferences.augment_styles))
		preferences.augment_styles = list()

	var/augment_balance = preferences.GetQuirkBalance()
	// Something is fucked
	if(augment_balance < 0)
		preferences.augments = list()
		preferences.augment_styles = list()
		augment_balance = preferences.GetQuirkBalance()
	var/list/unselected_augments = list()
	for(var/category in GLOB.augment_categories_to_slots_to_items)
		var/list/this_category = list()
		var/list/this_category_slots = list()

		this_category["name"] = category

		for(var/slot in GLOB.augment_categories_to_slots_to_items[category])
			var/list/this_slot = list()
			var/list/this_slot_items = list()

			this_slot["name"] = slot

			for(var/item_type in GLOB.augment_categories_to_slots_to_items[category][slot])
				if(preferences.augments[slot] == item_type)
					continue
				var/list/this_item = list()

				var/datum/augment_item/augment_item = GLOB.augment_item_datums[item_type]
				this_item["category"] = augment_item.category
				this_item["slot"] = augment_item.slot
				this_item["name"] = augment_item.name
				this_item["description"] = augment_item.description
				this_item["can_use_styles"] = augment_item.uses_robotic_styles
				this_item["value"] = augment_item.value
				this_item["cant_buy"] = (LAZYACCESS(preferences.augments, slot) ? "Slot occupied!" : ((augment_balance-augment_item.value < 0) ? "Not enough points!" : "") )

				this_slot_items += list(this_item)

			this_slot["items"] = this_slot_items
			this_category_slots += list(this_slot)

		this_category["slots"] = this_category_slots
		unselected_augments += list(this_category)
	var/list/our_augments = list()
	for(var/slot in preferences.augments)
		var/list/this_slot = list()
		var/list/this_slot_item = list()
		var/datum/augment_item/augment_item = GLOB.augment_item_datums[preferences.augments[slot]]

		this_slot_item["category"] = augment_item.category
		this_slot_item["slot"] = augment_item.slot
		this_slot_item["name"] = augment_item.name
		this_slot_item["description"] = augment_item.description
		this_slot_item["can_use_styles"] = augment_item.uses_robotic_styles
		this_slot_item["value"] = augment_item.value
		this_slot_item["cant_buy"] = ((augment_balance+augment_item.value < 0) ? "Not enough points!" : "") //we already bought it, so this means we cannot remove it

		this_slot["name"] = slot
		this_slot["item"] = this_slot_item

		our_augments += list(this_slot)
	var/list/unselected_augments_styles = list()
	for(var/style in GLOB.robotic_styles_list)
		unselected_augments_styles += style
	var/list/our_augment_styles = list()
	for(var/slot in preferences.augment_styles)
		our_augment_styles[slot] = preferences.augment_styles[slot]
	data["selected_augments"] = our_augments
	data["selected_augments_styles"] = our_augment_styles
	data["unselected_augments"] = unselected_augments
	data["unselected_augments_styles"] = unselected_augments_styles
	data["augment_balance"] = augment_balance
	return data

/datum/preference_middleware/augments/apply_to_human(mob/living/carbon/human/target, datum/preferences/preferences)
	for(var/slot in preferences.augments)
		var/augment_type = preferences.augments[slot]
		var/datum/augment_item/augment_item = GLOB.augment_item_datums[augment_type]
		augment_item.apply_to_human(target, FALSE, preferences)

/datum/preference_middleware/augments/proc/add_augment(list/params, mob/user)
	var/augment_category = params["augment_category"]
	var/augment_slot = params["augment_slot"]
	var/augment_name = params["augment_item"]
	var/augment_balance = preferences.GetQuirkBalance()
	for(var/augment_type in GLOB.augment_categories_to_slots_to_items[augment_category][augment_slot])
		var/datum/augment_item/augment_item = GLOB.augment_item_datums[augment_type]
		if(augment_item.name == augment_name)
			if((augment_balance-augment_item.value) >= 0)
				preferences.augments[augment_slot] = augment_type
	return TRUE

/datum/preference_middleware/augments/proc/remove_augment(list/params, mob/user)
	var/augment_slot = params["augment_slot"]
	var/augment_balance = preferences.GetQuirkBalance()
	for(var/slot in preferences.augments)
		if(slot == augment_slot)
			var/datum/augment_item/augment_item = GLOB.augment_item_datums[preferences.augments[slot]]
			if((augment_balance+augment_item.value) >= 0)
				preferences.augments -= augment_slot
				preferences.augment_styles -= augment_slot
				return TRUE

/datum/preference_middleware/augments/proc/set_augment_style(list/params, mob/user)
	var/augment_slot = params["augment_slot"]
	var/augment_style = params["augment_style"]
	if(augment_style == "None")
		preferences.augment_styles -= augment_slot
	else
		preferences.augment_styles[augment_slot] = augment_style
	return TRUE
