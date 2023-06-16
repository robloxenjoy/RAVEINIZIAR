/obj/item/bodypart/l_hand
	name = "left hand"
	desc = "In old english, left meant weak, guess they were onto something if you're finding this."
	icon_state = "default_human_l_hand"
	attack_verb_continuous = list("slaps", "punches")
	attack_verb_simple = list("slap", "punch")
	parent_body_zone = BODY_ZONE_L_ARM
	body_zone = BODY_ZONE_PRECISE_L_HAND
	body_part = HAND_LEFT
	render_layer = HANDS_PART_LAYER
	max_damage = 30
	max_stamina_damage = 30
	held_index = LEFT_HANDS
	px_x = -6
	px_y = -3
	stam_heal_tick = 1

	max_cavity_item_size = WEIGHT_CLASS_TINY
	max_cavity_volume = 2.5

	melee_hit_modifier = -2
	melee_hit_zone_modifier = -1

	amputation_point_name = "left wrist"
	bone_type = BONE_L_HAND
	tendon_type = TENDON_L_HAND
	artery_type = ARTERY_L_HAND
	nerve_type = NERVE_L_HAND
	starting_digits = list(
		"thumb" = /obj/item/digit/finger/thumb,
		"index finger" = /obj/item/digit/finger/index,
		"middle finger" = /obj/item/digit/finger/middle,
		"ring finger" = /obj/item/digit/finger/ring,
		"pinky finger" = /obj/item/digit/finger/pinky,
	)

/obj/item/bodypart/l_hand/drop_limb(special = FALSE, dismembered = FALSE, ignore_child_limbs = FALSE, destroyed = FALSE, wounding_type = WOUND_SLASH)
	var/mob/living/carbon/C = owner
	. = ..()
	if(C && !special)
		if(C.handcuffed)
			C.handcuffed.forceMove(drop_location())
			C.handcuffed.dropped(C)
			C.set_handcuffed(null)
			C.update_handcuffed()
		if(C.gloves)
			C.dropItemToGround(C.gloves, TRUE)
		if(C.wrists)
			C.dropItemToGround(C.wrists, TRUE)
		C.update_inv_gloves() //to remove the bloody hands overlay
		C.update_inv_wrists()

/obj/item/bodypart/l_hand/halber
	max_damage = 60
	max_stamina_damage = 60
	bone_type = BONE_L_HAND_HALBER