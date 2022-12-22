/mob/living/carbon/human/get_item_by_slot(slot_id)
	switch(slot_id)
		if(ITEM_SLOT_BACK)
			return back
		if(ITEM_SLOT_MASK)
			return wear_mask
		if(ITEM_SLOT_NECK)
			return wear_neck
		if(ITEM_SLOT_HANDCUFFED)
			return handcuffed
		if(ITEM_SLOT_LEGCUFFED)
			return legcuffed
		if(ITEM_SLOT_BELT)
			return belt
		if(ITEM_SLOT_ID)
			return wear_id
		if(ITEM_SLOT_EARS, ITEM_SLOT_LEAR)
			return ears
		if(ITEM_SLOT_REAR)
			return ears_extra
		if(ITEM_SLOT_EYES)
			return glasses
		if(ITEM_SLOT_GLOVES)
			return gloves
		if(ITEM_SLOT_WRISTS)
			return wrists
		if(ITEM_SLOT_HEAD)
			return head
		if(ITEM_SLOT_FEET)
			return shoes
		if(ITEM_SLOT_OCLOTHING)
			return wear_suit
		if(ITEM_SLOT_ICLOTHING)
			return w_uniform
		if(ITEM_SLOT_LPOCKET)
			return l_store
		if(ITEM_SLOT_RPOCKET)
			return r_store
		if(ITEM_SLOT_SUITSTORE)
			return s_store
	return null

//This is an UNSAFE proc. Use mob_can_equip() before calling this one! Or rather use equip_to_slot_if_possible() or advanced_equip_to_slot_if_possible()
// Initial is used to indicate whether or not this is the initial equipment (job datums etc) or just a player doing it
/mob/living/carbon/human/equip_to_slot(obj/item/I, slot, initial = FALSE, redraw_mob = FALSE, params)
	if(!..()) //a check failed or the item has already found its slot
		return

	var/not_handled = FALSE //Added in case we make this type path deeper one day
	switch(slot)
		if(ITEM_SLOT_BELT)
			if(belt)
				return
			belt = I
			update_inv_belt()
		if(ITEM_SLOT_ID)
			if(wear_id)
				return
			wear_id = I
			sec_hud_set_ID()
			update_inv_wear_id()
		if(ITEM_SLOT_EARS, ITEM_SLOT_LEAR)
			if(ears)
				return
			ears = I
			update_inv_ears()
		if(ITEM_SLOT_REAR)
			if(ears_extra)
				return
			ears_extra = I
			update_inv_ears()
		if(ITEM_SLOT_EYES)
			if(glasses)
				return
			glasses = I
			var/obj/item/clothing/glasses/G = I
			if(G.glass_colour_type)
				update_glasses_color(G, 1)
			if(G.tint)
				update_tint()
			if(G.vision_correction)
				clear_fullscreen("nearsighted")
			if(G.vision_flags || G.darkness_view || G.invis_override || G.invis_view || !isnull(G.lighting_alpha))
				update_sight()
			update_inv_glasses()
		if(ITEM_SLOT_GLOVES)
			if(gloves)
				return
			gloves = I
			update_inv_gloves()
		if(ITEM_SLOT_WRISTS)
			if(wrists)
				return
			wrists = I
			update_inv_wrists()
		if(ITEM_SLOT_FEET)
			if(shoes)
				return
			shoes = I
			update_inv_shoes()
		if(ITEM_SLOT_OCLOTHING)
			if(wear_suit)
				return

			wear_suit = I

			if(I.flags_inv & HIDEJUMPSUIT)
				update_inv_w_uniform()
			if(wear_suit.breakouttime) //when equipping a straightjacket
				ADD_TRAIT(src, TRAIT_RESTRAINED, SUIT_TRAIT)
				stop_pulling() //can't pull if restrained
				update_action_buttons_icon() //certain action buttons will no longer be usable.
			update_inv_wear_suit()
		if(ITEM_SLOT_ICLOTHING)
			if(w_uniform)
				return
			w_uniform = I
			update_suit_sensors()
			update_inv_w_uniform()
		if(ITEM_SLOT_LPOCKET)
			l_store = I
			update_inv_pockets()
		if(ITEM_SLOT_RPOCKET)
			r_store = I
			update_inv_pockets()
		if(ITEM_SLOT_SUITSTORE)
			if(s_store)
				return
			s_store = I
			update_inv_s_store()
		else
			to_chat(src, span_danger("You are trying to equip this item to an unsupported inventory slot. Report this to a coder!"))

	//Item is handled and in slot, valid to call callback, for this proc should always be true
	if(!not_handled)
		has_equipped(I, slot, initial)

		// Send a signal for when we equip an item that used to cover our feet/shoes. Used for bloody feet
		if((I.body_parts_covered & FEET) || (I.flags_inv | I.transparent_protection) & HIDESHOES)
			SEND_SIGNAL(src, COMSIG_CARBON_EQUIP_SHOECOVER, I, slot, initial, redraw_mob)

	return not_handled //For future deeper overrides
