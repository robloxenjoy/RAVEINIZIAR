/datum/interaction/friendly
	category = INTERACTION_CATEGORY_FRIENDLY
	interaction_flags = INTERACTION_RESPECT_COOLDOWN|INTERACTION_NEEDS_PHYSICAL_CONTACT
	user_cooldown_duration = INTERACTION_COOLDOWN
	target_cooldown_duraction = INTERACTION_COOLDOWN
	button_icon = "handshake"

/datum/interaction/friendly/handshake
	name = "Handshake"
	desc = "Shake their hands."
	message = span_notice("%USER shakes %TARGET's hand.")
	user_message = span_notice("I shake %TARGET's hand.")
	target_message = span_notice("%USER shakes my hand.")
	usage = INTERACT_OTHER
	user_hands_required = 1
	target_hands_required = 1
	sounds = 'sound/weapons/thudswoosh.ogg'
	sound_vary = 1
	sound_extrarange = -1
	button_icon = "handshake"

/datum/interaction/friendly/hug
	name = "Hug"
	desc = "Give them a hug! How nice."
	message = span_notice("%USER hugs %TARGET.")
	user_message = span_notice("I hug %TARGET.")
	target_message = span_notice("%USER hugs me.")
	usage = INTERACT_OTHER
	user_hands_required = 1
	sounds = 'sound/weapons/thudswoosh.ogg'
	sound_vary = 1
	sound_extrarange = -1
	button_icon = "grin-beam"

/datum/interaction/friendly/hug/do_interaction(datum/component/interactable/user, datum/component/interactable/target)
	var/mob/living/carbon/human/human_target = target.parent
	human_target.hug_act(user.parent)

/datum/interaction/friendly/headpat
	name = "Headpat"
	desc = "Pat their head! How nice."
	message = span_notice("%USER pats %TARGET's head.")
	user_message = span_notice("I pat %TARGET's head.")
	target_message = span_notice("%USER pats my head.")
	usage = INTERACT_OTHER
	user_hands_required = 1
	sounds = 'sound/weapons/thudswoosh.ogg'
	sound_vary = 1
	sound_extrarange = -1
	button_icon = "hand-paper"

/datum/interaction/friendly/headpat/do_interaction(datum/component/interactable/user, datum/component/interactable/target)
	var/mob/living/carbon/human/human_target = target.parent
	human_target.headpat_act(user.parent)
