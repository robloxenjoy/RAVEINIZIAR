/obj/item/bodypart/vitals
	name = "vitals"
	desc = "If someone lost this, yeah they're absolutely dead."
	icon = 'modular_septic/icons/obj/items/surgery.dmi'
	icon_state = "vitals"
	base_icon_state = "vitals"
	max_damage = 100
	max_stamina_damage = 100
	parent_body_zone = BODY_ZONE_CHEST
	body_zone = BODY_ZONE_PRECISE_VITALS
	body_part = VITALS
	stam_damage_coeff = 1
	maxdam_wound_penalty = 20 //hard to hit this cap
	dismemberable = FALSE
	limb_flags = BODYPART_EDIBLE|BODYPART_NO_STUMP|BODYPART_HAS_TENDON|BODYPART_HAS_NERVE|BODYPART_HAS_ARTERY
	children_zones = list(BODY_ZONE_PRECISE_GROIN)
	gender_rendering = TRUE

	max_cavity_item_size = WEIGHT_CLASS_BULKY
	max_cavity_volume = 6

	melee_hit_modifier = -1
	melee_hit_zone_modifier = 0

	cavity_name = "abdominal cavity"
	amputation_point_name = "thoracic spine"
	tendon_type = TENDON_VITALS
	artery_type = ARTERY_VITALS
	nerve_type = NERVE_VITALS

	spilled_overlay = "gut_busted"

/obj/item/bodypart/vitals/get_limb_icon(dropped)
	if(dropped && !isbodypart(loc))
		var/image/funky_anus = image(icon, src, base_icon_state, BELOW_MOB_LAYER)
		if(locate(/obj/item/organ/bone) in src)
			funky_anus.icon_state = "[base_icon_state]-bone"
		funky_anus.plane = plane
		. += funky_anus
