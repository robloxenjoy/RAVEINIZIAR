/datum/smite/brainspill
	name = "Brainletting"

/datum/smite/brainspill/effect(client/user, mob/living/target)
	. = ..()
	if (!iscarbon(target))
		to_chat(user, span_warning("This must be used on a carbon mob."), confidential = TRUE)
		return
	var/obj/item/bodypart/head = target.get_bodypart(BODY_ZONE_HEAD)
	if(head)
		for(var/obj/item/organ/bone/bone in head.getorganslotlist(ORGAN_SLOT_BONE))
			bone.compound_fracture()
		head.receive_damage(brute = 30, sharpness = SHARP_EDGED)
		head.force_wound_upwards(/datum/wound/spill/brain, TRUE)
