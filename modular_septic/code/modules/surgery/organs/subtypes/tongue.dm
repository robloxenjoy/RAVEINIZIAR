/obj/item/organ/tongue
	name = "tongue"
	desc = "Cat got your tongue?"
	icon_state = "tongue"
	base_icon_state = "tongue"
	zone = BODY_ZONE_PRECISE_MOUTH
	organ_efficiency = list(ORGAN_SLOT_TONGUE = 100)
	w_class = WEIGHT_CLASS_TINY

	organ_volume = 0.5
	max_blood_storage = 5
	current_blood = 5
	blood_req = 1
	oxygen_req = 0.5
	nutriment_req = 0.5
	hydration_req = 2

	attack_verb_continuous = list("licks", "slobbers", "slaps", "frenches", "tongues")
	attack_verb_simple = list("lick", "slobber", "slap", "french", "tongue")
	var/list/languages_possible
	var/say_mod = null

	/// Whether the owner of this tongue can taste anything. Being set to FALSE will mean no taste feedback will be provided.
	var/sense_of_taste = TRUE

	var/taste_sensitivity = 15 // lower is more sensitive.
	var/modifies_speech = FALSE
	var/static/list/languages_possible_base = typecacheof(list(
		/datum/language/common,
		/datum/language/uncommon,
		/datum/language/russian,
		/datum/language/yoinky,
		/datum/language/draconic,
		/datum/language/codespeak,
		/datum/language/monkey,
		/datum/language/narsie,
		/datum/language/beachbum,
		/datum/language/aphasia,
		/datum/language/piratespeak,
		/datum/language/moffic,
		/datum/language/sylvan,
		/datum/language/shadowtongue,
		/datum/language/terrum,
		/datum/language/nekomimetic,
	))

/obj/item/organ/tongue/Initialize(mapload)
	. = ..()
	languages_possible = languages_possible_base

/obj/item/organ/tongue/proc/handle_speech(datum/source, list/speech_args)
	return

/obj/item/organ/tongue/Insert(mob/living/carbon/new_owner, special = FALSE, drop_if_replaced = TRUE, new_zone = null)
	. = ..()
	if(say_mod && new_owner.dna?.species)
		new_owner.dna.species.say_mod = say_mod
	if(modifies_speech)
		RegisterSignal(new_owner, COMSIG_MOB_SAY, .proc/handle_speech)
	new_owner.UnregisterSignal(new_owner, COMSIG_MOB_SAY)

	/* This could be slightly simpler, by making the removal of the
	* NO_TONGUE_TRAIT conditional on the tongue's `sense_of_taste`, but
	* then you can distinguish between ageusia from no tongue, and
	* ageusia from having a non-tasting tongue.
	*/
	REMOVE_TRAIT(new_owner, TRAIT_AGEUSIA, NO_TONGUE_TRAIT)
	if(!sense_of_taste)
		ADD_TRAIT(new_owner, TRAIT_AGEUSIA, ORGAN_TRAIT)

/obj/item/organ/tongue/Remove(mob/living/carbon/old_owner, special = FALSE)
	. = ..()
	if(say_mod && old_owner.dna?.species)
		old_owner.dna.species.say_mod = initial(old_owner.dna.species.say_mod)
	UnregisterSignal(old_owner, COMSIG_MOB_SAY, .proc/handle_speech)
	old_owner.RegisterSignal(old_owner, COMSIG_MOB_SAY, /mob/living/carbon/.proc/handle_tongueless_speech)
	REMOVE_TRAIT(old_owner, TRAIT_AGEUSIA, ORGAN_TRAIT)
	// Carbons by default start with NO_TONGUE_TRAIT caused TRAIT_AGEUSIA
	ADD_TRAIT(old_owner, TRAIT_AGEUSIA, NO_TONGUE_TRAIT)

/obj/item/organ/tongue/could_speak_language(language)
	return is_type_in_typecache(language, languages_possible)
