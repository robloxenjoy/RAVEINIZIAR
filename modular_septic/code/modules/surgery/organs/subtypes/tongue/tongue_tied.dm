//Sign Language Tongue - yep, that's how you speak sign language.
/obj/item/organ/tongue/tied
	name = "tied tongue"
	desc = "If only one had a sword so we may finally untie this knot."
	say_mod = "signs"
	icon_state = "tongue-tied"
	modifies_speech = TRUE
	organ_flags = ORGAN_EDIBLE | ORGAN_UNREMOVABLE

/obj/item/organ/tongue/tied/Insert(mob/living/carbon/new_owner, special = FALSE, drop_if_replaced = TRUE, new_zone = null)
	. = ..()
	new_owner.verb_ask = "signs"
	new_owner.verb_exclaim = "signs"
	new_owner.verb_whisper = "subtly signs"
	new_owner.verb_sing = "rythmically signs"
	new_owner.verb_yell = "emphatically signs"
	ADD_TRAIT(new_owner, TRAIT_SIGN_LANG, ORGAN_TRAIT)
	REMOVE_TRAIT(new_owner, TRAIT_MUTE, ORGAN_TRAIT)

/obj/item/organ/tongue/tied/Remove(mob/living/carbon/new_owner, special = 0)
	. = ..()
	new_owner.verb_ask = initial(verb_ask)
	new_owner.verb_exclaim = initial(verb_exclaim)
	new_owner.verb_whisper = initial(verb_whisper)
	new_owner.verb_sing = initial(verb_sing)
	new_owner.verb_yell = initial(verb_yell)
	//People who are Ahealed get "cured" of their sign language-having ways. If I knew how to make the tied tongue persist through aheals, I'd do that.
	REMOVE_TRAIT(new_owner, TRAIT_SIGN_LANG, ORGAN_TRAIT)

//Thank you Jwapplephobia for helping me with the literal hellcode below

/obj/item/organ/tongue/tied/handle_speech(datum/source, list/speech_args)
	var/new_message
	var/message = speech_args[SPEECH_MESSAGE]
	var/exclamation_found = findtext(message, "!")
	var/question_found = findtext(message, "?")
	var/mob/living/carbon/M = owner
	new_message = message
	if(exclamation_found)
		new_message = replacetext(new_message, "!", ".")
	if(question_found)
		new_message = replacetext(new_message, "?", ".")
	speech_args[SPEECH_MESSAGE] = new_message

	if(exclamation_found && question_found)
		M.visible_message(span_notice("[M] lowers one of [M.p_their()] eyebrows, raising the other."))
	else if(exclamation_found)
		M.visible_message(span_notice("[M] raises [M.p_their()] eyebrows."))
	else if(question_found)
		M.visible_message(span_notice("[M] lowers [M.p_their()] eyebrows."))
