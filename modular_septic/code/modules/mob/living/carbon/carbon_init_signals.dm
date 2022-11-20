/mob/living/carbon/register_init_signals()
	. = ..()
	// Stimulant chemical stuff
	RegisterSignal(src, SIGNAL_ADDCHEMEFFECT(CE_SPEED), .proc/receive_speedboost)
	RegisterSignal(src, SIGNAL_REMOVECHEMEFFECT(CE_SPEED), .proc/remove_speedboost)
	// Death's door stuff
	RegisterSignal(src, SIGNAL_ADDTRAIT(TRAIT_DEATHS_DOOR), .proc/entered_deaths_door)
	RegisterSignal(src, SIGNAL_REMOVETRAIT(TRAIT_DEATHS_DOOR), .proc/left_deaths_door)
	// Basic speed stuff
	RegisterSignal(src, SIGNAL_ADDTRAIT(TRAIT_BASIC_SPEED_HALVED), .proc/basic_speed_halved)
	RegisterSignal(src, SIGNAL_REMOVETRAIT(TRAIT_BASIC_SPEED_HALVED), .proc/basic_speed_unhalved)
	// I LOVE LEAN!
	RegisterSignal(src, SIGNAL_ADDTRAIT(TRAIT_LEAN), .proc/started_leaning)
	RegisterSignal(src, SIGNAL_REMOVETRAIT(TRAIT_LEAN), .proc/stopped_leaning)
	// Combat message stuff
	RegisterSignal(src, COMSIG_CARBON_CLEAR_WOUND_MESSAGE, .proc/clear_wound_message)
	RegisterSignal(src, COMSIG_CARBON_ADD_TO_WOUND_MESSAGE, .proc/add_to_wound_message)

/mob/living/carbon/on_floored_start()
	if(body_position == STANDING_UP) //force them on the ground
		set_lying_angle(pick(90, 270))
		set_body_position(LYING_DOWN)
		on_fall()
		if(client)
			set_resting(TRUE)

/mob/living/carbon/on_floored_end()
	if(!resting)
		get_up()

/mob/living/carbon/proc/receive_speedboost(mob/living/carbon/source, chem_effect)
	var/speedboost = get_chem_effect(chem_effect)
	add_or_update_variable_movespeed_modifier(/datum/movespeed_modifier/chemical_effect/speedboost, TRUE, speedboost * SPEEDBOOST_SPEED_INCREASE)

/mob/living/carbon/proc/remove_speedboost(mob/living/carbon/source, chem_effect)
	remove_movespeed_modifier(/datum/movespeed_modifier/chemical_effect/speedboost, TRUE)

/mob/living/carbon/proc/entered_deaths_door(mob/living/carbon/source)
	updatehealth()

/mob/living/carbon/proc/left_deaths_door(mob/living/carbon/source)
	updatehealth()

/mob/living/carbon/proc/started_leaning(mob/living/carbon/lean_monster)
	//i love lean
	var/matrix/transformed = lean_monster.transform.Turn(5)
	animate(lean_monster, lean_monster.transform = transformed, time = 0.5 SECONDS)

/mob/living/carbon/proc/stopped_leaning(mob/living/carbon/lean_monster)
	//I LOVE LEAN!
	var/matrix/transformed = lean_monster.transform.Turn(-5)
	animate(lean_monster, lean_monster.transform = transformed, time = 0.5 SECONDS)

/mob/living/carbon/proc/basic_speed_halved(mob/living/carbon/source)
	update_basic_speed_modifier()

/mob/living/carbon/proc/basic_speed_unhalved(mob/living/carbon/source)
	update_basic_speed_modifier()

/mob/living/carbon/proc/clear_wound_message(datum/source)
	wound_message = ""

/mob/living/carbon/proc/add_to_wound_message(datum/source, new_message = "", clear_message = FALSE)
	if(clear_message)
		SEND_SIGNAL(src, COMSIG_CARBON_CLEAR_WOUND_MESSAGE)
	wound_message = "[wound_message][new_message]"
