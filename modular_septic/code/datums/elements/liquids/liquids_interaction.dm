/**
 * This element allows for items to interact with liquids on turfs.
 */
/datum/element/liquids_interaction
	element_flags = ELEMENT_BESPOKE | ELEMENT_DETACH
	id_arg_index = 2
	///Callback interaction called when the turf has some liquids on it
	var/datum/callback/interaction_callback

/datum/element/liquids_interaction/Attach(datum/target, on_interaction_callback)
	if(!isitem(target))
		return ELEMENT_INCOMPATIBLE
	. = ..()
	if(!interaction_callback)
		interaction_callback = CALLBACK(target, on_interaction_callback)
	RegisterSignal(target, COMSIG_ITEM_AFTERATTACK, .proc/on_afterattack) //The only signal allowing item -> turf interaction

/datum/element/liquids_interaction/Detach(mob/living/target)
	UnregisterSignal(target, COMSIG_ITEM_AFTERATTACK)

/datum/element/liquids_interaction/proc/on_afterattack(obj/item/source, atom/target, mob/user)
	SIGNAL_HANDLER

	if(!isturf(target))
		return
	var/turf/turf_target = target
	if(!turf_target.liquids)
		return
	if(interaction_callback.Invoke(source, target, user, turf_target.liquids))
		return COMPONENT_CANCEL_ATTACK_CHAIN
