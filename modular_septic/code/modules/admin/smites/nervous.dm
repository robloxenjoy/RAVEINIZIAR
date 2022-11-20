/datum/smite/nervous
	name = "Nervous"

/datum/smite/nervous/effect(client/user, mob/living/target)
	. = ..()
	if (!iscarbon(target))
		to_chat(user, span_warning("This must be used on a carbon mob."), confidential = TRUE)
		return
	var/mob/living/carbon/carbon_target = target
	for(var/obj/item/bodypart/limb as anything in carbon_target.bodyparts)
		var/type_wound = pick(/datum/wound/nerve/dissect, /datum/wound/nerve/tear)
		limb.force_wound_upwards(type_wound, smited = TRUE)
