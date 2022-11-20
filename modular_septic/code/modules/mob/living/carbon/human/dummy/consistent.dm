/mob/living/carbon/human/dummy/consistent/update_inv_gloves()
	remove_overlay(GLOVES_LAYER)

	if(client && hud_used?.inv_slots[TOBITSHIFT(ITEM_SLOT_GLOVES) + 1])
		var/atom/movable/screen/inventory/inv = hud_used.inv_slots[TOBITSHIFT(ITEM_SLOT_GLOVES) + 1]
		inv.update_appearance()

	if(num_hands > 0)
		if(!gloves && blood_in_hands)
			var/mutable_appearance/bloody_overlay = mutable_appearance('modular_septic/icons/effects/blood.dmi', "bloodyhands", -GLOVES_LAYER)
			if(num_hands < 2)
				if(has_left_hand(FALSE))
					bloody_overlay.icon_state = "bloodyhands_left"
				else if(has_right_hand(FALSE))
					bloody_overlay.icon_state = "bloodyhands_right"

			overlays_standing[GLOVES_LAYER] = bloody_overlay

	var/mutable_appearance/gloves_overlay = overlays_standing[GLOVES_LAYER]
	if(gloves)
		gloves.screen_loc = ui_gloves
		if(client && hud_used?.hud_shown)
			if(hud_used.inventory_shown)
				client.screen += gloves
		update_observer_view(gloves,1)
		overlays_standing[GLOVES_LAYER] = gloves.build_worn_icon(default_layer = GLOVES_LAYER, default_icon_file = 'icons/mob/clothing/hands.dmi')
		gloves_overlay = overlays_standing[GLOVES_LAYER]
	overlays_standing[GLOVES_LAYER] = gloves_overlay
	apply_overlay(GLOVES_LAYER)
