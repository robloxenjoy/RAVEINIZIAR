/atom/movable/screen/inventory
	icon = 'modular_septic/icons/hud/quake/screen_quake.dmi'
	icon_full = "occupied"

/atom/movable/screen/inventory/add_overlays()
	var/mob/user = hud?.mymob

	if(!user || !slot_id)
		return

	var/obj/item/our_item = user.get_item_by_slot(slot_id)
	if(our_item)
		our_item.apply_outline()
		return

	var/obj/item/holding = user.get_active_held_item()
	if(!holding)
		return

	var/image/item_overlay = image(holding)
	item_overlay.alpha = 128
	if(!user.can_equip(holding, slot_id, disable_warning = TRUE, bypass_equip_delay_self = TRUE))
		item_overlay.color = "#FF0000"
	else
		item_overlay.color = "#00FF00"
	item_overlay.filters += filter("outline", size = 1, color = item_overlay.color)

	cut_overlay(object_overlay)
	object_overlay = item_overlay
	add_overlay(object_overlay)

/atom/movable/screen/inventory/MouseExited()
	. = ..()
	var/mob/user = hud?.mymob
	if(slot_id)
		var/obj/item/our_item = user?.get_item_by_slot(slot_id)
		if(our_item)
			our_item.remove_filter("hover_outline")

/atom/movable/screen/inventory/hand
	icon = 'modular_septic/icons/hud/quake/screen_quake.dmi'
	icon_full = null

/atom/movable/screen/inventory/hand/update_icon_state()
	. = ..()
	if(!hud?.mymob)
		return
	icon_state = "hand_[hud.mymob.held_index_to_dir(held_index)]"
	var/obj/item/held_item = hud.mymob.get_active_held_item()
	if(held_item && SEND_SIGNAL(held_item, COMSIG_TWOHANDED_WIELD_CHECK))
		icon_state = "[icon_state]_wielded"

/atom/movable/screen/inventory/hand/update_overlays()
	. = ..()
	if(!hud?.mymob)
		return
	var/obj/item/held_item = hud.mymob.get_active_held_item()
	if(held_item && SEND_SIGNAL(held_item, COMSIG_TWOHANDED_WIELD_CHECK))
		if(!(held_index % RIGHT_HANDS))
			. += "hand_r_active"
		else
			. += "hand_l_active"
	else if(held_index == hud.mymob.active_hand_index)
		. += "hand_active"
