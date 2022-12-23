//Generic steps used in a lot of surgeries

//make incision
/datum/surgery_step/incise
	name = "Make incision"
	implements = list(
		TOOL_SCALPEL = 80,
		/obj/item/melee/energy/sword = 65,
		/obj/item/knife = 65,
		/obj/item/shard = 45,
		/obj/item = 45,
	) // 45% success with any sharp item.
	middle_click_step = TRUE
	minimum_time = 16
	maximum_time = 32
	surgery_flags = 0 //fucking FAGS

/datum/surgery_step/incise/tool_check(mob/user, obj/item/tool, mob/living/carbon/target)
	. = ..()
	if((implement_type == /obj/item) && !(tool.get_sharpness() & SHARP_EDGED))
		return FALSE
	if(istype(tool, /obj/item/reagent_containers))
		return FALSE

/datum/surgery_step/incise/validate_target(mob/living/target, mob/user)
	. = ..()
	if(!.) //nah nigga lol
		return FALSE
	var/mob/living/carbon/C = target
	var/obj/item/bodypart/BP = C.get_bodypart(user.zone_selected)
	if(BP.get_incision(TRUE))
		return FALSE

/datum/surgery_step/incise/preop(mob/user, mob/living/carbon/target, target_zone, obj/item/tool)
	display_results(user, target, \
		span_notice("I begin to make an incision in [target]'s [parse_zone(target_zone)]..."), \
		span_notice("[user] begins to make an incision in [target]'s [parse_zone(target_zone)]."), \
		span_notice("[user] begins to make an incision in [target]'s [parse_zone(target_zone)]."))
	return SURGERY_SUCCESS

/datum/surgery_step/incise/success(mob/user, mob/living/carbon/target, target_zone, obj/item/tool)
	. = ..()
	if(ishuman(target))
		var/mob/living/carbon/human/human_target = target
		if(!(NOBLOOD in human_target.dna.species.species_traits))
			display_results(user, target, \
				span_notice("Blood pools around the incision in [human_target]'s [parse_zone(target_zone)]."), \
				span_notice("Blood pools around the incision in [human_target]'s [parse_zone(target_zone)]."))
		var/obj/item/bodypart/BP = target.get_bodypart(target_zone)
		if(istype(BP))
			var/datum/injury/ouchie = BP.create_injury(WOUND_SLASH, BP.max_damage * 0.3, TRUE)
			if(!ouchie)
				return
			ouchie.injury_flags |= INJURY_SURGICAL
			SEND_SIGNAL(target, COMSIG_CARBON_CLEAR_WOUND_MESSAGE)
			playsound(target, 'modular_septic/sound/gore/flesh1.ogg', 75, 0)
			if(BP.current_splint)
				BP.remove_splint()
			if(BP.current_gauze)
				BP.remove_gauze()

//clamp bleeders
//Not a hard requirement, just needed if you don't want your patient to bleed out
/datum/surgery_step/clamp_bleeders
	name = "Clamp bleeders"
	implements = list(
		TOOL_HEMOSTAT = 80,
		TOOL_WIRECUTTER = 60,
		/obj/item/stack/package_wrap = 35,
		/obj/item/stack/cable_coil = 15,
	)
	minimum_time = 24
	maximum_time = 48

/datum/surgery_step/clamp_bleeders/validate_target(mob/living/target, mob/user)
	. = ..()
	if(!.)
		return
	var/mob/living/carbon/C = target
	var/obj/item/bodypart/limb = C.get_bodypart(user.zone_selected)
	if(limb.is_clamped())
		return FALSE

/datum/surgery_step/clamp_bleeders/preop(mob/user, mob/living/carbon/target, target_zone, obj/item/tool)
	display_results(user, target, \
		span_notice("I begin to clamp bleeders in [target]'s [parse_zone(target_zone)]..."), \
		span_notice("[user] begins to clamp bleeders in [target]'s [parse_zone(target_zone)]."), \
		span_notice("[user] begins to clamp bleeders in [target]'s [parse_zone(target_zone)]."))
	return SURGERY_SUCCESS

/datum/surgery_step/clamp_bleeders/success(mob/user, mob/living/carbon/target, target_zone, obj/item/tool)
	display_results(user, target, \
		span_notice("I clamp bleeders in [target]'s [parse_zone(target_zone)]..."), \
		span_notice("[user] clamps bleeders in [target]'s [parse_zone(target_zone)]."), \
		span_notice("[user] clamps bleeders in [target]'s [parse_zone(target_zone)]."))
	if(iscarbon(target))
		var/mob/living/carbon/C = target
		var/obj/item/bodypart/BP = C.get_bodypart(target_zone)
		if(BP)
			BP.clamp_limb()
	return SURGERY_SUCCESS

//retract skin
/datum/surgery_step/retract_skin
	name = "Retract skin"
	implements = list(
		TOOL_RETRACTOR = 80,
		TOOL_SCREWDRIVER = 45,
		TOOL_WIRECUTTER = 35,
	)
	minimum_time = 32
	maximum_time = 64

/datum/surgery_step/retract_skin/validate_target(mob/living/target, mob/user)
	. = ..()
	if(!.) //nah nigga lol
		return FALSE
	var/mob/living/carbon/C = target
	var/obj/item/bodypart/BP = C.get_bodypart(user.zone_selected)
	var/datum/injury/incision = BP.get_incision()
	if(CHECK_BITFIELD(incision?.injury_flags, INJURY_RETRACTED))
		return FALSE

/datum/surgery_step/retract_skin/preop(mob/user, mob/living/carbon/target, target_zone, obj/item/tool)
	display_results(user, target, \
		span_notice("I begin to retract the skin in [target]'s [parse_zone(target_zone)]..."), \
		span_notice("[user] begins to retract the skin in [target]'s [parse_zone(target_zone)]."), \
		span_notice("[user] begins to retract the skin in [target]'s [parse_zone(target_zone)]."))
	return SURGERY_SUCCESS

/datum/surgery_step/retract_skin/success(mob/user, mob/living/carbon/target, target_zone, obj/item/tool)
	display_results(user, target, \
		span_notice("I retract the skin in [target]'s [parse_zone(target_zone)]..."), \
		span_notice("[user] retracts the skin in [target]'s [parse_zone(target_zone)]."), \
		span_notice("[user] retracts the skin in [target]'s [parse_zone(target_zone)]."))
	var/obj/item/bodypart/BP = target.get_bodypart(target_zone)
	if(BP)
		BP.open_incision(user)
		if(!length(tool.embedding))
			tool.embedding = EMBED_HARMLESS
			tool.updateEmbedding()
		tool.tryEmbed(target = BP, forced = TRUE, silent = TRUE)
		tool.RegisterSignal(tool, COMSIG_ITEM_UNEMBEDDED, /obj/item/proc/unspeculumize, TRUE)
		playsound(target, 'modular_septic/sound/gore/stuck2.ogg', 60, 0)
	return SURGERY_SUCCESS

//saw bone
/datum/surgery_step/saw
	name = "Saw bone"
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

/datum/surgery_step/saw/validate_target(mob/living/target, mob/user)
	. = ..()
	if(!.) //nah nigga lol
		return FALSE
	var/mob/living/carbon/C = target
	var/obj/item/bodypart/BP = C.get_bodypart(check_zone(user.zone_selected))
	if(BP.is_fractured())
		return FALSE

/datum/surgery_step/saw/preop(mob/user, mob/living/carbon/target, target_zone, obj/item/tool)
	display_results(user, target, \
		span_notice("I begin to saw through the bone in [target]'s [parse_zone(target_zone)]..."), \
		span_notice("[user] begins to saw through the bone in [target]'s [parse_zone(target_zone)]."), \
		span_notice("[user] begins to saw through the bone in [target]'s [parse_zone(target_zone)]."))
	return SURGERY_SUCCESS

/datum/surgery_step/saw/success(mob/user, mob/living/carbon/target, target_zone, obj/item/tool)
	display_results(user, target, \
		span_notice("I saw [target]'s [parse_zone(target_zone)] open."), \
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

//drill bone
/datum/surgery_step/drill
	name = "Drill bone"
	implements = list(TOOL_DRILL = 80, \
			/obj/item/screwdriver/power = 80, \
			/obj/item/pickaxe/drill = 60, \
			TOOL_SCREWDRIVER = 20)
	minimum_time = 32
	maximum_time = 96
	surgery_flags = (STEP_NEEDS_INCISED | STEP_NEEDS_RETRACTED)

/datum/surgery_step/drill/validate_target(mob/living/target, mob/user)
	. = ..()
	if(!.) //nah nigga lol
		return FALSE
	var/mob/living/carbon/C = target
	var/obj/item/bodypart/BP = C.get_bodypart(user.zone_selected)
	if(CHECK_BITFIELD(BP?.how_open(), SURGERY_DRILLED))
		return FALSE

/datum/surgery_step/drill/preop(mob/user, mob/living/carbon/target, target_zone, obj/item/tool)
	display_results(user, target, \
		span_notice("I begin to drill into the bone in [target]'s [parse_zone(target_zone)]..."), \
		span_notice("[user] begins to drill into the bone in [target]'s [parse_zone(target_zone)]."), \
		span_notice("[user] begins to drill into the bone in [target]'s [parse_zone(target_zone)]."))
	return SURGERY_SUCCESS

/datum/surgery_step/drill/success(mob/user, mob/living/carbon/target, target_zone, obj/item/tool)
	display_results(user, target, \
		span_notice("I drill into [target]'s [parse_zone(target_zone)]."), \
		span_notice("[user] drills into [target]'s [parse_zone(target_zone)]!"), \
		span_notice("[user] drills into [target]'s [parse_zone(target_zone)]!"))
	var/obj/item/bodypart/BP = target.get_bodypart(user.zone_selected)
	var/datum/injury/incision = BP.get_incision()
	incision?.injury_flags |= INJURY_DRILLED
	return SURGERY_SUCCESS

//Cauterize incision
/datum/surgery_step/close
	name = "Cauterize"
	implements = list(
		TOOL_CAUTERY = 80,
		/obj/item/melee/energy = 65,
		/obj/item/gun/energy/laser = 50,
		/obj/item = 50,
	) // 50% success with any hot item.
	skill_used = SKILL_MEDICINE
	minimum_time = 16
	maximum_time = 48

/datum/surgery_step/close/validate_target(mob/living/target, mob/user)
	. = ..()
	if(!.) //nah nigga lol
		return FALSE
	var/mob/living/carbon/C = target
	var/obj/item/bodypart/BP = C.get_bodypart(user.zone_selected)
	for(var/datum/injury/IN in BP.injuries)
		if(IN.damage_type == WOUND_SLASH || IN.damage_type == WOUND_PIERCE)
			return TRUE
	return FALSE

/datum/surgery_step/close/tool_check(mob/user, obj/item/tool, mob/living/carbon/target)
	if(implement_type == TOOL_WELDER || implement_type == /obj/item)
		return tool.get_temperature()
	return TRUE

/datum/surgery_step/close/preop(mob/user, mob/living/carbon/target, target_zone, obj/item/tool)
	display_results(user, target, \
		span_notice("I begin cauterizing the wounds in [target]'s [parse_zone(target_zone)]..."), \
		span_notice("[user] begins to cauterize the wounds in [target]'s [parse_zone(target_zone)]."), \
		span_notice("[user] begins to cauterize the wounds in [target]'s [parse_zone(target_zone)]."))
	return SURGERY_SUCCESS

/datum/surgery_step/close/success(mob/user, mob/living/carbon/target, target_zone, obj/item/tool)
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

//disinfect injuries
/datum/surgery_step/disinfect_injuries
	name = "Disinfect injuries"
	implements = list(
		/obj/item/reagent_containers = 80,
	)
	minimum_time = 16
	maximum_time = 32
	surgery_flags = 0
	skill_used = SKILL_MEDICINE

/datum/surgery_step/disinfect_injuries/tool_check(mob/user, obj/item/tool, mob/living/carbon/target)
	. = ..()
	if(.)
		var/obj/item/reagent_containers/RC = tool
		if(!istype(RC) || !RC.is_drainable())
			return FALSE
		if(!RC.reagents?.has_reagent(/datum/reagent/space_cleaner/sterilizine, 10) && !RC.reagents.has_reagent(/datum/reagent/consumable/ethanol, 30))
			return FALSE
		if(RC.reagents.has_reagent(/datum/reagent/consumable/ethanol, 30))
			var/datum/reagent/consumable/ethanol/ethanol = RC.reagents.get_reagent(/datum/reagent/consumable/ethanol)
			if(ethanol.boozepwr < 40)
				return FALSE

/datum/surgery_step/disinfect_injuries/validate_target(mob/living/target, mob/user)
	. = ..()
	if(!.)
		return FALSE
	var/mob/living/carbon/C = target
	var/obj/item/bodypart/BP = C.get_bodypart(user.zone_selected)
	if(BP.is_disinfected() && BP.is_salved())
		return FALSE

/datum/surgery_step/disinfect_injuries/preop(mob/user, mob/living/carbon/target, target_zone, obj/item/tool)
	display_results(user, target, \
		span_notice("I begin to disinfect the injuries on [target]'s [parse_zone(target_zone)]..."), \
		span_notice("[user] begins to disinfect the injuries on [target]'s [parse_zone(target_zone)]."), \
		span_notice("[user] begins to disinfect the injuries on [target]'s [parse_zone(target_zone)]."))
	return SURGERY_SUCCESS

/datum/surgery_step/disinfect_injuries/success(mob/user, mob/living/carbon/target, target_zone, obj/item/tool)
	display_results(user, target, \
		span_notice("I disinfect the injuries on [target]'s [parse_zone(target_zone)]."), \
		span_notice("[user] disinfects the injuries on [target]'s [parse_zone(target_zone)]!"), \
		span_notice("[user] disinfects the injuries on [target]'s [parse_zone(target_zone)]!"))
	var/obj/item/bodypart/BP = target.get_bodypart(target_zone)
	BP?.disinfect_limb()
	BP?.salve_limb()
	return SURGERY_SUCCESS
