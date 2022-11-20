/proc/setup_surgery_steps()
	. = list()
	for(var/datum/surgery_step/surgery_step as anything in init_subtypes(/datum/surgery_step))
		if(!surgery_step.name)
			qdel(surgery_step)
			continue
		. |= surgery_step

/proc/setup_middleclick_surgery_steps()
	. = list()
	for(var/datum/surgery_step/surgery_step as anything in GLOB.surgery_steps)
		if(!surgery_step.middle_click_step)
			continue
		. |= surgery_step
