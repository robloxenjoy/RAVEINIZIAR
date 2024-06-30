/obj/item/bodypart/r_arm
	name = "Правая Рука"
	desc = "Конечность."
	icon_state = "default_human_r_arm"
	attack_verb_continuous = list("шлёпает")
	attack_verb_simple = list("шлёпать")
	max_damage = 50
	max_stamina_damage = 50
	parent_body_zone = BODY_ZONE_CHEST
	body_zone = BODY_ZONE_R_ARM
	body_part = ARM_RIGHT
	px_x = 6
	px_y = 0
	stam_heal_tick = 1

	children_zones = list(BODY_ZONE_PRECISE_R_HAND)
	max_cavity_item_size = WEIGHT_CLASS_SMALL
	max_cavity_volume = 3

	melee_hit_modifier = -1
	melee_hit_zone_modifier = 0

	amputation_point_name = "правое плечо"
	bone_type = BONE_R_ARM
	tendon_type = TENDON_R_ARM
	artery_type = ARTERY_R_ARM

/obj/item/bodypart/r_arm/set_owner(new_owner)
	. = ..()
	if(. == FALSE)
		return
	if(owner)
		if(HAS_TRAIT(owner, TRAIT_PARALYSIS_R_ARM))
			ADD_TRAIT(src, TRAIT_PARALYSIS, TRAIT_PARALYSIS_R_ARM)
			RegisterSignal(owner, SIGNAL_REMOVETRAIT(TRAIT_PARALYSIS_R_ARM), PROC_REF(on_owner_paralysis_loss))
		else
			REMOVE_TRAIT(src, TRAIT_PARALYSIS, TRAIT_PARALYSIS_R_ARM)
			RegisterSignal(owner, SIGNAL_ADDTRAIT(TRAIT_PARALYSIS_R_ARM), PROC_REF(on_owner_paralysis_gain))
	if(.)
		var/mob/living/carbon/old_owner = .
		if(HAS_TRAIT(old_owner, TRAIT_PARALYSIS_R_ARM))
			UnregisterSignal(old_owner, SIGNAL_REMOVETRAIT(TRAIT_PARALYSIS_R_ARM))
			if(!owner || !HAS_TRAIT(owner, TRAIT_PARALYSIS_R_ARM))
				REMOVE_TRAIT(src, TRAIT_PARALYSIS, TRAIT_PARALYSIS_R_ARM)
		else
			UnregisterSignal(old_owner, SIGNAL_ADDTRAIT(TRAIT_PARALYSIS_R_ARM))

///Proc to react to the owner gaining the TRAIT_PARALYSIS_R_ARM trait.
/obj/item/bodypart/r_arm/proc/on_owner_paralysis_gain(mob/living/carbon/source)
	SIGNAL_HANDLER
	ADD_TRAIT(src, TRAIT_PARALYSIS, TRAIT_PARALYSIS_R_ARM)
	UnregisterSignal(owner, SIGNAL_ADDTRAIT(TRAIT_PARALYSIS_R_ARM))
	RegisterSignal(owner, SIGNAL_REMOVETRAIT(TRAIT_PARALYSIS_R_ARM), PROC_REF(on_owner_paralysis_loss))

///Proc to react to the owner losing the TRAIT_PARALYSIS_R_ARM trait.
/obj/item/bodypart/r_arm/proc/on_owner_paralysis_loss(mob/living/carbon/source)
	SIGNAL_HANDLER
	REMOVE_TRAIT(src, TRAIT_PARALYSIS, TRAIT_PARALYSIS_R_ARM)
	UnregisterSignal(owner, SIGNAL_REMOVETRAIT(TRAIT_PARALYSIS_R_ARM))
	RegisterSignal(owner, SIGNAL_ADDTRAIT(TRAIT_PARALYSIS_R_ARM), PROC_REF(on_owner_paralysis_gain))

/obj/item/bodypart/r_arm/halber
	max_damage = 90
	max_stamina_damage = 90
	bone_type = BONE_R_ARM_HALBER
