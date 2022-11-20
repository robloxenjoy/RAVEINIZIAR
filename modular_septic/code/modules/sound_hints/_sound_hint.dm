#define SOUND_HINT_COOLDOWN_DURATION 1 SECONDS

//Do a little sound hint
/atom/proc/sound_hint(duration = 5, use_icon = 'modular_septic/icons/effects/sound.dmi', use_states = "sound2")
	//this is HORRIBLE but it prevents runtimes
	if(SSticker.current_state < GAME_STATE_PLAYING)
		return
	var/turf/our_turf = get_turf(src)
	// EXPERIMENTAL: Trying to curb the amount of sound hints for performance reasons
	if(!our_turf || !COOLDOWN_FINISHED(our_turf, sound_hint_cooldown))
		return
	COOLDOWN_START(our_turf, sound_hint_cooldown, SOUND_HINT_COOLDOWN_DURATION)
	var/hint_icon = pick(use_icon)
	var/hint_state = pick(use_states)
	var/image/hint = image(hint_icon, our_turf, hint_state)
	hint.appearance_flags = RESET_COLOR | RESET_TRANSFORM | RESET_ALPHA
	hint.plane = SOUND_HINT_PLANE
	hint.layer = SOUND_HINT_LAYER
	var/list/clients = list()
	for(var/mob/hearer as anything in GLOB.player_list)
		if(hearer.can_hear() && (get_dist(src, hearer) <= 10))
			clients |= hearer.client
	flick_overlay(hint, clients, duration)

#undef SOUND_HINT_COOLDOWN_DURATION
