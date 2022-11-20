/datum/hacking/vending
	holder_type = /obj/machinery/vending
	proper_name = "Vending Machine"
	hacking_actions = "vending"
	var/obvious = TRUE
	var/loud_sound = 'modular_septic/sound/effects/obvious.wav'

/datum/hacking/vending/generate_hacking_actions()
	GLOB.hacking_actions_by_key[hacking_actions] = list(
		"Virus" = .proc/infection,
		"Destroy" = .proc/destroy_holder,
	)
	return GLOB.hacking_actions_by_key[hacking_actions]

/datum/hacking/vending/proc/infection(mob/living/hackerman)
	var/obj/machinery/vending/vending = holder
	if(!vending.infected)
		vending.infected = TRUE
		vending.last_slogan = 50
		vending.slogan_delay = 150
		vending.slogan_list = list("GOD, GOD GOD GOD GOOODDDDD!!!", "OH MY GOODNESS GRACIOUS JEEEESUS CHRIST!", "OHHHHHHHHH!", "FFFUUUUCCCKK FUCKK AAHHHHHHHHHHH AHHHHHH FUCK!!!!", "HMHMMHGHHHHHH...MURDER CORRECTION NEEDED!")
		do_sparks(2, FALSE, vending)
		to_chat(hackerman, span_warning("I have infected the operating system with \"" + \
			span_green("P") + span_yellow("A") + span_green("I") + span_white("N") + " " + \
			span_red("W") + span_red("A") + span_red("R") + span_red("E") + \
			"\"!"))

/datum/hacking/vending/destroy_holder(mob/living/hackerman)
	var/obj/machinery/vending/vending = holder
	if(obvious)
		playsound(vending, loud_sound, 60, FALSE)
		do_sparks(1, FALSE, vending)

	vending_destruct(vending)

/datum/hacking/vending/proc/vending_destruct(mob/living/hackerman)
	var/obj/machinery/vending/vending = holder
	sleep(1 SECONDS)
	do_sparks(1, FALSE, vending)
	sleep(6)
	do_sparks(2, FALSE, vending)
	vending.deconstruct(FALSE)
