/obj/item/organ/eyes
	name = "eye"
	icon_state = "eye"
	base_icon_state = "eye"
	desc = "I see you!"
	zone = BODY_ZONE_PRECISE_R_EYE
	organ_efficiency = list(ORGAN_SLOT_EYES = 100) // we actually handle each eye individually, this is fine
	w_class = WEIGHT_CLASS_TINY
	side = RIGHT_SIDE

	maxHealth = STANDARD_ORGAN_THRESHOLD * 0.5 // very mushy organ
	high_threshold = STANDARD_ORGAN_THRESHOLD * 0.35
	low_threshold = STANDARD_ORGAN_THRESHOLD * 0.1

	low_threshold_passed = span_info("Distant objects become less tangible.")
	high_threshold_passed = span_info("Everything starts to look a lot less clear.")
	now_failing = span_warning("Darkness envelopes me, as my eye goes blind!")
	now_fixed = span_info("Color and shapes are once again perceivable.")
	high_threshold_cleared = span_info("My vision functions passably once more.")
	low_threshold_cleared = span_info("My vision is cleared of any ailment.")

	// remember that this is normally DOUBLED (2 eyes)
	organ_volume = 0.25
	max_blood_storage = 5
	current_blood = 5
	blood_req = 1
	oxygen_req = 0.5
	nutriment_req = 0.25
	hydration_req = 0.25

	var/sight_flags = 0
	var/see_in_dark = 2
	var/tint = 0
	/// Set to a hex code to override a mob's eye color
	var/eye_color = ""
	/// Used to store the owner's original eye color, before we got inserted
	var/old_eye_color = "ffffff"
	var/eye_icon_state = "eye"
	var/flash_protect = FLASH_PROTECTION_NONE
	var/see_invisible = SEE_INVISIBLE_LIVING
	var/lighting_alpha
	var/no_glasses = FALSE
	/// Changes how the eyes overlay is applied, makes it apply over the lighting layer
	var/overlay_ignore_lighting = FALSE
	/// Overlay iris when possible
	var/iris_icon_state = "eye-iris"

/obj/item/organ/eyes/left
	zone = BODY_ZONE_PRECISE_L_EYE
	side = LEFT_SIDE

/obj/item/organ/eyes/update_overlays()
	. = ..()
	if(iris_icon_state)
		var/image/iris = image(icon, src, iris_icon_state, layer+0.1)
		iris.color = eye_color || old_eye_color
		. += iris

/obj/item/organ/eyes/update_icon(updates)
	. = ..()
	transform = (side == RIGHT_SIDE) ? null : matrix(-1, 0, 0, 0, 1, 0)

/obj/item/organ/eyes/switch_side(new_side = RIGHT_SIDE)
	side = new_side
	if(side == RIGHT_SIDE)
		zone = BODY_ZONE_PRECISE_R_EYE
		eye_icon_state = "[initial(eye_icon_state)]-right"
	else
		zone = BODY_ZONE_PRECISE_L_EYE
		eye_icon_state = "[initial(eye_icon_state)]-left"
	if(!owner)
		current_zone = zone
	update_appearance()

/obj/item/organ/eyes/Insert(mob/living/carbon/new_owner, special = FALSE, drop_if_replaced = TRUE, new_zone = null)
	. = ..()
	var/mob/living/carbon/human/human_new_owner = owner
	var/new_side = (current_zone == BODY_ZONE_PRECISE_L_EYE ? LEFT_SIDE : (current_zone == BODY_ZONE_PRECISE_R_EYE ? RIGHT_SIDE : side))
	switch_side(new_side)
	if(istype(human_new_owner))
		if(current_zone == BODY_ZONE_PRECISE_L_EYE)
			old_eye_color = human_new_owner.left_eye_color
			if(eye_color)
				human_new_owner.left_eye_color = eye_color
				human_new_owner.regenerate_icons()
			else
				eye_color = human_new_owner.left_eye_color
		else if(current_zone == BODY_ZONE_PRECISE_R_EYE)
			old_eye_color = human_new_owner.right_eye_color
			if(eye_color)
				human_new_owner.right_eye_color = eye_color
				human_new_owner.regenerate_icons()
			else
				eye_color = human_new_owner.right_eye_color
		if(HAS_TRAIT(human_new_owner, TRAIT_NIGHT_VISION) && isnull(lighting_alpha))
			lighting_alpha = LIGHTING_PLANE_ALPHA_NV_TRAIT
	var/sight_index = 1
	if(side == RIGHT_SIDE)
		sight_index = 2
	new_owner.eye_organs.len = max(length(new_owner.eye_organs), sight_index)
	new_owner.eye_organs[sight_index] = src
	new_owner.update_eyes()
	new_owner.update_sight()
	new_owner.update_tint()
	if(new_owner.has_dna())
		new_owner.dna.species.handle_body(new_owner) //updates eye icon

/obj/item/organ/eyes/Remove(mob/living/carbon/old_owner, special = 0)
	var/sight_index = 1
	if(side == RIGHT_SIDE)
		sight_index = 2
	var/mob/living/carbon/human/human_old_owner = old_owner
	if(istype(human_old_owner) && eye_color)
		if(current_zone == BODY_ZONE_PRECISE_L_EYE)
			human_old_owner.left_eye_color = old_eye_color
		else if(current_zone == BODY_ZONE_PRECISE_R_EYE)
			human_old_owner.right_eye_color = old_eye_color
	. = ..()
	old_owner.eye_organs[sight_index] = null
	old_owner.update_eyes()
	old_owner.update_sight()
	old_owner.update_tint()
	if(old_owner.has_dna())
		old_owner.dna.species.handle_body(old_owner)

/obj/item/organ/eyes/applyOrganDamage(amount, maximum = maxHealth, silent = FALSE)
	. = ..()
	if(owner)
		owner.update_eyes()
		owner.update_sight()
		owner.update_tint()

/obj/item/organ/eyes/proc/refresh()
	if(ishuman(owner))
		var/mob/living/carbon/human/affected_human = owner
		if(zone == BODY_ZONE_PRECISE_L_EYE)
			old_eye_color = affected_human.left_eye_color
		else
			old_eye_color = affected_human.right_eye_color
		if(eye_color)
			if(zone == BODY_ZONE_PRECISE_L_EYE)
				affected_human.left_eye_color = eye_color
			else
				affected_human.right_eye_color = eye_color
			affected_human.regenerate_icons()
		else
			if(zone == BODY_ZONE_PRECISE_L_EYE)
				eye_color = affected_human.left_eye_color
			else
				eye_color = affected_human.right_eye_color
		if(HAS_TRAIT(affected_human, TRAIT_NIGHT_VISION) && isnull(lighting_alpha))
			lighting_alpha = LIGHTING_PLANE_ALPHA_NV_TRAIT
	owner.update_eyes()
	owner.update_sight()
	owner.update_tint()
	if(owner.has_dna() && ishuman(owner))
		owner.dna.species.handle_body(owner) //updates eye icon

/obj/item/organ/eyes/proc/get_eye_damage_level()
	switch(get_slot_efficiency(ORGAN_SLOT_EYES))
		if(-INFINITY to 1)
			return 3
		if(1 to 50)
			return 2
		if(50 to 80)
			return 1
		if(80 to INFINITY)
			return 0

