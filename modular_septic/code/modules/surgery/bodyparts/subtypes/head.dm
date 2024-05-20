/obj/item/bodypart/head
	name = "Голова"
	desc = "Всему!"
	icon_state = "default_human_head"
	max_damage = 75
	max_stamina_damage = 75
	parent_body_zone = BODY_ZONE_PRECISE_NECK
	body_zone = BODY_ZONE_HEAD
	body_part = HEAD
	w_class = WEIGHT_CLASS_BULKY // Quite a hefty load
	slowdown = 1 // Balancing measure
	px_x = 0
	px_y = -8
	stam_damage_coeff = 1
	limb_flags = BODYPART_EDIBLE|BODYPART_NO_STUMP|BODYPART_HAS_BONE|BODYPART_HAS_TENDON|BODYPART_HAS_NERVE|BODYPART_HAS_ARTERY //stump should be handled by the neck
	children_zones = list(BODY_ZONE_PRECISE_R_EYE, BODY_ZONE_PRECISE_L_EYE, BODY_ZONE_PRECISE_FACE, BODY_ZONE_PRECISE_MOUTH)
	gender_rendering = TRUE

	max_cavity_item_size = WEIGHT_CLASS_SMALL
	max_cavity_volume = 6

	melee_hit_modifier = -4
	melee_hit_zone_modifier = -2

	cavity_name = "cranial cavity"
	amputation_point_name = "neck"
	bone_type = BONE_HEAD
	tendon_type = TENDON_HEAD
	artery_type = ARTERY_HEAD
	nerve_type = NERVE_HEAD

	throw_range = 3 //bowling
	maxdam_wound_penalty = 20 //somewhat hard to hit this cap, better of trying to hit the neck
	dismemberment_sounds = list(
		'modular_septic/sound/gore/newhead_explodie1.ogg',
		'modular_septic/sound/gore/newhead_explodie2.ogg',
	)
	dismemberment_volume = 140

	/// Left eye
	var/obj/item/bodypart/l_eyelid/left_eye
	/// Right eye
	var/obj/item/bodypart/r_eyelid/right_eye
	/// Face
	var/obj/item/bodypart/face/face
	/// Jaw
	var/obj/item/bodypart/mouth/jaw

	// ~limb appearance info
	/// Hair colour and style
	var/hair_color = "000000"
	var/hairstyle = "Bald"
	var/hair_alpha = 255

/obj/item/bodypart/head/Destroy(force)
	QDEL_NULL(left_eye)
	QDEL_NULL(right_eye)
	QDEL_NULL(face)
	QDEL_NULL(jaw)
	return ..()

/obj/item/bodypart/head/desc_chaser(mob/user)
	. = list()
	if(prob(10))
		var/image_src = image2html('modular_septic/images/nerdemoji.gif', user, format = "png", sourceonly = TRUE)
		. += "<img src='[image_src]' width=96 height=96>"
	. += ..()

/obj/item/bodypart/head/on_rotten_trait_gain(obj/item/bodypart/source)
	. = ..()
	if(owner)
		ADD_TRAIT(owner, TRAIT_DISFIGURED, GERM_LEVEL_TRAIT)

/obj/item/bodypart/head/on_rotten_trait_loss(obj/item/bodypart/source)
	. = ..()
	if(owner)
		REMOVE_TRAIT(owner, TRAIT_DISFIGURED, GERM_LEVEL_TRAIT)

/obj/item/bodypart/head/handle_atom_del(atom/A)
	if(A == left_eye)
		left_eye = null
		if(!owner)
			update_icon_dropped()
	if(A == right_eye)
		right_eye = null
		if(!owner)
			update_icon_dropped()
	if(A == face)
		face = null
		if(!owner)
			update_icon_dropped()
	if(A == jaw)
		jaw = null
		if(!owner)
			update_icon_dropped()
	return ..()

/obj/item/bodypart/head/surgical_examine(mob/user)
	. = list()
	if(is_organic_limb())
		if(!brain)
			. += span_info("The brain has been removed from [src].")
		else if(brainmob?.health <= HEALTH_THRESHOLD_DEAD)
			. += span_info("[p_theyre(TRUE)] leaking some kind of clear fluid.")
		else if(brainmob)
			if(brainmob.key || brainmob.get_ghost(FALSE, TRUE))
				. += span_info("[p_theyre(TRUE)] muscles are twitching slightly... It seems to have some life still in it.")
			else
				. += span_info("[p_theyre(TRUE)] completely lifeless. Perhaps there'll be a chance for them later.")
		else if(brain?.decoy_override)
			. += span_info("[p_theyre(TRUE)] completely lifeless. Perhaps there'll be a chance for them later.")
		else
			. += span_info("[p_theyre(TRUE)] completely lifeless.")

	if(!face)
		. += span_info("[face?.real_name ? face.real_name : p_they(TRUE)] [p_have()] no face.")
	if(!left_eye)
		. += span_info("[face?.real_name ? face.real_name : p_they(TRUE)] [p_have()] no left eye.")
	if(!right_eye)
		. += span_info("[face?.real_name ? face.real_name : p_they(TRUE)] [p_have()] no right eye.")
	if(!jaw)
		. += span_info("[face?.real_name ? face.real_name : p_they(TRUE)] [p_have()] no jaw.")
	. += ..()

/obj/item/bodypart/head/attach_limb(mob/living/carbon/new_owner, special = FALSE, ignore_parent_limb = FALSE)
	// These are stored before calling super. This is so that if the head is from a different body, it persists its appearance.
	var/hair_color = src.hair_color
	var/hairstyle = src.hairstyle

	. = ..()
	if(!.)
		return

	if(right_eye)
		right_eye = null
	if(left_eye)
		left_eye = null
	if(face)
		face = null
	if(jaw)
		jaw = null

	if(ishuman(new_owner))
		var/mob/living/carbon/human/human_owner = new_owner
		human_owner.hair_color = hair_color
		human_owner.hairstyle = hairstyle

	if(!(new_owner.status_flags & BUILDING_ORGANS))
		new_owner.updatehealth()
		new_owner.update_body()
		new_owner.update_hair()
		new_owner.update_damage_overlays()

/obj/item/bodypart/head/drop_organs(mob/user, violent_removal)
	. = ..()
	right_eye = null
	left_eye = null
	face = null
	jaw = null

/obj/item/bodypart/head/drop_limb(special = FALSE, dismembered = FALSE, ignore_child_limbs = FALSE, destroyed = FALSE, wounding_type = WOUND_SLASH)
	if(!special)
		//Drop all worn head items
		for(var/obj/item/worn_item in list(owner.glasses, owner.ears, owner.head))
			owner.dropItemToGround(worn_item, force = TRUE)

	for(var/creamtype in GLOB.creamed_types)
		qdel(owner.GetComponent(creamtype))

	//Make sure de-zombification happens before bodypart removal instead of during it
	var/oozes = owner.getorganslotlist(ORGAN_SLOT_ZOMBIE)
	for(var/obj/item/organ/ooze as anything in oozes)
		ooze.transfer_to_limb(src, owner)

	return ..()

/obj/item/bodypart/head/update_limb(dropping_limb, mob/living/carbon/source)
	. = ..()
	if(!owner)
		name = initial(name)
		for(var/obj/item/bodypart/face/noface in src)
			if(noface.real_name)
				name = "[noface.real_name] голова"
				break
	else
		name = initial(name)

	if(istype(loc, /obj/item/bodypart/neck))
		var/obj/item/bodypart/neck/neck = loc
		neck.update_limb(dropping_limb, source)

	if(no_update)
		return

	var/mob/living/carbon/carbon
	if(source)
		carbon = source
	else
		carbon = owner

	if(carbon)
		if(HAS_TRAIT(carbon, TRAIT_HUSK) || HAS_TRAIT(src, TRAIT_HUSK))
			hairstyle = "Bald"
			hair_color = "000000"
			hair_alpha = initial(hair_alpha)
		else if(!animal_origin && advanced_rendering)
			var/mob/living/carbon/human/human = carbon
			var/datum/species/species = human.dna.species

			// hair
			if(human.hairstyle && (HAIR in species.species_traits))
				hairstyle = human.hairstyle
				if(species.hair_color)
					if(species.hair_color == "mutcolor")
						hair_color = human.dna.features["mcolor"]
					else if(hair_color == "fixedmutcolor")
						hair_color = "#[species.fixed_mut_color]"
					else
						hair_color = species.hair_color
				else
					hair_color = human.hair_color
				hair_alpha = species.hair_alpha
			else
				hairstyle = "Bald"
				hair_color = "000000"
				hair_alpha = initial(hair_alpha)

/obj/item/bodypart/head/get_limb_icon(dropped)
	. = ..()
	if(!dropped)
		return

	if(advanced_rendering) //having a robotic head hides certain features
		// hair
		if(hairstyle)
			var/datum/sprite_accessory/S = GLOB.hairstyles_list[hairstyle]
			if(S)
				var/image/hair_overlay = image(S.icon, "[S.icon_state]", -HAIR_LAYER, SOUTH)
				hair_overlay.color = "#" + hair_color
				hair_overlay.alpha = hair_alpha
				. += hair_overlay
	if(jaw)
		// lipstick
		if(jaw.lip_style)
			var/image/lips_overlay = image('modular_septic/icons/mob/human/sprite_accessory/human_face.dmi', "lips_[jaw.lip_style]", -BODY_LAYER, SOUTH)
			lips_overlay.color = jaw.lip_color
			. += lips_overlay
		// facial hair
		if(jaw.facial_hairstyle)
			var/datum/sprite_accessory/S2 = GLOB.facial_hairstyles_list[jaw.facial_hairstyle]
			if(S2)
				var/image/facial_overlay = image(S2.icon, "[S2.icon_state]", -HAIR_LAYER, SOUTH)
				facial_overlay.color = "#" + jaw.facial_hair_color
				facial_overlay.alpha = jaw.hair_alpha
				. += facial_overlay

	// eyes
	var/image/left_eye_overlay
	var/image/right_eye_overlay
	var/obj/item/organ/eyes/actual_left_eye = locate(/obj/item/organ/eyes) in left_eye
	var/obj/item/organ/eyes/actual_right_eye = locate(/obj/item/organ/eyes) in right_eye
	if(actual_left_eye)
		left_eye_overlay = image('modular_septic/icons/mob/human/sprite_accessory/human_face.dmi', null, actual_left_eye.eye_icon_state, -BODY_LAYER)
		left_eye_overlay.color = "#000000"
	else
		left_eye_overlay = image('modular_septic/icons/mob/human/sprite_accessory/human_face.dmi', null, "eye-left-missing", -BODY_LAYER)

	if(actual_right_eye)
		right_eye_overlay = image('modular_septic/icons/mob/human/sprite_accessory/human_face.dmi', null, actual_right_eye.eye_icon_state, -BODY_LAYER)
		right_eye_overlay.color = "#000000"
	else
		right_eye_overlay = image('modular_septic/icons/mob/human/sprite_accessory/human_face.dmi', null, "eye-right-missing", -BODY_LAYER)

	if(ishuman(owner) && (OFFSET_HEAD in owner.dna.species.offset_features))
		left_eye_overlay.pixel_x += owner.dna.species.offset_features[OFFSET_HEAD][1]
		left_eye_overlay.pixel_y += owner.dna.species.offset_features[OFFSET_HEAD][2]
		right_eye_overlay.pixel_x += owner.dna.species.offset_features[OFFSET_HEAD][1]
		right_eye_overlay.pixel_y += owner.dna.species.offset_features[OFFSET_HEAD][2]

	. += left_eye_overlay
	. += right_eye_overlay

	//face
	if(!face)
		. += image('modular_septic/icons/mob/human/sprite_accessory/human_face.dmi', null, "face_missing", -BODY_LAYER)
	//jaw
	if(!jaw)
		. += image('modular_septic/icons/mob/human/sprite_accessory/human_face.dmi', null, "lips_missing", -BODY_LAYER)
	//tape gag
	else if(jaw.tapered)
		. += image('modular_septic/icons/mob/human/overlays/tapegag.dmi', null, "tapegag", -UPPER_MEDICINE_LAYER)

/obj/item/bodypart/head/halber
	max_damage = 100
	max_stamina_damage = 100
	maxdam_wound_penalty = 30
	bone_type = BONE_HEAD_HALBER
