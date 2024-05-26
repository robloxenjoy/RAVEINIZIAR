/*
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
*/
/obj/item/bodypart/proc/special_gore(mob/living/carbon/human/owner, obj/item/bodypart/affected, damage = 0, sharpness = NONE, wound_messages = TRUE)
	if(damage > 8)
		if(sharpness)
			if(prob(50))
				return FALSE
			var/edge_protection = 0
			var/resultt = 0
			edge_protection = owner.get_edge_protection(affected)
			if(resultt <= 0)
				src.open_incision(owner)
				SEND_SIGNAL(owner, COMSIG_CARBON_ADD_TO_WOUND_MESSAGE, span_bolddanger(" [span_big("Надрез!")]"))
				for(var/obj/item/organ/bone/bonee as anything in getorganslotlist(ORGAN_SLOT_BONE))
					if(bonee.is_broken())
						playsound(get_turf(owner), 'modular_septic/sound/gore/dissection.ogg', 80, 0)
					else
						playsound(get_turf(owner), 'modular_septic/sound/gore/flesh1.ogg', 80, 0)

/obj/item/bodypart/l_eyelid/special_gore(mob/living/carbon/human/owner, obj/item/bodypart/affected, damage = 0, sharpness = NONE, wound_messages = TRUE)
	. = ..()
	if(damage > 8)
		if(prob(50))
			return FALSE
		var/edge_protection = 0
		edge_protection = owner.get_edge_protection(src)
		if(edge_protection <= 0)
			var/obj/item/organ/eyes/eyeb = getorganslot(ORGAN_SLOT_EYES)
			eyeb.Remove(eyeb.owner)
			eyeb.organ_flags |= ORGAN_CUT_AWAY
			qdel(eyeb)
			SEND_SIGNAL(owner, COMSIG_CARBON_ADD_TO_WOUND_MESSAGE, span_bolddanger(" [span_big("Глаз лопается!")]"))
			owner.custom_pain("МОЙ ЛЕВЫЙ ГЛАЗ!", rand(30, 40), affecting = src)
			if(!owner.IsUnconscious() || (owner.get_chem_effect(CE_PAINKILLER) < 50))
				owner.death_scream()

/obj/item/bodypart/r_eyelid/special_gore(mob/living/carbon/human/owner, obj/item/bodypart/affected, damage = 0, sharpness = NONE, wound_messages = TRUE)
	. = ..()
	if(damage > 8)
		if(prob(50))
			return FALSE
		var/edge_protection = 0
		edge_protection = owner.get_edge_protection(src)
		if(edge_protection <= 0)
			var/obj/item/organ/eyes/eyeb = getorganslot(ORGAN_SLOT_EYES)
			eyeb.Remove(eyeb.owner)
			eyeb.organ_flags |= ORGAN_CUT_AWAY
			qdel(eyeb)
			SEND_SIGNAL(owner, COMSIG_CARBON_ADD_TO_WOUND_MESSAGE, span_bolddanger(" [span_big("Глаз лопается!")]"))
			owner.custom_pain("МОЙ ПРАВЫЙ ГЛАЗ!", rand(30, 40), affecting = src)
			if(!owner.IsUnconscious() || (owner.get_chem_effect(CE_PAINKILLER) < 50))
				owner.death_scream()

/obj/item/bodypart/vitals/special_gore(mob/living/carbon/human/owner, obj/item/bodypart/affected, damage = 0, sharpness = NONE, wound_messages = TRUE)
	. = ..()
	if(damage > 10)
		if(prob(50))
			return FALSE
		var/edge_protection = 0
		edge_protection = owner.get_edge_protection(src)
		if(edge_protection <= 0)
			if(!getorganslot(ORGAN_SLOT_INTESTINES))
				return FALSE
			if(spilled)
				return FALSE
			if((get_mangled_state() != BODYPART_MANGLED_FLESH) && (get_mangled_state() != BODYPART_MANGLED_BOTH))
				return FALSE
			var/gaping_wound = FALSE
			for(var/datum/injury/injury as anything in injuries)
				if(injury.get_bleed_rate() && (injury.damage_per_injury() >= 20))
					gaping_wound = TRUE
					break
			if(!gaping_wound)
				return FALSE
			var/list/intestines = getorganslotlist(ORGAN_SLOT_INTESTINES)
			for(var/obj/item/organ/gut in intestines)
				gut.Remove(gut.owner)
				if(QDELETED(gut))
					continue
				gut.organ_flags |= ORGAN_CUT_AWAY
				var/sound_effect = list('modular_septic/sound/gore/spill1.ogg', 'modular_septic/sound/gore/spill2.ogg')
				playsound(owner, pick(sound_effect), 100, TRUE)
				spilled = TRUE
				owner.bleed(20)
				owner.update_damage_overlays()
				SEND_SIGNAL(owner, COMSIG_CARBON_ADD_TO_WOUND_MESSAGE, span_bolddanger(" [span_big("Кишки вырваны!")]"))
				var/turf/drop_location = owner.drop_location()
				if(istype(drop_location))
					gut.forceMove(owner.drop_location())
					owner.AddComponent(/datum/component/rope, gut, 'modular_septic/icons/effects/beam.dmi', "gut_beam2", 3, TRUE, /obj/effect/ebeam/gut, CALLBACK(owner, /mob/living/carbon/proc/gut_cut))
				else
					qdel(gut)
			for(var/obj/item/grab/grabber as anything in grasped_by)
				grabber.update_grab_mode()
