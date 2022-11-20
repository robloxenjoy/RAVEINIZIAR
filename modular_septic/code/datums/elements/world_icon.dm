/datum/element/world_icon
	id_arg_index = 2
	element_flags = ELEMENT_BESPOKE | ELEMENT_DETACH
	/// Proc used to update the appearance of the object when in the world
	var/attached_proc
	/// Only used if attached_proc doesn't exist, simply changes the icon of target to this when it's in the inventory
	var/inventory_icon
	/// Only used if attached_proc doesn't exist, simply changes the icon of target to this when it's NOT in the inventory
	var/world_icon

/datum/element/world_icon/Attach(atom/target, attached_proc, inventory_icon, world_icon)
	. = ..()
	if(!isitem(target))
		return ELEMENT_INCOMPATIBLE
	src.attached_proc = attached_proc
	src.inventory_icon = inventory_icon
	src.world_icon = world_icon
	RegisterSignal(target, COMSIG_ATOM_UPDATE_ICON, .proc/update_icon)
	RegisterSignal(target, list(COMSIG_ITEM_EQUIPPED, COMSIG_STORAGE_ENTERED, COMSIG_ITEM_DROPPED, COMSIG_STORAGE_EXITED), .proc/inventory_updated)
	target.update_appearance(UPDATE_ICON)

/datum/element/world_icon/Detach(atom/source)
	. = ..()
	UnregisterSignal(source, COMSIG_ATOM_UPDATE_ICON)
	UnregisterSignal(source, list(COMSIG_ITEM_EQUIPPED, COMSIG_STORAGE_ENTERED, COMSIG_ITEM_DROPPED, COMSIG_STORAGE_EXITED))
	source.update_appearance(UPDATE_ICON)

/datum/element/world_icon/proc/update_icon(obj/item/source, updates)
	SIGNAL_HANDLER

	if((source.item_flags & IN_INVENTORY) || \
	(source.stored_in && (SEND_SIGNAL(source.stored_in, COMSIG_CONTAINS_STORAGE))) || \
	(source.loc && SEND_SIGNAL(source.loc, COMSIG_CONTAINS_STORAGE)))
		if(attached_proc)
			return
		return default_inventory_icon(source)

	if(attached_proc)
		return call(source, attached_proc)(updates)
	else
		return default_world_icon(source)

/datum/element/world_icon/proc/inventory_updated(obj/item/source)
	SIGNAL_HANDLER

	source.update_appearance(UPDATE_ICON)

/datum/element/world_icon/proc/default_inventory_icon(obj/item/source)
	SIGNAL_HANDLER

	source.icon = inventory_icon

/datum/element/world_icon/proc/default_world_icon(obj/item/source)
	SIGNAL_HANDLER

	source.icon = world_icon
