SUBSYSTEM_DEF(potential)
	name = "Potential"
	wait = 30 MINUTES
	flags = SS_BACKGROUND
	runlevels = RUNLEVEL_GAME

/datum/controller/subsystem/potential/Initialize(start_timeofday)
	if(!untaped)
		return
	if(untaped.mob.stat != DEAD)
		if(ishuman(untaped))
			var/mob/living/carbon/human/untaped_human = untaped
			if(untaped_human.attributes)
				untaped_human.attributes.add_sheet(/datum/attribute_holder/sheet/potential)
				to_chat(untaped_human, span_achievementrare("I feel like my potential is being unlocked!"))

