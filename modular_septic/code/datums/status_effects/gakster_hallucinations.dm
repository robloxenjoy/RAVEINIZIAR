/datum/status_effect/gakster_dissociative_identity_disorder
	id = "DID"
	duration = -1
	tick_interval = 2
	alert_type = null

/datum/status_effect/gakster_dissociative_identity_disorder/on_apply()
	. = ..()
	ADD_TRAIT(owner, TRAIT_GAKSTER, TRAIT_STATUS_EFFECT(id))
	owner.playsound_local(owner, 'modular_septic/sound/effects/whispers.wav', 60)
	to_chat(owner, span_warning("Something is destroying my mind, and It's getting worse minute by minute..."))

/datum/status_effect/gakster_dissociative_identity_disorder/before_remove()
	owner.playsound_local(owner, 'modular_septic/sound/effects/stream.wav', 60)
	to_chat(owner, span_warning("I feel much more stable now, thank goodness."))
	return TRUE

/datum/status_effect/gakster_dissociative_identity_disorder/process()
	tick()

/datum/status_effect/gakster_dissociative_identity_disorder/tick(delta_time, times_fired)
	INVOKE_ASYNC(src, .proc/handle_gakster_talk)

/datum/status_effect/gakster_dissociative_identity_disorder/proc/handle_gakster_talk()
	var/list/objects = list()
	if(prob(0.20))
		for(var/obj/object in view(owner))
			objects += object
		if(!length(objects))
			return
		var/message
		if(prob(66) || !length(owner.last_words))
			var/list/gakster_object = GLOB.gakster_visions.Copy()
			gakster_object |= "[rand(0,9)][rand(0,9)][rand(0,9)][rand(0,9)]"
			message = pick(gakster_object)
		else
			message = owner.last_words
		message = replacetext_char(message, "SRC", "[owner.real_name]")
		message = replacetext_char(message, "CAPITALIZEME", "[uppertext(owner.real_name)]")
		var/obj/speaker = pick(objects)
		if(speaker && message)
			var/speak_sound = pick(
							'modular_septic/sound/insanity/glitchloop.wav',
							'modular_septic/sound/insanity/glitchloop2.wav',
							'modular_septic/sound/insanity/glitchloop3.wav',
							'modular_septic/sound/insanity/glitchloop4.wav',
							)
			owner.playsound_local(get_turf(owner), speak_sound, 50, 0)
			owner.Hear(message, speaker, owner.language_holder?.selected_language, message)
