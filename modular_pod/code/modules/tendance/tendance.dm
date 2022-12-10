/obj/effect/landmark/tendance
	name = "landmark"
	icon = 'modular_septic/icons/hud/screen_gen.dmi'
	icon_state = "tend"
	invisibility = 101
	anchored = 1

/area/medical/spawned
	name = "brat"
	ambientsounds = list('modular_pod/sound/ambi_sounds/borne.ogg', 'modular_pod/sound/ambi_sounds/buffmfffpampam.ogg', 'modular_pod/sound/ambi_sounds/BOOOM.ogg')
//	droning_sound = DRONING_FOREST
//	droning_volume = 35
	requires_power = FALSE
//	ambience_index = AMBIENCE_GENERIC
	min_ambience_cooldown = 40 SECONDS
	max_ambience_cooldown = 60 SECONDS
	area_flags = NO_ALERTS
	requires_power = FALSE
	power_environ = FALSE
	power_equip = FALSE
	power_light = FALSE
	outdoors = TRUE
	static_lighting = TRUE

/area/maintenance/polovich/tendance
	name = "tendance"
	ambientsounds = list('modular_pod/sound/ambi_sounds/borne.ogg', 'modular_pod/sound/ambi_sounds/buffmfffpampam.ogg', 'modular_pod/sound/ambi_sounds/BOOOM.ogg')
	droning_sound = DRONING_EVIL

/mob/proc/send_naxyu()
	if(stat != DEAD)
		return
	var/obj/effect/landmark/tendance/K = locate() in world
	var/mob/living/carbon/human/species/weakwillet/character = new(K.loc)

//	client.prefs.safe_transfer_prefs_to(character)
//	character.dna.update_dna_identity()
	character.fully_replace_character_name(character.real_name, "Particle Of Chaos")
	character.grant_all_languages(TRUE, TRUE, TRUE, LANGUAGE_WEAKWILLET)
	character.mind.add_antag_datum(/datum/antagonist/inborn)
	character.attributes.add_sheet(/datum/attribute_holder/sheet/job/weakwillet)
	var/datum/component/babble/babble = character.GetComponent(/datum/component/babble)
	if(!babble)
		character.AddComponent(/datum/component/babble, 'modular_septic/sound/voice/babble/inborn.wav')
	else
		babble.babble_sound_override = 'modular_septic/sound/voice/babble/inborn.wav'
		babble.volume = BABBLE_DEFAULT_VOLUME
		babble.duration = BABBLE_DEFAULT_DURATION

	if(mind)
		mind.active = 0
		mind.transfer_to(character)

//	character.timeofdeath = timeofdeath
	character.key = key
//	character.client.set_macros()
