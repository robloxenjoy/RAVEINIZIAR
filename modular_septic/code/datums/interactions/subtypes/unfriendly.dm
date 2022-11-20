/datum/interaction/unfriendly
	category = INTERACTION_CATEGORY_UNFRIENDLY
	interaction_flags = INTERACTION_RESPECT_COOLDOWN|INTERACTION_NEEDS_PHYSICAL_CONTACT
	user_cooldown_duration = INTERACTION_COOLDOWN
	target_cooldown_duraction = INTERACTION_COOLDOWN
	button_icon = "handshake"

/datum/interaction/unfriendly/middlefinger
	name = "Flip Them Off"
	desc = "Tell them to fuck off!"
	message = span_warning("%USER flips %TARGET's off.")
	user_message = span_warning("I flip %TARGET off!")
	target_message = span_warning("%USER flips me off!")
	usage = INTERACT_OTHER
	user_hands_required = 1
	button_icon = "hand-middle-finger"
	maximum_distance = 7
