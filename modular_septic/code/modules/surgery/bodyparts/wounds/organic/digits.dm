/*
	Kid named finger
*/
/datum/wound/digits
	sound_effect = list('modular_septic/sound/gore/trauma1.ogg', \
					'modular_septic/sound/gore/trauma2.ogg', \
					'modular_septic/sound/gore/trauma3.ogg')

	severity = WOUND_SEVERITY_MODERATE
	viable_zones = ALL_BODYPARTS

	threshold_minimum = 40
	wound_type = WOUND_DIGITS
	wound_flags = (WOUND_SOUND_HINTS)

/datum/wound/digits/can_afflict(obj/item/bodypart/new_limb, datum/wound/old_wound)
	. = ..()
	if(!.)
		return
	if(!new_limb.get_digits_amount())
		return FALSE

/datum/wound/digits/apply_wound(obj/item/bodypart/new_limb, silent = FALSE, datum/wound/old_wound = null, smited = FALSE, add_descriptive = TRUE)
	. = ..()
	if(!.)
		return
	var/finger_amount = rand(1,2)
	var/finger_type = "finger"
	var/static/list/toe_zones = list(BODY_ZONE_PRECISE_R_FOOT, BODY_ZONE_PRECISE_L_FOOT)
	if(new_limb.body_zone in toe_zones)
		finger_type = "toe"
	if(finger_amount == 1)
		finger_type = "a [finger_type]"
	finger_type = capitalize(finger_type)
	var/final_descriptive = "[finger_type][finger_amount > 1 ? "s" : ""] sail[finger_amount > 1 ? "" : "s"] off in an arc!"
	if(victim)
		if(sound_effect)
			playsound(new_limb.owner, pick(sound_effect), 70 + 20 * severity, TRUE)
		if(add_descriptive)
			SEND_SIGNAL(victim, COMSIG_CARBON_ADD_TO_WOUND_MESSAGE, span_danger(" [final_descriptive]"))
	new_limb.knock_out_digits(finger_amount)
	qdel(src)
