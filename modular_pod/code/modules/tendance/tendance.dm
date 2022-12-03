/obj/effect/landmark/tendance
	name = "landmark"
	icon = 'modular_septic/icons/hud/screen_gen.dmi'
	icon_state = "tend"
	invisibility = 101
	anchored = 1

/area/maintenance/spawned
	name = "spawned"
	ambientsounds = list('modular_pod/sound/ambi_sounds/borne.ogg', 'modular_pod/sound/ambi_sounds/buffmfffpampam.ogg', 'modular_pod/sound/ambi_sounds/BOOOM.ogg')
	droning_sound = DRONING_FOREST
	droning_volume = 35
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

/mob/proc/send_to_kyrilka()
	if(stat != DEAD)
		return
	var/obj/effect/landmark/tendance/K = locate() in world
	var/mob/living/carbon/human/species/weakwillet/character = new(K.loc)

	client.prefs.safe_transfer_prefs_to(character)
	character.dna.update_dna_identity()
	if(mind)
		mind.active = 0
		mind.transfer_to(character)

//	character.timeofdeath = timeofdeath
//	character.key = key
//	character.client.set_macros()
