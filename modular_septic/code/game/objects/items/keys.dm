/obj/item/key/examine(mob/user)
	. = ..()
	if(id_tag)
		. += span_notice("[p_theyre(TRUE)] tagged with \"[id_tag]\".")

/obj/item/key/proc/door_allowed(obj/machinery/door/door)
	if(id_tag == door.id_tag)
		return TRUE
	return FALSE

/obj/item/key/dorm
	name = "dorm key"
	desc = "A key to one of the dorm rooms."
	icon = 'modular_septic/icons/obj/items/keys.dmi'
	icon_state = "key_dorm"
	base_icon_state = "key_dorm"
	pickup_sound = 'modular_septic/sound/effects/keys_pickup.wav'
	drop_sound = 'modular_septic/sound/effects/keys_drop.wav'
