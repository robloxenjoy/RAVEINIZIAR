/datum/surgery_step/dissect
	name = "Dissect"
	implements = list(
		TOOL_SCALPEL = 80, \
		/obj/item/melee/energy/sword = 75, \
		/obj/item/knife = 65, \
		/obj/item/shard = 45, \
		/obj/item = 45,
	) // 45% success with any sharp item.
	middle_click_step = TRUE
	minimum_time = 20
	maximum_time = 40
	surgery_flags = 0 //fucking FAGS

/datum/surgery_step/dissect/validate_target(mob/living/target, mob/user)
	. = ..()
	if(!.) //nah nigga lol
		return FALSE
	var/mob/living/carbon/C = target
	var/obj/item/bodypart/BP = C.get_bodypart(user.zone_selected)
	if(!BP.get_incision(TRUE))
		return FALSE

/datum/surgery_step/dissect/tool_check(mob/user, obj/item/tool, mob/living/carbon/target)
	. = ..()
	if((implement_type == /obj/item) && !(tool.get_sharpness() & SHARP_EDGED))
		return FALSE
	if(istype(tool, /obj/item/reagent_containers))
		return FALSE

/datum/surgery_step/dissect/preop(mob/user, mob/living/carbon/target, target_zone, obj/item/tool)
	display_results(user, target, \
		span_notice("I begin to dissect [target]'s [parse_zone(target_zone)]..."), \
		span_danger("[user] begins to dissect [target]'s [parse_zone(target_zone)]."), \
		span_danger("[user] begins to dissect [target]'s [parse_zone(target_zone)]."))
	return SURGERY_SUCCESS

/datum/surgery_step/dissect/success(mob/user, mob/living/carbon/target, target_zone, obj/item/tool)
	display_results(user, target, \
		span_notice("I dissect [target]'s [parse_zone(target_zone)]!"), \
		span_danger("[user] dissects [target]'s [parse_zone(target_zone)]!"), \
		span_danger("[user] dissects [target]'s [parse_zone(target_zone)]!"))
	if(ishuman(target))
		var/obj/item/bodypart/bodypart = target.get_bodypart(target_zone)
		if(istype(bodypart))
			if(target.stat < UNCONSCIOUS)
				target.death_scream()
			for(var/obj/item/organ/bone/bone in bodypart.getorganslotlist(ORGAN_SLOT_BONE))
				bone.compound_fracture()
			if(bodypart.body_zone in (LIMB_BODYPARTS|BODY_ZONE_PRECISE_NECK))
				bodypart.apply_dismember(WOUND_SLASH, TRUE, FALSE)
			bodypart.open_incision()
			SEND_SIGNAL(target, COMSIG_CARBON_CLEAR_WOUND_MESSAGE)
			playsound(target, 'modular_septic/sound/gore/dissection.ogg', 80, 0)
	return SURGERY_SUCCESS
