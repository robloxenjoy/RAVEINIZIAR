/datum/smite/tendinitis
	name = "Tendinitis"

/datum/smite/tendinitis/effect(client/user, mob/living/target)
	. = ..()
	if (!iscarbon(target))
		to_chat(user, span_warning("This must be used on a carbon mob."), confidential = TRUE)
		return
	var/mob/living/carbon/carbon_target = target
	for(var/obj/item/bodypart/limb as anything in carbon_target.bodyparts)
		var/type_wound = pick(/datum/wound/tendon/dissect, /datum/wound/tendon/tear)
		limb.force_wound_upwards(type_wound, smited = TRUE)
