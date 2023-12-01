/obj/machinery/door/airlock
	icon = 'modular_septic/icons/obj/machinery/doors/airlocks/station/maintenance.dmi'
	overlays_file = 'modular_septic/icons/obj/machinery/doors/airlocks/station/maintenance_overlays.dmi'
	greyscale_config = null
	greyscale_colors = ""
	doorOpen = 'modular_septic/sound/machinery/airlock_open.ogg'
	doorClose = 'modular_septic/sound/machinery/airlock_close.ogg'
	boltUp = 'modular_septic/sound/machinery/airlock_bolt.ogg'
	boltDown = 'modular_septic/sound/machinery/airlock_unbolt.ogg'
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

/**
 * Generates the airlock's hacking datum.
 */
/obj/machinery/door/airlock/proc/set_hacking()
	return new /datum/hacking/airlock(src)