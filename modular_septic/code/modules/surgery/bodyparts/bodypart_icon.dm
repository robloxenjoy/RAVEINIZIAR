/obj/item/bodypart
	// Coloring and proper icon updating variables
	var/skin_tone = ""
	var/body_gender = ""
	var/species_id = ""
	var/species_color = ""
	var/mutation_color = ""
	var/no_update = FALSE
	var/should_draw_gender = FALSE
	var/should_draw_greyscale = FALSE
	var/gender_rendering = FALSE
	var/advanced_rendering = TRUE

	/// Icon used to generate standing overlays
	var/render_icon
	/// Layer used to generate standing overlays
	var/render_layer = BODYPARTS_LAYER
	/// Previously used for hands - used for rendering the limb's associated limb
	var/aux_zone
	/// Previously used for hands - used for rendering the limb's associated limbs
	var/aux_layer = BODYPARTS_LAYER
	/// The type of damage overlay (if any) to use when this bodypart is bruised/burned.
	var/dmg_overlay_type

	/// Alpha of markings on this limb
	var/markings_alpha = 255
	/// Body markings currently inhabiting the limb
	var/list/list/body_markings

//Updates an organ's brute/burn states for use by update_damage_overlays()
//Returns 1 if we need to update overlays. 0 otherwise.
/obj/item/bodypart/proc/update_bodypart_damage_state()
	var/tbrute = FLOOR( (brute_dam/max_damage)*3, 1 )
	var/tburn = FLOOR( (burn_dam/max_damage)*3, 1 )
	if((tbrute != brutestate) || (tburn != burnstate))
		brutestate = tbrute
		burnstate = tburn
		return TRUE
	return FALSE

//we inform the bodypart of the changes that happened to the owner, or give it the informations from a source mob.
/obj/item/bodypart/proc/update_limb(dropping_limb, mob/living/carbon/source)
	var/mob/living/carbon/updater
	if(source)
		updater = source
	else
		updater = owner

	//dropped limb
	if(!updater)
		no_update = TRUE
	else if(original_owner && !IS_WEAKREF_OF(updater, original_owner)) //Foreign limb
		no_update = TRUE
	else
		no_update = FALSE

	if(!original_owner && owner)
		original_owner = WEAKREF(owner)

	if(is_organic_limb())
		if(HAS_TRAIT(src, TRAIT_ROTTEN))
			render_icon = 'modular_septic/icons/mob/human/species/dead/rot_parts.dmi'
			species_id = "rot"
			dmg_overlay_type = ""
			should_draw_gender = FALSE
			should_draw_greyscale = FALSE
			no_update = TRUE
			return
		if(HAS_TRAIT(src, TRAIT_PLASMABURNT))
			render_icon = 'modular_septic/icons/mob/human/species/skeleton/plasmaman_parts.dmi'
			species_id = "plasmaman"
			dmg_overlay_type = ""
			should_draw_gender = FALSE
			should_draw_greyscale = FALSE
			no_update = TRUE
			return
		if(HAS_TRAIT(src, TRAIT_HUSK) || (updater && HAS_TRAIT(updater, TRAIT_HUSK)))
			render_icon = 'modular_septic/icons/mob/human/species/dead/husk_parts.dmi'
			species_id = "husk" //overrides species_id
			dmg_overlay_type = "" //no damage overlay shown when husked
			should_draw_gender = FALSE
			should_draw_greyscale = FALSE
			no_update = TRUE
			return

	if(no_update)
		return

	if(!animal_origin && ishuman(updater))
		var/mob/living/carbon/human/human_updater = updater
		should_draw_greyscale = FALSE

		var/datum/species/updater_species = human_updater.dna.species
		species_id = updater_species.limbs_id
		species_flags_list = human_updater.dna.species.species_traits

		if(updater_species.use_skintones)
			skin_tone = human_updater.skin_tone
			should_draw_greyscale = TRUE
		else
			skin_tone = ""

		body_gender = human_updater.body_type
		should_draw_gender = updater_species.sexes

		if((MUTCOLORS in updater_species.species_traits) || (DYNCOLORS in updater_species.species_traits))
			if(updater_species.fixed_mut_color)
				species_color = updater_species.fixed_mut_color
			else
				species_color = human_updater.dna.features["mcolor"]
			should_draw_greyscale = TRUE
		else
			species_color = ""

		if(!dropping_limb && human_updater.dna.check_mutation(HULK))
			mutation_color = "#00AA00"
		else
			mutation_color = ""

		dmg_overlay_type = updater_species.damage_overlay_type

		if(advanced_rendering)
			if(LAZYLEN(updater_species.body_markings))
				body_markings = list()
				if(updater_species.body_markings[body_zone])
					body_markings[body_zone] = updater_species.body_markings[body_zone].Copy()
				if(aux_zone && updater_species.body_markings[aux_zone])
					body_markings[aux_zone] = updater_species.body_markings[aux_zone].Copy()
				if((body_zone == BODY_ZONE_PRECISE_FACE) && updater_species.body_markings[BODY_ZONE_HEAD])
					body_markings[BODY_ZONE_HEAD] = updater_species.body_markings[BODY_ZONE_HEAD].Copy()
			if(!LAZYLEN(body_markings))
				body_markings = null
			if(updater_species.bodypart_alpha)
				alpha = updater_species.bodypart_alpha
			if(updater_species.markings_alpha)
				markings_alpha = updater_species.markings_alpha
			if(updater_species.limbs_icon)
				render_icon = updater_species.limbs_icon
	else if(animal_origin == MONKEY_BODYPART) //currently monkeys are the only non human mob to have damage overlays.
		dmg_overlay_type = animal_origin

	if(status == BODYPART_ROBOTIC)
		dmg_overlay_type = "robotic"

	if(dropping_limb)
		no_update = TRUE //when attached, the limb won't be affected by the appearance changes of its mob owner.

//to update the bodypart's icon when not attached to a mob
/obj/item/bodypart/proc/update_icon_dropped()
	//to erase the default sprite - we're building the visual aspects of the bodypart through overlays alone.
	icon_state =  ""
	cut_overlays()
	var/list/standing = list()
	standing |= get_limb_icon(TRUE)
	for(var/image/image in standing)
		image.pixel_x = px_x
		image.pixel_y = px_y
	for(var/obj/item/bodypart/child in src)
		var/list/current_run = child.get_limb_icon(TRUE)
		for(var/image/image in current_run)
			image.pixel_x = px_x
			image.pixel_y = px_y
		standing |= current_run
		for(var/obj/item/bodypart/grandchild in child)
			current_run = grandchild.get_limb_icon(TRUE)
			for(var/image/image in current_run)
				image.pixel_x = px_x
				image.pixel_y = px_y
			standing |= current_run
			//the ride never ends
			for(var/obj/item/bodypart/granderchild in grandchild)
				current_run = granderchild.get_limb_icon(TRUE)
				for(var/image/image in current_run)
					image.pixel_x = px_x
					image.pixel_y = px_y
				standing |= current_run
				for(var/obj/item/bodypart/grandestchild in granderchild)
					current_run = grandestchild.get_limb_icon(TRUE)
					for(var/image/image in current_run)
						image.pixel_x = px_x
						image.pixel_y = px_y
					standing |= current_run
	if(!LAZYLEN(standing))
		icon_state = base_icon_state
		return
	add_overlay(standing)

// Gives you a proper icon appearance for the dismembered limb
/obj/item/bodypart/proc/get_limb_icon(dropped)
	. = list()

	var/image_dir = 0
	if(dropped)
		image_dir = SOUTH
		if(dmg_overlay_type)
			if(body_zone in list(BODY_ZONE_PRECISE_R_HAND, BODY_ZONE_PRECISE_L_HAND))
				if(brutestate)
					. += image('modular_septic/icons/mob/human/overlays/damage.dmi', "[dmg_overlay_type]_[body_zone]_[brutestate]0", -UPPER_DAMAGE_LAYER, image_dir)
				if(burnstate)
					. += image('modular_septic/icons/mob/human/overlays/damage.dmi', "[dmg_overlay_type]_[body_zone]_0[burnstate]", -UPPER_DAMAGE_LAYER, image_dir)
			else
				if(brutestate)
					. += image('modular_septic/icons/mob/human/overlays/damage.dmi', "[dmg_overlay_type]_[body_zone]_[brutestate]0", -DAMAGE_LAYER, image_dir)
				if(burnstate)
					. += image('modular_septic/icons/mob/human/overlays/damage.dmi', "[dmg_overlay_type]_[body_zone]_0[burnstate]", -DAMAGE_LAYER, image_dir)

	var/image/limb = image(layer = -render_layer, dir = image_dir)
	var/image/aux
	. += limb

	if(animal_origin)
		if(is_organic_limb())
			limb.icon = DEFAULT_BODYPART_ICON_ANIMAL
			if(species_id == "husk")
				limb.icon_state = "[animal_origin]_husk_[body_zone]"
			else
				limb.icon_state = "[animal_origin]_[body_zone]"
		else
			limb.icon = DEFAULT_BODYPART_ICON_ROBOTIC
			limb.icon_state = "[animal_origin]_[body_zone]"
		return

	var/icon_gender = (body_gender in FEMININE_BODY_TYPES) ? "f" : "m" //gender of the icon, if applicable

	if(!gender_rendering)
		should_draw_gender = FALSE

	if(advanced_rendering)
		if(should_draw_greyscale)
			limb.icon = render_icon || DEFAULT_BODYPART_ICON_ORGANIC
			if(should_draw_gender)
				limb.icon_state = "[species_id]_[body_zone]_[icon_gender]"
			else if(use_digitigrade)
				limb.icon_state = "digitigrade_[use_digitigrade]_[body_zone]"
			else
				limb.icon_state = "[species_id]_[body_zone]"
		else
			limb.icon = render_icon || DEFAULT_BODYPART_ICON
			if(should_draw_gender)
				limb.icon_state = "[species_id]_[body_zone]_[icon_gender]"
			else
				limb.icon_state = "[species_id]_[body_zone]"
		if(aux_zone)
			aux = image(limb.icon, "[species_id]_[aux_zone]", -aux_layer, image_dir)
			. += aux

	else
		limb.icon = icon
		limb.icon_state = "[body_zone]" //Inorganic limbs are agender
		if(aux_zone)
			aux = image(limb.icon, "[aux_zone]", -aux_layer, image_dir)
			. += aux
		return

	if(should_draw_greyscale)
		var/draw_color = mutation_color || species_color || skintone2hex(skin_tone)
		if(draw_color)
			limb.color = sanitize_hexcolor(draw_color, 6, TRUE)
			if(aux)
				aux.color = limb.color

	if (!owner || is_pseudopart || is_stump() || HAS_TRAIT(src, TRAIT_ROTTEN) || !ishuman(owner))
		return

	var/mob/living/carbon/human/human = owner

	//set specific alpha before setting the markings alpha
	if(alpha != 255)
		for(var/ov in .)
			var/image/overlay = ov
			overlay.alpha = alpha

	if(!LAZYLEN(body_markings))
		return

	//Markings!
	var/override_color
	if(HAS_TRAIT(human, TRAIT_HUSK) || HAS_TRAIT(src, TRAIT_HUSK))
		override_color = "888888"

	for(var/name in body_markings[body_zone])
		var/datum/body_marking/marking = GLOB.body_markings[name]
		var/render_limb_string = body_zone
		if(use_digitigrade)
			render_limb_string = "digitigrade_[use_digitigrade]_[render_limb_string]"

		if(marking.gendered && gender_rendering)
			var/marking_gender = (human.body_type in FEMININE_BODY_TYPES) ? "f" : "m"
			render_limb_string = "[render_limb_string]_[marking_gender]"

		var/mutable_appearance/accessory_overlay = mutable_appearance(marking.icon, "[marking.icon_state]_[render_limb_string]", -BODY_ADJ_LAYER)
		if(body_zone in list(BODY_ZONE_PRECISE_R_HAND, BODY_ZONE_PRECISE_L_HAND))
			accessory_overlay.layer = -HANDS_ADJ_LAYER
		if(override_color)
			accessory_overlay.color = sanitize_hexcolor(override_color, 6, TRUE)
		else
			accessory_overlay.color = sanitize_hexcolor(body_markings[body_zone][name], 6, TRUE)
		accessory_overlay.alpha = markings_alpha
		. += accessory_overlay

	if(aux_zone)
		for(var/key in body_markings[aux_zone])
			var/datum/body_marking/marking = GLOB.body_markings[key]

			var/render_limb_string = aux_zone

			var/mutable_appearance/accessory_overlay = mutable_appearance(marking.icon, "[marking.icon_state]_[render_limb_string]", -BODY_ADJ_LAYER)
			if(body_zone in list(BODY_ZONE_PRECISE_R_HAND, BODY_ZONE_PRECISE_L_HAND))
				accessory_overlay.layer = -HANDS_ADJ_LAYER
			if(override_color)
				accessory_overlay.color = sanitize_hexcolor(override_color, 6, TRUE)
			else
				accessory_overlay.color = sanitize_hexcolor(body_markings[body_zone][key], 6, TRUE)
			accessory_overlay.alpha = markings_alpha
			. += accessory_overlay
