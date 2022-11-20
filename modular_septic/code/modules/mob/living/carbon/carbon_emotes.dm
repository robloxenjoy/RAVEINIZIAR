/mob/living/carbon/emote(act, m_type, message, intentional, force_silence)
	var/vocal_cord_efficiency = getorganslotefficiency(ORGAN_SLOT_VOICE)
	var/lung_efficiency = getorganslotefficiency(ORGAN_SLOT_LUNGS)
	var/obj/item/bodypart/mouth/shit = get_bodypart_nostump(BODY_ZONE_PRECISE_MOUTH)
	var/list/key_emotes = GLOB.emote_list[act]
	for(var/thing in key_emotes)
		var/datum/emote/emote = thing
		if(emote.emote_type == EMOTE_AUDIBLE)
			if(undergoing_cardiac_arrest() || (needs_lungs() && (lung_efficiency < ORGAN_FAILING_EFFICIENCY)) )
				if(act in list("scream", "screams", "agonyscream", "agonyscreams"))
					act = "loudnoise"
				else
					act = "quietnoise"
				return ..()
			else if(!shit || shit.bodypart_disabled || (vocal_cord_efficiency < ORGAN_FAILING_EFFICIENCY))
				act = "gargle"
				return ..()
	return ..()
