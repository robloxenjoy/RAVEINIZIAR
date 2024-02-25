/datum/component/two_handed
	/// The multiplier applied to min_force when wielded, does not work with min_force_wielded nor min_force_unwielded
	var/min_force_multiplier = null
	/// The min_force of the item when wielded
	var/min_force_wielded = null
	/// The min_force of the item when unwielded
	var/min_force_unwielded = null
	/// Increases minimum bound for the force increase we get per point of strength
	var/min_force_strength = 0
	/// Increases maximum bound for the force increase we get per point of strength
	var/force_strength = 0
	var/wieldnoise = 'modular_septic/sound/effects/hand_grip.ogg'
	var/unwieldnoise = 'modular_septic/sound/effects/hand_release.ogg'
	var/wieldvolume = 30
	var/unwieldvolume = 25

/datum/component/two_handed/Initialize(require_twohands = FALSE, wieldsound = FALSE, unwieldsound = FALSE, attacksound = FALSE, \
									force_multiplier = 0, force_wielded = 0, force_unwielded = 0, icon_wielded = FALSE, \
									min_force_multiplier = 0, min_force_wielded = 0, min_force_unwielded = 0, \
									min_force_strength = 0, force_strength = 0)
	if(!isitem(parent))
		return COMPONENT_INCOMPATIBLE

	src.require_twohands = require_twohands
	src.wieldsound = wieldsound
	src.unwieldsound = unwieldsound
	src.attacksound = attacksound
	src.force_multiplier = force_multiplier
	src.force_wielded = force_wielded
	src.force_unwielded = force_unwielded
	src.icon_wielded = icon_wielded
	src.min_force_multiplier = min_force_multiplier
	src.min_force_wielded = min_force_wielded
	src.min_force_unwielded = min_force_unwielded

/datum/component/two_handed/RegisterWithParent()
	. = ..()
	RegisterSignal(parent, COMSIG_TWOHANDED_WIELD_CHECK, .proc/wield_check)
	ADD_TRAIT(parent, TRAIT_NEEDS_TWO_HANDS, "[REF(src)]")

/datum/component/two_handed/UnregisterFromParent()
	. = ..()
	UnregisterSignal(parent, COMSIG_TWOHANDED_WIELD_CHECK)
	REMOVE_TRAIT(parent, TRAIT_NEEDS_TWO_HANDS, "[REF(src)]")

/datum/component/two_handed/wield(mob/living/carbon/user)
	if(wielded)
		return
	if(ismonkey(user))
		if(require_twohands)
			to_chat(user, span_notice("Слишком громоздко чтобы держать в одной руке!"))
			user.dropItemToGround(parent, force=TRUE)
		else
			to_chat(user, span_notice("Хммм..."))
		return
	if(user.get_inactive_held_item())
		if(require_twohands)
			to_chat(user, span_notice("Слишком громоздко чтобы держать в одной руке!"))
			user.dropItemToGround(parent, force=TRUE)
		else
			to_chat(user, span_warning("Нужно чтобы другая рука была пустой!"))
		return
	if(user.usable_hands < 2)
		if(require_twohands)
			user.dropItemToGround(parent, force=TRUE)
		to_chat(user, span_warning("У меня недостаточно рабочих рук."))
		return

	// wield update status
	if(SEND_SIGNAL(parent, COMSIG_TWOHANDED_WIELD, user) & COMPONENT_TWOHANDED_BLOCK_WIELD)
		// blocked wielding somehow
		return

	wielded = TRUE
	ADD_TRAIT(parent, TRAIT_WIELDED, "[REF(src)]")
	RegisterSignal(user, COMSIG_MOB_SWAP_HANDS, .proc/on_swap_hands)

	// update item stats and name
	var/obj/item/parent_item = parent
	if(force_multiplier)
		parent_item.force *= force_multiplier
	else if(force_wielded)
		parent_item.force = force_wielded
	if(min_force_multiplier)
		parent_item.force *= min_force_multiplier
	else if(force_wielded)
		parent_item.force = min_force_wielded
	if(sharpened_increase)
		parent_item.force += sharpened_increase
	parent_item.min_force_strength += min_force_strength
	parent_item.force_strength += force_strength

//	parent_item.name = "wielded [parent_item.name]"
	parent_item.update_appearance()

	if(iscyborg(user))
		to_chat(user, span_notice("I dedicate your module to [parent]."))
	else
		to_chat(user, span_notice("Я хватаю [parent] обеими руками."))
		playsound(user, wieldnoise, wieldvolume, FALSE)
		user.changeNext_move(CLICK_CD_MELEE)

	// Play sound if one is set
//	if(wieldsound)
//		playsound(user, wieldnoise, 65, FALSE)

	// Let's reserve the other hand
	offhand_item = new(user)
//	offhand_item.name = "[parent_item.name] - offhand"
	offhand_item.desc = "Второй хват на [parent_item]."
	offhand_item.wielded = TRUE
	offhand_item.layer = parent_item.layer - 0.05
	RegisterSignal(offhand_item, COMSIG_ITEM_DROPPED, .proc/on_drop)
	RegisterSignal(offhand_item, COMSIG_PARENT_QDELETING, .proc/on_destroy)
	user.put_in_inactive_hand(offhand_item)
	user.wield_ui_on()
	return TRUE

/datum/component/two_handed/unwield(mob/living/carbon/user, show_message, can_drop)
	if(!wielded)
		return

	// wield update status
	wielded = FALSE
	UnregisterSignal(user, COMSIG_MOB_SWAP_HANDS)
	SEND_SIGNAL(parent, COMSIG_TWOHANDED_UNWIELD, user)
	REMOVE_TRAIT(parent, TRAIT_WIELDED, "[REF(src)]")

	// update item stats
	var/obj/item/parent_item = parent
	if(sharpened_increase)
		parent_item.force -= sharpened_increase
	if(force_multiplier)
		parent_item.force /= force_multiplier
	else if(force_unwielded)
		parent_item.force = force_unwielded
	if(min_force_multiplier)
		parent_item.force /= min_force_multiplier
	else if(min_force_unwielded)
		parent_item.force = min_force_unwielded
	parent_item.min_force_strength -= min_force_strength
	parent_item.force_strength -= force_strength

	// update the items name to remove the wielded status
	var/sf = findtext(parent_item.name, "wielded ", 1, 9)
	if(sf)
		parent_item.name = copytext(parent_item.name, 9) // 9 == length("wielded ") + 1
	else
		parent_item.name = "[initial(parent_item.name)]"

	// Update icons
	parent_item.update_appearance()

	if(istype(user)) // tk showed that we might not have a mob here
		if(user.get_item_by_slot(ITEM_SLOT_BACK) == parent)
			user.update_inv_back()
		else
			user.update_inv_hands()
			playsound(user, unwieldnoise, unwieldvolume, FALSE)

		// if the item requires two handed drop the item on unwield
		if(require_twohands && can_drop)
			user.dropItemToGround(parent, force=TRUE)

		// Show message if requested
		if(show_message)
			if(iscyborg(user))
				to_chat(user, span_notice("I free up my module."))
			else if(require_twohands)
				to_chat(user, span_notice("I drop [parent]."))
			else
				to_chat(user, span_notice("Теперь я держу [parent] одной рукой."))

	// Play sound if set
//	if(unwieldsound)
//		playsound(user, unwieldnoise, 50, FALSE)

	// Remove the object in the offhand
	if(offhand_item)
		UnregisterSignal(offhand_item, list(COMSIG_ITEM_DROPPED, COMSIG_PARENT_QDELETING))
		qdel(offhand_item)
	// Clear any old refrence to an item that should be gone now
	offhand_item = null
	user.wield_ui_off()
	return TRUE

/datum/component/two_handed/proc/wield_check()
	SIGNAL_HANDLER

	return wielded

/obj/item/offhand
	icon = 'modular_septic/icons/hud/quake/grab.dmi'
	icon_state = "blank"
	base_icon_state = "blank"
	carry_weight = 0
	layer = LOW_ITEM_LAYER
	wield_info = null

//Outline looks weird on offhand
/obj/item/offhand/apply_outline(outline_color)
	return
