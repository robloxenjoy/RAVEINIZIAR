/obj/item/organ/nervesystem
	name = "Нервная Система"
	desc = "Что-то не так."
	gender = FEMALE
	icon_state = "nerve"
	base_icon_state = "nerve"
	attack_verb_continuous = list("хлестает")
	attack_verb_simple = list("хлестать")

	w_class = WEIGHT_CLASS_NORMAL
	zone = BODY_ZONE_PRECISE_NECK
	organ_efficiency = list(ORGAN_SLOT_NERVESYSTEM = 100)
	needs_processing = FALSE

	healing_factor = STANDARD_ORGAN_HEALING

	food_reagents = list(
		/datum/reagent/consumable/nutriment/organ_tissue = 5,
	)

	organ_volume = 1
	max_blood_storage = 25
	current_blood = 15
	blood_req = 3
	oxygen_req = 1
	nutriment_req = 2
	hydration_req = 3

/obj/item/organ/nervesystem/get_availability(datum/species/S)
	return !(NONERVESYSTEM in S.species_traits)

/obj/item/organ/nervesystem/applyOrganDamage(amount, maximum = maxHealth, silent = FALSE)
	. = ..()
	if(!owner)
		return
	var/static/list/stephenhawking_traits = list(TRAIT_PARALYSIS_R_ARM, TRAIT_PARALYSIS_L_ARM, \
											TRAIT_PARALYSIS_R_LEG, TRAIT_PARALYSIS_L_LEG)
	var/obj/item/bodypart/limb = owner.get_bodypart(current_zone)
	if((amount > 0) && (damage >= low_threshold))
		if(damage >= medium_threshold)
			if(limb.body_zone == BODY_ZONE_PRECISE_NECK)
				var/paralyzed_limbs = 0
				for(var/tetraplegia in stephenhawking_traits)
					if(HAS_TRAIT(owner, tetraplegia))
						paralyzed_limbs++
				if(paralyzed_limbs < 4)
					to_chat(owner, span_flashinguserdanger("Я стал <b>ТЕТРАПЛЕГИКОМ</b>!"))
				for(var/tetraplegia in stephenhawking_traits)
					ADD_TRAIT(owner, tetraplegia, NECK_FRACTURE_TRAIT)
//				var/obj/item/organ/brain/brain = owner.getorganslot(ORGAN_SLOT_BRAIN)
//				if(brain)
//					brain.applyOrganDamage(rand(40, 90))
//				var/fuckbrain = owner.diceroll(GET_MOB_ATTRIBUTE_VALUE(owner, STAT_ENDURANCE), context = DICE_CONTEXT_MENTAL)
//				if(fuckbrain <= DICE_SUCCESS)
//					owner.gain_trauma(/datum/brain_trauma/severe/halitus_deprivation)
/*
			if(limb.body_zone in list(BODY_ZONE_PRECISE_FACE, BODY_ZONE_HEAD))
				if(!active_trauma)
					active_trauma = owner.gain_trauma_type((damage >= maxHealth ? BRAIN_TRAUMA_SEVERE : BRAIN_TRAUMA_MILD), TRAUMA_RESILIENCE_WOUND)
					COOLDOWN_START(src, next_trauma_cycle, (rand(100-WOUND_BONE_HEAD_TIME_VARIANCE, 100+WOUND_BONE_HEAD_TIME_VARIANCE) * 0.01 * 1.5 MINUTES * (damage/maxHealth)))
				if(!HAS_TRAIT_FROM(owner, TRAIT_DISFIGURED, BRUTE))
					owner.visible_message(span_danger("<b>[owner]</b> лицо превращается в искалеченную массу!"), \
								span_userdanger("<b>МОЁ ЛИЦО ИЗУВЕЧЕНО!</b>"))
				ADD_TRAIT(owner, TRAIT_DISFIGURED, BRUTE)
				var/obj/item/bodypart/face/face = owner.get_bodypart_nostump(BODY_ZONE_PRECISE_FACE)
				if(face)
					ADD_TRAIT(face, TRAIT_DISFIGURED, BRUTE)
			jostle(owner)
*/
		var/obj/item/bodypart/child
		if(length(limb.children_zones))
			child = owner.get_bodypart(limb.children_zones[1])
		if( (limb.held_index && owner.get_item_for_held_index(limb.held_index) && prob(70 * (damage/maxHealth))) || \
			(child?.held_index && owner.get_item_for_held_index(child.held_index) && prob(55 * (damage/maxHealth))) )
			var/obj/item/held_item = owner.get_item_for_held_index(limb.held_index || child?.held_index)
			if(istype(held_item, /obj/item/offhand))
				held_item = owner.get_active_held_item()
			if(held_item && owner.dropItemToGround(held_item))
				owner.visible_message(span_danger("<b>[owner]</b> бросает [held_item] от шока!"), \
					span_userdanger("Шок заставляет меня выбросить [held_item]!"), \
					vision_distance = COMBAT_MESSAGE_RANGE)
		if(owner.stat < UNCONSCIOUS)
			if((damage >= medium_threshold) && (prev_damage < medium_threshold))
				owner.agony_scream()
			else if((damage >= low_threshold) && (prev_damage < low_threshold))
				owner.death_scream()
	else if(amount < 0)
		if(damage < medium_threshold)
			if(limb.body_zone == BODY_ZONE_PRECISE_NECK)
				var/was_paralyzed_limbs = 0
				for(var/tetraplegia in stephenhawking_traits)
					if(HAS_TRAIT(owner, tetraplegia))
						was_paralyzed_limbs++
				for(var/stephenhawking in list(TRAIT_PARALYSIS_R_ARM, TRAIT_PARALYSIS_L_ARM, \
											TRAIT_PARALYSIS_R_LEG, TRAIT_PARALYSIS_L_LEG))
					REMOVE_TRAIT(owner, stephenhawking, NECK_FRACTURE_TRAIT)
				var/paralyzed_limbs = 0
				for(var/tetraplegia in stephenhawking_traits)
					if(HAS_TRAIT(owner, tetraplegia))
						paralyzed_limbs++
				if((paralyzed_limbs >= 4) && (paralyzed_limbs < was_paralyzed_limbs))
					to_chat(owner, span_green("Я больше не <b>тетраплегик</b>!"))

/obj/item/organ/nervesystem/Insert(mob/living/carbon/new_owner, special = FALSE, drop_if_replaced = TRUE, new_zone = null)
	. = ..()
	var/obj/item/bodypart/limb
	if(!(new_owner.status_flags & BUILDING_ORGANS))
		limb = new_owner.get_bodypart(current_zone)
	if(!(new_owner.status_flags & BUILDING_ORGANS) && limb)
		if((limb.body_zone == BODY_ZONE_PRECISE_NECK) && !limb.getorganslot(ORGAN_SLOT_BONE))
			var/static/list/stephenhawking_traits = list(TRAIT_PARALYSIS_R_ARM, TRAIT_PARALYSIS_L_ARM, \
													TRAIT_PARALYSIS_R_LEG, TRAIT_PARALYSIS_L_LEG)
			var/paralyzed_limbs = 0
			for(var/tetraplegia in stephenhawking_traits)
				if(HAS_TRAIT(owner, tetraplegia))
					paralyzed_limbs++
			if(paralyzed_limbs < 4)
				to_chat(owner, span_flashinguserdanger("Я стал <b>ТЕТРАПЛЕГИКОМ</b>!"))
			for(var/tetraplegia in stephenhawking_traits)
				ADD_TRAIT(owner, tetraplegia, NECK_FRACTURE_TRAIT)
/*
		if((limb.body_zone in list(BODY_ZONE_HEAD, BODY_ZONE_PRECISE_FACE)) && !limb.getorganslot(ORGAN_SLOT_BONE))
			if(!HAS_TRAIT_FROM(new_owner, TRAIT_DISFIGURED, BRUTE))
				new_owner.visible_message(span_danger("<b>[owner]</b> лицо превращается в искалеченную массу!"), \
							span_userdanger("<b>МОЁ ЛИЦО ИЗУВЕЧЕНО!</b>"))
			ADD_TRAIT(new_owner, TRAIT_DISFIGURED, BRUTE)
			var/obj/item/bodypart/face/face = new_owner.get_bodypart_nostump(BODY_ZONE_PRECISE_FACE)
			if(face)
				ADD_TRAIT(face, TRAIT_DISFIGURED, BRUTE)
*/

/obj/item/organ/nervesystem/Remove(mob/living/carbon/organ_owner, special)
	var/obj/item/bodypart/limb
	if(!(organ_owner.status_flags & BUILDING_ORGANS))
		limb = organ_owner.get_bodypart(current_zone)
	. = ..()
	if(!(organ_owner.status_flags & BUILDING_ORGANS) && limb)
		if((limb.body_zone == BODY_ZONE_PRECISE_NECK) && !limb.getorganslot(ORGAN_SLOT_BONE))
			var/static/list/stephenhawking_traits = list(TRAIT_PARALYSIS_R_ARM, TRAIT_PARALYSIS_L_ARM, \
													TRAIT_PARALYSIS_R_LEG, TRAIT_PARALYSIS_L_LEG)
			var/paralyzed_limbs = 0
			for(var/tetraplegia in stephenhawking_traits)
				if(HAS_TRAIT(organ_owner, tetraplegia))
					paralyzed_limbs++
			if(paralyzed_limbs < 4)
				to_chat(organ_owner, span_flashinguserdanger("Я стал <b>ТЕТРАПЛЕГИКОМ</b>!"))
			for(var/tetraplegia in stephenhawking_traits)
				ADD_TRAIT(organ_owner, tetraplegia, NECK_FRACTURE_TRAIT)
/*
		if((limb.body_zone in list(BODY_ZONE_HEAD, BODY_ZONE_PRECISE_FACE)) && !limb.getorganslot(ORGAN_SLOT_BONE))
			if(!HAS_TRAIT_FROM(organ_owner, TRAIT_DISFIGURED, BRUTE))
				organ_owner.visible_message(span_danger("<b>[owner]</b> лицо превращается в искалеченную массу!"), \
							span_userdanger("<b>МОЁ ЛИЦО ИЗУВЕЧЕНО!</b>"))
			ADD_TRAIT(organ_owner, TRAIT_DISFIGURED, BRUTE)
			var/obj/item/bodypart/face/face = organ_owner.get_bodypart_nostump(BODY_ZONE_PRECISE_FACE)
			if(face)
				ADD_TRAIT(face, TRAIT_DISFIGURED, BRUTE)
*/

/obj/item/organ/nervesystem/halber
	maxHealth = 120
	high_threshold = 110
	low_threshold = 100
