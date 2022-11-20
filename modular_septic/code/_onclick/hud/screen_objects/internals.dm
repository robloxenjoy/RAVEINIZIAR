/atom/movable/screen/internals
	icon = 'modular_septic/icons/hud/quake/screen_quake.dmi'
	screen_loc = ui_internal

/atom/movable/screen/internals/Click(location, control, params)
	. = ..()
	if(!iscarbon(usr))
		return
	var/mob/living/carbon/C = usr
	var/list/modifiers = params2list(params)
	if(LAZYACCESS(modifiers, RIGHT_CLICK))
		var/obj/item/tank/internal = C.internal
		if(istype(internal))
			to_chat(C, span_alert("I am not running on internals."))
		else
			internal.examine(C)
		return
	if(C.incapacitated())
		return

	if(C.internal)
		C.internal = null
		to_chat(C, span_notice("You are no longer running on internals."))
		icon_state = "internal0"
	else
		if(!C.getorganslot(ORGAN_SLOT_BREATHING_TUBE))
			if(!istype(C.wear_mask, /obj/item/clothing/mask))
				to_chat(C, span_warning("You are not wearing an internals mask!"))
				return 1
			else
				var/obj/item/clothing/mask/M = C.wear_mask
				if(M.mask_adjusted) // if mask on face but pushed down
					M.adjustmask(C) // adjust it back
				if( !(M.clothing_flags & MASKINTERNALS) )
					to_chat(C, span_warning("You are not wearing an internals mask!"))
					return

		var/obj/item/I = C.is_holding_item_of_type(/obj/item/tank)
		if(I)
			to_chat(C, span_notice("You are now running on internals from [I] in your [C.get_held_index_name(C.get_held_index_of_item(I))]."))
			C.internal = I
		else if(ishuman(C))
			var/mob/living/carbon/human/H = C
			if(istype(H.s_store, /obj/item/tank))
				to_chat(H, span_notice("You are now running on internals from [H.s_store] on your [H.wear_suit.name]."))
				H.internal = H.s_store
			else if(istype(H.belt, /obj/item/tank))
				to_chat(H, span_notice("You are now running on internals from [H.belt] on your belt."))
				H.internal = H.belt
			else if(istype(H.l_store, /obj/item/tank))
				to_chat(H, span_notice("You are now running on internals from [H.l_store] in your left pocket."))
				H.internal = H.l_store
			else if(istype(H.r_store, /obj/item/tank))
				to_chat(H, span_notice("You are now running on internals from [H.r_store] in your right pocket."))
				H.internal = H.r_store

		//Separate so CO2 jetpacks are a little less cumbersome.
		if(!C.internal && istype(C.back, /obj/item/tank))
			to_chat(C, span_notice("You are now running on internals from [C.back] on your back."))
			C.internal = C.back

		if(C.internal)
			icon_state = "internal1"
		else
			to_chat(C, span_warning("You don't have an oxygen tank!"))
			return
	C.update_action_buttons_icon()
