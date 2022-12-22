// Return the item currently in the slot ID
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
