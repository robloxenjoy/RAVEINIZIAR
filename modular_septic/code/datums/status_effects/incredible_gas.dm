/datum/status_effect/incredible_gas
	id = "incredibly_gassed"
	status_type = STATUS_EFFECT_REFRESH
	processing_speed = STATUS_EFFECT_NORMAL_PROCESS
	alert_type = null
	duration = 15 SECONDS

/datum/status_effect/incredible_gas/on_apply()
	. = ..()
	owner.attributes?.add_attribute_modifier(/datum/attribute_modifier/incredible_gas, TRUE)

/datum/status_effect/incredible_gas/on_remove()
	. = ..()
	owner.attributes?.remove_attribute_modifier(/datum/attribute_modifier/incredible_gas, TRUE)

/datum/status_effect/incredible_gas/tick()
	. = ..()
	owner.blur_eyes(1)
	if(prob(25))
		owner.emote("cry")
