/datum/keybinding/client/communication/say/down(client/user)
	. = ..()
	user.mob?.set_typing_indicator(TRUE)

/datum/keybinding/client/communication/me/down(client/user)
	. = ..()
	user.mob?.set_typing_indicator(TRUE)

/datum/keybinding/client/communication/whisper
	hotkey_keys = list("Y")
	name = "Whisper"
	full_name = "IC Whisper"
	keybind_signal = COMSIG_KB_CLIENT_WHISPER_DOWN

/datum/keybinding/client/communication/whisper/down(client/user)
	. = ..()
	user.mob?.set_typing_indicator(TRUE)
