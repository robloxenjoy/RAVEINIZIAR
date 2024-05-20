/obj/item/bodypart/proc/another_special_destroying(mob/living/carbon/human/owner, mob/living/carbon/human/user, obj/item/bodypart/affected, obj/item/weapon, damage = 0, damage_flag = MELEE, damage_type = BRUTE, sharpness = NONE, def_zone = BODY_ZONE_CHEST, intended_zone = BODY_ZONE_CHEST, wound_messages = TRUE, list/modifiers)
	return

/obj/item/bodypart/proc/another_special_bullet_destroying(mob/living/carbon/human/owner, mob/living/carbon/human/user, obj/item/bodypart/affected, obj/item/weapon, damage = 0, damage_flag = MELEE, damage_type = BRUTE, sharpness = NONE, def_zone = BODY_ZONE_CHEST, intended_zone = BODY_ZONE_CHEST, wound_messages = TRUE, list/modifiers)
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
