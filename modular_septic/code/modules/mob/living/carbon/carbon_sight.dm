/mob/living/carbon/update_sight()
	if(!client)
		return

	if(stat == DEAD)
		sight = (SEE_TURFS|SEE_MOBS|SEE_OBJS)
		see_in_dark = 8
		see_invisible = SEE_INVISIBLE_OBSERVER
		return

	sight = initial(sight)
	lighting_alpha = initial(lighting_alpha)
	var/obj/item/organ/eyes/LE = LAZYACCESS(eye_organs, 1)
	var/obj/item/organ/eyes/RE = LAZYACCESS(eye_organs, 2)
	if(LE || RE)
		see_in_dark = max(RE?.see_in_dark, LE?.see_in_dark)
		see_invisible = max(RE?.see_invisible, LE?.see_invisible)
		sight |= RE?.sight_flags
		sight |= LE?.sight_flags
		if(!isnull(RE?.lighting_alpha) && !isnull(LE?.lighting_alpha))
			lighting_alpha = min(RE?.lighting_alpha, LE?.lighting_alpha)
		else if(!isnull(RE?.lighting_alpha))
			lighting_alpha = RE?.lighting_alpha
		else if(!isnull(LE?.lighting_alpha))
			lighting_alpha = LE?.lighting_alpha
	else
		update_tint()

	if(client.eye != src)
		var/atom/A = client.eye
		if(A.update_remote_sight(src)) //returns 1 if we override all other sight updates.
			return

	if(glasses)
		var/obj/item/clothing/glasses/G = glasses
		sight |= G.vision_flags
		see_in_dark = max(G.darkness_view, see_in_dark)
		if(G.invis_override)
			see_invisible = G.invis_override
		else
			see_invisible = min(G.invis_view, see_invisible)
		if(!isnull(G.lighting_alpha))
			lighting_alpha = min(lighting_alpha, G.lighting_alpha)

	if(HAS_TRAIT(src, TRAIT_THERMAL_VISION))
		sight |= (SEE_MOBS)
		lighting_alpha = min(lighting_alpha, LIGHTING_PLANE_ALPHA_MOSTLY_VISIBLE)

	if(HAS_TRAIT(src, TRAIT_XRAY_VISION))
		sight |= (SEE_TURFS|SEE_MOBS|SEE_OBJS)
		see_in_dark = max(see_in_dark, 8)

	if(see_override)
		see_invisible = see_override

	if(SSmapping.level_trait(z, ZTRAIT_NOXRAY))
		sight = null

	return ..()

/mob/living/carbon/set_usable_eyes(new_value)
	. = ..()
	if(isnull(.))
		return
	update_eyes()
	update_sight()
	update_tint()

/mob/living/carbon/get_total_tint()
	. = 0
	if(isclothing(head))
		. += head.tint
	if(isclothing(wear_mask))
		. += wear_mask.tint

	var/obj/item/organ/eyes/LE = LAZYACCESS(eye_organs, 1)
	var/obj/item/organ/eyes/RE = LAZYACCESS(eye_organs, 2)
	if(!RE && !LE)
		return INFINITY //we blind

/mob/living/carbon/proc/update_eyes()
	if(!client)
		return

	var/obj/item/organ/eyes/LE = LAZYACCESS(eye_organs, 1)
	var/obj/item/organ/eyes/RE = LAZYACCESS(eye_organs, 2)
	var/left_damage = (LE ? LE.get_eye_damage_level() : 3)
	var/right_damage = (RE ? RE.get_eye_damage_level() : 3)
	if((left_damage >= 3) && (right_damage >= 3))
		become_blind(EYE_DAMAGE)
		return TRUE
	else
		cure_blind(EYE_DAMAGE)

	var/fuck_with_fov = TRUE
	if(head?.fov_shadow_angle)
		fuck_with_fov = FALSE

	var/datum/component/field_of_vision/fov = GetComponent(/datum/component/field_of_vision)
	if(!fov)
		if(left_damage in 1 to 2)
			overlay_fullscreen("left_eye_damage", /atom/movable/screen/fullscreen/impaired/left, left_damage)
		else
			clear_fullscreen("left_eye_damage")
		if(right_damage in 1 to 2)
			overlay_fullscreen("right_eye_damage", /atom/movable/screen/fullscreen/impaired/right, right_damage)
		else
			clear_fullscreen("right_eye_damage")
	else if(fuck_with_fov)
		if(!left_damage && (fov?.shadow_angle == FOV_180PLUS45_DEGREES))
			fov.generate_fov_holder(source = src, shadow_angle = FOV_90_DEGREES, angle = get_fov_angle(FOV_90_DEGREES), register = FALSE, delete_holder = TRUE)
		else if(left_damage >= 3)
			fov.generate_fov_holder(source = src, shadow_angle = FOV_180PLUS45_DEGREES, angle = get_fov_angle(FOV_180PLUS45_DEGREES), register = FALSE, delete_holder = TRUE)

		if(!right_damage && (fov?.shadow_angle == FOV_180MINUS45_DEGREES))
			fov.generate_fov_holder(source = src, shadow_angle = FOV_90_DEGREES, angle = get_fov_angle(FOV_90_DEGREES), register = FALSE, delete_holder = TRUE)
		else if(right_damage >= 3)
			fov.generate_fov_holder(source = src, shadow_angle = FOV_180MINUS45_DEGREES, angle = get_fov_angle(FOV_180MINUS45_DEGREES), register = FALSE, delete_holder = TRUE)

	return TRUE
