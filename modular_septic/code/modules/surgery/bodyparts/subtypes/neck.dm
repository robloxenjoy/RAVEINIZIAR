/obj/item/bodypart/neck
	name = "Шея"
	desc = "Каким образом?"
	icon = 'modular_septic/icons/obj/items/surgery.dmi'
	icon_state = "neck"
	base_icon_state = "neck"
	attack_verb_continuous = list("snaps")
	attack_verb_simple = list("snap")
	parent_body_zone = BODY_ZONE_CHEST
	body_zone = BODY_ZONE_PRECISE_NECK
	body_part = NECK
	limb_flags = BODYPART_EDIBLE|BODYPART_HAS_BONE|BODYPART_HAS_TENDON|BODYPART_HAS_NERVE|BODYPART_HAS_ARTERY
	max_damage = 30
	max_stamina_damage = 30
	wound_resistance = -5
	maxdam_wound_penalty = 5 // too easy to hit max damage, too lethal
	children_zones = list(BODY_ZONE_HEAD)
	stam_heal_tick = 1
	can_be_disabled = FALSE

	max_cavity_item_size = WEIGHT_CLASS_TINY
	max_cavity_volume = 2.5

	melee_hit_modifier = -3
	melee_hit_zone_modifier = -1

	throw_range = 3
	px_x = 0
	px_y = -8
	dismemberment_sounds = list(
		'modular_septic/sound/gore/neck_explodie1.ogg',
		'modular_septic/sound/gore/neck_explodie2.ogg',
	)
	dismemberment_volume = 125

	cavity_name = "esophagus"
	amputation_point_name = "trachea"
	bone_type = BONE_NECK
	tendon_type = TENDON_NECK
	artery_type = ARTERY_NECK
	nerve_type = NERVE_NECK

/obj/item/bodypart/neck/get_limb_icon(dropped)
	var/obj/item/bodypart/head/head = locate(/obj/item/bodypart/head) in src
	if(dropped && !isbodypart(loc))
		if(head)
			. = list()
			. |= head.get_limb_icon(dropped)
		else
			var/image/funky_anus = image(icon, src, base_icon_state, BELOW_MOB_LAYER)
			if(locate(/obj/item/organ/bone) in src)
				funky_anus.icon_state = "[base_icon_state]-bone"
			funky_anus.plane = plane
			. += funky_anus

/obj/item/bodypart/neck/update_limb(dropping_limb, mob/living/carbon/source)
	. = ..()
	if(!owner)
		name = initial(name)
		for(var/obj/item/bodypart/head/nohead in src)
			if(nohead.face)
				name = "[nohead.face.real_name]'s neck"
				break
	else
		name = initial(name)

/obj/item/bodypart/neck/halber
	max_damage = 50
	max_stamina_damage = 50
	wound_resistance = -2
	maxdam_wound_penalty = 15
	bone_type = BONE_NECK_HALBER