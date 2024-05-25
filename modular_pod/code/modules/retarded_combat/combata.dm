/obj/item/bodypart/proc/another_special_destroying(mob/living/carbon/human/owner, mob/living/carbon/human/user, obj/item/bodypart/affected, obj/item/weapon, damage = 0, damage_flag = MELEE, damage_type = BRUTE, sharpness = NONE, def_zone = BODY_ZONE_CHEST, intended_zone = BODY_ZONE_CHEST, wound_messages = TRUE, list/modifiers)
	return

/obj/item/bodypart/mouth/another_special_destroying(mob/living/carbon/human/owner, mob/living/carbon/human/user, obj/item/bodypart/affected, obj/item/weapon, damage = 0, damage_flag = MELEE, damage_type = BRUTE, sharpness = NONE, def_zone = BODY_ZONE_CHEST, intended_zone = BODY_ZONE_CHEST, wound_messages = TRUE, list/modifiers)
	if(damage_flag == MELEE)
		if((sharpness & SHARP_POINTY) || (sharpness & SHARP_IMPALING))
			if(damage > 10)
				var/edge_protection = 0
				var/resultt = 0
				edge_protection = owner.get_edge_protection(src)
				resultt = (edge_protection - weapon.edge_protection_penetration)
				if(resultt <= 0)
					var/obj/item/organ/brain/brain = owner.getorganslot(ORGAN_SLOT_BRAIN)
					if(brain)
						brain.applyOrganDamage(damage/1.1)

/obj/item/bodypart/r_eyelid/another_special_destroying(mob/living/carbon/human/owner, mob/living/carbon/human/user, obj/item/bodypart/affected, obj/item/weapon, damage = 0, damage_flag = MELEE, damage_type = BRUTE, sharpness = NONE, def_zone = BODY_ZONE_CHEST, intended_zone = BODY_ZONE_CHEST, wound_messages = TRUE, list/modifiers)
	if(damage_flag == MELEE)
		if((sharpness & SHARP_POINTY) || (sharpness & SHARP_IMPALING))
			if(damage > 10)
				var/edge_protection = 0
				var/resultt = 0
				edge_protection = owner.get_edge_protection(src)
				resultt = (edge_protection - weapon.edge_protection_penetration)
				if(resultt <= 0)
					var/obj/item/organ/brain/brain = owner.getorganslot(ORGAN_SLOT_BRAIN)
					if(brain)
						brain.applyOrganDamage(damage/1.1)

/obj/item/bodypart/l_eyelid/another_special_destroying(mob/living/carbon/human/owner, mob/living/carbon/human/user, obj/item/bodypart/affected, obj/item/weapon, damage = 0, damage_flag = MELEE, damage_type = BRUTE, sharpness = NONE, def_zone = BODY_ZONE_CHEST, intended_zone = BODY_ZONE_CHEST, wound_messages = TRUE, list/modifiers)
	if(damage_flag == MELEE)
		if((sharpness & SHARP_POINTY) || (sharpness & SHARP_IMPALING))
			if(damage > 10)
				var/edge_protection = 0
				var/resultt = 0
				edge_protection = owner.get_edge_protection(src)
				resultt = (edge_protection - weapon.edge_protection_penetration)
				if(resultt <= 0)
					var/obj/item/organ/brain/brain = owner.getorganslot(ORGAN_SLOT_BRAIN)
					brain.applyOrganDamage(damage/1.1)

/obj/item/bodypart/proc/special_gore(mob/living/carbon/human/owner, mob/living/carbon/human/user, obj/item/bodypart/affected, obj/item/weapon, damage = 0, damage_flag = MELEE, damage_type = BRUTE, sharpness = NONE, def_zone = BODY_ZONE_CHEST, intended_zone = BODY_ZONE_CHEST, wound_messages = TRUE, list/modifiers)
	return

/obj/item/bodypart/l_eyelid/special_gore(mob/living/carbon/human/owner, mob/living/carbon/human/user, obj/item/bodypart/affected, obj/item/weapon, damage = 0, damage_flag = MELEE, damage_type = BRUTE, sharpness = NONE, def_zone = BODY_ZONE_CHEST, intended_zone = BODY_ZONE_CHEST, wound_messages = TRUE, list/modifiers)
	if(damage > 8)
		if(prob(50))
			return FALSE
		var/edge_protection = 0
		edge_protection = owner.get_edge_protection(src)
		if(edge_protection <= 0)
			if(!src.getorganslot(ORGAN_SLOT_EYES))
				return FALSE
			var/list/eyes = getorganslotlist(ORGAN_SLOT_EYES)
			var/obj/item/organ/eyeb
			if(eyeb in eyes)
				eyeb.Remove(eyeb.owner)
				eyeb.organ_flags |= ORGAN_CUT_AWAY
				qdel(eyeb)
				SEND_SIGNAL(owner, COMSIG_CARBON_ADD_TO_WOUND_MESSAGE, span_bolddanger(" [span_big("Глаз лопается!")]"))

/obj/item/bodypart/r_eyelid/special_gore(mob/living/carbon/human/owner, mob/living/carbon/human/user, obj/item/bodypart/affected, obj/item/weapon, damage = 0, damage_flag = MELEE, damage_type = BRUTE, sharpness = NONE, def_zone = BODY_ZONE_CHEST, intended_zone = BODY_ZONE_CHEST, wound_messages = TRUE, list/modifiers)
	if(damage > 8)
		if(prob(50))
			return FALSE
		var/edge_protection = 0
		edge_protection = owner.get_edge_protection(src)
		if(edge_protection <= 0)
			if(!src.getorganslot(ORGAN_SLOT_EYES))
				return FALSE
			var/list/eyes = getorganslotlist(ORGAN_SLOT_EYES)
			var/obj/item/organ/eyeb
			if(eyeb in eyes)
				eyeb.Remove(eyeb.owner)
				eyeb.organ_flags |= ORGAN_CUT_AWAY
				qdel(eyeb)
				SEND_SIGNAL(owner, COMSIG_CARBON_ADD_TO_WOUND_MESSAGE, span_bolddanger(" [span_big("Глаз лопается!")]"))
