//limb reattachment
/datum/surgery_step/add_prosthetic
	name = "Add prosthetic"
	implements = list(
		/obj/item/storage/organbox = 85,
		/obj/item/bodypart = 80,
	)
	minimum_time = 24
	maximum_time = 48
	target_mobtypes = list(/mob/living/carbon/human)
	possible_locs = ALL_BODYPARTS
	requires_bodypart = FALSE
	requires_missing_bodypart = TRUE
	requires_bodypart_type = 0
	surgery_flags = 0
	var/organ_rejection_dam = 0

/datum/surgery_step/add_prosthetic/preop(mob/user, mob/living/carbon/target, target_zone, obj/item/tool)
	if(istype(tool, /obj/item/storage/organbox))
		if(!tool.contents.len)
			to_chat(user, span_notice("There is nothing inside [tool]!"))
			return SURGERY_SUCCESS
		var/obj/item/inside = tool.contents[1]
		if(!isbodypart(inside))
			to_chat(user, span_notice("[inside] cannot be attached!"))
			return SURGERY_SUCCESS
		tool = inside
	if(isbodypart(tool))
		var/obj/item/bodypart/bodypart = tool
		if(bodypart.status != BODYPART_ROBOTIC)
			organ_rejection_dam = 10
			if(ishuman(target))
				var/mob/living/carbon/human/human = target
				if(human.dna.species.id != bodypart.species_id)
					organ_rejection_dam = 30

		if(target_zone == bodypart.body_zone) //so we can't replace a leg with an arm, or a human arm with a monkey arm.
			display_results(user, target, \
				span_notice("I begin to replace [target]'s [parse_zone(target_zone)] with [tool]..."), \
				span_notice("[user] begins to replace [target]'s [parse_zone(target_zone)] with [tool]."), \
				span_notice("[user] begins to replace [target]'s [parse_zone(target_zone)]."))
		else if(target_zone in bodypart.children_zones)
			display_results(user, target, \
				span_notice("I begin to replace [target]'s [parse_zone(target_zone)] with [tool]..."), \
				span_notice("[user] begins to replace [target]'s [parse_zone(target_zone)] with [tool]."), \
				span_notice("[user] begins to replace [target]'s [parse_zone(target_zone)]."))
		else
			to_chat(user, span_warning("[tool] isn't the right type for [parse_zone(target_zone)]."))
	else
		display_results(user, target,
			span_notice("I begin to attach [tool] onto [target]..."), \
			span_notice("[user] begins to attach [tool] onto [target]'s [parse_zone(target_zone)]."), \
			span_notice("[user] begins to attach something onto [target]'s [parse_zone(target_zone)]."))
	return SURGERY_SUCCESS

/datum/surgery_step/add_prosthetic/success(mob/user, mob/living/carbon/target, target_zone, obj/item/tool)
	if(istype(tool, /obj/item/storage/organbox))
		tool.icon_state = initial(tool.icon_state)
		tool.desc = initial(tool.desc)
		tool.cut_overlays()
		tool = tool.contents[1]
	if(istype(tool, /obj/item/bodypart) && user.temporarilyRemoveItemFromInventory(tool))
		var/obj/item/bodypart/limb = tool
		if(target_zone != limb.body_zone)
			if(target_zone in limb.children_zones)
				for(var/obj/item/bodypart/fosterchild in limb)
					if((fosterchild.body_zone in limb.children_zones) && (target_zone == fosterchild.body_zone))
						limb = fosterchild
						limb.forceMove(get_turf(target))
						limb.attach_limb(target)
						break
			else
				return SURGERY_SUCCESS
		else
			limb.attach_limb(target)
		if(organ_rejection_dam)
			target.adjustToxLoss(organ_rejection_dam)
		display_results(user, target, \
			span_notice("I succeed in replacing [target]'s [parse_zone(target_zone)]."), \
			span_notice("[user] successfully replaces [target]'s [parse_zone(target_zone)] with [tool]!"), \
			span_notice("[user] successfully replaces [target]'s [parse_zone(target_zone)]!"))
	else
		var/obj/item/bodypart/limb = target.newBodyPart(target_zone, FALSE, FALSE)
		if(!limb)
			return SURGERY_SUCCESS
		limb.is_pseudopart = TRUE
		limb.attach_limb(target)
		display_results(user, target, \
			span_notice("I attach [tool]."), \
			span_notice("[user] finishes attaching [tool]!"), \
			span_notice("[user] finishes the attachment procedure!"))
		if(istype(tool))
			var/obj/item/new_limb = new tool.type(target)
			if(target_zone == BODY_ZONE_PRECISE_R_HAND)
				target.put_in_r_hand(new_limb)
				ADD_TRAIT(new_limb, TRAIT_NODROP, "surgery")
			else if(target_zone == BODY_ZONE_PRECISE_L_HAND)
				target.put_in_l_hand(new_limb)
				ADD_TRAIT(new_limb, TRAIT_NODROP, "surgery")
			limb.name = "[new_limb.name] [limb.name]"
			limb.desc = new_limb.desc
			target.regenerate_icons()
			qdel(tool)
	return SURGERY_SUCCESS

//sewing a limb back on
/datum/surgery_step/sew_limb
	name = "Sew limb"
	implements = list(/obj/item/stack/medical/nervemend = 90,
			/obj/item/stack/medical/suture = 80, \
			/obj/item/stack/sticky_tape/surgical = 75, \
			/obj/item/stack/sticky_tape = 65, \
			/obj/item/stack/cable_coil = 50)
	minimum_time = 24
	maximum_time = 48
	target_mobtypes = list(/mob/living/carbon/human)
	possible_locs = ALL_BODYPARTS
	requires_bodypart = TRUE
	requires_bodypart_type = BODYPART_ORGANIC
	surgery_flags = 0

/datum/surgery_step/sew_limb/tool_check(mob/user, obj/item/tool, mob/living/carbon/target)
	. = ..()
	var/obj/item/stack/stack = tool
	if(!istype(stack))
		return FALSE
	if(stack.get_amount() < 3)
		return FALSE

/datum/surgery_step/sew_limb/validate_target(mob/living/target, mob/user)
	. = ..()
	if(!. || !iscarbon(target))
		return
	var/mob/living/carbon/carbon_target = target
	var/obj/item/bodypart/affected = carbon_target.get_bodypart(user.zone_selected)
	if(!affected.is_cut_away())
		return FALSE

/datum/surgery_step/sew_limb/preop(mob/user, mob/living/carbon/target, target_zone, obj/item/tool)
	var/obj/item/bodypart/bodypart = target.get_bodypart(target_zone)
	display_results(user, target, \
		span_notice("I begin to sew [target]'s [parse_zone(target_zone)] to it's [bodypart.amputation_point_name]..."), \
		span_notice("[user] begins to sew [target]'s [parse_zone(target_zone)] in place!"), \
		span_notice("[user] begins to sew [target]'s [parse_zone(target_zone)] in place!"))
	return SURGERY_SUCCESS

/datum/surgery_step/sew_limb/success(mob/user, mob/living/carbon/target, target_zone, obj/item/tool)
	var/obj/item/stack/vibe = tool
	if(istype(vibe) && !vibe.use(3))
		return SURGERY_SUCCESS
	var/mob/living/carbon/human/human_target = target
	var/obj/item/bodypart/bodypart = human_target.get_bodypart(target_zone)
	display_results(user, target,
		span_notice("I sew [human_target]'s [parse_zone(target_zone)] to it's [bodypart.amputation_point_name]."), \
		span_notice("[user] sews [human_target]'s [parse_zone(target_zone)] in place!"), \
		span_notice("[user] sews [human_target]'s [parse_zone(target_zone)] in place!"))
	var/obj/item/bodypart/target_limb = target.get_bodypart(target_zone)
	target_limb?.sew_limb()
	return SURGERY_SUCCESS
