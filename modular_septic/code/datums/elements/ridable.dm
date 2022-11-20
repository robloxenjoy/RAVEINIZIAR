/obj/item/riding_offhand
	icon = 'modular_septic/icons/hud/quake/grab.dmi'
	icon_state = "offhand"
	base_icon_state = "offhand"
	carry_weight = 0
	slot_flags = NONE
	layer = LOW_ITEM_LAYER

// Outline looks weird on offhand
/obj/item/riding_offhand/apply_outline(outline_color)
	return

/obj/item/riding_offhand/on_thrown(mob/living/carbon/user, atom/target)
	if(rider == user)
		return //Piggyback user.
	user.unbuckle_mob(rider)
	if(HAS_TRAIT(user, TRAIT_PACIFISM))
		to_chat(user, span_notice("I gently let go of [rider]."))
		return
	return rider
