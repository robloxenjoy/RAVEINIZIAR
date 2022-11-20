//REDPILL
/datum/surgery_step/insert_pill
	name = "Insert pill"
	implements = list(
		/obj/item/reagent_containers/pill = 80,
	)
	minimum_time = 25
	maximum_time = 50
	requires_bodypart_type = null
	possible_locs = list(BODY_ZONE_PRECISE_MOUTH)
	surgery_flags = (STEP_NEEDS_INCISED|STEP_NEEDS_RETRACTED|STEP_NEEDS_DRILLED)

/datum/surgery_step/insert_pill/preop(mob/user, mob/living/carbon/target, target_zone, obj/item/tool)
	display_results(user, target, \
		span_notice("I begin to wedge [tool] in [target]'s [parse_zone(target_zone)]..."), \
		span_notice("[user] begins to wedge \the [tool] in [target]'s [parse_zone(target_zone)]."), \
		span_notice("[user] begins to wedge something inside [target]'s [parse_zone(target_zone)]."))
	return SURGERY_SUCCESS

/datum/surgery_step/insert_pill/success(mob/user, mob/living/carbon/target, target_zone, var/obj/item/reagent_containers/pill/tool)
	user.transferItemToLoc(tool, target, TRUE)

	var/datum/action/item_action/hands_free/activate_pill/pill_action = new(tool)
	pill_action.button.name = "Activate [tool.name]"
	pill_action.target = tool
	pill_action.Grant(target)	//The pill never actually goes in an inventory slot, so the owner doesn't inherit actions from it

	display_results(user, target, \
		span_notice("I wedge [tool] into [target]'s [parse_zone(target_zone)]."), \
		span_notice("[user] wedges \the [tool] into [target]'s [parse_zone(target_zone)]!"), \
		span_notice("[user] wedges something inside [target]'s [parse_zone(target_zone)]!"))
	return SURGERY_SUCCESS

//LE ACTION!
/datum/action/item_action/hands_free/activate_pill
	name = "Activate Pill"

/datum/action/item_action/hands_free/activate_pill/Trigger()
	if(!..())
		return FALSE
	var/obj/item/item_target = target
	to_chat(owner, span_userdanger("You grit your teeth and burst the implanted [item_target.name]!"))
	log_combat(owner, null, "swallowed an implanted pill", item_target)
	if(item_target.reagents?.total_volume)
		item_target.reagents.trans_to(owner, item_target.reagents.total_volume)
	qdel(target)
	return TRUE
