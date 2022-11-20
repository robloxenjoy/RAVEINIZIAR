//amputate limb
//(but robotic)
/datum/surgery_step/mechanic_sever_limb
	name = "Sever limb"
	implements = list(
		TOOL_WIRECUTTER = 80,
		TOOL_SAW = 60,
	)
	minimum_time = 32
	maximum_time = 96
	target_mobtypes = list(/mob/living/carbon/human)
	possible_locs = AMPUTATABLE_BODYPARTS
	requires_bodypart_type = BODYPART_ROBOTIC
	surgery_flags = (STEP_NEEDS_INCISED|STEP_NEEDS_BROKEN)
	skill_used = SKILL_ELECTRONICS

/datum/surgery_step/mechanic_sever_limb/validate_target(mob/living/carbon/target, mob/user)
	. = ..()
	var/obj/item/bodypart/part = target.get_bodypart(user.zone_selected)
	if(part?.is_stump())
		return FALSE

/datum/surgery_step/mechanic_sever_limb/preop(mob/user, mob/living/carbon/target, target_zone, obj/item/tool)
	var/obj/item/bodypart/BP = target.get_bodypart(target_zone)
	display_results(user, target, \
		span_notice("I begin to sever [target]'s [parse_zone(target_zone)] by \the [BP.amputation_point_name]..."), \
		span_notice("[user] begins to sever [target]'s [parse_zone(target_zone)]!"), \
		span_notice("[user] begins to sever [target]'s [parse_zone(target_zone)]!"))
	return SURGERY_SUCCESS

/datum/surgery_step/mechanic_sever_limb/success(mob/user, mob/living/carbon/target, target_zone, obj/item/tool)
	var/mob/living/carbon/human/L = target
	var/obj/item/bodypart/BP = target.get_bodypart(target_zone)
	display_results(user, target, \
		span_notice("I sever [L]'s [parse_zone(target_zone)] from \the [BP.amputation_point_name]."), \
		span_notice("[user] severs [L]'s [parse_zone(target_zone)]!"), \
		span_notice("[user] severs [L]'s [parse_zone(target_zone)]!"))
	var/obj/item/bodypart/target_limb = target.get_bodypart(target_zone)
	target_limb.drop_limb()
	return SURGERY_SUCCESS


//amputate stump
/datum/surgery_step/mechanic_sever_stump
	name = "Sever stump"
	implements = list(TOOL_SAW = 80, \
			/obj/item/melee/arm_blade = 75, \
			/obj/item/chainsaw = 75, \
			/obj/item/mounted_chainsaw = 75, \
			/obj/item/fireaxe = 50, \
			/obj/item/hatchet = 40, \
			/obj/item/knife/butcher = 25)
	minimum_time = 16
	maximum_time = 56
	target_mobtypes = list(/mob/living/carbon/human)
	possible_locs = AMPUTATABLE_BODYPARTS
	requires_bodypart_type = BODYPART_ROBOTIC
	surgery_flags = (STEP_NEEDS_INCISED)
	skill_used = SKILL_ELECTRONICS

/datum/surgery_step/mechanic_sever_stump/validate_target(mob/living/carbon/target, mob/user)
	. = ..()
	var/obj/item/bodypart/stump = target.get_bodypart(user.zone_selected)
	if(!stump?.is_stump())
		return FALSE

/datum/surgery_step/mechanic_sever_stump/preop(mob/user, mob/living/carbon/target, target_zone, obj/item/tool)
	var/obj/item/bodypart/BP = target.get_bodypart(target_zone)
	display_results(user, target, \
		span_notice("I begin to sever [target]'s [parse_zone(target_zone)] by \the [BP.amputation_point_name]..."),
		span_notice("[user] begins to sever [target]'s [parse_zone(target_zone)]!"), \
		span_notice("[user] begins to sever [target]'s [parse_zone(target_zone)]!"))
	return SURGERY_SUCCESS

/datum/surgery_step/mechanic_sever_stump/success(mob/user, mob/living/carbon/target, target_zone, obj/item/tool)
	var/mob/living/carbon/human/L = target
	var/obj/item/bodypart/BP = target.get_bodypart(target_zone)
	display_results(user, target, \
		span_notice("I sever [L]'s [parse_zone(target_zone)] from \the [BP.amputation_point_name]."), \
		span_notice("[user] severs [L]'s [parse_zone(target_zone)]!"), \
		span_notice("[user] severs [L]'s [parse_zone(target_zone)]!"))
	var/obj/item/bodypart/target_limb = target.get_bodypart(target_zone)
	target_limb.drop_limb()
	return SURGERY_SUCCESS
