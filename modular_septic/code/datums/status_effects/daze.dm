//DAZED
/datum/status_effect/incapacitating/dazed
	id = "dazed"

/datum/status_effect/incapacitating/dazed/on_apply()
	. = ..()
	if(!.)
		return
	ADD_TRAIT(owner, TRAIT_INCAPACITATED, TRAIT_STATUS_EFFECT(id))

/datum/status_effect/incapacitating/dazed/on_remove()
	REMOVE_TRAIT(owner, TRAIT_INCAPACITATED, TRAIT_STATUS_EFFECT(id))
	return ..()
