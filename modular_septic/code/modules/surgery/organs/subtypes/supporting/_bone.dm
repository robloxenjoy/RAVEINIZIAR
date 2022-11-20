/obj/item/organ/bone
	name = "bone"
	desc = "Bone apple tea."
	icon_state = "bone"
	base_icon_state = "bone"
	drop_sound = 'modular_septic/sound/gore/bone_drop.ogg'

	organ_flags = ORGAN_NOINFECTION|ORGAN_LIMB_SUPPORTER|ORGAN_INDESTRUCTIBLE|ORGAN_NO_VIOLENT_DAMAGE // you can't just eat a bone
	organ_efficiency = list(ORGAN_SLOT_BONE = 100)
	needs_processing = FALSE

	maxHealth = BONE_MAX_HEALTH
	//compound fracture
	high_threshold = BONE_MAX_HEALTH * 0.8
	//fracture
	medium_threshold = BONE_MAX_HEALTH * 0.5
	//dislocation
	low_threshold = BONE_MAX_HEALTH * 0.2
	pain_multiplier = 0.35

	organ_volume = 0.5
	nutriment_req = 0.15
	hydration_req = 0.15

	force = 5
	throwforce = 5

	attaching_items = list(/obj/item/stack/medical/bone_gel)
	healing_items = list(/obj/item/stack/medical/bone_gel)

	/// BONE_JOINTED, BONE_ENCASING
	var/bone_flags = BONE_JOINTED
	/// Descriptive string for dislocations
	var/joint_name = "joint"
	/// Did this bone get reinforced? Mostly used to prevent armor stacking
	var/reinforced = FALSE
	/// Bones sometimes provide wound resistance depending on efficiency
	var/wound_resistance = 0

	// Variables below only matter for dislocations/fractures
	/// If we suffer severe head booboos, we can get brain traumas tied to them
	var/datum/brain_trauma/active_trauma
	/// If we are dealing brain traumas, when is the next one due?
	COOLDOWN_DECLARE(next_trauma_cycle)
	/// Have we been taped?
	var/taped = FALSE
	/// Have we been bone gel'd?
	var/gelled = FALSE

/obj/item/organ/bone/can_heal(delta_time, times_fired)
	return FALSE

/obj/item/organ/bone/update_icon_state()
	. = ..()
	if(reinforced && (status == ORGAN_ORGANIC))
		icon_state = "[base_icon_state]-reinforced"

/obj/item/organ/bone/get_visible_state()
	return

/obj/item/organ/bone/handle_organ_attack(obj/item/tool, mob/living/user, params)
	if(owner && DOING_INTERACTION_WITH_TARGET(user, owner))
		return TRUE
	else if(DOING_INTERACTION_WITH_TARGET(user, src))
		return TRUE
	if(owner && CHECK_BITFIELD(organ_flags, ORGAN_CUT_AWAY))
		for(var/thing in attaching_items)
			if(istype(tool, thing))
				handle_attaching_item(tool, user, params)
				return TRUE
	for(var/thing in healing_items)
		if(istype(tool, thing))
			handle_healing_item(tool, user, params)
			return TRUE
	for(var/thing in healing_tools)
		if(tool.tool_behaviour == thing)
			handle_healing_item(tool, user, params)
			return TRUE
	if(owner && (tool.tool_behaviour == TOOL_SAW) && !CHECK_BITFIELD(organ_flags, ORGAN_CUT_AWAY))
		handle_cutting_away(tool, user, params)
		return TRUE

/obj/item/organ/bone/handle_cutting_away(obj/item/tool, mob/living/user, params)
	user.visible_message(span_notice("<b>[user]</b> starts sawing \the [src] from \the [owner]..."), \
					span_notice("I start sawing \the [src] from \the [owner]..."), \
					vision_distance = COMBAT_MESSAGE_RANGE)
	owner.custom_pain("OH GOD! My [src] is being BROKEN AWAY!", 30, FALSE, owner.get_bodypart(current_zone))
	if(!do_mob(user, owner, 8 SECONDS))
		to_chat(user, span_warning("I must stand still!"))
		return TRUE
	user.visible_message(span_notice("<b>[user]</b> saws \the [src] away."), \
					span_notice("I saw \the [src] away."), \
					vision_distance = COMBAT_MESSAGE_RANGE)
	organ_flags |= ORGAN_CUT_AWAY
	return TRUE

/obj/item/organ/bone/applyOrganDamage(amount, maximum = maxHealth, silent = FALSE)
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
					to_chat(owner, span_flashinguserdanger("I become <b>TETRAPLEGIC</b>!"))
				for(var/tetraplegia in stephenhawking_traits)
					ADD_TRAIT(owner, tetraplegia, NECK_FRACTURE_TRAIT)
			if(limb.body_zone in list(BODY_ZONE_PRECISE_FACE, BODY_ZONE_HEAD))
				if(!active_trauma)
					active_trauma = owner.gain_trauma_type((damage >= maxHealth ? BRAIN_TRAUMA_SEVERE : BRAIN_TRAUMA_MILD), TRAUMA_RESILIENCE_WOUND)
					COOLDOWN_START(src, next_trauma_cycle, (rand(100-WOUND_BONE_HEAD_TIME_VARIANCE, 100+WOUND_BONE_HEAD_TIME_VARIANCE) * 0.01 * 1.5 MINUTES * (damage/maxHealth)))
				if(!HAS_TRAIT_FROM(owner, TRAIT_DISFIGURED, BRUTE))
					owner.visible_message(span_danger("<b>[owner]</b>'s face turns into an unrecognizable, mangled mess!"), \
								span_userdanger("<b>MY FACE IS HORRIBLY MANGLED!</b>"))
				ADD_TRAIT(owner, TRAIT_DISFIGURED, BRUTE)
				var/obj/item/bodypart/face/face = owner.get_bodypart_nostump(BODY_ZONE_PRECISE_FACE)
				if(face)
					ADD_TRAIT(face, TRAIT_DISFIGURED, BRUTE)
			jostle(owner)
		var/obj/item/bodypart/child
		if(length(limb.children_zones))
			child = owner.get_bodypart(limb.children_zones[1])
		if( (limb.held_index && owner.get_item_for_held_index(limb.held_index) && prob(70 * (damage/maxHealth))) || \
			(child?.held_index && owner.get_item_for_held_index(child.held_index) && prob(55 * (damage/maxHealth))) )
			var/obj/item/held_item = owner.get_item_for_held_index(limb.held_index || child?.held_index)
			if(istype(held_item, /obj/item/offhand))
				held_item = owner.get_active_held_item()
			if(held_item && owner.dropItemToGround(held_item))
				owner.visible_message(span_danger("<b>[owner]</b> drops [held_item] in shock!"), \
					span_userdanger("The shock on my [name] causes me to drop [held_item]!"), \
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
					to_chat(owner, span_green("I am no longer <b>tetraplegic</b>!"))
			if(active_trauma)
				QDEL_NULL(active_trauma)

/obj/item/organ/bone/Insert(mob/living/carbon/new_owner, special = FALSE, drop_if_replaced = TRUE, new_zone = null)
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
				to_chat(owner, span_flashinguserdanger("I become <b>TETRAPLEGIC</b>!"))
			for(var/tetraplegia in stephenhawking_traits)
				ADD_TRAIT(owner, tetraplegia, NECK_FRACTURE_TRAIT)
		if((limb.body_zone in list(BODY_ZONE_HEAD, BODY_ZONE_PRECISE_FACE)) && !limb.getorganslot(ORGAN_SLOT_BONE))
			if(!HAS_TRAIT_FROM(new_owner, TRAIT_DISFIGURED, BRUTE))
				new_owner.visible_message(span_danger("<b>[owner]</b>'s face turns into an unrecognizable, mangled mess!"), \
							span_userdanger("<b>MY FACE IS HORRIBLY MANGLED!</b>"))
			ADD_TRAIT(new_owner, TRAIT_DISFIGURED, BRUTE)
			var/obj/item/bodypart/face/face = new_owner.get_bodypart_nostump(BODY_ZONE_PRECISE_FACE)
			if(face)
				ADD_TRAIT(face, TRAIT_DISFIGURED, BRUTE)

/obj/item/organ/bone/Remove(mob/living/carbon/organ_owner, special)
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
				to_chat(organ_owner, span_flashinguserdanger("I become <b>TETRAPLEGIC</b>!"))
			for(var/tetraplegia in stephenhawking_traits)
				ADD_TRAIT(organ_owner, tetraplegia, NECK_FRACTURE_TRAIT)
		if((limb.body_zone in list(BODY_ZONE_HEAD, BODY_ZONE_PRECISE_FACE)) && !limb.getorganslot(ORGAN_SLOT_BONE))
			if(!HAS_TRAIT_FROM(organ_owner, TRAIT_DISFIGURED, BRUTE))
				organ_owner.visible_message(span_danger("<b>[owner]</b>'s face turns into an unrecognizable, mangled mess!"), \
							span_userdanger("<b>MY FACE IS HORRIBLY MANGLED!</b>"))
			ADD_TRAIT(organ_owner, TRAIT_DISFIGURED, BRUTE)
			var/obj/item/bodypart/face/face = organ_owner.get_bodypart_nostump(BODY_ZONE_PRECISE_FACE)
			if(face)
				ADD_TRAIT(face, TRAIT_DISFIGURED, BRUTE)

/obj/item/organ/bone/on_life(delta_time, times_fired)
	. = ..()
	if(damage < medium_threshold)
		gelled = FALSE
		taped = FALSE
		if(active_trauma)
			QDEL_NULL(active_trauma)
		return

	if((current_zone == BODY_ZONE_HEAD) && COOLDOWN_FINISHED(src, next_trauma_cycle))
		if(active_trauma)
			QDEL_NULL(active_trauma)
		else
			active_trauma = owner.gain_trauma_type((damage >= maxHealth ? BRAIN_TRAUMA_SEVERE : BRAIN_TRAUMA_MILD), TRAUMA_RESILIENCE_WOUND)
		COOLDOWN_START(src, next_trauma_cycle, (rand(100-WOUND_BONE_HEAD_TIME_VARIANCE, 100+WOUND_BONE_HEAD_TIME_VARIANCE) * 0.01 * 1.5 MINUTES * (damage/maxHealth)))

	if(gelled && taped)
		applyOrganDamage(-0.1 * delta_time)
		if(DT_PROB((damage/maxHealth) * 3, delta_time))
			var/obj/item/bodypart/limb = owner.get_bodypart(current_zone)
			limb.add_pain(10)
			if(prob(40))
				to_chat(owner, span_userdanger("You feel a sharp pain in your body as your bones are reforming!"))

/obj/item/organ/bone/proc/reinforce(added_resistance = 5)
	if(reinforced || (status != ORGAN_ORGANIC))
		return
	wound_resistance += added_resistance
	force += 5
	throwforce += 5
	reinforced = TRUE
	name = "reinforced [name]"
	update_appearance()

/obj/item/organ/bone/get_wound_weakness(wounding_type = WOUND_BLUNT)
	. = -wound_resistance
	if(damage < low_threshold)
		return
	//dislocated
	else if(damage < medium_threshold)
		. += 15
	//fractured
	else if(damage < high_threshold)
		. += 30
	//compound fractured
	else
		. += 35

/// If we're a human who's punching something with a broken hand, we might hurt ourselves doing so
/obj/item/organ/bone/proc/attack_with_hurt_hand(mob/living/carbon/owner, obj/item/bodypart/limb, atom/target)
	if(damage < low_threshold)
		return
	var/punch_verb = "punch"
	if(IS_HELP_INTENT(owner, null))
		punch_verb = "touch"
	// With a bone wound, you have up to a 60% chance to proc pain on hit
	if(prob(60 * (damage/maxHealth)))
		if(prob(75 - (35 * damage/maxHealth)))
			to_chat(owner, span_userdanger("The [damage >= medium_threshold ? "fracture" : "dislocation"] in my [limb.name] shoots with pain as i [punch_verb] [target]!"))
			limb.add_pain(10)
		else
			owner.visible_message(span_danger("<b>[owner]</b> weakly [punch_verb]es [target] with [owner.p_their()] broken [limb.name], recoiling in pain!"), \
				span_userdanger("I fail to [punch_verb] [target] as the [damage >= medium_threshold ? "fracture" : "dislocation"] in my [limb.name] lights up pain!"), \
				vision_distance=COMBAT_MESSAGE_RANGE)
			owner.agony_scream()
			owner.Stun(0.5 SECONDS)
			limb.add_pain(rand(10, 15))
			return COMPONENT_CANCEL_ATTACK_CHAIN

/// If we're a human who's kicking something with a broken foot, we might hurt ourselves doing so
/obj/item/organ/bone/proc/attack_with_hurt_foot(mob/living/carbon/owner, obj/item/bodypart/limb, atom/target)
	if(damage < low_threshold)
		return
	// With a bone wound, you have up to a 60% chance to proc pain on hit
	if(prob(60 * (damage/maxHealth)))
		if(prob(75 - (35 * damage/maxHealth)))
			to_chat(owner, span_userdanger("The [damage >= medium_threshold ? "fracture" : "dislocation"] in your [limb.name] shoots with pain as you kick [target]!"))
			limb.add_pain(10)
		else
			owner.visible_message(span_danger("<b>[owner]</b> weakly kicks [target] with [owner.p_their()] broken [limb.name], recoiling from pain!"), \
				span_userdanger("You fail to kick [target] as the [damage >= medium_threshold ? "fracture" : "dislocation"] in your [limb.name] lights up in unbearable pain!"), \
				vision_distance=COMBAT_MESSAGE_RANGE)
			owner.agony_scream()
			owner.Stun(0.5 SECONDS)
			limb.add_pain(rand(10, 15))
			return COMPONENT_CANCEL_ATTACK_CHAIN

/// If we're a human who's biting something with a broken jaw, we might hurt ourselves doing so
/obj/item/organ/bone/proc/attack_with_hurt_jaw(mob/living/carbon/owner, obj/item/bodypart/limb, atom/target)
	if(damage < low_threshold)
		return
	// With a bone wound, you have up to a 60% chance to proc pain on hit
	if(prob(60 * (damage/maxHealth)))
		if(prob(75 - (35 * damage/maxHealth)))
			to_chat(owner, span_userdanger("The [damage >= medium_threshold ? "fracture" : "dislocation"] in your [limb.name] shoots with pain as you bite [target]!"))
			limb.add_pain(10)
		else
			owner.visible_message(span_danger("<b>[owner]</b> weakly bites [target] with [owner.p_their()] broken [limb.name], recoiling from pain!"), \
				span_userdanger("You fail to bite [target] as the [damage >= medium_threshold ? "fracture" : "dislocation"] in your [limb.name] lights up in unbearable pain!"), \
				vision_distance=COMBAT_MESSAGE_RANGE)
			owner.agony_scream()
			owner.Stun(0.5 SECONDS)
			limb.add_pain(rand(10, 15))
			return COMPONENT_CANCEL_ATTACK_CHAIN

/obj/item/organ/bone/proc/can_jostle(mob/living/carbon/source)
	if(damage < medium_threshold)
		return FALSE
	if(!istype(source))
		source = owner
	if(!istype(source))
		return FALSE
	return TRUE

/obj/item/organ/bone/proc/jostle(mob/living/carbon/source)
	// no damage checks here, please use can_jostle() before executing this
	var/obj/item/bodypart/limb = source?.get_bodypart(current_zone)
	if(!limb)
		return
	source.custom_pain("Staggering pain jolts through my [name]!", 30, affecting = limb)
	source.Stumble(3 SECONDS)
	source.Immobilize(2 SECONDS)
	limb.damage_internal_organs(wounding_type = WOUND_PIERCE, amount = (rand(5, 10) * (damage/maxHealth)), forced = TRUE, wound_messages = FALSE)
	if((source.get_active_hand() == limb) && source.can_feel_pain() && (source.get_chem_effect(CE_PAINKILLER) < 50))
		source.dropItemToGround(source.get_active_held_item())
	return TRUE

/obj/item/organ/bone/proc/movement_jostle(mob/living/carbon/source)
	if(!can_jostle(source))
		return FALSE
	var/obj/item/bodypart/limb = source?.get_bodypart(current_zone)
	if((1 - limb.current_splint?.splint_factor) >= 0.5)
		return
	if((source.stat < UNCONSCIOUS) && prob(10 * (damage/maxHealth)))
		if(jostle(source))
			return TRUE

/obj/item/organ/bone/proc/dislocate()
	if(!owner)
		return
	if(damage >= low_threshold)
		return
	setOrganDamage(low_threshold * 1.5)
	return TRUE

/obj/item/organ/bone/proc/fracture()
	if(!owner)
		return
	if(damage >= medium_threshold)
		return
	setOrganDamage(medium_threshold * 1.5)
	return TRUE

/obj/item/organ/bone/proc/compound_fracture()
	if(!owner)
		return
	if(damage >= high_threshold)
		return
	setOrganDamage(high_threshold * 1.5)
	return TRUE

/obj/item/organ/bone/proc/relocate()
	if(!owner)
		return
	if(damage >= medium_threshold)
		return
	setOrganDamage(0)
	return TRUE

/obj/item/organ/bone/proc/mend_fracture()
	if(!owner)
		return
	if(damage < medium_threshold)
		return
	if(damage >= high_threshold)
		return
	if(bone_flags & BONE_JOINTED)
		setOrganDamage(low_threshold * 1.5)
	else
		setOrganDamage(0)
	return TRUE

/obj/item/organ/bone/proc/mend_compound_fracture()
	if(!owner)
		return
	if(damage < high_threshold)
		return
	setOrganDamage(medium_threshold * 1.5)
	return TRUE
