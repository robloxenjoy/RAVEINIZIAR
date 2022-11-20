/obj/item/organ/tongue/cat
	name = "spiked tongue"
	desc = "Cat got his tongue."
	icon_state = "tongue-fluffy"
	say_mod = "mrowls"
	taste_sensitivity = 3
	modifies_speech = TRUE

/obj/item/organ/tongue/cat/handle_speech(datum/source, list/speech_args)
	var/static/regex/cat_rrr = new("r+", "g")
	var/static/regex/cat_RRR = new("R+", "g")
	var/message = speech_args[SPEECH_MESSAGE]
	if(message[1] != "*")
		message = cat_rrr.Replace(message, "rrr")
		message = cat_RRR.Replace(message, "RRR")
	speech_args[SPEECH_MESSAGE] = message
