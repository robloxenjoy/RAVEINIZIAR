/obj/item/radio
	carry_weight = 600 GRAMS
	var/sound/send_chatter = sound('modular_septic/sound/radio/common.ogg', FALSE, 0, CHANNEL_RADIO_CHATTER, 50)
	var/sound/receive_chatter = sound('modular_septic/sound/radio/radio_chatter.ogg', FALSE, 0, CHANNEL_RADIO_CHATTER, 50)

/obj/item/radio/Hear(message, atom/movable/speaker, message_language, raw_message, radio_freq, list/spans, list/message_mods)
	. = ..()
	if(radio_freq && receive_chatter)
		playsound(src, receive_chatter.file, receive_chatter.volume, FALSE, channel = receive_chatter.channel)

/obj/item/radio/talk_into(atom/movable/M, message, channel, list/spans, datum/language/language, list/message_mods)
	. = ..()
	if(send_chatter)
		playsound(src, send_chatter.file, send_chatter.volume, FALSE, channel = send_chatter.channel)
