/datum/interaction/romance
	category = INTERACTION_CATEGORY_ROMANTIC
	interaction_flags = INTERACTION_RESPECT_COOLDOWN|INTERACTION_NEEDS_PHYSICAL_CONTACT|INTERACTION_USER_CLIMAX|INTERACTION_TARGET_CLIMAX|INTERACTION_USER_LUST|INTERACTION_TARGET_LUST
	user_cooldown_duration = INTERACTION_COOLDOWN
	target_cooldown_duraction = INTERACTION_COOLDOWN
	button_icon = "heart"

/datum/interaction/romance/handholding
	name = "Handholding"
	desc = "Hold their hands. How cute!"
	message = span_love("%USER holds %TARGET's hand.")
	user_message = span_love("I hold %TARGET's hand.")
	target_message = span_love("%USER holds my hand.")
	button_icon = "hands-helping"

/datum/interaction/romance/kisscheeks
	name = "Kiss Cheeks"
	desc = "Kiss them. On the cheek."
	message = span_horny("%USER kisses %TARGET's cheek.")
	user_message = span_horny("I kiss %TARGET's cheek.")
	target_message = span_horny("%USER kisses my cheek.")
	button_icon = "kiss-beam"

/datum/interaction/romance/kisscheeks/evaluate_user(datum/component/interactable/user, datum/component/interactable/target, silent)
	. = ..()
	if(!.)
		return
	var/mob/living/carbon/human/human_user = target.parent
	if(!human_user.get_bodypart_nostump(BODY_ZONE_PRECISE_FACE))
		return FALSE

/datum/interaction/romance/kisscheeks/evaluate_target(datum/component/interactable/user, datum/component/interactable/target, silent)
	. = ..()
	if(!.)
		return
	var/mob/living/carbon/human/human_target = target.parent
	if(!human_target.get_bodypart_nostump(BODY_ZONE_PRECISE_FACE))
		return FALSE

/datum/interaction/romance/kiss
	name = "Kiss"
	desc = "Kiss them. On the mouth."
	message = span_horny("%USER kisses %TARGET's lips.")
	user_message = span_horny("I kiss %TARGET's lips.")
	target_message = span_horny("%USER kisses my lips.")
	button_icon = "kiss-wink-heart"
	arousal_gain_target = AROUSAL_GAIN_LOW
	arousal_gain_user = AROUSAL_GAIN_LOW

/datum/interaction/romance/kiss/evaluate_user(datum/component/interactable/user, datum/component/interactable/target, silent)
	. = ..()
	if(!.)
		return
	var/mob/living/carbon/human/human_user = target.parent
	if(!human_user.get_bodypart_nostump(BODY_ZONE_PRECISE_MOUTH) || human_user.is_mouth_covered())
		return FALSE

/datum/interaction/romance/kiss/evaluate_target(datum/component/interactable/user, datum/component/interactable/target, silent)
	. = ..()
	if(!.)
		return
	var/mob/living/carbon/human/human_target = target.parent
	if(!human_target.get_bodypart_nostump(BODY_ZONE_PRECISE_MOUTH) || human_target.is_mouth_covered())
		return FALSE
