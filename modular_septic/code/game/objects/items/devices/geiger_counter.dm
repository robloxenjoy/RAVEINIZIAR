/obj/item/geiger_counter
	name = "\improper Geiger counter"
	desc = "A handheld device used for detecting and measuring radiation pulses."
	icon = 'modular_septic/icons/obj/items/device.dmi'
	inhand_icon_state = "geiger"
	icon_state = "geiger_off"
	righthand_file = 'modular_septic/icons/obj/items/inhands/items_and_weapons_righthand.dmi'
	lefthand_file = 'modular_septic/icons/obj/items/inhands/items_and_weapons_lefthand.dmi'
	inhand_icon_state = "multitool"
	w_class = WEIGHT_CLASS_NORMAL
	custom_materials = list(/datum/material/iron = 500, /datum/material/glass = 500)

/obj/item/geiger_counter/attack_self(mob/user)
	scanning = !scanning

	if (scanning)
		AddComponent(/datum/component/geiger_sound)
		playsound(src, 'modular_septic/sound/effects/geiger_turn_on_0.wav', 90, FALSE)
	else
		qdel(GetComponent(/datum/component/geiger_sound))
		playsound(src, 'modular_septic/sound/effects/geiger_turn_off_0.wav', 75, FALSE)

	update_appearance(UPDATE_ICON)
	to_chat(user, span_notice("[icon2html(src, user)] You switch [scanning ? "on" : "off"] [src]."))
