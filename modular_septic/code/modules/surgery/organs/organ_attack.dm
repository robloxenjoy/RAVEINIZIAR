//This file mostly handles healing organs and other weird shit
/obj/item/organ/throw_impact(atom/hit_atom, datum/thrownthing/throwingdatum)
	. = ..()
	if(status == ORGAN_ORGANIC)
		playsound(src, 'sound/misc/splort.ogg', 50, TRUE, -1)

/obj/item/organ/attackby(obj/item/I, mob/living/user, params)
	. = ..()
	return handle_organ_attack(I, user, params)

/obj/item/organ/proc/handle_organ_attack(obj/item/tool, mob/living/user, params)
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
	if(owner && CHECK_BITFIELD(tool.get_sharpness(), SHARP_EDGED) && !CHECK_BITFIELD(organ_flags, ORGAN_CUT_AWAY))
		handle_cutting_away(tool, user, params)
		return TRUE

/obj/item/organ/proc/handle_attaching_item(obj/item/tool, mob/living/user, params)
	var/obj/item/stack/stack = tool
	user.visible_message(span_notice("<b>[user]</b> starts attaching \the [src] on \the <b>[owner]</b>..."), \
					span_notice("I start attaching \the [src] on \the <b>[owner]</b>..."), \
					vision_distance = COMBAT_MESSAGE_RANGE)
	owner.custom_pain("OH GOD! There is something ripping me from inside!", 30, FALSE, owner.get_bodypart(current_zone))
	if(!do_mob(user, owner, 3 SECONDS))
		to_chat(user, span_warning("I must stand still!"))
		return
	if(istype(stack) && !stack.use(2))
		to_chat(user, span_warning("I don't have enough to attach \the [src]!"))
		return
	user.visible_message(span_notice("<b>[user]</b> attaches \the [src] safely on \the <b>[owner]</b>."), \
						span_notice("I attach \the [src] safely on \the <b>[owner]</b>."))
	organ_flags &= ~ORGAN_CUT_AWAY

/obj/item/organ/proc/handle_healing_item(obj/item/tool, mob/living/user, params)
	var/obj/item/stack/stack = tool
	if(organ_flags & (ORGAN_DESTROYED|ORGAN_DEAD))
		to_chat(user, span_warning("\The [src] is damaged beyond the point of no return."))
		return
	if(!damage)
		to_chat(user, span_notice("\The [src] is in pristine quality already."))
		return
	user.visible_message(span_notice("<b>[user]</b> starts healing \the [src]..."), \
					span_notice("I start healing \the [src]..."), \
					vision_distance = COMBAT_MESSAGE_RANGE)
	if(owner)
		owner.custom_pain("OH GOD! There are needles inside my [src]!", 30, FALSE, owner.get_bodypart(current_zone))
		if(!do_mob(user, owner, 5 SECONDS))
			to_chat(user, span_warning("I must stand still!"))
			return
	else
		if(!do_after(user, 5 SECONDS, src))
			to_chat(user, span_warning("I must stand still!"))
			return
	if(istype(stack))
		if(!stack.use(2))
			to_chat(user, span_warning("I don't have enough to heal \the [src]!"))
			return
	user.visible_message(span_notice("<b>[user]</b> healing \the [src]."), \
						span_notice("I heal \the [src]."))
	applyOrganDamage(-min(maxHealth/2, 50))

/obj/item/organ/proc/handle_cutting_away(obj/item/tool, mob/living/user, params)
	user.visible_message(span_notice("<b>[user]</b> starts severing \the [src] from \the [owner]..."), \
					span_notice("I start severing \the [src] from \the [owner]..."), \
					vision_distance = COMBAT_MESSAGE_RANGE)
	owner.custom_pain("OH GOD! My [src] is being STABBED!", 30, FALSE, owner.get_bodypart(current_zone))
	if(!do_mob(user, owner, 6 SECONDS))
		to_chat(user, span_warning("I must stand still!"))
		return TRUE
	user.visible_message(span_notice("<b>[user]</b> severs \the [src] away."), \
					span_notice("I sever \the [src] away."), \
					vision_distance = COMBAT_MESSAGE_RANGE)
	organ_flags |= ORGAN_CUT_AWAY
	return TRUE
