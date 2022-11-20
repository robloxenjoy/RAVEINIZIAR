/obj/item/organ/cyberimp/arm
	name = "arm-mounted implant"
	desc = "You shouldn't see this! Adminhelp and report this as an issue on github!"
	zone = BODY_ZONE_R_ARM
	organ_efficiency = list(ORGAN_SLOT_ARM_AUG = 100)
	icon_state = "implant-toolkit"
	w_class = WEIGHT_CLASS_SMALL
	actions_types = list(/datum/action/item_action/organ_action/toggle)
	emp_vulnerability = 50
	///A ref for the arm we're taking up. Mostly for the unregister signal upon removal
	var/obj/hand
	//A list of typepaths to create and insert into ourself on init
	var/list/items_to_create = list()
	/// Used to store a list of all items inside, for multi-item implants.
	var/list/items_list = list()// I would use contents, but they shuffle on every activation/deactivation leading to interface inconsistencies.
	/// You can use this var for item path, it would be converted into an item on New().
	var/obj/item/active_item
	/// Sound played when extending
	var/extend_sound = 'sound/mecha/mechmove03.ogg'
	/// Sound played when retracting
	var/retract_sound = 'sound/mecha/mechmove03.ogg'

/obj/item/organ/cyberimp/arm/Initialize()
	. = ..()
	if(ispath(active_item))
		active_item = new active_item(src)
		items_list += WEAKREF(active_item)
	for(var/typepath in items_to_create)
		var/atom/new_item = new typepath(src)
		items_list += WEAKREF(new_item)

	SetSlotFromZone()
	update_appearance()

/obj/item/organ/cyberimp/arm/Destroy()
	hand = null
	active_item = null
	for(var/datum/weakref/ref in items_list)
		var/obj/item/to_del = ref.resolve()
		if(!to_del)
			continue
		qdel(to_del)
	items_list.Cut()
	return ..()

/obj/item/organ/cyberimp/arm/proc/SetSlotFromZone(new_zone = zone)
	switch(new_zone)
		if(BODY_ZONE_R_ARM)
			organ_efficiency = list(ORGAN_SLOT_ARM_AUG = 100)
		if(BODY_ZONE_L_ARM)
			organ_efficiency = list(ORGAN_SLOT_ARM_AUG = 100)
		else
			CRASH("Invalid zone set for arm cyberimp.")

/obj/item/organ/cyberimp/arm/update_icon(updates)
	. = ..()
	transform = (zone == BODY_ZONE_R_ARM) ? null : matrix(-1, 0, 0, 0, 1, 0)

/obj/item/organ/cyberimp/arm/screwdriver_act(mob/living/user, obj/item/I)
	. = ..()
	if(.)
		return TRUE
	I.play_tool_sound(src)
	if(zone == BODY_ZONE_R_ARM)
		zone = BODY_ZONE_L_ARM
	else
		zone = BODY_ZONE_R_ARM
	to_chat(user, span_notice("I modify [src] to be installed on the [zone == BODY_ZONE_R_ARM ? "right" : "left"] arm."))
	SetSlotFromZone()
	update_appearance()

/obj/item/organ/cyberimp/arm/Insert(mob/living/carbon/new_owner, special = FALSE, drop_if_replaced = TRUE, new_zone = null)
	. = ..()
	var/side = current_zone == BODY_ZONE_R_ARM ? RIGHT_HANDS : LEFT_HANDS
	hand = owner.hand_bodyparts[side]
	if(hand)
		RegisterSignal(hand, COMSIG_ITEM_ATTACK_SELF, .proc/ui_action_click) //If the limb gets an attack-self, open the menu. Only happens when hand is empty
		RegisterSignal(owner, COMSIG_KB_MOB_DROPITEM_DOWN, .proc/dropkey) //We're nodrop, but we'll watch for the drop hotkey anyway and then stow if possible.

/obj/item/organ/cyberimp/arm/Remove(mob/living/carbon/old_owner, special = FALSE)
	Retract()
	if(hand)
		UnregisterSignal(hand, COMSIG_ITEM_ATTACK_SELF)
		UnregisterSignal(old_owner, COMSIG_KB_MOB_DROPITEM_DOWN)
	return ..()

/obj/item/organ/cyberimp/arm/emp_act(severity)
	. = ..()
	if(!owner || !CHECK_BITFIELD(organ_flags, ORGAN_SYNTHETIC) || . & EMP_PROTECT_SELF)
		return
	if(prob(15/severity * (emp_vulnerability/50)) && owner)
		to_chat(owner, span_warning("The electromagnetic pulse causes [src] to malfunction!"))
		// give the owner an idea about why his implant is glitching
		Retract()

/**
 * Called when the mob uses the "drop item" hotkey
 *
 * Items inside toolset implants have TRAIT_NODROP, but we can still use the drop item hotkey as a
 * quick way to store implant items. In this case, we check to make sure the user has the correct arm
 * selected, and that the item is actually owned by us, and then we'll hand off the rest to Retract()
**/
/obj/item/organ/cyberimp/arm/proc/dropkey(mob/living/carbon/host)
	if(!host)
		return //How did we even get here
	if(hand != host.hand_bodyparts[host.active_hand_index])
		return //wrong hand
	Retract()

/obj/item/organ/cyberimp/arm/proc/Retract()
	if(!active_item || (active_item in src))
		return

	owner.visible_message(span_notice("[owner] retracts [active_item] back into [owner.p_their()] [zone == BODY_ZONE_R_ARM ? "right" : "left"] arm."),
		span_notice("[active_item] snaps back into your [zone == BODY_ZONE_R_ARM ? "right" : "left"] arm."),
		span_hear("You hear a short mechanical noise."))

	owner.transferItemToLoc(active_item, src, TRUE)
	active_item = null
	playsound(get_turf(owner), 'sound/mecha/mechmove03.ogg', 50, TRUE)

/obj/item/organ/cyberimp/arm/proc/Extend(obj/item/item)
	if(!(item in src))
		return

	active_item = item

	active_item.resistance_flags = INDESTRUCTIBLE | LAVA_PROOF | FIRE_PROOF | UNACIDABLE | ACID_PROOF
	ADD_TRAIT(active_item, TRAIT_NODROP, HAND_REPLACEMENT_TRAIT)
	active_item.slot_flags = null
	active_item.set_custom_materials(null)

	var/side = zone == BODY_ZONE_R_ARM? RIGHT_HANDS : LEFT_HANDS
	var/hand = owner.get_empty_held_index_for_side(side)
	if(hand)
		owner.put_in_hand(active_item, hand)
	else
		var/list/hand_items = owner.get_held_items_for_side(side, all = TRUE)
		var/success = FALSE
		var/list/failure_message = list()
		for(var/i in 1 to hand_items.len) //Can't just use *in* here.
			var/I = hand_items[i]
			if(!owner.dropItemToGround(I))
				failure_message += span_warning("My [I] interferes with [src]!")
				continue
			to_chat(owner, span_notice("I drop [I] to activate [src]!"))
			success = owner.put_in_hand(active_item, owner.get_empty_held_index_for_side(side))
			break
		if(!success)
			for(var/i in failure_message)
				to_chat(owner, i)
			return
	owner.visible_message(span_notice("<b>[owner]</b> extends [active_item] from [owner.p_their()] [current_zone == BODY_ZONE_R_ARM ? "right" : "left"] arm."),
		span_notice("I extend [active_item] from your [current_zone == BODY_ZONE_R_ARM ? "right" : "left"] arm."),
		span_hear("I hear a short mechanical noise."))
	playsound(get_turf(owner), 'sound/mecha/mechmove03.ogg', 50, TRUE)

/obj/item/organ/cyberimp/arm/ui_action_click()
	if((organ_flags & ORGAN_FAILING) || (!active_item && !contents.len))
		to_chat(owner, span_warning("The implant doesn't respond. It seems to be broken..."))
		return

	if(!active_item || (active_item in src))
		active_item = null
		if(contents.len == 1)
			Extend(contents[1])
		else
			var/list/choice_list = list()
			for(var/obj/item/I in items_list)
				choice_list[I] = image(I)
			var/obj/item/choice = show_radial_menu(owner, owner, choice_list)
			if(owner && owner == usr && owner.stat != DEAD && (src in owner.internal_organs) && !active_item && (choice in contents))
				// This monster sanity check is a nice example of how bad input is.
				Extend(choice)
	else
		Retract()
