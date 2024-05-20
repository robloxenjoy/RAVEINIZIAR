/obj/item/bodypart/proc/another_special_destroying(victim, user, affected, weapon, damage, damage_flag, damage_type, sharpness, def_zone, intended_zone, modifiers)
	return

/obj/item/bodypart/mouth/another_special_destroying(victim, user, affected, weapon, damage, damage_flag, damage_type, sharpness, def_zone, intended_zone, modifiers)
	if(damage_flag == MELEE)
		if((sharpness & SHARP_POINTY) || (sharpness & SHARP_IMPALING))
			if(damage > 5)
				var/edge_protection = 0
				var/resultt = 0
				edge_protection = victim.get_edge_protection(affected)
				resultt = (edge_protection - weapon.edge_protection_penetration)
				if(resultt <= 0)
					var/obj/item/organ/brain/brain = user.getorganslot(ORGAN_SLOT_BRAIN)
					brain.applyOrganDamage(damage/2)
