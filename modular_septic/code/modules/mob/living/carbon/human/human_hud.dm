/mob/living/carbon/human/proc/update_hud_nutrition(new_value = 3)
	if(!client || !hud_used?.nutrition)
		return
	hud_used.nutrition.update_nutrition(new_value)

/mob/living/carbon/human/proc/update_hud_hydration(new_value = 3)
	if(!client || !hud_used?.hydration)
		return
	hud_used.hydration.update_hydration(new_value)

/mob/living/carbon/human/proc/update_hud_pressure(new_value = 2)
	if(!client || !hud_used?.pressure)
		return
	hud_used.pressure.update_pressure(new_value)

/mob/living/carbon/human/proc/update_hud_temperature(new_value = 3)
	if(!client || !hud_used?.temperature)
		return
	hud_used.temperature.update_temperature(new_value)

/mob/living/carbon/human/proc/update_hud_bodytemperature(new_value = 3)
	if(!client || !hud_used?.bodytemperature)
		return
	hud_used.bodytemperature.update_temperature(new_value)

/mob/living/carbon/human/proc/update_hud_breath(failed_last_breath = FALSE, lung_efficiency = 100, bruised_threshold = ORGAN_BRUISED_EFFICIENCY, failing_threshold = ORGAN_FAILING_EFFICIENCY)
	if(!client || !hud_used?.breath)
		return
	var/resulting_breath = 3
	if((lung_efficiency <= 0) || (stat >= DEAD))
		resulting_breath = 0
	else if(lung_efficiency < failing_threshold)
		resulting_breath = 1
	else if((lung_efficiency < bruised_threshold) || failed_last_breath)
		resulting_breath = 2
	hud_used.breath.update_breath(resulting_breath)
