/obj/item/bodypart/l_foot
	name = "left foot"
	desc = "Seems like left has taken another meaning here."
	icon_state = "default_human_r_foot"
	attack_verb_continuous = list("kicks", "stomps")
	attack_verb_simple = list("kick", "stomp")
	parent_body_zone = BODY_ZONE_L_LEG
	body_zone = BODY_ZONE_PRECISE_L_FOOT
	body_part = FOOT_LEFT
	max_damage = 30
	max_stamina_damage = 30
	stance_index = 3
	px_x = -2
	px_y = 9
	stam_heal_tick = 1

	max_cavity_item_size = WEIGHT_CLASS_TINY
	max_cavity_volume = 2.5

	melee_hit_modifier = -2
	melee_hit_zone_modifier = -1

	amputation_point_name = "left ankle"
	bone_type = BONE_L_FOOT
	tendon_type = TENDON_L_FOOT
	artery_type = ARTERY_L_FOOT
	nerve_type = NERVE_L_FOOT
	starting_digits = list(
		"big toe" = /obj/item/digit/toe/big,
		"index toe" = /obj/item/digit/toe/index,
		"middle toe" = /obj/item/digit/toe/middle,
		"ring toe" = /obj/item/digit/toe/ring,
		"pinky toe" = /obj/item/digit/toe/pinky,
	)

/obj/item/bodypart/l_foot/drop_limb(special = FALSE, dismembered = FALSE, ignore_child_limbs = FALSE, destroyed = FALSE, wounding_type = WOUND_SLASH)
	if(owner && !special)
		if(owner.legcuffed)
			owner.legcuffed.forceMove(owner.drop_location())
			owner.legcuffed.dropped(owner)
			owner.legcuffed = null
			owner.update_inv_legcuffed()
		if(owner.shoes)
			owner.dropItemToGround(owner.shoes, TRUE)
	return ..()
