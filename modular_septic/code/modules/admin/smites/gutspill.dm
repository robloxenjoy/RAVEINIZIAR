/datum/smite/gutspill
	name = "Gut Busting"

/datum/smite/gutspill/effect(client/user, mob/living/target)
	. = ..()
	if (!iscarbon(target))
		to_chat(user, span_warning("This must be used on a carbon mob."), confidential = TRUE)
		return
	var/obj/item/bodypart/vitals = target.get_bodypart(BODY_ZONE_PRECISE_VITALS)
	if(vitals)
		vitals.receive_damage(brute = 30, sharpness = SHARP_EDGED)
		vitals.force_wound_upwards(/datum/wound/spill/gut, TRUE)
