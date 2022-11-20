/datum/species/can_equip(obj/item/I, slot, disable_warning, mob/living/carbon/human/H, bypass_equip_delay_self = FALSE)
	if(slot in no_equip)
		if(!I.species_exception || !is_type_in_list(src, I.species_exception))
			return FALSE

	// if there's an item in the slot we want, fail
	if(H.get_item_by_slot(slot))
		return FALSE

	// this check prevents us from equipping something to a slot it doesn't support, WITH the exceptions of storage slots (pockets, and backpacks)
	// we don't require having those slots defined in the item's slot_flags, so we'll rely on their own checks further down
	if(!(I.slot_flags & slot))
		var/excused = FALSE
		// Anything that's small or smaller can fit into a pocket by default
		if((slot == ITEM_SLOT_RPOCKET || slot == ITEM_SLOT_LPOCKET) && I.w_class <= WEIGHT_CLASS_SMALL)
			excused = TRUE
		else if(slot == ITEM_SLOT_BACKPACK || slot == ITEM_SLOT_HANDS)
			excused = TRUE
		else if((slot == ITEM_SLOT_SUITSTORE) && (I.slot_flags & ITEM_SLOT_BACK))
			excused = TRUE
		if(!excused)
			return FALSE

	switch(slot)
		if(ITEM_SLOT_HANDS)
			if(H.get_empty_held_indexes())
				return TRUE
			return FALSE
		if(ITEM_SLOT_MASK)
			if(!H.get_bodypart_nostump(check_zone(BODY_ZONE_PRECISE_FACE)))
				return FALSE
			return equip_delay_self_check(I, H, bypass_equip_delay_self)
		if(ITEM_SLOT_NECK)
			if(!H.get_bodypart_nostump(check_zone(BODY_ZONE_PRECISE_NECK)))
				return FALSE
			return equip_delay_self_check(I, H, bypass_equip_delay_self)
		if(ITEM_SLOT_BACK)
			return equip_delay_self_check(I, H, bypass_equip_delay_self)
		if(ITEM_SLOT_OCLOTHING)
			return equip_delay_self_check(I, H, bypass_equip_delay_self)
		if(ITEM_SLOT_GLOVES)
			return equip_delay_self_check(I, H, bypass_equip_delay_self)
		if(ITEM_SLOT_RWRIST)
			return equip_delay_self_check(I, H, bypass_equip_delay_self)
		if(ITEM_SLOT_LWRIST)
			return equip_delay_self_check(I, H, bypass_equip_delay_self)
		if(ITEM_SLOT_FEET)
			if(H.num_legs < H.default_num_legs)
				return FALSE
			if(DIGITIGRADE in species_traits)
				if(!disable_warning)
					to_chat(H, span_warning("The footwear around here isn't compatible with your feet!"))
				return FALSE
			return equip_delay_self_check(I, H, bypass_equip_delay_self)
		if(ITEM_SLOT_BELT)
			var/obj/item/bodypart/O = H.get_bodypart_nostump(check_zone(BODY_ZONE_PRECISE_GROIN))
			if(!H.w_uniform && !nojumpsuit && (!O || O.status != BODYPART_ROBOTIC))
				if(!disable_warning)
					to_chat(H, span_warning("You need a jumpsuit before you can attach this [I.name]!"))
				return FALSE
			return equip_delay_self_check(I, H, bypass_equip_delay_self)
		if(ITEM_SLOT_EYES)
			if(!H.get_bodypart_nostump(check_zone(BODY_ZONE_PRECISE_FACE)))
				return FALSE
			for(var/thing in H.getorganslotlist(ORGAN_SLOT_EYES))
				var/obj/item/organ/eyes/E = thing
				if(E.no_glasses)
					return FALSE
			return equip_delay_self_check(I, H, bypass_equip_delay_self)
		if(ITEM_SLOT_HEAD)
			if(!H.get_bodypart_nostump(check_zone(BODY_ZONE_HEAD)))
				return FALSE
			return equip_delay_self_check(I, H, bypass_equip_delay_self)
		if(ITEM_SLOT_EARS, ITEM_SLOT_LEAR, ITEM_SLOT_REAR)
			if(!H.get_bodypart_nostump(check_zone(BODY_ZONE_PRECISE_FACE)))
				return FALSE
			return equip_delay_self_check(I, H, bypass_equip_delay_self)
		if(ITEM_SLOT_ICLOTHING)
			return equip_delay_self_check(I, H, bypass_equip_delay_self)
		if(ITEM_SLOT_ID)
			var/obj/item/bodypart/O = H.get_bodypart_nostump(check_zone(BODY_ZONE_CHEST))
			if(!H.w_uniform && !nojumpsuit && (!O || O.status != BODYPART_ROBOTIC))
				if(!disable_warning)
					to_chat(H, span_warning("You need a jumpsuit before you can attach this [I.name]!"))
				return FALSE
			return equip_delay_self_check(I, H, bypass_equip_delay_self)
		if(ITEM_SLOT_LPOCKET)
			if(HAS_TRAIT(I, TRAIT_NODROP)) //Pockets aren't visible, so you can't move TRAIT_NODROP items into them.
				return FALSE
			if(H.l_store) // no pocket swaps at all
				return FALSE
			var/obj/item/bodypart/O = H.get_bodypart_nostump(check_zone(BODY_ZONE_L_LEG))
			if(!H.w_uniform && !nojumpsuit && (!O || O.status != BODYPART_ROBOTIC))
				if(!disable_warning)
					to_chat(H, span_warning("You need a jumpsuit before you can pocket this [I.name]!"))
				return FALSE
			return TRUE
		if(ITEM_SLOT_RPOCKET)
			if(HAS_TRAIT(I, TRAIT_NODROP))
				return FALSE
			if(H.r_store)
				return FALSE
			var/obj/item/bodypart/O = H.get_bodypart_nostump(check_zone(BODY_ZONE_R_LEG))
			if(!H.w_uniform && !nojumpsuit && (!O || O.status != BODYPART_ROBOTIC))
				if(!disable_warning)
					to_chat(H, span_warning("You need a jumpsuit before you can pocket this [I.name]!"))
				return FALSE
			return TRUE
		if(ITEM_SLOT_SUITSTORE)
			if(HAS_TRAIT(I, TRAIT_NODROP))
				return FALSE
			if(!H.get_bodypart_nostump(check_zone(BODY_ZONE_CHEST)))
				return FALSE
			return equip_delay_self_check(I, H, bypass_equip_delay_self)
		if(ITEM_SLOT_HANDCUFFED)
			if(!istype(I, /obj/item/restraints/handcuffs))
				return FALSE
			if(H.num_hands < H.default_num_hands)
				return FALSE
			return TRUE
		if(ITEM_SLOT_LEGCUFFED)
			if(!istype(I, /obj/item/restraints/legcuffs))
				return FALSE
			if(H.num_legs < H.default_num_legs)
				return FALSE
			return TRUE
		if(ITEM_SLOT_BACKPACK)
			if(H.back && SEND_SIGNAL(H.back, COMSIG_TRY_STORAGE_CAN_INSERT, I, H, bypass_equip_delay_self, FALSE, bypass_equip_delay_self))
				return TRUE
			return FALSE
	return FALSE //Unsupported slot
