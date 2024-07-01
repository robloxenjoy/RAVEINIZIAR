/datum/keybinding/mob/toggle_move_intent
	hotkey_keys = list("Unbound")

/datum/keybinding/mob/toggle_move_intent_alternative
	full_name = "Cycle move intent"

/datum/keybinding/mob/stop_pulling
	hotkey_keys = list("N", "Delete")

/datum/keybinding/mob/swap_hands
	hotkey_keys = list("Space")

/datum/keybinding/mob/target_head_cycle
	full_name = "Target: Cycle Head"
	description = "Pressing this key cycles between head, eyes, face and jaw. This will impact where you hit people, and can be used for surgery."

/datum/keybinding/mob/target_eyes
	full_name = "Target: Cycle Eyes"
	description = "Pressing this key cycles between the left and right eye. This will impact where you hit people, and can be used for surgery."

/datum/keybinding/mob/target_mouth
	full_name = "Target: Cycle Face"
	description = "Pressing this key cycles between jaw and face. This will impact where you hit people, and can be used for surgery."

/datum/keybinding/mob/target_body_chest
	full_name = "Target: Cycle Chest"
	description = "Pressing this key cycles between chest and neck. This will impact where you hit people, and can be used for surgery."

/datum/keybinding/mob/target_body_groin
	hotkey_keys = list("Numpad2")
	full_name = "Target: Cycle Vitals"
	description = "Pressing this key cycles between vitals and groin. This will impact where you hit people, and can be used for surgery."

/datum/keybinding/mob/target_left_arm
	full_name = "Target: Cycle Left Arm"
	description = "Pressing this key cycles between left arm and left hand. This will impact where you hit people, and can be used for surgery."

/datum/keybinding/mob/target_r_arm
	full_name = "Target: Cycle Right Arm"
	description = "Pressing this key cycles between right arm and right hand. This will impact where you hit people, and can be used for surgery."

/datum/keybinding/mob/target_left_leg
	full_name = "Target: Cycle Left Leg"
	description = "Pressing this key cycles between left leg and left foot. This will impact where you hit people, and can be used for surgery."

/datum/keybinding/mob/target_right_leg
	full_name = "Target: Cycle Right Leg"
	description = "Pressing this key cycles between right leg and right foot. This will impact where you hit people, and can be used for surgery."

/datum/keybinding/mob/inspect
	hotkey_keys = list("L")
	name = "blind_inspect"
	full_name = "Blind Inspect"
	description = "Pressing this key will let you see a ghostly image of whatever is in front of you for a short while."
	keybind_signal = COMSIG_KB_CLIENT_BLIND_INSPECT_DOWN

/datum/keybinding/mob/inspect/down(client/user)
	. = ..()
	user.mob.inspect_front()

/datum/keybinding/mob/fullscreen
	hotkey_keys = list("F12")
	name = "fullscreen"
	full_name = "Fullscreen"
	description = "Toggle Fullscreen."
//	category = CATEGORY_CARBON
	keybind_signal = COMSIG_KB_CLIENT_FULLSCREEN_DOWN

/datum/keybinding/mob/fullscreen/down(client/client)
	. = ..()
	if(client.fullscren_enabled)
		client.do_fullscreen(FALSE)
	else
		client.do_fullscreen(TRUE)
