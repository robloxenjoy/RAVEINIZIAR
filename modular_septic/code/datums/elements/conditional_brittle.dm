/datum/element/conditional_brittle
	id_arg_index = 2
	element_flags = ELEMENT_DETACH | ELEMENT_BESPOKE
	var/brittle_condition = "fireaxe"

/datum/element/conditional_brittle/Attach(datum/target, brittle_condition = "fireaxe")
	var/atom/atom_target = target
	if(!istype(atom_target) || !atom_target.uses_integrity || isarea(target))
		return ELEMENT_INCOMPATIBLE
	. = ..()
	src.brittle_condition = brittle_condition
	RegisterSignal(target, COMSIG_CONDITIONAL_DESTRUCTIVE_BREAK, .proc/check_break)

/datum/element/conditional_brittle/Detach(datum/source)
	. = ..()
	UnregisterSignal(source, COMSIG_CONDITIONAL_DESTRUCTIVE_BREAK)

/datum/element/conditional_brittle/proc/check_break(atom/source, obj/item/destruction_source, destruction_condition, destruction_flag)
	SIGNAL_HANDLER

	if(destruction_condition != brittle_condition)
		return

	source.atom_destruction(destruction_flag)
