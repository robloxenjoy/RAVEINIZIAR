/atom/movable/compose_message(atom/movable/speaker, datum/language/message_language, raw_message, radio_freq, list/spans, list/message_mods = list(), face_name = FALSE)
	//This proc uses text() because it is faster than appending strings. Thanks BYOND.
	//Basic span
	var/spanpart1 = "<span class='[radio_freq ? get_radio_span(radio_freq) : "game say"]'>"
	//Start name span.
	var/spanpart2 = "<span class='name'>"
	//Radio freq/name display
	var/freqpart = radio_freq ? "\[[get_radio_name(radio_freq)]\] " : ""
	//Job name display
	var/jobpart = compose_job(speaker, message_language, raw_message, radio_freq)
	//Speaker name
	var/namepart = "[speaker.GetVoice()][speaker.get_alt_name()]"
	if(face_name && ishuman(speaker))
		var/mob/living/carbon/human/H = speaker
		namepart = "[H.get_face_name()]" //So "fake" speaking like in hallucinations does not give the speaker away if disguised
	if(ismob(speaker))
		var/mob/mob_speaker = speaker
		namepart = "<span style='color: [mob_speaker.chat_color];'><b>[namepart]</b></span>"
	//End name span.
	var/endspanpart = "</span>"

	//Message
	var/messagepart = " <span class='message'>[lang_treat(speaker, message_language, raw_message, spans, message_mods)]</span></span>"

	var/languageicon = ""
	var/datum/language/D = GLOB.language_datum_instances[message_language]
	if(istype(D) && D.display_icon(src))
		languageicon = "[D.get_icon()] "

	return "[spanpart1][spanpart2][freqpart][languageicon][compose_track_href(speaker, namepart)][namepart][jobpart][endspanpart][messagepart]"

/atom/movable/compose_job(atom/movable/speaker, message_langs, raw_message, radio_freq)
	. = ""
	if(!radio_freq)
		return
	var/anonymize = FALSE
	var/radio_icon
	var/real_speaker = speaker
	if(istype(real_speaker, /atom/movable/virtualspeaker))
		var/atom/movable/virtualspeaker/virtual_speaker = real_speaker
		real_speaker = virtual_speaker.GetSource()
		if(ismob(src) && virtual_speaker.radio)
			var/mob/mob_source = src
			if(mob_source.client)
				radio_icon = icon2html(virtual_speaker.radio, mob_source.client)
		anonymize = virtual_speaker.radio?.anonymize
	if(anonymize)
		return " <b>\[Unknown\]</b>"
	if(ishuman(real_speaker))
		var/mob/living/carbon/human/human_speaker = real_speaker
		var/speaker_age_gender = human_speaker.get_aged_gender()
		var/speaker_job = human_speaker.get_assignment("", "", FALSE)
		if(speaker_age_gender)
			return " [radio_icon ? "<b>\[[radio_icon]\]</b>" : null]<b>\[[speaker_job ? "[speaker_job] " : ""][speaker_age_gender]\]</b>"
	if(istype(real_speaker, /obj/machinery/announcement_system))
		return " [radio_icon ? "<b>\[[radio_icon]\]</b>" : null]<b>\[AAS\]</b>"
	return " [radio_icon ? "<b>\[[radio_icon]\]</b>" : null]<b>\[Unknown\]</b>"
