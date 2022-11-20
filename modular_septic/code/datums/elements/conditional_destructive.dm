/datum/element/conditional_destructive
	id_arg_index = 2
	element_flags = ELEMENT_DETACH | ELEMENT_BESPOKE
	var/destruction_condition = "fireaxe"
	var/destruction_flag = MELEE
	var/wield_needed = TRUE
	var/proximity_needed = TRUE

/datum/element/conditional_destructive/Attach(datum/target, destruction_condition = "fireaxe", destruction_flag = MELEE, wield_needed = TRUE, proximity_needed = TRUE)
	if(!isitem(target))
		return ELEMENT_INCOMPATIBLE
	. = ..()
	src.destruction_condition = destruction_condition
	src.destruction_flag = destruction_flag
	src.wield_needed = wield_needed
	src.proximity_needed = proximity_needed
	RegisterSignal(target, COMSIG_ITEM_AFTERATTACK, .proc/item_afterattack)

/datum/element/conditional_destructive/Detach(datum/source)
	. = ..()
	UnregisterSignal(source, COMSIG_ITEM_AFTERATTACK)

/datum/element/conditional_destructive/proc/item_afterattack(obj/item/source, atom/target, mob/user, proximity_flag, click_parameters)
	SIGNAL_HANDLER

	if(wield_needed && !SEND_SIGNAL(source, COMSIG_TWOHANDED_WIELD_CHECK))
		return
	if(!proximity_needed || proximity_flag)
		SEND_SIGNAL(target, COMSIG_CONDITIONAL_DESTRUCTIVE_BREAK, source, destruction_condition, destruction_flag)
