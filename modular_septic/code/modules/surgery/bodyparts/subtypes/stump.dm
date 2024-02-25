/obj/item/bodypart/stump
	name = "limb stump"
	desc = "If you're reading this, you should be stumped."
	limb_flags = BODYPART_NO_STUMP
	limb_efficiency = 0
	max_damage = 25 //placeholder to avoid runtimes, actually set on inherit_from_limb()
	render_icon = 'modular_septic/icons/mob/human/overlays/stump.dmi'
	no_update = TRUE
	gender_rendering = FALSE
	dismemberment_sounds = list('modular_septic/sound/gore/severed.ogg') // A stump Isn't that big, It's smaller then a regular limb so I give it a smaller sounding.

/obj/item/bodypart/stump/transfer_to_limb(obj/item/bodypart/new_limb, mob/living/carbon/was_owner)
	qdel(src)
	return FALSE

/obj/item/bodypart/stump/update_limb(dropping_limb, mob/living/carbon/source)
	return

/obj/item/bodypart/stump/get_limb_icon(dropped)
	if(!is_organic_limb())
		return
	. = list()
	var/image/stump = image(layer = -render_layer)
	if(dropped)
		stump = image(layer = -render_layer, dir = SOUTH)
	else
		stump = image(layer = -render_layer)
	stump.icon = render_icon
	stump.icon_state = "stump_[body_zone]"
	. += stump

/obj/item/bodypart/stump/update_icon_dropped()
	return

/obj/item/bodypart/stump/get_mangled_state()
	return BODYPART_MANGLED_BOTH

/obj/item/bodypart/stump/drop_limb(special = FALSE, dismembered = FALSE, ignore_child_limbs = FALSE, destroyed = FALSE, wounding_type = WOUND_SLASH)
	return ..(destroyed = TRUE)

/obj/item/bodypart/stump/get_shock(painkiller_included, nerve_included)
	nerve_included = FALSE
	return ..()

/obj/item/bodypart/stump/is_stump()
	return TRUE

/obj/item/bodypart/stump/proc/inherit_from_limb(obj/item/bodypart/parent)
	name = "stump of a [parse_zone(parent.body_zone)]"
	parent_body_zone = parent.parent_body_zone
	body_zone = parent.body_zone
	body_part = parent.body_part
	max_cavity_item_size = parent.max_cavity_item_size
	max_cavity_volume = parent.max_cavity_volume
	amputation_point_name = parent.amputation_point_name
	bone_type = parent.bone_type
	artery_type = parent.artery_type
	tendon_type = parent.tendon_type
	nerve_type = parent.nerve_type
	cavity_name = parent.cavity_name
	dismemberment_sounds = parent.dismemberment_sounds?.Copy()
	melee_hit_modifier = parent.melee_hit_modifier
	melee_hit_zone_modifier = parent.melee_hit_zone_modifier
	ranged_hit_modifier = parent.ranged_hit_modifier
	ranged_hit_zone_modifier = parent.ranged_hit_zone_modifier
	max_damage = parent.max_damage
	max_pain_damage = parent.max_pain_damage
	max_stamina_damage = parent.max_stamina_damage
	status = parent.status
	limb_flags = parent.limb_flags
	limb_flags &= ~(BODYPART_HAS_BONE|BODYPART_HAS_TENDON|BODYPART_HAS_NERVE|BODYPART_VITAL)
	animal_origin = parent.animal_origin
	for(var/obj/item/organ/artery/artery in parent.getorganslotlist(ORGAN_SLOT_ARTERY))
		var/obj/item/organ/artery/copycat = new artery.type(src)
		copycat.name = "mangled [artery.name]"
		copycat.organ_efficiency = list(ORGAN_SLOT_ARTERY = 0)
		copycat.applyOrganDamage(artery.maxHealth)
		break
