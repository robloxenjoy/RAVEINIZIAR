//open shell
/datum/surgery_step/mechanic_incise
	name = "Unscrew shell"
	implements = list(
		TOOL_SCREWDRIVER = 80,
		TOOL_DRILL = 70,
		TOOL_SCALPEL = 70,
		/obj/item/knife	= 50,
		/obj/item = 45,
	) // 45% success with any pointy item.
	middle_click_step = TRUE
	minimum_time = 16
	maximum_time = 32
	surgery_flags = 0 //fucking FAGS
	requires_bodypart_type = BODYPART_ROBOTIC
	skill_used = SKILL_ELECTRONICS

/datum/surgery_step/mechanic_incise/tool_check(mob/user, obj/item/tool, mob/living/carbon/target)
	. = ..()
	if(implement_type == /obj/item && !(tool.get_sharpness() & SHARP_POINTY))
		return FALSE
	if(istype(tool, /obj/item/reagent_containers))
		return FALSE

/datum/surgery_step/mechanic_incise/validate_target(mob/living/target, mob/user)
	. = ..()
	if(!.) //nah nigga lol
		return FALSE
	var/mob/living/carbon/C = target
	var/obj/item/bodypart/BP = C.get_bodypart(user.zone_selected)
	if(BP.get_incision(TRUE))
		return FALSE

/datum/surgery_step/mechanic_incise/preop(mob/user, mob/living/carbon/target, target_zone, obj/item/tool)
	display_results(user, target, \
		span_notice("I begin to unscrew the shell of [target]'s [parse_zone(target_zone)]..."), \
		span_notice("[user] begins to unscrew the shell of [target]'s [parse_zone(target_zone)]."), \
		span_notice("[user] begins to unscrew the shell of [target]'s [parse_zone(target_zone)]."))
	return SURGERY_SUCCESS

/datum/surgery_step/mechanic_incise/success(mob/user, mob/living/carbon/target, target_zone, obj/item/tool)
	. = ..()
	if(ishuman(target))
		var/mob/living/carbon/human/H = target
		if(!(NOBLOOD in H.dna.species.species_traits))
			display_results(user, target, \
				span_notice("Blood pools around the incision in [H]'s [parse_zone(target_zone)]."), \
				span_notice("Blood pools around the incision in [H]'s [parse_zone(target_zone)]."))
		var/obj/item/bodypart/BP = target.get_bodypart(target_zone)
		if(istype(BP))
			var/datum/injury/ouchie = BP.create_injury(WOUND_SLASH, BP.max_damage * 0.3, TRUE)
			if(!ouchie)
				return
			ouchie.apply_injury(BP.max_damage * 0.3, BP)
			ouchie.injury_flags |= INJURY_SURGICAL
			SEND_SIGNAL(target, COMSIG_CARBON_CLEAR_WOUND_MESSAGE)
			if(BP.current_splint)
				BP.remove_splint()
			if(BP.current_gauze)
				BP.remove_gauze()
	return SURGERY_SUCCESS

//short circuits
//(mechanical equivalente of clamp bleeders)
/datum/surgery_step/mechanic_clamp_bleeders
	name = "Short circuits"
	implements = list(
		TOOL_MULTITOOL = 80,
		TOOL_WIRECUTTER = 70,
	) // try to reroute blood and electricity conductors
	minimum_time = 24
	maximum_time = 48
	requires_bodypart_type = BODYPART_ROBOTIC
	skill_used = SKILL_ELECTRONICS

/datum/surgery_step/mechanic_clamp_bleeders/validate_target(mob/living/target, mob/user)
	. = ..()
	if(!.)
		return
	var/mob/living/carbon/C = target
	var/obj/item/bodypart/limb = C.get_bodypart(user.zone_selected)
	if(limb.is_clamped())
		return FALSE

/datum/surgery_step/mechanic_clamp_bleeders/preop(mob/user, mob/living/carbon/target, target_zone, obj/item/tool)
	display_results(user, target, \
		span_notice("I begin to short circuits in [target]'s [parse_zone(target_zone)]..."), \
		span_notice("[user] begins to short circuits in in [target]'s [parse_zone(target_zone)]."), \
		span_notice("[user] begins to short circuits in in [target]'s [parse_zone(target_zone)]."))
	return SURGERY_SUCCESS

/datum/surgery_step/mechanic_clamp_bleeders/success(mob/user, mob/living/carbon/target, target_zone, obj/item/tool)
	. = ..()
	if(iscarbon(target))
		var/mob/living/carbon/C = target
		var/obj/item/bodypart/BP = C.get_bodypart(target_zone)
		if(BP)
			BP.clamp_limb()
	return SURGERY_SUCCESS

//Pry shell
//(mechanical equivalent of retract skin)
/datum/surgery_step/mechanic_retract_skin
	name = "Pry shell"
	implements = list(TOOL_CROWBAR = 80, \
			/obj/item = 45) //45% with any pointy item
	minimum_time = 32
	maximum_time = 64
	requires_bodypart_type = BODYPART_ROBOTIC
	skill_used = SKILL_ELECTRONICS

/datum/surgery_step/mechanic_retract_skin/tool_check(mob/user, obj/item/tool, mob/living/carbon/target)
	. = ..()
	if(implement_type == /obj/item && !(tool.get_sharpness() & SHARP_POINTY))
		return FALSE
	if(istype(tool, /obj/item/reagent_containers))
		return FALSE

/datum/surgery_step/mechanic_retract_skin/validate_target(mob/living/target, mob/user)
	. = ..()
	if(!.) //nah nigga lol
		return FALSE
	var/mob/living/carbon/C = target
	var/obj/item/bodypart/BP = C.get_bodypart(user.zone_selected)
	var/datum/injury/incision = BP.get_incision()
	if(CHECK_BITFIELD(incision?.injury_flags, INJURY_RETRACTED))
		return FALSE

/datum/surgery_step/mechanic_retract_skin/preop(mob/user, mob/living/carbon/target, target_zone, obj/item/tool)
	display_results(user, target, \
		span_notice("I begin to pry the shell from [target]'s [parse_zone(target_zone)]..."), \
		span_notice("[user] begin to pry the shell from [target]'s [parse_zone(target_zone)]."), \
		span_notice("[user] begin to pry the shell from [target]'s [parse_zone(target_zone)]."))
	return SURGERY_SUCCESS

/datum/surgery_step/mechanic_retract_skin/success(mob/user, mob/living/carbon/target, target_zone, obj/item/tool)
	. = ..()
	var/obj/item/bodypart/BP = target.get_bodypart(check_zone(target_zone))
	if(BP)
		BP.open_incision(user)
	return SURGERY_SUCCESS

//saw endoskeleton
//(mechanical equivalent of sawing through bone)
/datum/surgery_step/mechanic_saw
	name = "Saw endoskeleton"
	implements = list(
		TOOL_SAW = 85,
		/obj/item/melee/arm_blade = 75,
		/obj/item/fireaxe = 50,
		/obj/item/hatchet = 35,
		/obj/item/knife/butcher = 25,
	)
	minimum_time = 32
	maximum_time = 96
	surgery_flags = (STEP_NEEDS_INCISED|STEP_NEEDS_RETRACTED)
	requires_bodypart_type = BODYPART_ROBOTIC
	skill_used = SKILL_ELECTRONICS

/datum/surgery_step/mechanic_saw/validate_target(mob/living/target, mob/user)
	. = ..()
	if(!.) //nah nigga lol
		return FALSE
	var/mob/living/carbon/C = target
	var/obj/item/bodypart/BP = C.get_bodypart(check_zone(user.zone_selected))
	if(BP.is_fractured())
		return FALSE

/datum/surgery_step/mechanic_saw/preop(mob/user, mob/living/carbon/target, target_zone, obj/item/tool)
	display_results(user, target, \
		span_notice("You begin to saw through the bone in [target]'s [parse_zone(target_zone)]..."), \
		span_notice("[user] begins to saw through the bone in [target]'s [parse_zone(target_zone)]."), \
		span_notice("[user] begins to saw through the bone in [target]'s [parse_zone(target_zone)]."))
	return SURGERY_SUCCESS

/datum/surgery_step/mechanic_saw/success(mob/user, mob/living/carbon/target, target_zone, obj/item/tool)
	display_results(user, target, \
		span_notice("You saw [target]'s [parse_zone(target_zone)] open."), \
		span_notice("[user] saws [target]'s [parse_zone(target_zone)] open!"), \
		span_notice("[user] saws [target]'s [parse_zone(target_zone)] open!"))
	//oh GOD oh fuck we need to break this nigga's limb to continue surgery
	var/mob/living/carbon/C = target
	var/obj/item/bodypart/BP = C.get_bodypart(target_zone)
	if(!BP.is_fractured())
		var/datum/wound/blunt/severe/fracture = new()
		fracture.apply_wound(BP, TRUE)
		SEND_SIGNAL(C, COMSIG_CARBON_CLEAR_WOUND_MESSAGE)
	return SURGERY_SUCCESS

//close shell
//(mechanical equivalent of mend incision)
/datum/surgery_step/mechanic_close
	name = "Screw shell"
	implements = list(
		TOOL_SCREWDRIVER = 80,
		TOOL_DRILL = 70,
		TOOL_SCALPEL = 70,
		/obj/item/knife	= 50,
		/obj/item = 35,
	) // 35% success with any sharp item.
	minimum_time = 16
	maximum_time = 48
	requires_bodypart_type = BODYPART_ROBOTIC
	skill_used = SKILL_ELECTRONICS

/datum/surgery_step/mechanic_close/tool_check(mob/user, obj/item/tool, mob/living/carbon/target)
	. = ..()
	if(implement_type == /obj/item && !(tool.get_sharpness() & SHARP_POINTY))
		return FALSE
	if(istype(tool, /obj/item/reagent_containers))
		return FALSE

/datum/surgery_step/mechanic_close/validate_target(mob/living/target, mob/user)
	. = ..()
	if(!.) //nah nigga lol
		return FALSE
	var/mob/living/carbon/C = target
	var/obj/item/bodypart/BP = C.get_bodypart(user.zone_selected)
	for(var/datum/injury/IN as anything in BP.injuries)
		if(IN.damage_type == WOUND_SLASH || IN.damage_type == WOUND_PIERCE)
			return TRUE
	return FALSE

/datum/surgery_step/mechanic_close/tool_check(mob/user, obj/item/tool, mob/living/carbon/target)
	if(implement_type == /obj/item && !tool.get_sharpness())
		return FALSE
	return TRUE

/datum/surgery_step/mechanic_close/preop(mob/user, mob/living/carbon/target, target_zone, obj/item/tool)
	display_results(user, target, \
		span_notice("I begin to screw the shell of [target]'s [parse_zone(target_zone)]..."), \
		span_notice("[user] begins to screw the shell of [target]'s [parse_zone(target_zone)]."), \
		span_notice("[user] begins to screw the shell of [target]'s [parse_zone(target_zone)]."))
	return SURGERY_SUCCESS

/datum/surgery_step/mechanic_close/success(mob/user, mob/living/target, target_zone, obj/item/tool)
	. = ..()
	if(iscarbon(target))
		var/mob/living/carbon/C = target
		var/obj/item/bodypart/BP = C.get_bodypart(target_zone)
		if(istype(BP))
			for(var/datum/injury/inch in BP.injuries)
				if(inch.is_surgical())
					inch.clamp_injury()
					inch.close_injury()
				else
					inch.clamp_injury()
		if(BP.is_clamped())
			BP.unclamp_limb()
	return SURGERY_SUCCESS

