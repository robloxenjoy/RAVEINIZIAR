/obj/item/organ/tongue/snail
	name = "radula"
	color = "#96DB00" // TODO proper sprite, rather than recoloured pink tongue
	desc = "A minutely toothed, chitious ribbon, which as a side effect, makes all snails talk IINNCCRREEDDIIBBLLYY SSLLOOWWLLYY."
	modifies_speech = TRUE

/obj/item/organ/tongue/snail/handle_speech(datum/source, list/speech_args)
	var/new_message
	var/message = speech_args[SPEECH_MESSAGE]
	for(var/i in 1 to length(message))
		if(findtext("ABCDEFGHIJKLMNOPWRSTUVWXYZabcdefghijklmnopqrstuvwxyz", message[i])) //Im open to suggestions
			new_message += message[i] + message[i] + message[i] //aaalllsssooo ooopppeeennn tttooo sssuuuggggggeeessstttiiiooonsss
		else
			new_message += message[i]
	speech_args[SPEECH_MESSAGE] = new_message
