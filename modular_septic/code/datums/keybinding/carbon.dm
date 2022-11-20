/datum/keybinding/carbon/select_help_intent
	hotkey_keys = list("1")
	name = "select_help_intent"
	full_name = "Select help intent"
	description = ""
	category = CATEGORY_CARBON
	keybind_signal = COMSIG_KB_CARBON_SELECTHELPINTENT_DOWN

/datum/keybinding/carbon/select_help_intent/down(client/user)
	. = ..()
	if(.)
		return
	var/mob/living/living_user = user.mob
	if(istype(living_user))
		living_user.a_intent_change(INTENT_HELP)
	return TRUE

/datum/keybinding/carbon/select_disarm_intent
	hotkey_keys = list("2")
	name = "select_disarm_intent"
	full_name = "Select disarm intent"
	description = ""
	category = CATEGORY_CARBON
	keybind_signal = COMSIG_KB_CARBON_SELECTDISARMINTENT_DOWN

/datum/keybinding/carbon/select_disarm_intent/down(client/user)
	. = ..()
	if(.)
		return
	var/mob/living/living_user = user.mob
	if(istype(living_user))
		living_user.a_intent_change(INTENT_DISARM)
	return TRUE

/datum/keybinding/carbon/select_grab_intent
	hotkey_keys = list("3")
	name = "select_grab_intent"
	full_name = "Select grab intent"
	description = ""
	category = CATEGORY_CARBON
	keybind_signal = COMSIG_KB_CARBON_SELECTGRABINTENT_DOWN

/datum/keybinding/carbon/select_grab_intent/down(client/user)
	. = ..()
	if(.)
		return
	var/mob/living/living_user = user.mob
	if(istype(living_user))
		living_user.a_intent_change(INTENT_GRAB)
	return TRUE

/datum/keybinding/carbon/select_harm_intent
	hotkey_keys = list("4")
	name = "select_harm_intent"
	full_name = "Select harm intent"
	description = ""
	category = CATEGORY_CARBON
	keybind_signal = COMSIG_KB_CARBON_SELECTHARMINTENT_DOWN

/datum/keybinding/carbon/select_harm_intent/down(client/user)
	. = ..()
	if(.)
		return
	var/mob/living/living_user = user.mob
	if(istype(living_user))
		living_user.a_intent_change(INTENT_HARM)
	return TRUE

/datum/keybinding/carbon/cycle_intent_right
	hotkey_keys = list("Northwest") // HOME
	name = "cycle_intent_right"
	full_name = "Cycle Intent Right"
	description = ""
	keybind_signal = COMSIG_KB_MOB_CYCLEINTENTRIGHT_DOWN

/datum/keybinding/carbon/cycle_intent_right/down(client/user)
	. = ..()
	if(.)
		return
	var/mob/living/living_user = user.mob
	if(istype(living_user))
		living_user.a_intent_change(INTENT_HOTKEY_RIGHT)
	return TRUE

/datum/keybinding/carbon/cycle_intent_left
	hotkey_keys = list("Insert")
	name = "cycle_intent_left"
	full_name = "Cycle Intent Left"
	description = ""
	keybind_signal = COMSIG_KB_MOB_CYCLEINTENTLEFT_DOWN

/datum/keybinding/carbon/cycle_intent_left/down(client/user)
	. = ..()
	if(.)
		return
	var/mob/living/living_user = user.mob
	if(istype(living_user))
		living_user.a_intent_change(INTENT_HOTKEY_LEFT)
	return TRUE

/datum/keybinding/carbon/fixeye
	hotkey_keys = list("F")
	name = "fixeye"
	full_name = "Fix Eye"
	description = "Fix the direction you're staring at."
	category = CATEGORY_MOVEMENT
	keybind_signal = COMSIG_KB_FIXEYE_DOWN

/datum/keybinding/carbon/fixeye/down(client/user)
	. = ..()
	var/mob/living/living_user = user.mob
	if(istype(living_user))
		SEND_SIGNAL(living_user, COMSIG_FIXEYE_TOGGLE)
	return TRUE

/datum/keybinding/carbon/toggle_throw_mode
	hotkey_keys = list("R")

/datum/keybinding/carbon/hold_throw_mode
	hotkey_keys = list("Unbound")

/datum/keybinding/carbon/sprint
	hotkey_keys = list("Unbound")
	name = "sprint"
	full_name = "Sprint"
	description = "Toggle sprinting."
	category = CATEGORY_MOVEMENT
	keybind_signal = COMSIG_KB_CARBON_SPRINT_DOWN

/datum/keybinding/carbon/sprint/down(client/user)
	. = ..()
	var/mob/living/living_user = user.mob
	if(istype(living_user))
		living_user.toggle_sprint()
	return TRUE

/datum/keybinding/carbon/wield
	hotkey_keys = list("X")
	name = "wield"
	full_name = "Wield"
	description = "Wield/unwield active held item."
	category = CATEGORY_CARBON
	keybind_signal = COMSIG_KB_CARBON_SPRINT_DOWN

/datum/keybinding/carbon/wield/down(client/user)
	. = ..()
	var/mob/living/living_user = user.mob
	if(istype(living_user))
		living_user.wield_active_hand()
	return TRUE
