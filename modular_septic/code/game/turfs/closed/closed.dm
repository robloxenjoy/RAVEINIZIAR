/turf/closed
	plane = GAME_PLANE
	layer = CLOSED_TURF_LAYER
	upper_frill_plane = FRILL_PLANE
	upper_frill_layer = ABOVE_MOB_LAYER
	lower_frill_plane = GAME_PLANE_ABOVE_WINDOW
	lower_frill_layer = ABOVE_DOOR_LAYER

/turf/closed/on_rammed(mob/living/carbon/rammer)
	rammer.ram_stun()
	var/smash_sound = pick('modular_septic/sound/gore/smash1.ogg',
						'modular_septic/sound/gore/smash2.ogg',
						'modular_septic/sound/gore/smash3.ogg')
	playsound(src, smash_sound, 75)
	rammer.sound_hint()
	sound_hint()
