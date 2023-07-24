/obj/effect/landmark/spawnedmob/lynx
	name = "landmark"
	icon = 'modular_septic/icons/hud/screen_gen.dmi'
	icon_state = "helloiamlynx"
	invisibility = 101
	anchored = 1

/obj/effect/landmark/tendance
	name = "landmark"
	icon = 'modular_septic/icons/hud/screen_gen.dmi'
	icon_state = "tend"
	invisibility = 101
	anchored = 1

/area/medical/spawned
	name = "brat"
	ambientsounds = list('modular_pod/sound/ambi_sounds/borne.ogg', 'modular_pod/sound/ambi_sounds_two/aloha.ogg', 'modular_pod/sound/ambi_sounds_two/birds.ogg', 'modular_pod/sound/ambi_sounds_two/birds_ds.ogg', 'modular_pod/sound/ambi_sounds_two/birds_po.ogg', 'modular_pod/sound/ambi_sounds_two/birds_sc.ogg', 'modular_pod/sound/ambi_sounds_two/birds_vs.ogg', 'modular_pod/sound/ambi_sounds_two/cyclobe_first.ogg', 'modular_pod/sound/ambi_sounds_two/cyclobe_two.ogg', 'modular_pod/sound/ambi_sounds_two/dead_dawn.ogg', 'modular_pod/sound/ambi_sounds_two/hrumka.ogg', 'modular_pod/sound/ambi_sounds_two/living.ogg', 'modular_pod/sound/ambi_sounds_two/living_two.ogg', 'modular_pod/sound/ambi_sounds_two/mylove.ogg', 'modular_pod/sound/ambi_sounds_two/own.ogg', 'modular_pod/sound/ambi_sounds_two/pain.ogg', 'modular_pod/sound/ambi_sounds_two/pain_two.ogg', 'modular_pod/sound/ambi_sounds_two/peregi.ogg', 'modular_pod/sound/ambi_sounds_two/phil.ogg', 'modular_pod/sound/ambi_sounds_two/phill.ogg', 'modular_pod/sound/ambi_sounds_two/queen.ogg', 'modular_pod/sound/ambi_sounds_two/queen_second.ogg', 'modular_pod/sound/ambi_sounds_two/queen_three.ogg', 'modular_pod/sound/ambi_sounds_two/red.ogg', 'modular_pod/sound/ambi_sounds_two/reddy.ogg', 'modular_pod/sound/ambi_sounds_two/run.ogg', 'modular_pod/sound/ambi_sounds_two/run_two.ogg', 'modular_pod/sound/ambi_sounds_two/slur.ogg', 'modular_pod/sound/ambi_sounds_two/spacevoice.ogg', 'modular_pod/sound/ambi_sounds_two/spacevoice_three.ogg', 'modular_pod/sound/ambi_sounds_two/spacevoice_two.ogg', 'modular_pod/sound/ambi_sounds_two/spiral.ogg', 'modular_pod/sound/ambi_sounds_two/stan.ogg', 'modular_pod/sound/ambi_sounds_two/sun.ogg', 'modular_pod/sound/ambi_sounds_two/sunny.ogg', 'modular_pod/sound/ambi_sounds_two/thee.ogg', 'modular_pod/sound/ambi_sounds_two/things.ogg', 'modular_pod/sound/ambi_sounds_two/things_two.ogg', 'modular_pod/sound/ambi_sounds/crow.ogg', 'modular_pod/sound/ambi_sounds/crow_two.ogg', 'modular_pod/sound/ambi_sounds/crow_three.ogg', 'modular_pod/sound/ambi_sounds/crow_four.ogg', 'modular_pod/sound/ambi_sounds/crow_five.ogg', 'modular_pod/sound/ambi_sounds/essel_first.ogg', 'modular_pod/sound/ambi_sounds/essel_two.ogg', 'modular_pod/sound/ambi_sounds/essel_three.ogg', 'modular_pod/sound/ambi_sounds/fire.ogg', 'modular_pod/sound/ambi_sounds/fire_four.ogg', 'modular_pod/sound/ambi_sounds/fire_three.ogg', 'modular_pod/sound/ambi_sounds/fire_two.ogg', 'modular_pod/sound/ambi_sounds/fire.ogg', 'modular_pod/sound/ambi_sounds/forest_first.ogg', 'modular_pod/sound/ambi_sounds/forest_two.ogg', 'modular_pod/sound/ambi_sounds/forest_three.ogg', 'modular_pod/sound/ambi_sounds/lot.ogg', 'modular_pod/sound/ambi_sounds/ostia.ogg', 'modular_pod/sound/ambi_sounds/weeper_first.ogg', 'modular_pod/sound/ambi_sounds/weeper_three.ogg', 'modular_pod/sound/ambi_sounds/weeper_two.ogg')
//	droning_sound = DRONING_FOREST
//	droning_volume = 35
	requires_power = FALSE
//	ambience_index = AMBIENCE_GENERIC
	min_ambience_cooldown = 50 SECONDS
	max_ambience_cooldown = 75 SECONDS
	area_flags = NO_ALERTS
	requires_power = FALSE
	power_environ = FALSE
	power_equip = FALSE
	power_light = FALSE
	outdoors = TRUE
	static_lighting = TRUE

/area/maintenance/polovich/tendance
	name = "tendance"
	ambientsounds = list('modular_pod/sound/ambi_sounds/borne.ogg', 'modular_pod/sound/ambi_sounds_two/aloha.ogg', 'modular_pod/sound/ambi_sounds_two/birds.ogg', 'modular_pod/sound/ambi_sounds_two/birds_ds.ogg', 'modular_pod/sound/ambi_sounds_two/birds_po.ogg', 'modular_pod/sound/ambi_sounds_two/birds_sc.ogg', 'modular_pod/sound/ambi_sounds_two/birds_vs.ogg', 'modular_pod/sound/ambi_sounds_two/cyclobe_first.ogg', 'modular_pod/sound/ambi_sounds_two/cyclobe_two.ogg', 'modular_pod/sound/ambi_sounds_two/dead_dawn.ogg', 'modular_pod/sound/ambi_sounds_two/hrumka.ogg', 'modular_pod/sound/ambi_sounds_two/living.ogg', 'modular_pod/sound/ambi_sounds_two/living_two.ogg', 'modular_pod/sound/ambi_sounds_two/mylove.ogg', 'modular_pod/sound/ambi_sounds_two/own.ogg', 'modular_pod/sound/ambi_sounds_two/pain.ogg', 'modular_pod/sound/ambi_sounds_two/pain_two.ogg', 'modular_pod/sound/ambi_sounds_two/peregi.ogg', 'modular_pod/sound/ambi_sounds_two/phil.ogg', 'modular_pod/sound/ambi_sounds_two/phill.ogg', 'modular_pod/sound/ambi_sounds_two/queen.ogg', 'modular_pod/sound/ambi_sounds_two/queen_second.ogg', 'modular_pod/sound/ambi_sounds_two/queen_three.ogg', 'modular_pod/sound/ambi_sounds_two/red.ogg', 'modular_pod/sound/ambi_sounds_two/reddy.ogg', 'modular_pod/sound/ambi_sounds_two/run.ogg', 'modular_pod/sound/ambi_sounds_two/run_two.ogg', 'modular_pod/sound/ambi_sounds_two/slur.ogg', 'modular_pod/sound/ambi_sounds_two/spacevoice.ogg', 'modular_pod/sound/ambi_sounds_two/spacevoice_three.ogg', 'modular_pod/sound/ambi_sounds_two/spacevoice_two.ogg', 'modular_pod/sound/ambi_sounds_two/spiral.ogg', 'modular_pod/sound/ambi_sounds_two/stan.ogg', 'modular_pod/sound/ambi_sounds_two/sun.ogg', 'modular_pod/sound/ambi_sounds_two/sunny.ogg', 'modular_pod/sound/ambi_sounds_two/thee.ogg', 'modular_pod/sound/ambi_sounds_two/things.ogg', 'modular_pod/sound/ambi_sounds_two/things_two.ogg', 'modular_pod/sound/ambi_sounds/crow.ogg', 'modular_pod/sound/ambi_sounds/crow_two.ogg', 'modular_pod/sound/ambi_sounds/crow_three.ogg', 'modular_pod/sound/ambi_sounds/crow_four.ogg', 'modular_pod/sound/ambi_sounds/crow_five.ogg', 'modular_pod/sound/ambi_sounds/essel_first.ogg', 'modular_pod/sound/ambi_sounds/essel_two.ogg', 'modular_pod/sound/ambi_sounds/essel_three.ogg', 'modular_pod/sound/ambi_sounds/fire.ogg', 'modular_pod/sound/ambi_sounds/fire_four.ogg', 'modular_pod/sound/ambi_sounds/fire_three.ogg', 'modular_pod/sound/ambi_sounds/fire_two.ogg', 'modular_pod/sound/ambi_sounds/fire.ogg', 'modular_pod/sound/ambi_sounds/forest_first.ogg', 'modular_pod/sound/ambi_sounds/forest_two.ogg', 'modular_pod/sound/ambi_sounds/forest_three.ogg', 'modular_pod/sound/ambi_sounds/lot.ogg', 'modular_pod/sound/ambi_sounds/ostia.ogg', 'modular_pod/sound/ambi_sounds/weeper_first.ogg', 'modular_pod/sound/ambi_sounds/weeper_three.ogg', 'modular_pod/sound/ambi_sounds/weeper_two.ogg')
	droning_sound = DRONING_EVIL
/*
/mob/proc/send_naxyu()
	if(stat != DEAD)
		return

	var/obj/effect/landmark/tendance/K = locate() in world
	var/mob/living/carbon/human/species/weakwillet/character = new(K.loc)

//	client.prefs.safe_transfer_prefs_to(character)
//	character.dna.update_dna_identity()
//	character.attributes.update_attributes()
	character.fully_replace_character_name(character.real_name, "Particle Of Chaos")
	character.grant_all_languages(TRUE, TRUE, TRUE, LANGUAGE_WEAKWILLET)
	var/datum/component/babble/babble = character.GetComponent(/datum/component/babble)
	if(!babble)
		character.AddComponent(/datum/component/babble, 'modular_septic/sound/voice/babble/creature.wav')
	else
		babble.babble_sound_override = 'modular_septic/sound/voice/babble/inborn.wav'
		babble.volume = BABBLE_DEFAULT_VOLUME
		babble.duration = BABBLE_DEFAULT_DURATION

	if(mind)
		mind.active = 0
		mind.transfer_to(character)

	if(prob(5))
		character.attributes.add_sheet(/datum/attribute_holder/sheet/job/strongwillet)
		character.height = HUMAN_HEIGHT_TALLEST
		if(prob(65))
			character.put_in_hands(new /obj/item/changeable_attacks/slashstabbash/axe/big/steel(character.drop_location()), FALSE)
	else
		character.attributes.add_sheet(/datum/attribute_holder/sheet/job/weakwillet)
		character.height = HUMAN_HEIGHT_MEDIUM

	character.attributes.update_attributes()

	character.key = key
	character.playsound_local(character, 'modular_pod/sound/eff/DSBOSPN.wav', 100)
//	character.overlay_fullscreen("ressur", /atom/movable/screen/fullscreen/willetbecome)
//	addtimer(CALLBACK(character, .proc/clear_fullscreen, "ressur", 3), 3)
*/