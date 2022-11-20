/datum/hacking/infocom
	holder_type = /obj/machinery/infocom
	proper_name = "Information Communication"
	hacking_actions = "malicious"

/datum/hacking/infocom/generate_hacking_actions()
	GLOB.hacking_actions_by_key[hacking_actions] = list(
		"Virus" = .proc/virus,
		"Destroy" = .proc/destroy_holder,
	)
	return GLOB.hacking_actions_by_key[hacking_actions]

/datum/hacking/infocom/destroy_holder(mob/living/hackerman)
	//We have to return immediately
	INVOKE_ASYNC(src, .proc/infocom_destruction)

/datum/hacking/infocom/proc/infocom_destruction(mob/living/hackerman)
	var/obj/machinery/infocom/infocom = holder
	sleep(1 SECONDS)
	do_sparks(1, FALSE, infocom)
	sleep(0.6 SECONDS)
	do_sparks(2, FALSE, infocom)
	infocom.deconstruct(FALSE)

/datum/hacking/infocom/proc/virus(atom/hackerman)
	var/obj/machinery/infocom/infocom = holder
	if(infocom.virused)
		return
	else
		to_chat(hackerman, span_warning("I've infected [src] with painware."))
		do_sparks(1, FALSE, infocom)
		infocom.virused = TRUE
		infocom.radiotune = list('modular_septic/sound/efn/hackedcom1.ogg', 'modular_septic/sound/efn/hackedcom2.ogg', 'modular_septic/sound/efn/hackedcom3.ogg')
		infocom.voice_lines = list("WHY AR%$# Y%$#U HE%$#E$#*", "YOU BBL%$%#ACK", "YOU N%$##R", "YOU D#$%@ERVE% NOTHING BUT H%$#TE", "I WI%$#LL COME TO YOU RHO%$%#USE AND K%$ILL YOU")
		infocom.voice_delay = 1 SECONDS
		infocom.start_spitting_fax()

