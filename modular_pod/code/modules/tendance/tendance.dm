/obj/effect/landmark/tendance
	name = "landmark"
	icon = 'icons/mob/screen_gen.dmi'
	icon_state = "tend"
	invisibility = 101
	anchored = 1
	unacidable = 1

/area/maintenance/polovich/tendance
	name = "tendance"
	ambientsounds = list('modular_pod/sound/ambi_sounds/borne.ogg', 'modular_pod/sound/ambi_sounds/buffmfffpampam.ogg', 'modular_pod/sound/ambi_sounds/BOOOM.ogg')
	droning_sound = DRONING_EVIL

/mob/living/carbon/human/dead
	alpha = 180

/mob/proc/send_to_kyrilka()
	if(istype(src, /mob/living/carbon/human/dead) || stat != DEAD)
		return
	var/obj/effect/landmark/tendance/K = locate() in world
	var/mob/living/carbon/human/dead/character = new(K.loc)

	client.prefs.safe_transfer_prefs_to(character)
	character.dna.update_dna_identity()
	if(mind)
		mind.active = 0
		mind.transfer_to(character)

	character.clients_names = clients_names.Copy()
	character.clients_names[character] = clients_names[src]
	character.timeofdeath = timeofdeath
	character.key = key
//	character.client.set_macros()