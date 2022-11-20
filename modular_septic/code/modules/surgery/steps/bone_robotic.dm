//Relocate bones
/datum/surgery_step/relocate_bones_mechanic
	name = "Relocate bones"
	implements = list(
		TOOL_WRENCH = 85,
	)
	minimum_time = 25
	maximum_time = 75
	ignore_clothes = TRUE
	surgery_flags = (STEP_NEEDS_NOT_INCISED|STEP_NEEDS_DISLOCATED)
	requires_bodypart_type = BODYPART_ROBOTIC
	skill_used = SKILL_ELECTRONICS

/datum/surgery_step/relocate_bones_mechanic/validate_target(mob/living/target, mob/user)
	. = ..()
	if(!.)
		return
	var/valid_bone = FALSE
	var/obj/item/bodypart/borked = target.get_bodypart(user.zone_selected)
	for(var/obj/item/organ/bone/bone as anything in borked?.getorganslotlist(ORGAN_SLOT_BONE))
		if(!(bone.organ_flags & ORGAN_SYNTHETIC) || !(bone.bone_flags & BONE_JOINTED) || (bone.damage < bone.low_threshold) || (bone.damage >= bone.medium_threshold))
			continue
		valid_bone = TRUE
		break
	return valid_bone


/datum/surgery_step/relocate_bones_mechanic/preop(mob/user, mob/living/carbon/target, target_zone, obj/item/tool)
	display_results(user, target, \
		span_notice("I begin to relocate [target]'s [parse_zone(user.zone_selected)]..."), \
		span_notice("[user] begins to relocate [target]'s [parse_zone(user.zone_selected)] with [tool]."), \
		span_notice("[user] begins to relocate [target]'s [parse_zone(user.zone_selected)]."))
	return SURGERY_SUCCESS

/datum/surgery_step/relocate_bones_mechanic/success(mob/user, mob/living/carbon/target, target_zone, obj/item/tool)
	if(istype(tool, /obj/item/stack))
		var/obj/item/stack/used_stack = tool
		used_stack.use(1)
	display_results(user, target, \
		span_notice("I successfully relocate [target]'s [parse_zone(target_zone)]."), \
		span_notice("[user] successfully relocates in [target]'s [parse_zone(target_zone)] with [tool]!"), \
		span_notice("[user] successfully relocates in [target]'s [parse_zone(target_zone)]!"))
	log_combat(user, target, "relocated bones in")
	var/obj/item/bodypart/borked = target.get_bodypart(target_zone)
	for(var/obj/item/organ/bone/bone as anything in borked?.getorganslotlist(ORGAN_SLOT_BONE))
		if(!(bone.organ_flags & ORGAN_SYNTHETIC))
			continue
		if(bone.bone_flags & BONE_JOINTED)
			bone.relocate()
	return SURGERY_SUCCESS

// Set bones
/datum/surgery_step/mechanic_set_bones
	name = "Set bones"
	implements = list(TOOL_WRENCH = 80, \
			/obj/item/stack/sticky_tape = 30)
	minimum_time = 25
	maximum_time = 75
	surgery_flags = (STEP_NEEDS_INCISED|STEP_NEEDS_DISLOCATED) //i hate black people
	requires_bodypart_type = BODYPART_ROBOTIC
	skill_used = SKILL_ELECTRONICS

/datum/surgery_step/mechanic_set_bones/validate_target(mob/living/target, mob/user)
	. = ..()
	if(!.)
		return
	var/valid_bone = FALSE
	var/obj/item/bodypart/borked = target.get_bodypart(user.zone_selected)
	for(var/obj/item/organ/bone/bone as anything in borked?.getorganslotlist(ORGAN_SLOT_BONE))
		if(!(bone.organ_flags & ORGAN_SYNTHETIC) || (bone.damage < bone.low_threshold) || (bone.damage >= bone.medium_threshold))
			continue
		valid_bone = TRUE
		break
	return valid_bone

/datum/surgery_step/mechanic_set_bones/preop(mob/user, mob/living/carbon/target, target_zone, obj/item/tool)
	display_results(user, target, \
		span_notice("I begin to set the endoskeleton in [target]'s [parse_zone(user.zone_selected)]..."), \
		span_notice("[user] begins to set the endoskeleton in [target]'s [parse_zone(user.zone_selected)] with [tool]."), \
		span_notice("[user] begins to set the endoskeleton in [target]'s [parse_zone(user.zone_selected)]."))
	return SURGERY_SUCCESS

/datum/surgery_step/mechanic_set_bones/success(mob/user, mob/living/carbon/target, target_zone, obj/item/tool)
	if(istype(tool, /obj/item/stack))
		var/obj/item/stack/used_stack = tool
		used_stack.use(1)
	display_results(user, target, \
		span_notice("I successfully set the endoskeleton in [target]'s [parse_zone(target_zone)]."), \
		span_notice("[user] successfully sets the endoskeleton in [target]'s [parse_zone(target_zone)] with [tool]!"), \
		span_notice("[user] successfully sets the endoskeleton in [target]'s [parse_zone(target_zone)]!"))
	log_combat(user, target, "set bones in")
	var/obj/item/bodypart/borked = target.get_bodypart(target_zone)
	for(var/obj/item/organ/bone/bone in borked?.getorganslotlist(ORGAN_SLOT_BONE))
		if(!(bone.organ_flags & ORGAN_SYNTHETIC))
			continue
		if(bone.bone_flags & BONE_JOINTED)
			bone.relocate()
	return SURGERY_SUCCESS

/datum/surgery_step/mechanic_set_bones/failure(mob/user, mob/living/target, target_zone, obj/item/tool, fail_prob = 0)
	. = ..()
	if(istype(tool, /obj/item/stack))
		var/obj/item/stack/used_stack = tool
		used_stack.use(1)

// Weld endoskeleton
//(mechanic gel bones)
/datum/surgery_step/mechanic_gel_bones
	name = "Weld endoskeleton"
	implements = list(TOOL_WELDER = 80)
	minimum_time = 25
	maximum_time = 75
	surgery_flags = (STEP_NEEDS_INCISED|STEP_NEEDS_BROKEN)
	requires_bodypart_type = BODYPART_ROBOTIC
	skill_used = SKILL_ELECTRONICS

/datum/surgery_step/mechanic_gel_bones/validate_target(mob/living/target, mob/user)
	. = ..()
	if(!.)
		return
	var/valid_bone = FALSE
	var/obj/item/bodypart/borked = target.get_bodypart(user.zone_selected)
	for(var/obj/item/organ/bone/bone as anything in borked?.getorganslotlist(ORGAN_SLOT_BONE))
		if(!(bone.organ_flags & ORGAN_SYNTHETIC) || (bone.damage < bone.medium_threshold))
			continue
		valid_bone = TRUE
		break
	return valid_bone

/datum/surgery_step/mechanic_gel_bones/preop(mob/user, mob/living/carbon/target, target_zone, obj/item/tool)
	display_results(user, target, \
		span_notice("I begin welding the fracture in [target]'s [parse_zone(user.zone_selected)]..."), \
		span_notice("[user] begins welding the fracture in [target]'s [parse_zone(user.zone_selected)] with [tool]."), \
		span_notice("[user] begins welding the fracture in [target]'s [parse_zone(user.zone_selected)]."))
	return SURGERY_SUCCESS

/datum/surgery_step/mechanic_gel_bones/success(mob/user, mob/living/carbon/target, target_zone, obj/item/tool, default_display_results = FALSE)
	display_results(user, target, \
		span_notice("I successfully weld the fracture on [target]'s [parse_zone(target_zone)]."), \
		span_notice("[user] successfully weld the fracture on [target]'s [parse_zone(target_zone)] with [tool]!"), \
		span_notice("[user] successfully weld the fracture on [target]'s [parse_zone(target_zone)]!"))
	log_combat(user, target, "mended fracture")
	var/obj/item/bodypart/unfracture_me = target.get_bodypart(target_zone)
	for(var/obj/item/organ/bone/bone in unfracture_me.getorganslotlist(ORGAN_SLOT_BONE))
		if(!(bone.organ_flags & ORGAN_SYNTHETIC))
			continue
		bone.mend_compound_fracture()
		bone.mend_fracture()
	return SURGERY_SUCCESS
