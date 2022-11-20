/obj/machinery/airalarm
	icon = 'modular_septic/icons/obj/machinery/air_alarm.dmi'
	icon_state = "alarm"
	base_icon_state = "alarm"
	/// Our internal radio
	var/obj/item/radio/radio = /obj/item/radio
	/// The key our internal radio uses
	var/radio_key = /obj/item/encryptionkey/headset_eng

/obj/machinery/airalarm/Initialize(mapload)
	. = ..()
	if(ispath(radio))
		radio = new(src)
		radio.keyslot = new radio_key
		radio.listening = 0
		radio.recalculateChannels()
	AddElement(/datum/element/wall_mount)
	update_appearance()

/obj/machinery/airalarm/Destroy()
	QDEL_NULL(radio)
	return ..()
