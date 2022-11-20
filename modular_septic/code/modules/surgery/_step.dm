//I fuck sex
/datum/surgery_step
	var/name
	/**
	 * Path of tool associated with success probability
	 * Alternatively, tool may be a tool behavior string
	 */
	var/list/implements = list()
	/// The current type of implement used - This has to be stored, as the actual typepath of the tool may not match the list type
	var/implement_type = null
	/// Chance of success when using your hand - 0 means you can't use your hand at all
	var/accept_hand = 0
	/// Best case scenario time for this step
	var/minimum_time = 10
	/// Worst case scenario time for this step
	var/maximum_time = 20
	/// Is this step realized via middle click instead of normal click?
	var/middle_click_step = FALSE
	/// Can this step be repeated?
	var/repeatable = FALSE
	/// Are we being done, right now?
	var/step_in_progress = FALSE
	/**
	 * //list of chems needed to complete the step
	 * Even on success, the step will have no effect if the chems required on the mob do not exist
	 */
	var/list/chems_needed = null
	/// Any on the chem required list or all on the chem required list?
	var/require_all_chems = TRUE
	/// Do silicons care about probability of success?
	var/silicons_obey_prob = FALSE
	/// Random surgery flags that mostly indicate additional requirements
	var/surgery_flags = STEP_NEEDS_INCISED
	/// Conditionally used so tool quality affects success chance
	var/success_multiplier = 1
	/// Do we ignore checks for clothes covering the location?
	var/ignore_clothes = FALSE
	/// Does this step require a non-missing bodypart? Incompatible with requires_missing_bodypart
	var/requires_bodypart = TRUE
	/// Does this step require the bodypart to be missing? (Limb attachment)
	var/requires_missing_bodypart = TRUE
	/// If true, this surgery step cannot be done on pseudo limbs (like chainsaw arms)
	var/requires_real_bodypart = FALSE
	/// What type of bodypart we require, in case requires_bodypart
	var/requires_bodypart_type = BODYPART_ORGANIC
	/// Does the patient need to be lying down?
	var/lying_required = FALSE
	/// Body zones this surgery can be performed on
	var/list/possible_locs = ALL_BODYPARTS
	/// Acceptable mob types for this srugery
	var/list/target_mobtypes = list(/mob/living/carbon)
	/// Tech tree datum required to unlock this surgery step, will be implemented later
	var/requires_tech
	/// Stat used only affects surgery speed, but not chance
	var/stat_used = null
	/// Skill used affects both speed and chance
	var/skill_used = SKILL_SURGERY

/datum/surgery_step/proc/validate_user(mob/user)
	. = TRUE
	if(!(user.zone_selected in possible_locs))
		. = FALSE

/datum/surgery_step/proc/validate_target(mob/living/target, mob/user)
	. = TRUE
	if(length(target_mobtypes))
		. = FALSE
		for(var/bingus in target_mobtypes)
			if(istype(target, bingus))
				. = TRUE
	if(lying_required && (target.body_position != LYING_DOWN))
		. = FALSE
	if(iscarbon(target))
		var/mob/living/carbon/C = target
		var/mob/living/carbon/human/H = C
		var/obj/item/bodypart/BP = C.get_bodypart(check_zone(user.zone_selected))
		if(requires_bodypart && !BP)
			return FALSE
		else if(!requires_bodypart)
			if(requires_missing_bodypart && BP)
				return FALSE
			return TRUE
		if(istype(H) && !ignore_clothes && BP && LAZYLEN(H.clothingonpart(BP)) )
			. = FALSE
		if(requires_bodypart_type && !(BP.status == requires_bodypart_type))
			. = FALSE
		if(CHECK_BITFIELD(surgery_flags, STEP_NEEDS_ENCASED) && !BP.is_encased())
			. = FALSE
		var/how_open = BP.how_open()
		if(CHECK_BITFIELD(surgery_flags, STEP_NEEDS_INCISED) && !CHECK_BITFIELD(how_open, SURGERY_INCISED))
			. = FALSE
		if(CHECK_BITFIELD(surgery_flags, STEP_NEEDS_NOT_INCISED) && CHECK_BITFIELD(how_open, SURGERY_INCISED))
			. = FALSE
		if(CHECK_BITFIELD(surgery_flags, STEP_NEEDS_RETRACTED) && !CHECK_BITFIELD(how_open, SURGERY_RETRACTED))
			. = FALSE
		if(CHECK_BITFIELD(surgery_flags, STEP_NEEDS_DRILLED) && !CHECK_BITFIELD(how_open, SURGERY_DRILLED))
			. = FALSE
		if(CHECK_BITFIELD(surgery_flags, STEP_NEEDS_BROKEN) && !CHECK_BITFIELD(how_open, SURGERY_BROKEN))
			. = FALSE
		if(user == target)
			var/obj/item/bodypart/active_hand = user.get_active_hand()
			if((active_hand?.body_zone in list(BODY_ZONE_R_ARM, BODY_ZONE_PRECISE_R_HAND)) && (user.zone_selected in list(BODY_ZONE_R_ARM, BODY_ZONE_PRECISE_R_HAND)))
				return FALSE
			if((active_hand?.body_zone in list(BODY_ZONE_L_ARM, BODY_ZONE_PRECISE_L_HAND)) && (user.zone_selected in list(BODY_ZONE_L_ARM, BODY_ZONE_PRECISE_L_HAND)))
				return FALSE

/datum/surgery_step/proc/tool_check(mob/user, obj/item/tool, mob/living/carbon/target)
	return TRUE

/datum/surgery_step/proc/chem_check(mob/living/target)
	if(!LAZYLEN(chems_needed))
		return TRUE
	if(require_all_chems)
		. = TRUE
		for(var/R in chems_needed)
			if(!target.reagents.has_reagent(R))
				return FALSE
	else
		. = FALSE
		for(var/R in chems_needed)
			if(target.reagents.has_reagent(R))
				return TRUE

/datum/surgery_step/proc/try_op(mob/user, mob/living/target, target_zone, obj/item/tool, try_to_fail = FALSE)
	var/success = FALSE
	if(accept_hand && !tool)
		success = TRUE
	else if(tool)
		for(var/key in implements)
			var/match = FALSE
			if(ispath(key) && istype(tool, key))
				match = TRUE
			else if(tool.tool_behaviour == key)
				match = TRUE
			if(match)
				implement_type = key
				if(tool_check(user, tool, target))
					success = TRUE
					break
	if(success)
		if(!validate_user(user))
			success = FALSE
		if(!validate_target(target, user))
			success = FALSE
		if(target.surgeries[target_zone])
			success = FALSE

	if(success)
		if(get_location_accessible(target, target_zone) || ignore_clothes)
			initiate(user, target, target_zone, tool, try_to_fail)
			return TRUE
	return FALSE

/datum/surgery_step/proc/initiate(mob/user, mob/living/target, target_zone, obj/item/tool, try_to_fail = FALSE)
	target.surgeries[target_zone] = src
	var/obj/item/bodypart/affecting = target.get_bodypart(target_zone)
	if(!preop(user, target, target_zone, tool))
		target.surgeries -= target_zone
		return SURGERY_FAILURE

	var/time = minimum_time
	var/maximum_time_increase = (maximum_time - minimum_time)
	if(skill_used && stat_used)
		time += (maximum_time_increase * ((1 - GET_MOB_SKILL_VALUE(user, skill_used)/SKILL_MASTER) + (1 - GET_MOB_ATTRIBUTE_VALUE(user, stat_used)/ATTRIBUTE_MASTER))/2)
	else if(skill_used)
		time += (maximum_time_increase * (1 - GET_MOB_SKILL_VALUE(user, skill_used)/SKILL_MASTER))
	else if(stat_used)
		time += (maximum_time_increase * (1 - GET_MOB_ATTRIBUTE_VALUE(user, stat_used)/ATTRIBUTE_MASTER))
	time = clamp(CEILING(time, 1), minimum_time, maximum_time)
	var/speed_mod = (user == target ? 1.5 : 1)
	if(tool)
		speed_mod *= tool.toolspeed

	var/success = SURGERY_SUCCESS
	if(!do_after(user, time * speed_mod, target = target))
		target.surgeries -= target_zone
		return success

	var/prob_chance = 100
	if(implement_type)	//this means it isn't a require hand or any item step.
		prob_chance = implements[implement_type]
	else if(!tool)
		prob_chance = accept_hand

	prob_chance *= get_surgery_probability_multiplier(src, target, user)

	var/mob/living/carbon/carbon_target = target
	if(istype(carbon_target) && \
		(carbon_target.stat < UNCONSCIOUS) && \
		affecting?.can_feel_pain() && \
		(carbon_target.mob_biotypes & MOB_ORGANIC) && \
		!carbon_target.InFullShock() && (carbon_target.get_chem_effect(CE_PAINKILLER) < 50))
		prob_chance *= 0.5
		carbon_target.visible_message(span_danger("<b>[carbon_target]</b> [pick("writhes in pain", "squirms and kicks in agony", "cries in pain as [target.p_their()] body violently jerks")], impeding the surgery!"), \
					span_userdanger(span_big("I [pick("writhe as agonizing pain surges throughout my entire body", "feel burning pain sending my body into a convulsion", " squirm as sickening pain fills every part of me")]!")))
		carbon_target.client?.give_award(/datum/award/achievement/misc/look_mom_no_anesthesia, carbon_target)
		carbon_target.agony_scream()
		var/obj/item/bodypart/affected = carbon_target.get_bodypart(check_zone(target_zone))
		var/damage = 7.5 * (ATTRIBUTE_MIDDLING/GET_MOB_ATTRIBUTE_VALUE(carbon_target, STAT_ENDURANCE))
		if(affected?.get_incision())
			var/datum/injury/incision = affected.get_incision()
			incision.open_injury(damage)
		else
			carbon_target.apply_damage(damage, damagetype = BRUTE, def_zone = target_zone, blocked = FALSE, forced = FALSE)

	//Dice roll
	var/real_chance = prob_chance
	if(skill_used)
		real_chance = user.attribute_probability(GET_MOB_SKILL_VALUE(user, skill_used), prob_chance, SKILL_MIDDLING, 5)
	var/didntfuckup = TRUE
	if(!prob(real_chance))
		didntfuckup = FALSE
	if(didntfuckup || (iscyborg(user) && !silicons_obey_prob && chem_check(target) && !try_to_fail))
		if(success(user, target, target_zone, tool))
			success = SURGERY_SUCCESS
	else
		if(failure(user, target, target_zone, tool))
			success = SURGERY_SUCCESS
	spread_germs_to_bodypart(affecting, user, tool)

	target.surgeries -= target_zone
	return success

/datum/surgery_step/proc/preop(mob/user, mob/living/target, target_zone, obj/item/tool)
	display_results(user, target, \
		span_notice("I begin to perform surgery on [target]..."), \
		span_notice("[user] begins to perform surgery on [target]."), \
		span_notice("[user] begins to perform surgery on [target]."))
	return SURGERY_SUCCESS

/datum/surgery_step/proc/success(mob/user, mob/living/target, target_zone, obj/item/tool)
	display_results(user, target, \
		span_notice("I succeed."), \
		span_notice("[user] succeeds!"), \
		span_notice("[user] finishes."))
	return SURGERY_SUCCESS

/datum/surgery_step/proc/failure(mob/user, mob/living/target, target_zone, obj/item/tool)
	display_results(user, target, span_warning("I screw up!"), \
		span_warning("[user] screws up!"), \
		span_warning("[user] finishes."), \
		TRUE) //By default the patient will notice if the wrong thing has been cut
	var/obj/item/bodypart/limb = target.get_bodypart(check_zone(target_zone))
	limb?.receive_damage(brute = 15, sharpness = tool?.get_sharpness())
	return SURGERY_SUCCESS

/datum/surgery_step/proc/get_chem_list()
	if(!LAZYLEN(chems_needed))
		return
	var/list/chems = list()
	for(var/R in chems_needed)
		var/datum/reagent/temp = GLOB.chemical_reagents_list[R]
		if(temp)
			var/chemname = temp.name
			chems += chemname
	return english_list(chems, and_text = require_all_chems ? " and " : " or ")

//Replaces visible_message during operations so only people looking over the surgeon can tell what they're doing, allowing for shenanigans.
/datum/surgery_step/proc/display_results(mob/user, mob/living/carbon/target, self_message, detailed_message, vague_message, target_detailed = FALSE)
	//Only the surgeon and people looking over his shoulder can see the operation clearly
	var/list/detailed_mobs = fov_viewers(1, user)
	detailed_mobs |= user
	if(!target_detailed && (user != target))
		detailed_mobs -= target //The patient can't see well what's going on, unless it's something like getting cut
	user.visible_message(detailed_message, self_message, vision_distance = 1, ignored_mobs = target_detailed ? null : target)
	user.visible_message(vague_message, ignored_mobs = detailed_mobs)
