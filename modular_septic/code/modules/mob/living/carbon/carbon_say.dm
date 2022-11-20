// asystole or no lung niggas cant emote proper
/mob/living/carbon/say(message, bubble_type, list/spans = list(), sanitize = TRUE, datum/language/language = null, ignore_spam = FALSE, forced = null, filterproof = null)
	var/lung_efficiency = getorganslotefficiency(ORGAN_SLOT_LUNGS)
	if(undergoing_cardiac_arrest() || losebreath || (needs_lungs() && (lung_efficiency < ORGAN_FAILING_EFFICIENCY)))
		return emote("loudnoise")
	var/vocal_cord_efficiency = getorganslotefficiency(ORGAN_SLOT_VOICE)
	// this is bad and should be turned into speech modifiers
	var/obj/item/bodypart/mouth/jaw = get_bodypart_nostump(BODY_ZONE_PRECISE_MOUTH)
	if(!jaw || jaw.bodypart_disabled || (vocal_cord_efficiency < ORGAN_FAILING_EFFICIENCY))
		message = handle_vocal_cord_torn(message)
	return ..()

/proc/handle_vocal_cord_torn(message)
	message = uppertext(message)
	if(prob(20))
		message = pick("GHHHHHH...", "GLLLL...", "ZZRRRRR...")
	else
		var/new_message = ""
		var/m_len = length(message)
		var/tracker = 1
		while(tracker < m_len)
			var/nletter = copytext(message, tracker, tracker + 1)
			if(!(nletter in list("A", "E", "I", "O", "U", " ")) && (tracker % 2))
				nletter = pick("GH", "SHK", "KSS", "SS", "GNHH")
			else if((nletter == " ") && prob(50))
				nletter = "... "
			new_message += nletter
			tracker++
		for(var/uhoh in list("E", "I", "O"))
			new_message = replacetext(new_message, uhoh, pick("H", "G", "GHHH", "GRRR", "GLLL", "ZZZGH", "GLRG", "... ", "RRR"))
		new_message = replacetext(new_message, "U", pick("UHHH", "UH... "))
		message = new_message
	return message
