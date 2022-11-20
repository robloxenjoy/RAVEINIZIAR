/obj/item/organ/cyberimp/brain/anti_drop
	name = "anti-drop implant"
	desc = "This cybernetic brain implant will allow you to force your hand muscles to contract, preventing item dropping. Twitch ear to toggle."
	implant_overlay_color = "#DE7E00"
	actions_types = list(/datum/action/item_action/organ_action/toggle)
	var/active = 0
	var/list/stored_items = list()

/obj/item/organ/cyberimp/brain/anti_drop/ui_action_click()
	active = !active
	if(active)
		for(var/obj/item/I in owner.held_items)
			stored_items += I

		var/list/L = owner.get_empty_held_indexes()
		if(LAZYLEN(L) == owner.held_items.len)
			to_chat(owner, span_notice("You are not holding any items, your hands relax..."))
			active = 0
			stored_items = list()
		else
			for(var/obj/item/I in stored_items)
				to_chat(owner, span_notice("Your [owner.get_held_index_name(owner.get_held_index_of_item(I))]'s grip tightens."))
				ADD_TRAIT(I, TRAIT_NODROP, IMPLANT_TRAIT)

	else
		release_items()
		to_chat(owner, span_notice("Your hands relax..."))

/obj/item/organ/cyberimp/brain/anti_drop/emp_act(severity)
	. = ..()
	if(!owner || . & EMP_PROTECT_SELF)
		return
	var/range = severity ? 10 : 5
	var/atom/A
	if(active)
		release_items()
	for(var/obj/item/I in stored_items)
		A = pick(oview(range))
		I.throw_at(A, range, 2)
		to_chat(owner, span_warning("Your [owner.get_held_index_name(owner.get_held_index_of_item(I))] spasms and throws the [I.name]!"))
	stored_items = list()

/obj/item/organ/cyberimp/brain/anti_drop/proc/release_items()
	for(var/obj/item/I in stored_items)
		REMOVE_TRAIT(I, TRAIT_NODROP, IMPLANT_TRAIT)
	stored_items = list()

/obj/item/organ/cyberimp/brain/anti_drop/Remove(mob/living/carbon/old_owner, special = 0)
	if(active)
		ui_action_click()
	return ..()
