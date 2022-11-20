/datum/hacking/closet
	holder_type = /obj/structure/closet
	proper_name = "Secure Closet"
	hacking_actions = "safe"
	var/obvious = TRUE
	var/loud_sound = 'modular_septic/sound/effects/obvious.wav'

/datum/hacking/closet/generate_hacking_actions()
	GLOB.hacking_actions_by_key[hacking_actions] = list(
		"Scramble" = .proc/scramble_lock,
		"Lock" = .proc/lock_closet,
		"Destroy" = .proc/destroy_holder,
	)
	return GLOB.hacking_actions_by_key[hacking_actions]

/datum/hacking/closet/destroy_holder(mob/living/hackerman)
	var/obj/structure/closet/secure_closet = holder
	if(obvious)
		playsound(secure_closet, loud_sound, 60, FALSE)
		do_sparks(1, FALSE, secure_closet)
	//We have to return immediately
	INVOKE_ASYNC(src, .proc/closet_destruction)

/datum/hacking/closet/proc/closet_destruction(mob/living/hackerman)
	var/obj/structure/closet/secure_closet = holder
	sleep(1 SECONDS)
	do_sparks(1, FALSE, secure_closet)
	sleep(0.6 SECONDS)
	do_sparks(2, FALSE, secure_closet)
	secure_closet.deconstruct(FALSE)

/datum/hacking/closet/proc/lock_closet(atom/hackerman)
	var/obj/structure/closet/secure_closet = holder
	if(secure_closet.locked)
		secure_closet.locked = FALSE
	else
		secure_closet.locked = TRUE
	secure_closet.update_appearance()

/datum/hacking/closet/proc/scramble_lock(atom/hackerman)
	var/obj/structure/closet/secure_closet = holder
	secure_closet.req_access = list(ACCESS_CENT_SPECOPS)
