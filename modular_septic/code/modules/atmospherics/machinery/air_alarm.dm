/obj/machinery/airalarm
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

/obj/machinery/airalarm/Destroy()
	QDEL_NULL(radio)
	return ..()
