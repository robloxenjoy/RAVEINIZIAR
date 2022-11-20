/mob/living/carbon/update_inv_hands()
	remove_overlay(HANDS_LAYER)
	if(handcuffed)
		drop_all_held_items()
		return

	var/list/hands = list()
	for(var/obj/item/held_item in held_items)
		if(client && hud_used && hud_used.hud_version != HUD_STYLE_NOHUD)
			held_item.screen_loc = ui_hand_position(get_held_index_of_item(held_item))
			if(SEND_SIGNAL(held_item, COMSIG_TWOHANDED_WIELD_CHECK))
				wield_ui_on()
			client.screen += held_item
			if(length(observers))
				for(var/mob/dead/observe as anything in observers)
					if(observe.client && observe.client.eye == src)
						observe.client.screen += held_item
					else
						observers -= observe
						if(!observers.len)
							observers = null
							break

		var/icon_file = held_item.lefthand_file
		if(!(get_held_index_of_item(held_item) % RIGHT_HANDS))
			icon_file = held_item.righthand_file

		hands += held_item.build_worn_icon(default_layer = HANDS_LAYER, default_icon_file = icon_file, isinhands = TRUE)

	if(length(hands))
		overlays_standing[HANDS_LAYER] = hands

	apply_overlay(HANDS_LAYER)

/mob/living/carbon/update_inv_head()
	remove_overlay(HEAD_LAYER)

	//Decapitated
	if(!get_bodypart_nostump(BODY_ZONE_HEAD))
		return

	if(client && hud_used && hud_used.inv_slots[TOBITSHIFT(ITEM_SLOT_BACK) + 1])
		var/atom/movable/screen/inventory/inv = hud_used.inv_slots[TOBITSHIFT(ITEM_SLOT_HEAD) + 1]
		inv.update_icon()

	if(head)
		var/desired_icon = head.worn_icon
		var/used_style = NONE
		if(dna?.species?.mutant_bodyparts["snout"])
			var/datum/sprite_accessory/snouts/S = GLOB.sprite_accessories["snout"][dna.species.mutant_bodyparts["snout"][MUTANT_INDEX_NAME]]
			if(S.use_muzzled_sprites && head.mutant_variants & STYLE_MUZZLE)
				used_style = STYLE_MUZZLE
		switch(used_style)
			if(STYLE_MUZZLE)
				desired_icon = head.worn_icon_muzzled || 'modular_septic/icons/mob/clothing/head_muzzled.dmi'

		overlays_standing[HEAD_LAYER] = head.build_worn_icon(default_layer = HEAD_LAYER, default_icon_file = 'icons/mob/clothing/head.dmi', override_icon = desired_icon, mutant_styles = used_style)
		update_hud_head(head)

	apply_overlay(HEAD_LAYER)

/mob/living/carbon/update_inv_wear_mask()
	remove_overlay(FACEMASK_LAYER)

	//Decapitated
	if(!get_bodypart_nostump(BODY_ZONE_PRECISE_FACE))
		return

	if(client && hud_used && hud_used.inv_slots[TOBITSHIFT(ITEM_SLOT_MASK) + 1])
		var/atom/movable/screen/inventory/inv = hud_used.inv_slots[TOBITSHIFT(ITEM_SLOT_MASK) + 1]
		inv.update_icon()

	if(wear_mask)
		var/desired_icon = wear_mask.worn_icon
		var/used_style = NONE
		if(dna?.species?.mutant_bodyparts["snout"])
			var/datum/sprite_accessory/snouts/S = GLOB.sprite_accessories["snout"][dna.species.mutant_bodyparts["snout"][MUTANT_INDEX_NAME]]
			if(S.use_muzzled_sprites && wear_mask.mutant_variants & STYLE_MUZZLE)
				used_style = STYLE_MUZZLE
		switch(used_style)
			if(STYLE_MUZZLE)
				desired_icon = wear_mask.worn_icon_muzzled || 'modular_septic/icons/mob/clothing/mask_muzzled.dmi'

		if(!(ITEM_SLOT_MASK in check_obscured_slots()))
			overlays_standing[FACEMASK_LAYER] = wear_mask.build_worn_icon(default_layer = FACEMASK_LAYER, default_icon_file = 'icons/mob/clothing/mask.dmi', override_icon = desired_icon, mutant_styles = used_style)
		update_hud_wear_mask(wear_mask)

	apply_overlay(FACEMASK_LAYER)

/mob/living/carbon/update_body()
	if(status_flags & BUILDING_ORGANS)
		return
	update_body_parts()

/mob/living/carbon/update_body_parts()
	//CHECK FOR UPDATE
	for(var/obj/item/bodypart/bodypart in bodyparts)
		bodypart.update_limb()
	var/oldkey = icon_render_key
	icon_render_key = generate_icon_render_key()
	if(oldkey == icon_render_key)
		return

	remove_overlay(BODYPARTS_LAYER)

	//LOAD ICONS
	if(limb_icon_cache[icon_render_key])
		load_limb_from_cache()
		return

	var/is_taur = FALSE
	if(dna?.species.mutant_bodyparts["taur"])
		var/datum/sprite_accessory/taur/taur_legs = GLOB.sprite_accessories["taur"][dna.species.mutant_bodyparts["taur"][MUTANT_INDEX_NAME]]
		if(taur_legs.hide_legs)
			is_taur = TRUE

	//GENERATE NEW LIMBS
	var/list/new_limbs = list()
	for(var/obj/item/bodypart/bodypart as anything in bodyparts)
		if(is_taur && (bodypart.body_part & LEGS|FEET))
			continue
		var/bp_icon = bodypart.get_limb_icon()
		if(islist(bp_icon) && length(bp_icon))
			new_limbs |= bp_icon
	if(length(new_limbs))
		overlays_standing[BODYPARTS_LAYER] = new_limbs
		limb_icon_cache[icon_render_key] = new_limbs

	apply_overlay(BODYPARTS_LAYER)

	update_damage_overlays()
	update_medicine_overlays()

/mob/living/carbon/generate_icon_render_key()
	. = "carbon"
	var/husked = FALSE
	if(dna?.species)
		. += "-markingalpha[dna.species.markings_alpha]"
	if(dna?.species?.mutant_bodyparts["taur"])
		. += "-taur[dna.species.mutant_bodyparts["taur"][MUTANT_INDEX_NAME]]"
	if(HAS_TRAIT(src, TRAIT_HUSK))
		husked = TRUE
		. += "-husk"
	if(dna.check_mutation(HULK))
		. += "-coloured-hulk"
	for(var/X in bodyparts)
		var/obj/item/bodypart/bodypart = X
		. += "-[bodypart.body_zone]"
		if(bodypart.is_stump())
			. += "-stump"
		if(bodypart.animal_origin)
			. += "-[bodypart.animal_origin]"
		if(bodypart.status == BODYPART_ORGANIC)
			. += "-organic"
		else if(bodypart.status == BODYPART_ROBOTIC)
			. += "-robotic"
		if(bodypart.body_gender && bodypart.gender_rendering)
			. += "-gender[bodypart.body_gender]"
		if(bodypart.species_id)
			. += "-[bodypart.species_id]"
		if(bodypart.color)
			. += "-color[bodypart.color]"
		if(bodypart.use_digitigrade)
			. += "-digitigrade[bodypart.use_digitigrade]"
		if(bodypart.dmg_overlay_type)
			. += "-[bodypart.dmg_overlay_type]"
		if(HAS_TRAIT(bodypart, TRAIT_ROTTEN))
			. += "-rotten"
		else if(HAS_TRAIT(bodypart, TRAIT_PLASMABURNT))
			. += "-plasmaburnt"
		else if(HAS_TRAIT(bodypart, TRAIT_HUSK))
			. += "-husk"
		if(bodypart.advanced_rendering)
			. += "-advanced_render"
		for(var/zone in bodypart.body_markings)
			. += "-[zone]_markings"
			for(var/key in bodypart.body_markings[zone])
				var/datum/body_marking/marking = GLOB.body_markings[key]
				var/marking_string = "-marking-[marking.icon_state]"
				if(husked || HAS_TRAIT(bodypart, TRAIT_HUSK))
					marking_string += "-markingcolor888888"
				else
					marking_string += "-markingcolor[bodypart.body_markings[zone][key]]"
				. += marking_string

//change the mob's icon to the one matching its key
/mob/living/carbon/load_limb_from_cache()
	remove_overlay(BODYPARTS_LAYER)

	if(limb_icon_cache[icon_render_key])
		overlays_standing[BODYPARTS_LAYER] = limb_icon_cache[icon_render_key]

	apply_overlay(BODYPARTS_LAYER)

	update_damage_overlays()
	update_medicine_overlays()

/mob/living/carbon/perform_update_transform()
	var/matrix/ntransform = matrix(transform) //aka transform.Copy()
	var/final_pixel_y = pixel_y
	var/final_dir = dir
	var/changed = 0
	if(lying_angle != lying_prev && rotate_on_lying)
		changed++
		ntransform.TurnTo(lying_prev, lying_angle)
		if(!lying_angle) //Lying to standing
			final_pixel_y = base_pixel_y
		else if((lying_prev == 0) && (lying_angle >= 90)) //Standing to lying
			pixel_y = base_pixel_y
			final_pixel_y = base_pixel_y + PIXEL_Y_OFFSET_LYING
			if(dir & (EAST | WEST)) //Facing east or west
				final_dir = pick(NORTH, SOUTH) //So you fall on your side rather than your face or ass

	if(resize != RESIZE_DEFAULT_SIZE)
		changed++
		ntransform.Scale(resize)
		resize = RESIZE_DEFAULT_SIZE

	if(changed)
		SEND_SIGNAL(src, COMSIG_PAUSE_FLOATING_ANIM, 0.3 SECONDS)
		animate(src, transform = ntransform, time = (lying_prev == 0 || lying_angle == 0) ? 2 : 0, pixel_y = final_pixel_y, dir = final_dir, easing = (EASE_IN|EASE_OUT))
		addtimer(CALLBACK(src, .proc/update_shadow), 2)

/mob/living/carbon/update_shadow()
	vis_contents -= get_mob_shadow(NORMAL_MOB_SHADOW)
	vis_contents -= get_mob_shadow(LYING_MOB_SHADOW, pixel_y = 3)
	if(body_position != LYING_DOWN)
		vis_contents |= get_mob_shadow(NORMAL_MOB_SHADOW)
	else
		vis_contents |= get_mob_shadow(LYING_MOB_SHADOW, pixel_y = 3)

/mob/living/carbon/update_fire(fire_icon = "generic_mob_burning")
	remove_overlay(FIRE_LAYER)

	if(on_fire || HAS_TRAIT(src, TRAIT_PERMANENTLY_ONFIRE))
		var/mutable_appearance/new_fire_overlay = mutable_appearance('modular_septic/icons/mob/human/overlays/onfire.dmi', fire_icon, -FIRE_LAYER)
		new_fire_overlay.appearance_flags = RESET_COLOR
		overlays_standing[FIRE_LAYER] = new_fire_overlay

	apply_overlay(FIRE_LAYER)

/mob/living/carbon/update_damage_overlays()
	remove_overlay(DAMAGE_LAYER)

	var/mutable_appearance/damage_overlays = mutable_appearance('modular_septic/icons/mob/human/overlays/damage.dmi', "blank", -DAMAGE_LAYER)
	for(var/obj/item/bodypart/bodypart as anything in bodyparts)
		if(bodypart.is_stump())
			continue
		if(bodypart.dmg_overlay_type)
			var/image/damage
			switch(bodypart.body_zone)
				if(BODY_ZONE_PRECISE_FACE, BODY_ZONE_PRECISE_MOUTH)
					damage = image('modular_septic/icons/mob/human/overlays/damage.dmi', "[bodypart.dmg_overlay_type]_[BODY_ZONE_HEAD]_[bodypart.brutestate]0")
				if(BODY_ZONE_PRECISE_VITALS)
					damage = image('modular_septic/icons/mob/human/overlays/damage.dmi', "[bodypart.dmg_overlay_type]_[BODY_ZONE_CHEST]_[bodypart.brutestate]0")
				else
					damage = image('modular_septic/icons/mob/human/overlays/damage.dmi', "[bodypart.dmg_overlay_type]_[bodypart.body_zone]_[bodypart.brutestate]0")
			damage.layer = -DAMAGE_LAYER
			if(bodypart.render_layer == HANDS_PART_LAYER)
				damage.layer = -UPPER_DAMAGE_LAYER
			damage_overlays.add_overlay(damage)
	overlays_standing[DAMAGE_LAYER] = damage_overlays

	apply_overlay(DAMAGE_LAYER)

/mob/living/carbon/proc/update_medicine_overlays()
	remove_overlay(LOWER_MEDICINE_LAYER)
	remove_overlay(UPPER_MEDICINE_LAYER)

	var/mutable_appearance/lower_medicine_overlays = mutable_appearance('modular_septic/icons/mob/human/overlays/medicine_overlays.dmi', "blank", -LOWER_MEDICINE_LAYER)
	var/mutable_appearance/upper_medicine_overlays = mutable_appearance('modular_septic/icons/mob/human/overlays/medicine_overlays.dmi', "blank", -UPPER_MEDICINE_LAYER)
	for(var/obj/item/bodypart/bodypart as anything in bodyparts)
		if(bodypart.is_stump())
			continue
		var/image/gauze
		if(bodypart.current_gauze?.medicine_overlay_prefix)
			gauze = image('modular_septic/icons/mob/human/overlays/medicine_overlays.dmi', "[bodypart.current_gauze.medicine_overlay_prefix]_[bodypart.body_zone][bodypart.use_digitigrade ? "_digitigrade" : "" ]")
			gauze.layer = -LOWER_MEDICINE_LAYER
			if(bodypart.render_layer == HANDS_PART_LAYER)
				upper_medicine_overlays.add_overlay(gauze)
			else
				lower_medicine_overlays.add_overlay(gauze)
		var/image/splint
		if(bodypart.current_splint?.medicine_overlay_prefix)
			splint = image('modular_septic/icons/mob/human/overlays/medicine_overlays.dmi', "[bodypart.current_splint.medicine_overlay_prefix]_[check_zone(bodypart.body_zone)][bodypart.use_digitigrade ? "_digitigrade" : "" ]")
			splint.layer = -LOWER_MEDICINE_LAYER
			if(bodypart.render_layer == HANDS_PART_LAYER)
				upper_medicine_overlays.add_overlay(splint)
			else
				lower_medicine_overlays.add_overlay(splint)
	overlays_standing[LOWER_MEDICINE_LAYER] = lower_medicine_overlays
	overlays_standing[UPPER_MEDICINE_LAYER] = upper_medicine_overlays

	apply_overlay(LOWER_MEDICINE_LAYER)
	apply_overlay(UPPER_MEDICINE_LAYER)

/mob/living/carbon/proc/update_artery_overlays()
	remove_overlay(ARTERY_LAYER)

	var/mutable_appearance/arteries = mutable_appearance('modular_septic/icons/mob/human/overlays/artery.dmi', "blank", -ARTERY_LAYER)
	for(var/obj/item/bodypart/bodypart as anything in bodyparts)
		if(bodypart.is_stump() || !bodypart.is_organic_limb() || !bodypart.get_bleed_rate(TRUE))
			continue
		var/image/artery
		if(bodypart.is_artery_torn())
			artery = image('modular_septic/icons/mob/human/overlays/artery.dmi', "[bodypart.body_zone]_artery1")
			artery.layer = -ARTERY_LAYER
			arteries.add_overlay(artery)
	overlays_standing[ARTERY_LAYER] = arteries

	apply_overlay(ARTERY_LAYER)

/mob/living/carbon/proc/update_gore_overlays()
	remove_overlay(GORE_LAYER)

	var/mutable_appearance/gore = mutable_appearance('modular_septic/icons/mob/human/overlays/gore.dmi', "blank", -ARTERY_LAYER)
	for(var/obj/item/bodypart/bodypart as anything in bodyparts)
		if(bodypart.is_stump() || !bodypart.is_organic_limb() || !bodypart.get_bleed_rate(TRUE))
			continue
		var/image/spill
		if(bodypart.spilled && bodypart.spilled_overlay)
			spill = image('modular_septic/icons/mob/human/overlays/gore.dmi', "[bodypart.spilled_overlay]")
			spill.layer = -GORE_LAYER
			gore.add_overlay(spill)
	overlays_standing[GORE_LAYER] = gore

	apply_overlay(GORE_LAYER)

/mob/living/carbon/proc/update_smelly()
	remove_overlay(SMELL_LAYER)
