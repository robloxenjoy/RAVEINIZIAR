/datum/status_effect/high_blood_pressure
	alert_type = null

/datum/status_effect/high_blood_pressure/on_apply()
	if(iscarbon(owner))
		var/mob/living/carbon/carbon = owner
		carbon.add_chem_effect(CE_PULSE, 2, "high_blood_pressure")

/datum/status_effect/high_blood_pressure/on_remove()
	if(iscarbon(owner))
		var/mob/living/carbon/carbon = owner
		carbon.remove_chem_effect(CE_PULSE, "high_blood_pressure")
