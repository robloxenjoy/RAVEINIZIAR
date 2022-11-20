/obj/machinery/door/airlock
	greyscale_config = /datum/greyscale_config/airlocks/custom
	greyscale_colors = "#a5a7ac#a5a7ac#969696#969696#5ea52c#6d6565#777777"
	doorOpen = 'modular_septic/sound/machinery/airlock_open.wav'
	doorClose = 'modular_septic/sound/machinery/airlock_close.wav'
	boltUp = 'modular_septic/sound/machinery/airlock_bolt.wav'
	boltDown = 'modular_septic/sound/machinery/airlock_unbolt.wav'
	doorDeni = 'modular_septic/sound/machinery/airlock_deny.ogg'

/obj/machinery/door/airlock/Initialize(mapload)
	. = ..()
	hacking = set_hacking()

// airlocks don't get damaged by ramming
/obj/machinery/door/airlock/on_rammed(mob/living/carbon/rammer)
	rammer.ram_stun()
	var/smash_sound = pick('modular_septic/sound/gore/smash1.ogg',
						'modular_septic/sound/gore/smash2.ogg',
						'modular_septic/sound/gore/smash3.ogg')
	playsound(src, smash_sound, 75)
	rammer.sound_hint()
	sound_hint()

/**
 * Generates the airlock's hacking datum.
 */
/obj/machinery/door/airlock/proc/set_hacking()
	return new /datum/hacking/airlock(src)
