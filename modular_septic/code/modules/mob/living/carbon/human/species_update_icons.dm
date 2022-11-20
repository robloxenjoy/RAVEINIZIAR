/datum/species
	/// Replaces bodypart icons
	var/limbs_icon
	/// What accessories can a species have aswell as their default accessory of such type e.g. "frills" = "Aquatic". Default accessory colors is dictated by the accessory properties and mutcolors of the specie
	var/list/list/default_mutant_bodyparts = list()
	/// What accessories we are currently using
	var/list/list/mutant_bodyparts = list()
	/// A list of actual body markings on the owner of the species. Associative lists with keys named by limbs defines, pointing to a list with names and colors for the marking to be rendered. This is also stored in the DNA.
	var/list/list/body_markings = list()
	/// Override for the alpha of bodyparts and mutant parts.
	var/bodypart_alpha = 255
	/// Override for alpha value of markings, should be much lower than the above value.
	var/markings_alpha = 255
	/// Whether a species can use augmentations in preferences
	var/can_augmentation = TRUE
	/// If a species can always be picked in prefs for the purposes of customizing it for ghost roles or events
	var/always_customizable = FALSE

/datum/species/can_wag_tail(mob/living/carbon/human/wagger)
	if(!wagger) //Somewhere in the core code we're getting those procs with H being null
		return FALSE
	var/list/tails = wagger.getorganslotlist(ORGAN_SLOT_TAIL)
	if(!length(tails))
		return FALSE
	for(var/obj/item/organ/tail/tail as anything in tails)
		if(tail.can_wag)
			return TRUE
	return FALSE

/datum/species/is_wagging_tail(mob/living/carbon/human/wagger)
	if(!wagger) //Somewhere in the core code we're getting those procs with H being null
		return FALSE
	var/list/tails = wagger.getorganslotlist(ORGAN_SLOT_TAIL)
	if(!LAZYLEN(tails))
		return FALSE
	for(var/obj/item/organ/tail/tail in tails)
		if(tail.can_wag && tail.wagging)
			return TRUE
	return FALSE

/datum/species/start_wagging_tail(mob/living/carbon/human/wagger)
	if(!wagger) //Somewhere in the core code we're getting those procs with H being null
		return FALSE
	var/list/tails = wagger.getorganslotlist(ORGAN_SLOT_TAIL)
	if(!LAZYLEN(tails))
		return FALSE
	for(var/obj/item/organ/tail/tail in tails)
		if(tail.can_wag)
			tail.wagging = TRUE
	return FALSE

/datum/species/stop_wagging_tail(mob/living/carbon/human/wagger)
	if(!wagger) //Somewhere in the core code we're getting those procs with H being null
		return FALSE
	var/list/tails = wagger.getorganslotlist(ORGAN_SLOT_TAIL)
	if(!LAZYLEN(tails))
		return FALSE
	for(var/obj/item/organ/tail/tail in tails)
		tail.wagging = FALSE
	wagger.update_body()

/datum/species/spec_death(gibbed = FALSE, mob/living/carbon/human/dead)
	. = ..()
	if(is_wagging_tail(dead))
		stop_wagging_tail(dead)

/datum/species/handle_hair(mob/living/carbon/human/H, forced_colour)
	H.remove_overlay(HAIR_LAYER)
	var/obj/item/bodypart/head/head = H.get_bodypart_nostump(BODY_ZONE_HEAD)
	if(!head) //Decapitated
		return

	if(HAS_TRAIT(H, TRAIT_HUSK))
		return
	var/datum/sprite_accessory/S
	var/list/standing = list()

	var/hair_hidden = FALSE //ignored if the matching dynamic_X_suffix is non-empty
	var/facialhair_hidden = FALSE // ^

	var/dynamic_hair_suffix = "" //if this is non-null, and hair+suffix matches an iconstate, then we render that hair instead
	var/dynamic_fhair_suffix = ""

	//for augmented heads
	if(head.status == BODYPART_ROBOTIC)
		return

	//we check if our hat or helmet hides our facial hair.
	if(H.head)
		var/obj/item/I = H.head
		if(isclothing(I))
			var/obj/item/clothing/C = I
			dynamic_fhair_suffix = C.dynamic_fhair_suffix
		if(I.flags_inv & HIDEFACIALHAIR)
			facialhair_hidden = TRUE

	if(H.wear_mask)
		var/obj/item/I = H.wear_mask
		if(isclothing(I))
			var/obj/item/clothing/C = I
			dynamic_fhair_suffix = C.dynamic_fhair_suffix //mask > head in terms of facial hair
		if(I.flags_inv & HIDEFACIALHAIR)
			facialhair_hidden = TRUE

	if(H.facial_hairstyle && (FACEHAIR in species_traits) && (!facialhair_hidden || dynamic_fhair_suffix))
		S = GLOB.facial_hairstyles_list[H.facial_hairstyle]
		if(S)
			//List of all valid dynamic_fhair_suffixes
			var/static/list/fextensions
			if(!fextensions)
				var/icon/fhair_extensions = icon('icons/mob/facialhair_extensions.dmi')
				fextensions = list()
				for(var/s in fhair_extensions.IconStates(1))
					fextensions[s] = TRUE
				qdel(fhair_extensions)

			//Is hair+dynamic_fhair_suffix a valid iconstate?
			var/fhair_state = S.icon_state
			var/fhair_file = S.icon
			if(fextensions[fhair_state+dynamic_fhair_suffix])
				fhair_state += dynamic_fhair_suffix
				fhair_file = 'icons/mob/facialhair_extensions.dmi'

			var/mutable_appearance/facial_overlay = mutable_appearance(fhair_file, fhair_state, -HAIR_LAYER)

			if(!forced_colour)
				if(hair_color)
					if(hair_color == "mutcolor")
						facial_overlay.color = sanitize_hexcolor(H.dna.features["mcolor"], 6, TRUE)
					else if(hair_color == "fixedmutcolor")
						facial_overlay.color = sanitize_hexcolor(fixed_mut_color, 6, TRUE)
					else
						facial_overlay.color = sanitize_hexcolor(hair_color, 6, TRUE)
				else
					facial_overlay.color = sanitize_hexcolor(H.facial_hair_color, 6, TRUE)
			else
				facial_overlay.color = sanitize_hexcolor(forced_colour, 6, TRUE)

			facial_overlay.alpha = hair_alpha

			facial_overlay = apply_height_offsets(facial_overlay, H.height, on_head = TRUE)
			standing += facial_overlay

	if(H.head)
		var/obj/item/I = H.head
		if(isclothing(I))
			var/obj/item/clothing/C = I
			dynamic_hair_suffix = C.dynamic_hair_suffix
		if(I.flags_inv & HIDEHAIR)
			hair_hidden = TRUE

	if(H.wear_mask)
		var/obj/item/maybe_mask = H.wear_mask
		if(!dynamic_hair_suffix && isclothing(maybe_mask)) //head > mask in terms of head hair
			var/obj/item/clothing/mask = maybe_mask
			dynamic_hair_suffix = mask.dynamic_hair_suffix
		if(maybe_mask.flags_inv & HIDEHAIR)
			hair_hidden = TRUE

	if(!hair_hidden || dynamic_hair_suffix)
		var/mutable_appearance/hair_appearance = mutable_appearance(layer = -HAIR_LAYER)
		var/mutable_appearance/gradient_appearance = mutable_appearance(layer = -HAIR_LAYER)
		if(H.hairstyle && (HAIR in species_traits))
			S = GLOB.hairstyles_list[H.hairstyle]
			if(S)
				//List of all valid dynamic_hair_suffixes
				var/static/list/extensions
				if(!extensions)
					var/icon/hair_extensions = icon('icons/mob/hair_extensions.dmi') //hehe
					extensions = list()
					for(var/icon_state in hair_extensions.IconStates(1))
						extensions[icon_state] = TRUE
					qdel(hair_extensions)

				//Is hair+dynamic_hair_suffix a valid iconstate?
				var/hair_state = S.icon_state
				var/hair_file = S.icon
				if(extensions[hair_state+dynamic_hair_suffix])
					hair_state += dynamic_hair_suffix
					hair_file = 'icons/mob/hair_extensions.dmi'

				hair_appearance.icon = hair_file
				hair_appearance.icon_state = hair_state

				if(!forced_colour)
					if(hair_color)
						if(hair_color == "mutcolor")
							hair_appearance.color = sanitize_hexcolor(H.dna.features["mcolor"], 6, TRUE)
						else if(hair_color == "fixedmutcolor")
							hair_appearance.color = sanitize_hexcolor(fixed_mut_color, 6, TRUE)
						else
							hair_appearance.color = sanitize_hexcolor(hair_color, 6, TRUE)
					else
						hair_appearance.color = sanitize_hexcolor(H.hair_color, 6, TRUE)

					//Gradients
					grad_style = H.grad_style
					grad_color = H.grad_color
					if(grad_style)
						var/datum/sprite_accessory/gradient = GLOB.hair_gradients_list[grad_style]
						var/icon/temp = icon(gradient.icon, gradient.icon_state)
						var/icon/temp_hair = icon(hair_file, hair_state)
						temp.Blend(temp_hair, ICON_ADD)
						gradient_appearance.icon = temp
						gradient_appearance.color = grad_color
				else
					hair_appearance.color = sanitize_hexcolor(forced_colour, 6, TRUE)
				hair_appearance.alpha = hair_alpha
				if(OFFSET_FACE in H.dna.species.offset_features)
					hair_appearance.pixel_x += H.dna.species.offset_features[OFFSET_FACE][1]
					hair_appearance.pixel_y += H.dna.species.offset_features[OFFSET_FACE][2]
		if(hair_appearance.icon)
			hair_appearance = apply_height_offsets(hair_appearance, H.height, on_head = TRUE)
			standing += hair_appearance
		if(gradient_appearance.color)
			gradient_appearance = apply_height_offsets(gradient_appearance, H.height, on_head = TRUE)
			standing += gradient_appearance

	if(standing.len)
		H.overlays_standing[HAIR_LAYER] = standing

	H.apply_overlay(HAIR_LAYER)

/datum/species/handle_body(mob/living/carbon/human/species_human)
	species_human.remove_overlay(BODY_LAYER)

	var/list/standing = list()

	var/obj/item/bodypart/head/head = species_human.get_bodypart_nostump(BODY_ZONE_HEAD)
	if(head && !(HAS_TRAIT(species_human, TRAIT_HUSK)))
		var/obj/item/bodypart/face/face = species_human.get_bodypart_nostump(BODY_ZONE_PRECISE_FACE)
		var/obj/item/bodypart/mouth/jaw = species_human.get_bodypart_nostump(BODY_ZONE_PRECISE_MOUTH)
		// face
		if(!face)
			var/mutable_appearance/face_overlay = mutable_appearance('modular_septic/icons/mob/human/sprite_accessory/human_face.dmi', "face_missing", -BODY_LAYER)
			if(OFFSET_FACE in offset_features)
				face_overlay.pixel_x += offset_features[OFFSET_FACE][1]
				face_overlay.pixel_y += offset_features[OFFSET_FACE][2]
			face_overlay = apply_height_offsets(face_overlay, species_human.height, on_head = TRUE)
			standing += face_overlay
		// jaw
		if(jaw)
			// lipstick
			if(species_human.lip_style && (LIPS in species_traits))
				var/mutable_appearance/lip_overlay = mutable_appearance('modular_septic/icons/mob/human/sprite_accessory/human_face.dmi', "lips_[species_human.lip_style]", -BODY_LAYER)
				lip_overlay.color = sanitize_hexcolor(species_human.lip_color, 6, TRUE)
				if(OFFSET_FACE in species_human.dna.species.offset_features)
					lip_overlay.pixel_x += species_human.dna.species.offset_features[OFFSET_FACE][1]
					lip_overlay.pixel_y += species_human.dna.species.offset_features[OFFSET_FACE][2]
				lip_overlay = apply_height_offsets(lip_overlay, species_human.height, on_head = TRUE)
				standing += lip_overlay
		else
			var/mutable_appearance/lip_overlay = mutable_appearance('modular_septic/icons/mob/human/sprite_accessory/human_face.dmi', "lips_missing", -BODY_LAYER)
			if(OFFSET_FACE in species_human.dna.species.offset_features)
				lip_overlay.pixel_x += species_human.dna.species.offset_features[OFFSET_FACE][1]
				lip_overlay.pixel_y += species_human.dna.species.offset_features[OFFSET_FACE][2]
			lip_overlay = apply_height_offsets(lip_overlay, species_human.height, on_head = TRUE)
			standing += lip_overlay
		// eyes
		if(!(NOEYESPRITES in species_traits))
			var/obj/item/bodypart/left_eyelid = species_human.get_bodypart_nostump(BODY_ZONE_PRECISE_L_EYE)
			var/obj/item/bodypart/right_eyelid = species_human.get_bodypart_nostump(BODY_ZONE_PRECISE_R_EYE)
			var/obj/item/organ/eyes/LE
			var/obj/item/organ/eyes/RE
			for(var/obj/item/organ/eyes/eye in left_eyelid?.get_organs())
				LE = eye
				break
			for(var/obj/item/organ/eyes/eye in right_eyelid?.get_organs())
				RE = eye
				break
			var/obscured = species_human.check_obscured_slots(TRUE) //eyes that shine in the dark shouldn't show when you have glasses
			//cut any possible vis overlays
			if(length(body_vis_overlays))
				SSvis_overlays.remove_vis_overlay(species_human, body_vis_overlays)
			var/mutable_appearance/right_overlay
			var/mutable_appearance/right_emissive
			if(RE)
				right_overlay = mutable_appearance('modular_septic/icons/mob/human/sprite_accessory/human_face.dmi', RE.eye_icon_state, -BODY_LAYER)
				if(EYECOLOR in species_traits)
					right_overlay.color = sanitize_hexcolor(species_human.right_eye_color, 6, TRUE)
				if(RE.overlay_ignore_lighting && !(obscured & ITEM_SLOT_EYES))
					right_emissive = mutable_appearance('modular_septic/icons/mob/human/sprite_accessory/human_face.dmi', RE.eye_icon_state)
					right_emissive.plane = EMISSIVE_PLANE
			else
				right_overlay = mutable_appearance('modular_septic/icons/mob/human/sprite_accessory/human_face.dmi', "eye-right-missing", -BODY_LAYER)
			var/mutable_appearance/left_overlay
			var/mutable_appearance/left_emissive
			if(LE)
				left_overlay = mutable_appearance('modular_septic/icons/mob/human/sprite_accessory/human_face.dmi', LE.eye_icon_state, -BODY_LAYER)
				if(EYECOLOR in species_traits)
					left_overlay.color = sanitize_hexcolor(species_human.left_eye_color, 6, TRUE)
				if(LE.overlay_ignore_lighting && !(obscured & ITEM_SLOT_EYES))
					left_emissive = mutable_appearance('modular_septic/icons/mob/human/sprite_accessory/human_face.dmi', LE.eye_icon_state)
					left_emissive.plane = EMISSIVE_PLANE
			else
				left_overlay = mutable_appearance('modular_septic/icons/mob/human/sprite_accessory/human_face.dmi', "eye-left-missing", -BODY_LAYER)
			if(OFFSET_FACE in offset_features)
				if(right_overlay)
					right_overlay.pixel_x += offset_features[OFFSET_FACE][1]
					right_overlay.pixel_y += offset_features[OFFSET_FACE][2]
				if(right_emissive)
					right_emissive.pixel_x += offset_features[OFFSET_FACE][1]
					right_emissive.pixel_y += offset_features[OFFSET_FACE][2]
				if(left_overlay)
					left_overlay.pixel_x += offset_features[OFFSET_FACE][1]
					left_overlay.pixel_y += offset_features[OFFSET_FACE][2]
				if(left_emissive)
					left_emissive.pixel_x += offset_features[OFFSET_FACE][1]
					left_emissive.pixel_y += offset_features[OFFSET_FACE][2]
			if(right_overlay)
				right_overlay = apply_height_offsets(right_overlay, species_human.height, on_head = TRUE)
				standing += right_overlay
			if(right_emissive)
				right_emissive = apply_height_offsets(right_emissive, species_human.height, on_head = TRUE)
				standing += right_emissive
			if(left_overlay)
				left_overlay = apply_height_offsets(left_overlay, species_human.height, on_head = TRUE)
				standing += left_overlay
			if(left_emissive)
				left_emissive = apply_height_offsets(left_emissive, species_human.height, on_head = TRUE)
				standing += left_emissive

	//Underwear, Undershirts & Socks
	if(!(NO_UNDERWEAR in species_traits))
		if(species_human.underwear && !(species_human.underwear_visibility & UNDERWEAR_HIDE_UNDIES))
			var/datum/sprite_accessory/underwear/underwear = GLOB.underwear_list[species_human.underwear]
			if(underwear)
				var/mutable_appearance/underwear_appearance
				if(species_human.dna.species.sexes && (species_human.body_type in FEMININE_BODY_TYPES) && (underwear.gender == MALE))
					underwear_appearance = wear_female_version(underwear.icon_state, underwear.icon, -BODY_LAYER, FEMALE_UNIFORM_FULL)
				else
					underwear_appearance = mutable_appearance(underwear.icon, underwear.icon_state, -BODY_LAYER)
				if(!underwear.use_static)
					underwear_appearance.color = sanitize_hexcolor(species_human.underwear_color, 6, TRUE)
				underwear_appearance = apply_height_filters(underwear_appearance, species_human.height)
				standing += underwear_appearance

		if(species_human.undershirt && !(species_human.underwear_visibility & UNDERWEAR_HIDE_SHIRT))
			var/datum/sprite_accessory/undershirt/undershirt = GLOB.undershirt_list[species_human.undershirt]
			if(undershirt)
				var/mutable_appearance/undershirt_appearance
				if(species_human.dna.species.sexes && (species_human.body_type in FEMININE_BODY_TYPES))
					undershirt_appearance = wear_female_version(undershirt.icon_state, undershirt.icon, -BODY_LAYER)
				else
					undershirt_appearance = mutable_appearance(undershirt.icon, undershirt.icon_state, -BODY_LAYER)
				undershirt_appearance = apply_height_filters(undershirt_appearance, species_human.height)
				standing += undershirt_appearance

		if(species_human.socks && (species_human.num_legs >= species_human.default_num_legs) && !(DIGITIGRADE in species_traits) && !(species_human.underwear_visibility & UNDERWEAR_HIDE_SOCKS))
			var/datum/sprite_accessory/socks/socks = GLOB.socks_list[species_human.socks]
			if(socks)
				var/mutable_appearance/socks_appearance = mutable_appearance(socks.icon, socks.icon_state, -BODY_LAYER)
				socks_appearance = apply_height_filters(socks_appearance, species_human.height)
				standing += socks_appearance

	if(LAZYLEN(standing))
		species_human.overlays_standing[BODY_LAYER] = standing

	species_human.apply_overlay(BODY_LAYER)

	handle_mutant_bodyparts(species_human)

/datum/species/handle_mutant_bodyparts(mob/living/carbon/human/H, forced_colour, force_update = FALSE)
	var/list/standing = list()

	//Digitigrade legs are stuck in the phantom zone between true limbs and mutant bodyparts. Mainly it just needs more agressive updating than most limbs.
	var/update_needed = FALSE
	var/not_digitigrade = TRUE
	for(var/obj/item/bodypart/bodypart as anything in H.bodyparts)
		if(!bodypart.use_digitigrade)
			continue
		not_digitigrade = FALSE
		if(!(DIGITIGRADE in species_traits)) //Someone cut off a digitigrade leg and tacked it on
			species_traits += DIGITIGRADE
		var/should_be_squished = FALSE
		if((H.wear_suit && H.wear_suit.flags_inv & HIDEJUMPSUIT && !(H.wear_suit.mutant_variants & STYLE_DIGITIGRADE) && (H.wear_suit.body_parts_covered & LEGS)) || (H.w_uniform && (H.w_uniform.body_parts_covered & LEGS|FEET) && !(H.w_uniform.mutant_variants & STYLE_DIGITIGRADE)))
			should_be_squished = TRUE
		if(bodypart.use_digitigrade == FULL_DIGITIGRADE && should_be_squished)
			bodypart.use_digitigrade = SQUISHED_DIGITIGRADE
			update_needed = TRUE
		else if(bodypart.use_digitigrade == SQUISHED_DIGITIGRADE && !should_be_squished)
			bodypart.use_digitigrade = FULL_DIGITIGRADE
			update_needed = TRUE
	if(update_needed)
		H.update_body_parts()
	//Curse is lifted
	if(not_digitigrade && (DIGITIGRADE in species_traits))
		species_traits -= DIGITIGRADE

	if(!length(mutant_bodyparts) || HAS_TRAIT(src, TRAIT_INVISIBLE_MAN))
		H.remove_overlay(BODYPARTS_EXTENSION_BEHIND_LAYER)
		H.remove_overlay(BODY_BEHIND_LAYER)
		H.remove_overlay(BODYPARTS_EXTENSION_LAYER)
		H.remove_overlay(BODY_ADJ_LAYER)
		H.remove_overlay(BODY_FRONT_LAYER)
		return

	var/list/bodyparts_to_add = list()
	var/new_renderkey = "[id]-[H.height]"
	for(var/key in mutant_bodyparts)
		var/datum/sprite_accessory/accessory
		var/name = LAZYACCESSASSOC(mutant_bodyparts, key, MUTANT_INDEX_NAME)
		var/colors = LAZYACCESSASSOC(mutant_bodyparts, key, MUTANT_INDEX_COLOR)
		if(name)
			accessory = LAZYACCESSASSOC(GLOB.sprite_accessories, key, name)
		if(!accessory || isnull(accessory.icon_state))
			continue
		var/special_colors = accessory.get_special_color(H)
		if(special_colors)
			colors = special_colors
		var/obj/item/bodypart/associated_part
		if(accessory.body_zone)
			associated_part = H.get_bodypart_nostump(accessory.body_zone)
		if(accessory.is_hidden(H, associated_part))
			continue
		var/render_state
		if(accessory.special_render_case)
			render_state = accessory.get_special_render_state(H)
		else
			render_state = accessory.icon_state
		new_renderkey += "-[key]-[render_state]"
		if(colors)
			if(islist(colors))
				for(var/this_color in colors)
					var/final_color = sanitize_hexcolor(this_color, 6, FALSE)
					new_renderkey += "-[final_color]"
			else
				var/final_color = sanitize_hexcolor(colors, 6, FALSE)
				new_renderkey += "-[final_color]"
		bodyparts_to_add[accessory] = render_state

	if((new_renderkey == H.mutant_renderkey) && !force_update)
		return

	H.mutant_renderkey = new_renderkey

	H.remove_overlay(BODYPARTS_EXTENSION_BEHIND_LAYER)
	H.remove_overlay(BODY_BEHIND_LAYER)
	H.remove_overlay(BODYPARTS_EXTENSION_LAYER)
	H.remove_overlay(BODY_ADJ_LAYER)
	H.remove_overlay(BODY_FRONT_LAYER)

	var/gender = (H.body_type in FEMININE_BODY_TYPES) ? "f" : "m"
	for(var/datum/sprite_accessory/sprite_accessory as anything in bodyparts_to_add)
		var/key = sprite_accessory.key

		var/icon_to_use
		var/x_shift
		var/render_state = bodyparts_to_add[sprite_accessory]

		var/override_color = forced_colour
		if(!override_color && sprite_accessory.special_colorize)
			override_color = sprite_accessory.get_special_render_colour(H, render_state)

		if(sprite_accessory.special_icon_case)
			icon_to_use = sprite_accessory.get_special_icon(H, render_state)
		else
			icon_to_use = sprite_accessory.icon

		if(sprite_accessory.special_x_dimension)
			x_shift = sprite_accessory.get_special_x_dimension(H, render_state)
		else
			x_shift = sprite_accessory.dimension_x

		if(sprite_accessory.gender_specific)
			render_state = "[gender]_[key]_[render_state]"
		else
			render_state = "m_[key]_[render_state]"

		for(var/layer in sprite_accessory.relevant_layers)
			standing = list()
			var/layertext = mutant_bodyparts_layertext(layer)

			var/mutable_appearance/accessory_overlay = mutable_appearance(icon_to_use, layer = -layer)

			accessory_overlay.icon_state = "[render_state]_[layertext]"

			if(sprite_accessory.center)
				accessory_overlay = center_image(accessory_overlay, x_shift, sprite_accessory.dimension_y)

			if(!override_color)
				if(HAS_TRAIT(H, TRAIT_HUSK))
					if(sprite_accessory.color_src == USE_MATRIXED_COLORS) //Matrixed+husk needs special care, otherwise we get sparkle dogs
						accessory_overlay.color = HUSK_COLOR_LIST
					else
						accessory_overlay.color = "#AAAAAA" //The gray husk color
				else
					switch(sprite_accessory.color_src)
						if(USE_ONE_COLOR)
							///Matrix
							if(islist(mutant_bodyparts[key][MUTANT_INDEX_COLOR]))
								accessory_overlay.color = sanitize_hexcolor(mutant_bodyparts[key][MUTANT_INDEX_COLOR][1], 6, TRUE)
							///Hex
							else
								accessory_overlay.color = sanitize_hexcolor(mutant_bodyparts[key][MUTANT_INDEX_COLOR], 6, TRUE)
						if(USE_MATRIXED_COLORS)
							var/list/color_list = mutant_bodyparts[key][MUTANT_INDEX_COLOR]
							//this is here and not with the alpha setting code below as setting the alpha on a matrix color mutable appearance breaks it (at least in this case)
							var/alpha_value = bodypart_alpha
							var/list/finished_list = list()
							if(length(color_list) == 1)
								color_list = color_list[1]
							//Matrix
							if(istype(color_list))
								finished_list += ReadRGB("[sanitize_hexcolor(color_list[min(1, length(color_list))], 6, FALSE)]00")
								finished_list += ReadRGB("[sanitize_hexcolor(color_list[min(2, length(color_list))], 6, FALSE)]00")
								finished_list += ReadRGB("[sanitize_hexcolor(color_list[min(3, length(color_list))], 6, FALSE)]00")
								finished_list += list(0,0,0,alpha_value)
							//Hex
							else
								var/color = ReadRGB("[sanitize_hexcolor(color_list, 6, FALSE)]00")
								var/list/final_color = ReadRGB(color)
								finished_list = list(final_color, final_color, final_color)
								finished_list += list(0,0,0,alpha_value)
							for(var/index in 1 to length(finished_list))
								finished_list[index] /= 255
							accessory_overlay.color = finished_list
						if(MUTCOLORS)
							if(fixed_mut_color)
								accessory_overlay.color = sanitize_hexcolor(fixed_mut_color, 6, TRUE)
							else
								accessory_overlay.color = sanitize_hexcolor(H.dna.features["mcolor"], 6, TRUE)
						if(HAIR)
							if(hair_color == "mutcolor")
								accessory_overlay.color = sanitize_hexcolor(H.dna.features["mcolor"], 6, TRUE)
							else if(hair_color == "fixedmutcolor")
								accessory_overlay.color = sanitize_hexcolor(fixed_mut_color, 6, TRUE)
							else
								accessory_overlay.color = sanitize_hexcolor(H.hair_color, 6, TRUE)
						if(FACEHAIR)
							accessory_overlay.color = sanitize_hexcolor(H.facial_hair_color, 6, TRUE)
						if(EYECOLOR)
							accessory_overlay.color = sanitize_hexcolor(H.left_eye_color, 6, TRUE)
			else
				accessory_overlay.color = sanitize_hexcolor(override_color, 6, TRUE)
			if(sprite_accessory.body_zone == BODY_ZONE_HEAD)
				accessory_overlay = apply_height_offsets(accessory_overlay, H.height, on_head = TRUE)
			else
				accessory_overlay = apply_height_offsets(accessory_overlay, H.height, on_head = FALSE)
			standing += accessory_overlay

			if(sprite_accessory.hasinner)
				var/mutable_appearance/inner_accessory_overlay = mutable_appearance(sprite_accessory.icon, layer = -layer)
				if(sprite_accessory.gender_specific)
					inner_accessory_overlay.icon_state = "[gender]_[key]inner_[sprite_accessory.icon_state]_[layertext]"
				else
					inner_accessory_overlay.icon_state = "m_[key]inner_[sprite_accessory.icon_state]_[layertext]"

				if(sprite_accessory.center)
					inner_accessory_overlay = center_image(inner_accessory_overlay, sprite_accessory.dimension_x, sprite_accessory.dimension_y)

				if(sprite_accessory.body_zone == BODY_ZONE_HEAD)
					inner_accessory_overlay = apply_height_offsets(inner_accessory_overlay, H.height, on_head = TRUE)
				else
					inner_accessory_overlay = apply_height_filters(inner_accessory_overlay, H.height)
				standing += inner_accessory_overlay

			//Here's EXTRA parts of accessories which I should get rid of sometime TODO i guess
			if(sprite_accessory.extra) //apply the extra overlay, if there is one
				var/mutable_appearance/extra_accessory_overlay = mutable_appearance(sprite_accessory.icon, layer = -layer)
				if(sprite_accessory.gender_specific)
					extra_accessory_overlay.icon_state = "[gender]_[key]_extra_[sprite_accessory.icon_state]_[layertext]"
				else
					extra_accessory_overlay.icon_state = "m_[key]_extra_[sprite_accessory.icon_state]_[layertext]"
				if(sprite_accessory.center)
					extra_accessory_overlay = center_image(extra_accessory_overlay, sprite_accessory.dimension_x, sprite_accessory.dimension_y)

				switch(sprite_accessory.extra_color_src) //change the color of the extra overlay
					if(MUTCOLORS)
						if(fixed_mut_color)
							extra_accessory_overlay.color = sanitize_hexcolor(fixed_mut_color, 6, TRUE)
						else
							extra_accessory_overlay.color = sanitize_hexcolor(H.dna.features["mcolor"], 6, TRUE)
					if(MUTCOLORS2)
						extra_accessory_overlay.color = sanitize_hexcolor(H.dna.features["mcolor2"], 6, TRUE)
					if(MUTCOLORS3)
						extra_accessory_overlay.color = sanitize_hexcolor(H.dna.features["mcolor3"], 6, TRUE)
					if(HAIR)
						if(hair_color == "mutcolor")
							extra_accessory_overlay.color = sanitize_hexcolor(H.dna.features["mcolor3"], 6, TRUE)
						else
							extra_accessory_overlay.color = sanitize_hexcolor(H.hair_color, 6, TRUE)
					if(FACEHAIR)
						extra_accessory_overlay.color = sanitize_hexcolor(H.facial_hair_color, 6, TRUE)
					if(EYECOLOR)
						extra_accessory_overlay.color = sanitize_hexcolor(H.left_eye_color, 6, TRUE)

				if(sprite_accessory.body_zone == BODY_ZONE_HEAD)
					extra_accessory_overlay = apply_height_offsets(extra_accessory_overlay, H.height, on_head = TRUE)
				else
					extra_accessory_overlay = apply_height_offsets(extra_accessory_overlay, H.height, on_head = FALSE)
				standing += extra_accessory_overlay

			if(sprite_accessory.extra2) //apply the extra overlay, if there is one
				var/mutable_appearance/extra2_accessory_overlay = mutable_appearance(sprite_accessory.icon, layer = -layer)
				if(sprite_accessory.gender_specific)
					extra2_accessory_overlay.icon_state = "[gender]_[key]_extra2_[sprite_accessory.icon_state]_[layertext]"
				else
					extra2_accessory_overlay.icon_state = "m_[key]_extra2_[sprite_accessory.icon_state]_[layertext]"
				if(sprite_accessory.center)
					extra2_accessory_overlay = center_image(extra2_accessory_overlay, sprite_accessory.dimension_x, sprite_accessory.dimension_y)

				switch(sprite_accessory.extra2_color_src) //change the color of the extra overlay
					if(MUTCOLORS)
						if(fixed_mut_color)
							extra2_accessory_overlay.color = sanitize_hexcolor(fixed_mut_color, 6, TRUE)
						else
							extra2_accessory_overlay.color = sanitize_hexcolor(H.dna.features["mcolor"], 6, TRUE)
					if(MUTCOLORS2)
						extra2_accessory_overlay.color = sanitize_hexcolor(H.dna.features["mcolor2"], 6, TRUE)
					if(MUTCOLORS3)
						extra2_accessory_overlay.color = sanitize_hexcolor(H.dna.features["mcolor3"], 6, TRUE)
					if(HAIR)
						if(hair_color == "mutcolor3")
							extra2_accessory_overlay.color = sanitize_hexcolor(H.dna.features["mcolor"], 6, TRUE)
						else
							extra2_accessory_overlay.color = sanitize_hexcolor(H.hair_color, 6, TRUE)

				if(sprite_accessory.body_zone == BODY_ZONE_HEAD)
					extra2_accessory_overlay = apply_height_offsets(extra2_accessory_overlay, H.height, on_head = TRUE)
				else
					extra2_accessory_overlay = apply_height_offsets(extra2_accessory_overlay, H.height, on_head = FALSE)
				standing += extra2_accessory_overlay

			if((bodypart_alpha != 255) && !override_color)
				for(var/image/overlay as anything in standing)
					//check for a list because setting the alpha of the matrix colors breaks the color (the matrix alpha is set above inside the matrix)
					if(islist(overlay.color))
						continue
					overlay.alpha = bodypart_alpha

			if(!H.overlays_standing[layer])
				H.overlays_standing[layer] = list()
			H.overlays_standing[layer] += standing

	H.apply_overlay(BODYPARTS_EXTENSION_BEHIND_LAYER)
	H.apply_overlay(BODY_BEHIND_LAYER)
	H.apply_overlay(BODYPARTS_EXTENSION_LAYER)
	H.apply_overlay(BODY_ADJ_LAYER)
	H.apply_overlay(BODY_FRONT_LAYER)

/datum/species/proc/handle_bodyparts(mob/living/carbon/human/H)
	//CHECK FOR UPDATE
	for(var/obj/item/bodypart/bodypart as anything in H.bodyparts)
		bodypart.update_limb()
	var/oldkey = H.icon_render_key
	H.icon_render_key = H.generate_icon_render_key()
	if(oldkey == H.icon_render_key)
		return

	H.remove_overlay(BODYPARTS_LAYER)

	//LOAD ICONS
	if(H.limb_icon_cache[H.icon_render_key])
		H.load_limb_from_cache()
		return

	var/is_taur = FALSE
	if(mutant_bodyparts["taur"])
		var/datum/sprite_accessory/taur/taur_legs = GLOB.sprite_accessories["taur"][mutant_bodyparts["taur"][MUTANT_INDEX_NAME]]
		if(taur_legs.hide_legs)
			is_taur = TRUE

	//GENERATE NEW LIMBS
	var/list/new_limbs = list()
	for(var/obj/item/bodypart/bodypart as anything in H.bodyparts)
		if(is_taur && (bodypart.body_part & LEGS|FEET))
			continue
		var/bp_icon = bodypart.get_limb_icon()
		if(islist(bp_icon) && length(bp_icon))
			new_limbs |= bp_icon

	for(var/image/image as anything in new_limbs)
		image = apply_height_filters(image, H.height)
	H.overlays_standing[BODYPARTS_LAYER] = new_limbs
	H.limb_icon_cache[H.icon_render_key] = new_limbs

	H.apply_overlay(BODYPARTS_LAYER)

	H.update_damage_overlays()
	H.update_medicine_overlays()

/datum/species/proc/handle_damage_overlays(mob/living/carbon/human/H)
	H.remove_overlay(DAMAGE_LAYER)

	var/mutable_appearance/damage_overlays = mutable_appearance('modular_septic/icons/mob/human/overlays/damage.dmi', "blank", -DAMAGE_LAYER)
	for(var/obj/item/bodypart/bodypart as anything in H.bodyparts)
		if(bodypart.is_stump())
			continue
		if(bodypart.dmg_overlay_type)
			var/image/damage
			switch(bodypart.body_zone)
				if(BODY_ZONE_PRECISE_FACE, BODY_ZONE_PRECISE_MOUTH)
					damage = mutable_appearance('modular_septic/icons/mob/human/overlays/damage.dmi', "[bodypart.dmg_overlay_type]_[BODY_ZONE_HEAD]_[bodypart.brutestate]0")
				if(BODY_ZONE_PRECISE_VITALS)
					damage = mutable_appearance('modular_septic/icons/mob/human/overlays/damage.dmi', "[bodypart.dmg_overlay_type]_[BODY_ZONE_CHEST]_[bodypart.brutestate]0")
				else
					damage = mutable_appearance('modular_septic/icons/mob/human/overlays/damage.dmi', "[bodypart.dmg_overlay_type]_[bodypart.body_zone]_[bodypart.brutestate]0")
			damage.layer = -DAMAGE_LAYER
			if(bodypart.render_layer == HANDS_PART_LAYER)
				damage.layer = -UPPER_DAMAGE_LAYER
			damage_overlays.add_overlay(damage)
	if(length(damage_overlays.overlays))
		damage_overlays = apply_height_filters(damage_overlays, H.height)
		H.overlays_standing[DAMAGE_LAYER] = damage_overlays

	H.apply_overlay(DAMAGE_LAYER)

/datum/species/proc/handle_medicine_overlays(mob/living/carbon/human/H)
	H.remove_overlay(LOWER_MEDICINE_LAYER)
	H.remove_overlay(UPPER_MEDICINE_LAYER)

	var/mutable_appearance/lower_medicine_overlays = mutable_appearance('modular_septic/icons/mob/human/overlays/medicine_overlays.dmi', "blank", -LOWER_MEDICINE_LAYER)
	var/mutable_appearance/upper_medicine_overlays = mutable_appearance('modular_septic/icons/mob/human/overlays/medicine_overlays.dmi', "blank", -UPPER_MEDICINE_LAYER)
	for(var/obj/item/bodypart/bodypart as anything in H.bodyparts)
		if(bodypart.is_stump())
			continue
		var/image/gauze
		if(bodypart.current_gauze?.medicine_overlay_prefix)
			gauze = mutable_appearance('modular_septic/icons/mob/human/overlays/medicine_overlays.dmi', "[bodypart.current_gauze.medicine_overlay_prefix]_[bodypart.body_zone][bodypart.use_digitigrade ? "_digitigrade" : "" ]")
			gauze.layer = -LOWER_MEDICINE_LAYER
			if(bodypart.render_layer == HANDS_PART_LAYER)
				upper_medicine_overlays.add_overlay(gauze)
			else
				lower_medicine_overlays.add_overlay(gauze)
		var/image/splint
		if(bodypart.current_splint?.medicine_overlay_prefix)
			splint = mutable_appearance('modular_septic/icons/mob/human/overlays/medicine_overlays.dmi', "[bodypart.current_splint.medicine_overlay_prefix]_[check_zone(bodypart.body_zone)][bodypart.use_digitigrade ? "_digitigrade" : "" ]")
			splint.layer = -LOWER_MEDICINE_LAYER
			if(bodypart.render_layer == HANDS_PART_LAYER)
				upper_medicine_overlays.add_overlay(splint)
			else
				lower_medicine_overlays.add_overlay(splint)
	if(length(lower_medicine_overlays.overlays))
		lower_medicine_overlays = apply_height_filters(lower_medicine_overlays, H.height)
		H.overlays_standing[LOWER_MEDICINE_LAYER] = lower_medicine_overlays
	if(length(upper_medicine_overlays.overlays))
		upper_medicine_overlays = apply_height_filters(upper_medicine_overlays, H.height)
		H.overlays_standing[UPPER_MEDICINE_LAYER] = upper_medicine_overlays

	H.apply_overlay(LOWER_MEDICINE_LAYER)
	H.apply_overlay(UPPER_MEDICINE_LAYER)

/datum/species/proc/handle_artery_overlays(mob/living/carbon/human/H)
	H.remove_overlay(ARTERY_LAYER)

	var/mutable_appearance/arteries = mutable_appearance('modular_septic/icons/mob/human/overlays/artery.dmi', "blank", -ARTERY_LAYER)
	for(var/obj/item/bodypart/bodypart as anything in H.bodyparts)
		if(bodypart.is_stump() || !bodypart.is_organic_limb() || !bodypart.get_bleed_rate(TRUE))
			continue
		var/image/artery
		if(bodypart.is_artery_torn())
			artery = mutable_appearance('modular_septic/icons/mob/human/overlays/artery.dmi', "[bodypart.body_zone]_artery1")
			artery.layer = -ARTERY_LAYER
			arteries.add_overlay(artery)
	if(length(arteries.overlays))
		arteries = apply_height_filters(arteries, H.height)
		H.overlays_standing[ARTERY_LAYER] = arteries

	H.apply_overlay(ARTERY_LAYER)

/datum/species/proc/handle_gore_overlays(mob/living/carbon/human/H)
	H.remove_overlay(GORE_LAYER)

	var/mutable_appearance/gore = mutable_appearance('modular_septic/icons/mob/human/overlays/gore.dmi', "blank", -GORE_LAYER)
	for(var/obj/item/bodypart/bodypart as anything in H.bodyparts)
		if(bodypart.is_stump() || !bodypart.is_organic_limb() || !bodypart.get_bleed_rate(TRUE))
			continue
		var/image/spill
		if(bodypart.spilled && bodypart.spilled_overlay)
			spill = mutable_appearance('modular_septic/icons/mob/human/overlays/gore.dmi', "[bodypart.spilled_overlay]")
			if(bodypart.body_zone == BODY_ZONE_PRECISE_VITALS)
				var/has_gut = FALSE
				for(var/datum/component/rope/possible_rope as anything in H.GetComponents(/datum/component/rope))
					var/obj/item/organ/roped_organ = possible_rope.roped
					if(istype(roped_organ) && (ORGAN_SLOT_INTESTINES in roped_organ.organ_efficiency))
						has_gut = TRUE
						break
				if(!has_gut)
					spill.icon_state += "_gutless"
			spill.layer = -GORE_LAYER
			gore.add_overlay(spill)
	if(length(gore.overlays))
		gore = apply_height_filters(gore, H.height)
		H.overlays_standing[GORE_LAYER] = gore

	H.apply_overlay(GORE_LAYER)

/datum/species/proc/get_random_features()
	var/list/returned = MANDATORY_FEATURE_LIST
	returned["mcolor"] = random_color()
	returned["mcolor2"] = random_color()
	returned["mcolor3"] = random_color()
	return returned

/datum/species/proc/get_random_mutant_bodyparts(list/features) //Needs features to base the colour off of
	var/list/mutantpart_list = list()
	var/list/bodyparts_to_add = LAZYCOPY(default_mutant_bodyparts)
	for(var/key in bodyparts_to_add)
		var/datum/sprite_accessory/sprite_accessory
		if(bodyparts_to_add[key] == ACC_RANDOM)
			sprite_accessory = random_accessory_of_key_for_species(key, src)
		else
			sprite_accessory = LAZYACCESSASSOC(GLOB.sprite_accessories, key, bodyparts_to_add[key])
			if(!sprite_accessory)
				continue
		var/list/color_list = sprite_accessory.get_default_color(features, src)
		var/list/final_list = list()
		final_list[MUTANT_INDEX_NAME] = sprite_accessory.name
		final_list[MUTANT_INDEX_COLOR] = color_list
		mutantpart_list[key] = final_list

	return mutantpart_list

/datum/species/proc/get_random_body_markings(list/features) //Needs features to base the colour off of
	return list()
