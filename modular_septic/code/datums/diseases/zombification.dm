/datum/disease/zombification
	name = "Zombification"
	desc = "Reanimation after death caused by mystical sources. \
			Only happens to those who have faith in God."
	form = "No more room in hell"
	agent = "Lost soul"
	spread_text = "Unburied and uncremated Corpses"
	cure_text = "A Second Death"
	hopelessness = "No Salvation"
	max_stages = 2
	severity = DISEASE_SEVERITY_BIOHAZARD
	disease_flags = CAN_CARRY
	spread_flags = DISEASE_SPREAD_SPECIAL
	visibility_flags = HIDDEN_SCANNER|HIDDEN_PANDEMIC
	viable_mobtypes = list(/mob/living/carbon/human)
	process_dead = TRUE
	bypasses_immunity = TRUE

	/// Progress to zombification in seconds
	var/progress = 0

	/// This should only be true if we are becoming a zombie by death, and are on stage 1
	var/cure_on_revival = FALSE

	// Vars used to store old info about the infected
	/// Old species name before it got changed to lost soul
	var/old_species_name = ""
	/// Our old attack verbs
	var/old_attack_verb = ""
	/// Our old continuous attack verbs
	var/old_attack_verb_continuous = ""
	/// Our old say mod
	var/old_say_mod = ""
	/// Our old bodytemp
	var/old_bodytemp_normal = 0
	/// Our old speedmod
	var/old_speedmod = 0
	/// Our old death sound
	var/old_deathsound
	/// Did we have the undead mob biotype?
	var/was_undead = FALSE
	/// Zombies can only speak in retardspeak, this keeps track of our retardspeak before infection
	var/list/was_retarded

/datum/disease/zombification/Destroy()
	if(stage >= 2)
		dezombify()
	return ..()

/datum/disease/zombification/infect(mob/living/infectee, make_copy)
	if(iscarbon(infectee))
		var/mob/living/carbon/carbon_infectee = infectee
		CHECK_DNA_AND_SPECIES(carbon_infectee)
	return ..()

/datum/disease/zombification/stage_act(delta_time, times_fired)
	. = ..()
	//we got revived, yippie
	if(cure_on_revival && affected_mob.stat < DEAD)
		qdel(src)
	// Brain destroyed
	if(!affected_mob.getorgan(/obj/item/organ/brain))
		qdel(src)
	if(stage < 2)
		progress += (delta_time SECONDS)
		// the body needs two minutes unattended
		if(progress >= 2 MINUTES)
			var/old_cure_on_revival = cure_on_revival
			//we may need to call revive if our man is dead
			cure_on_revival = FALSE
			zombify()
			cure_on_revival = old_cure_on_revival
	else
		affected_mob.adjustStaminaLoss(-5)
		affected_mob.adjustFatigueLoss(-2.5)
		if((affected_mob.stat < DEAD) && DT_PROB(2, delta_time))
			playsound(affected_mob, "modular_septic/sound/zombie/idle[rand(1, 14)].wav")

/datum/disease/zombification/proc/zombify()
	if(QDELETED(affected_mob))
		return
	CHECK_DNA_AND_SPECIES(affected_mob)
	visibility_flags = NONE
	REMOVE_TRAIT(affected_mob, TRAIT_ADVANCEDTOOLUSER, SPECIES_TRAIT)
	ADD_TRAIT(affected_mob, TRAIT_HUSK, "zombie_infection")
	ADD_TRAIT(affected_mob, TRAIT_NOPAIN, "zombie_infection")
	ADD_TRAIT(affected_mob, TRAIT_STABLEHEART, "zombie_infection")
	ADD_TRAIT(affected_mob, TRAIT_FAKEDEATH, "zombie_infection")
	ADD_TRAIT(affected_mob, TRAIT_NOHUNGER, "zombie_infection")
	ADD_TRAIT(affected_mob, TRAIT_NOTHIRST, "zombie_infection")
	ADD_TRAIT(affected_mob, TRAIT_NOBREATH, "zombie_infection")
	ADD_TRAIT(affected_mob, TRAIT_NOMETABOLISM, "zombie_infection")
	ADD_TRAIT(affected_mob, TRAIT_NOCLONELOSS, "zombie_infection")
	old_species_name = affected_mob.dna.species.name
	affected_mob.dna.species.name = "Lost Soul"
	old_attack_verb = (islist(affected_mob.dna.species.attack_verb) ? \
					(list() | affected_mob.dna.species.attack_verb) : \
					affected_mob.dna.species.attack_verb)
	affected_mob.dna.species.attack_verb = "claw"
	old_attack_verb_continuous = (islist(affected_mob.dna.species.attack_verb_continuous) ? \
					(list() | affected_mob.dna.species.attack_verb_continuous) : \
					affected_mob.dna.species.attack_verb_continuous)
	affected_mob.dna.species.attack_verb_continuous = "claws"
	old_say_mod = (islist(affected_mob.dna.species.say_mod) ? \
					(list() | affected_mob.dna.species.say_mod) : \
					affected_mob.dna.species.say_mod)
	affected_mob.dna.species.say_mod = "moans"
	old_bodytemp_normal = affected_mob.dna.species.bodytemp_normal
	affected_mob.dna.species.bodytemp_normal = T0C
	old_speedmod = affected_mob.dna.species.speedmod
	affected_mob.dna.species.speedmod = 0.75
	old_deathsound = affected_mob.dna.species.deathsound
	affected_mob.dna.species.deathsound = 'modular_septic/sound/zombie/die.wav'
	affected_mob.drop_all_held_items()
	var/list/stat_modification = list( \
		STAT_STRENGTH = 5, \
		STAT_ENDURANCE = 3, \
		STAT_DEXTERITY = 3, \
		STAT_INTELLIGENCE = -6, \
		)
	affected_mob.attributes?.add_or_update_variable_attribute_modifier(/datum/attribute_modifier/zombie, TRUE, stat_modification)
	affected_mob.set_heartattack(TRUE)
	if(stage <= 1)
		to_chat(affected_mob, "I have become a lost soul!")
	update_stage(2)
	RegisterSignal(affected_mob, COMSIG_MOB_SAY, .proc/handle_speech)
	RegisterSignal(affected_mob, COMSIG_LIVING_REVIVE, .proc/mob_revived)
	RegisterSignal(affected_mob, COMSIG_LIVING_TRY_PUT_IN_HAND, .proc/deny_put_in_hand)
	if(!(affected_mob.mob_biotypes & MOB_UNDEAD))
		was_undead = TRUE
		affected_mob.mob_biotypes |= MOB_UNDEAD
	if(!affected_mob.language_holder.has_language(/datum/language/aphasia, TRUE))
		was_retarded = list(LAZYACCESS(affected_mob.language_holder.understood_languages, /datum/language/aphasia), \
					LAZYACCESS(affected_mob.language_holder.spoken_languages, /datum/language/aphasia))
		affected_mob.language_holder.understood_languages[/datum/language/aphasia] = list(LANGUAGE_ATOM)
		affected_mob.language_holder.spoken_languages[/datum/language/aphasia] = list(LANGUAGE_ATOM)
	affected_mob.language_holder.selected_language = /datum/language/aphasia
	stage = 2
	affected_mob.fully_heal(FALSE)

/datum/disease/zombification/proc/dezombify()
	if(QDELETED(affected_mob))
		return
	CHECK_DNA_AND_SPECIES(affected_mob)
	if(TRAIT_ADVANCEDTOOLUSER in affected_mob.dna.species.inherent_traits)
		ADD_TRAIT(affected_mob, TRAIT_ADVANCEDTOOLUSER, SPECIES_TRAIT)
	visibility_flags = HIDDEN_SCANNER|HIDDEN_PANDEMIC
	REMOVE_TRAIT(affected_mob, TRAIT_HUSK, "zombie_infection")
	REMOVE_TRAIT(affected_mob, TRAIT_NOPAIN, "zombie_infection")
	REMOVE_TRAIT(affected_mob, TRAIT_STABLEHEART, "zombie_infection")
	REMOVE_TRAIT(affected_mob, TRAIT_FAKEDEATH, "zombie_infection")
	REMOVE_TRAIT(affected_mob, TRAIT_NOHUNGER, "zombie_infection")
	REMOVE_TRAIT(affected_mob, TRAIT_NOTHIRST, "zombie_infection")
	REMOVE_TRAIT(affected_mob, TRAIT_NOBREATH, "zombie_infection")
	REMOVE_TRAIT(affected_mob, TRAIT_NOMETABOLISM, "zombie_infection")
	REMOVE_TRAIT(affected_mob, TRAIT_NOCLONELOSS, "zombie_infection")
	affected_mob.dna.species.name = old_species_name
	affected_mob.dna.species.attack_verb = (islist(old_attack_verb) ? \
					(list() | old_attack_verb) : old_attack_verb)
	affected_mob.dna.species.attack_verb_continuous = (islist(old_attack_verb_continuous) ? \
					(list() | old_attack_verb_continuous) : old_attack_verb_continuous)
	affected_mob.dna.species.say_mod = (islist(old_say_mod) ? \
					(list() | old_say_mod) : old_say_mod)
	affected_mob.dna.species.bodytemp_normal = old_bodytemp_normal
	affected_mob.dna.species.speedmod = old_speedmod
	affected_mob.dna.species.deathsound = old_deathsound
	affected_mob.set_heartattack(FALSE)
	if(stage >= 2)
		to_chat(affected_mob, span_nicegreen("I am no longer a lost soul!"))
	update_stage(1)
	UnregisterSignal(affected_mob, COMSIG_MOB_SAY)
	UnregisterSignal(affected_mob, COMSIG_LIVING_REVIVE)
	UnregisterSignal(affected_mob, COMSIG_LIVING_TRY_PUT_IN_HAND)
	if(!was_undead)
		affected_mob.mob_biotypes &= ~MOB_UNDEAD
	if(LAZYACCESS(was_retarded, 1))
		affected_mob.language_holder.understood_languages[/datum/language/aphasia] = was_retarded[1]
	else
		affected_mob.language_holder.understood_languages -= /datum/language/aphasia
	if(LAZYACCESS(was_retarded, 2))
		affected_mob.language_holder.spoken_languages[/datum/language/aphasia] = was_retarded[2]
	else
		affected_mob.language_holder.spoken_languages -= /datum/language/aphasia
	affected_mob.language_holder.selected_language = LAZYACCESS(affected_mob.language_holder.spoken_languages, 1)
	affected_mob.fully_heal()

/datum/disease/zombification/proc/mob_revived(mob/source)
	SIGNAL_HANDLER
	if(cure_on_revival && (stage < 2))
		qdel(src)

/datum/disease/zombification/proc/deny_put_in_hand(mob/source)
	SIGNAL_HANDLER
	return COMPONENT_LIVING_CANT_PUT_IN_HAND

/datum/disease/zombification/proc/handle_speech(mob/source, list/speech_args)
	if(speech_args[SPEECH_LANGUAGE] == /datum/language/aphasia)
		return
	speech_args[SPEECH_MESSAGE] = handle_vocal_cord_torn(speech_args[SPEECH_MESSAGE])
