/proc/possible_values_for_sprite_accessory_list(list/sprite_accessories, direction = SOUTH)
	var/static/none_icon = icon('modular_septic/icons/mob/human/sprite_accessory/mutant_bodyparts.dmi', "none")
	var/list/possible_values = list()
	for(var/key in sprite_accessories)
		var/datum/sprite_accessory/sprite_accessory = sprite_accessories[key]
		if(istype(sprite_accessory) && \
			sprite_accessory.icon && \
			sprite_accessory.icon_state && \
			(sprite_accessory.icon_state != "none") )
			var/icon/final_icon
			if(!istype(sprite_accessory, /datum/sprite_accessory/hair) && !istype(sprite_accessory, /datum/sprite_accessory/facial_hair))
				var/list/icon_states = icon_states(sprite_accessory.icon)
				for(var/layer in sprite_accessory.relevant_layers)
					var/final_icon_state = ""
					if(sprite_accessory.gender_specific)
						final_icon_state = "male_"
					else
						final_icon_state = "m_"
					final_icon_state += "[sprite_accessory.key]_[sprite_accessory.icon_state]"
					var/append_text = ""
					switch(layer)
						if(BODY_FRONT_LAYER)
							append_text = "FRONT"
						if(BODY_ADJ_LAYER)
							append_text = "ADJ"
						if(BODY_BEHIND_LAYER)
							append_text = "BEHIND"
					if(append_text)
						final_icon_state += "_[append_text]"
					if(final_icon_state in icon_states)
						if(!final_icon)
							final_icon = icon(sprite_accessory.icon, final_icon_state, direction)
						else
							final_icon.Blend(icon(sprite_accessory.icon, final_icon_state, direction), ICON_OVERLAY)
			else
				final_icon = icon(sprite_accessory.icon, sprite_accessory.icon_state, direction)
			// This means it didn't have a proper final icon state
			if(!final_icon)
				final_icon = none_icon
			possible_values[key] = final_icon
		else
			// This means it didn't have an icon state at all
			possible_values[key] = none_icon
	return possible_values

/proc/generate_possible_values_for_sprite_accessories_on_head(accessories, direction = SOUTH)
	var/static/none_icon = icon('modular_septic/icons/mob/human/sprite_accessory/mutant_bodyparts.dmi', "none")

	var/list/values = possible_values_for_sprite_accessory_list(accessories, direction)

	var/icon/head_icon = icon(DEFAULT_BODYPART_ICON_ORGANIC, "human_head_m", direction)
	head_icon.Blend("#[skintone2hex("caucasian1")]", ICON_MULTIPLY)

	for(var/key in values)
		var/datum/sprite_accessory/accessory = accessories[key]
		if(!istype(accessory) || !accessory.icon_state || (accessory.icon_state == "none"))
			values[key] = none_icon
			continue

		var/icon/final_icon = new(head_icon)

		var/icon/accessory_icon = values[key]
		var/accessory_preview_color = accessory.get_preview_color()
		//Color matrix
		if(islist(accessory_preview_color))
			accessory_icon.MapColors(
				accessory_preview_color[1],
				accessory_preview_color[2],
				accessory_preview_color[3]
				)
		//Not color matrix
		else
			accessory_icon.Blend(accessory_preview_color, ICON_MULTIPLY)

		if(accessory_icon)
			final_icon.Blend(accessory_icon, ICON_OVERLAY)

		final_icon.Crop(10, 22, 22, 32)
		final_icon.Scale(32, 32)

		values[key] = final_icon

	return values

/proc/generate_possible_values_for_sprite_accessories_on_moth_head(accessories, direction = SOUTH)
	var/static/none_icon = icon('modular_septic/icons/mob/human/sprite_accessory/mutant_bodyparts.dmi', "none")

	var/list/values = possible_values_for_sprite_accessory_list(accessories, direction)

	var/icon/head_icon = icon('modular_septic/icons/mob/human/species/insect/moth_parts.dmi', "moth_head_m", direction)

	for(var/key in values)
		var/datum/sprite_accessory/accessory = accessories[key]
		if(!istype(accessory) || !accessory.icon_state || (accessory.icon_state == "none"))
			values[key] = none_icon
			continue

		var/icon/final_icon = new(head_icon)

		var/icon/accessory_icon = values[key]
		var/accessory_preview_color = accessory.get_preview_color()
		//Color matrix
		if(islist(accessory_preview_color))
			accessory_icon.MapColors(
				accessory_preview_color[1],
				accessory_preview_color[2],
				accessory_preview_color[3]
				)
		//Not color matrix
		else
			accessory_icon.Blend(accessory_preview_color, ICON_MULTIPLY)

		if(accessory_icon)
			final_icon.Blend(accessory_icon, ICON_OVERLAY)

		final_icon.Crop(10, 22, 22, 32)
		final_icon.Scale(32, 32)

		values[key] = final_icon

	return values

/proc/generate_possible_values_for_sprite_accessories_on_chest(accessories, direction = SOUTH)
	var/static/none_icon = icon('modular_septic/icons/mob/human/sprite_accessory/mutant_bodyparts.dmi', "none")

	var/list/values = possible_values_for_sprite_accessory_list(accessories, direction)

	var/icon/chest_icon = icon(DEFAULT_BODYPART_ICON_ORGANIC, "human_chest_m")

	for(var/key in values)
		var/datum/sprite_accessory/accessory = accessories[key]
		if(!istype(accessory) || !accessory.icon_state || (accessory.icon_state == "none"))
			values[key] = none_icon
			continue

		var/icon/final_icon = new(chest_icon)

		var/icon/accessory_icon = values[key]
		var/accessory_preview_color = accessory.get_preview_color()
		//Color matrix
		if(islist(accessory_preview_color))
			accessory_icon.MapColors(
				accessory_preview_color[1],
				accessory_preview_color[2],
				accessory_preview_color[3]
				)
		//Not color matrix
		else
			accessory_icon.Blend(accessory_preview_color, ICON_MULTIPLY)

		if(accessory_icon)
			final_icon.Blend(accessory_icon, ICON_OVERLAY)

		final_icon.Crop(6, 9, 27, 24)
		final_icon.Scale(32, 32)

		values[key] = final_icon

	return values

/proc/generate_possible_values_for_sprite_accessories_on_moth_chest(accessories, direction = SOUTH)
	var/static/none_icon = icon('modular_septic/icons/mob/human/sprite_accessory/mutant_bodyparts.dmi', "none")

	var/list/values = possible_values_for_sprite_accessory_list(accessories, direction)

	var/icon/chest_icon = icon('modular_septic/icons/mob/human/species/insect/moth_parts.dmi', "moth_chest_m", direction)

	for(var/key in values)
		var/datum/sprite_accessory/accessory = accessories[key]
		if(!istype(accessory) || !accessory.icon_state || (accessory.icon_state == "none"))
			values[key] = none_icon
			continue

		var/icon/final_icon = new(chest_icon)

		var/icon/accessory_icon = values[key]
		var/accessory_preview_color = accessory.get_preview_color()
		//Color matrix
		if(islist(accessory_preview_color))
			accessory_icon.MapColors(
				accessory_preview_color[1],
				accessory_preview_color[2],
				accessory_preview_color[3]
				)
		//Not color matrix
		else
			accessory_icon.Blend(accessory_preview_color, ICON_MULTIPLY)

		if(accessory_icon)
			final_icon.Blend(accessory_icon, ICON_OVERLAY)

		final_icon.Crop(6, 9, 27, 24)
		final_icon.Scale(32, 32)

		values[key] = final_icon

	return values

/proc/generate_possible_values_for_sprite_accessories_on_groin(accessories, direction = SOUTH)
	var/static/none_icon = icon('modular_septic/icons/mob/human/sprite_accessory/mutant_bodyparts.dmi', "none")

	var/list/values = possible_values_for_sprite_accessory_list(accessories, direction)

	var/icon/groin_icon = icon(DEFAULT_BODYPART_ICON_ORGANIC, "human_groin_m", direction)
	for(var/icon_state in list("human_r_leg", "human_r_foot", "human_l_leg", "human_l_foot"))
		groin_icon.Blend(icon(DEFAULT_BODYPART_ICON_ORGANIC, icon_state, direction), ICON_OVERLAY)
	groin_icon.Blend("#[skintone2hex("caucasian1")]", ICON_MULTIPLY)

	for(var/key in values)
		var/datum/sprite_accessory/accessory = accessories[key]
		if(!istype(accessory) || !accessory.icon_state || (accessory.icon_state == "none"))
			values[key] = none_icon
			continue

		var/icon/final_icon = new(groin_icon)

		var/icon/accessory_icon = values[key]
		var/accessory_preview_color = accessory.get_preview_color()
		//Color matrix
		if(islist(accessory_preview_color))
			accessory_icon.MapColors(
				accessory_preview_color[1],
				accessory_preview_color[2],
				accessory_preview_color[3]
				)
		//Not color matrix
		else
			accessory_icon.Blend(accessory_preview_color, ICON_MULTIPLY)

		if(accessory_icon)
			final_icon.Blend(accessory_icon, ICON_OVERLAY)

		final_icon.Crop(8, 1, 24, 12)
		final_icon.Scale(32, 32)

		values[key] = final_icon

	return values

/proc/generate_possible_values_for_sprite_accessories_on_groin_with_tail(accessories, direction = SOUTH)
	var/static/none_icon = icon('modular_septic/icons/mob/human/sprite_accessory/mutant_bodyparts.dmi', "none")

	var/list/values = possible_values_for_sprite_accessory_list(accessories, direction)

	var/icon/groin_icon = icon(DEFAULT_BODYPART_ICON_ORGANIC, "human_groin_m", direction)
	for(var/icon_state in list("human_r_leg", "human_r_foot", "human_l_leg", "human_l_foot"))
		groin_icon.Blend(icon(DEFAULT_BODYPART_ICON_ORGANIC, icon_state, direction), ICON_OVERLAY)
	groin_icon.Blend("#[skintone2hex("caucasian1")]", ICON_MULTIPLY)
	var/datum/sprite_accessory/tails/lizard/smooth/lizard_tail = GLOB.sprite_accessories["tail"]["Smooth"]
	var/icon/tail_icon = icon(lizard_tail.icon, "m_tail_smooth_FRONT")
	var/tail_preview_color = lizard_tail.get_preview_color()
	//Color matrix
	if(islist(tail_preview_color))
		tail_icon.MapColors(
				tail_preview_color[1],
				tail_preview_color[2],
				tail_preview_color[3]
				)
	//Not color matrix
	else
		tail_icon.Blend(tail_preview_color, ICON_MULTIPLY)
	groin_icon.Blend(tail_icon, ICON_OVERLAY)

	for(var/key in values)
		var/datum/sprite_accessory/accessory = accessories[key]
		if(!istype(accessory) || !accessory.icon_state || (accessory.icon_state == "none"))
			values[key] = none_icon
			continue

		var/icon/final_icon = new(groin_icon)

		var/icon/accessory_icon = values[key]
		var/accessory_preview_color = accessory.get_preview_color()
		//Color matrix
		if(islist(accessory_preview_color))
			accessory_icon.MapColors(
				accessory_preview_color[1],
				accessory_preview_color[2],
				accessory_preview_color[3]
				)
		//Not color matrix
		else
			accessory_icon.Blend(accessory_preview_color, ICON_MULTIPLY)

		if(accessory_icon)
			final_icon.Blend(accessory_icon, ICON_OVERLAY)

		final_icon.Crop(9, 1, 23, 12)
		final_icon.Scale(32, 32)

		values[key] = final_icon

	return values
