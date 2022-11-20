/mob/living/carbon/can_feel_pain()
	return !HAS_TRAIT(src, TRAIT_NOPAIN)

/mob/living/carbon/update_shock()
	. = ..()
	if(!client || !hud_used)
		return
	if(hud_used.pain_guy)
		if(stat < DEAD)
			. = TRUE
			switch(traumatic_shock)
				if(-INFINITY to 5)
					hud_used.pain_guy.icon_state = "[hud_used.pain_guy.base_icon_state]0"
				if(5 to 15)
					hud_used.pain_guy.icon_state = "[hud_used.pain_guy.base_icon_state]1"
				if(15 to 30)
					hud_used.pain_guy.icon_state = "[hud_used.pain_guy.base_icon_state]2"
				if(30 to 45)
					hud_used.pain_guy.icon_state = "[hud_used.pain_guy.base_icon_state]3"
				if(45 to 60)
					hud_used.pain_guy.icon_state = "[hud_used.pain_guy.base_icon_state]4"
				if(60 to 75)
					hud_used.pain_guy.icon_state = "[hud_used.pain_guy.base_icon_state]5"
				if(75 to INFINITY)
					hud_used.pain_guy.icon_state = "[hud_used.pain_guy.base_icon_state]6"
			if(HAS_TRAIT(src, TRAIT_DEATHS_DOOR))
				hud_used.pain_guy.icon_state = "[hud_used.pain_guy.base_icon_state]dd"
			if(HAS_TRAIT(src, TRAIT_NOPAIN) || HAS_TRAIT(src, TRAIT_FAKEDEATH))
				hud_used.pain_guy.icon_state = "[hud_used.pain_guy.base_icon_state]u"
		else
			hud_used.pain_guy.icon_state = "paind"
	//Pain fucks up our vision
	switch(traumatic_shock)
		if(-INFINITY to SHOCK_STAGE_2)
			hud_used.update_chromatic_aberration(intensity = 0)
		if(SHOCK_STAGE_2 to SHOCK_STAGE_4)
			hud_used.update_chromatic_aberration(intensity = 1, red_x = 1, red_y = 1, blue_x = -1, blue_y = -1)
		if(SHOCK_STAGE_4 to SHOCK_STAGE_6)
			hud_used.update_chromatic_aberration(intensity = 2, red_x = 2, red_y = 2, blue_x = -2, blue_y = -2)
		if(SHOCK_STAGE_6 to INFINITY)
			hud_used.update_chromatic_aberration(intensity = 3, red_x = 3, red_y = 3, blue_x = -3, blue_y = -3)

/mob/living/carbon/handle_shock(delta_time, times_fired)
	. = ..()
	if(!can_feel_pain())
		REMOVE_TRAIT(src, TRAIT_BASIC_SPEED_HALVED, SHOCK)
		return
	if(stat >= UNCONSCIOUS)
		return

	var/our_endurance = GET_MOB_ATTRIBUTE_VALUE(src, STAT_ENDURANCE)

	if(HAS_TRAIT(src, TRAIT_PAINLOVER) && (traumatic_shock >= PAIN_HALVE_MOVE/2))
		SEND_SIGNAL(src, COMSIG_ADD_MOOD_EVENT, "pain", /datum/mood_event/paingood)
	else if(traumatic_shock >= PAIN_HALVE_MOVE)
		SEND_SIGNAL(src, COMSIG_ADD_MOOD_EVENT, "pain", /datum/mood_event/painbad)
	if(traumatic_shock >= (PAIN_HALVE_MOVE * (our_endurance/ATTRIBUTE_MIDDLING)))
		ADD_TRAIT(src, TRAIT_BASIC_SPEED_HALVED, SHOCK)
	else
		REMOVE_TRAIT(src, TRAIT_BASIC_SPEED_HALVED, SHOCK)

	if(traumatic_shock >= (PAIN_GIVES_IN * (our_endurance/ATTRIBUTE_MIDDLING)))
		if(buckled || (body_position == LYING_DOWN))
			Knockdown(4 SECONDS)
		else
			visible_message(PAIN_KNOCKDOWN_MESSAGE, \
						PAIN_KNOCKDOWN_MESSAGE_SELF, \
						visible_message_flags = EMOTE_MESSAGE)
			//Blood on screen
			flash_pain(100)
			//Scream
			death_scream()
			//Immobilize for a second
			Immobilize(1 SECONDS)
			//After immobilize runs out, fall down
			addtimer(CALLBACK(src, .proc/Knockdown, 4 SECONDS), 1 SECONDS)

	var/maxbpshock = 0
	var/obj/item/bodypart/damaged_bodypart
	for(var/obj/item/bodypart/bodypart as anything in bodyparts)
		var/bpshock = bodypart.get_shock(FALSE, TRUE)
		// make the choice of the organ depend on damage,
		// but also sometimes use one of the less damaged ones
		if((bpshock >= maxbpshock) && ((maxbpshock <= 0) || prob(70)) )
			damaged_bodypart = bodypart
			maxbpshock = bpshock

	if(damaged_bodypart && (get_chem_effect(CE_PAINKILLER) < maxbpshock))
		if(damaged_bodypart.held_index)
			if((maxbpshock >= 15) && prob(maxbpshock))
				var/obj/item/droppy = get_item_for_held_index(damaged_bodypart.held_index)
				if(droppy)
					dropItemToGround(droppy)
		else if((maxbpshock >= 15) && prob(maxbpshock))
			var/obj/item/bodypart/child
			for(var/child_zone in damaged_bodypart.children_zones)
				child = get_bodypart(child_zone)
				if(!child?.held_index)
					continue
				var/obj/item/droppy = get_item_for_held_index(child.held_index)
				if(droppy)
					dropItemToGround(droppy)
		var/burning = (damaged_bodypart.burn_dam >= damaged_bodypart.brute_dam)
		var/message
		switch(CEILING(maxbpshock, 1))
			if(1 to 10)
				message = "My [damaged_bodypart.name] [burning ? "burns" : "hurts"]."
			if(11 to 90)
				message = "My [damaged_bodypart.name] [burning ? "burns" : "hurts"] badly!"
			if(91 to INFINITY)
				message = "[pick("WHAT A PAIN!", "OH GOD!", "OH LORD!")]! My [damaged_bodypart.name] [damaged_bodypart.p_are()] [burning ? "on fire" : "hurting terribly"]!"
		custom_pain(message, maxbpshock, TRUE, damaged_bodypart, TRUE)

	// Damage to internal organs hurts a lot.
	for(var/obj/item/organ/organ as anything in internal_organs)
		if(DT_PROB(1, delta_time) && organ.can_feel_pain() && (organ.get_shock() >= 5))
			var/obj/item/bodypart/parent = get_bodypart(organ.current_zone)
			if(parent)
				var/pain = 10
				var/message = "I feel a dull pain in my [parent.name]."
				if(organ.is_failing())
					pain = 40
					message = "I feel a sharp pain in my [parent.name]!"
				else if(organ.damage >= organ.low_threshold)
					pain = 25
					message = "I feel a pain in my [parent.name]."
				else
					pain = 10
					message = "I feel a dull pain in my [parent.name]."
				custom_pain(message, pain, FALSE, parent)

	if(traumatic_shock >= PAIN_SHOCK_PENALTY)
		var/penalty = min(SHOCK_PENALTY_CAP, FLOOR(traumatic_shock/(our_endurance*2), 1))
		if(penalty)
			var/probability = CEILING(min(60, traumatic_shock/(2 * (our_endurance/ATTRIBUTE_MIDDLING))), 1)
			if(DT_PROB(probability/2, delta_time))
				update_shock_penalty(penalty)

	var/general_damage_message = null
	var/general_message_prob = 1
	var/general_damage = getToxLoss() + getCloneLoss()
	switch(CEILING(general_damage, 1))
		if(1 to 5)
			general_message_prob = 0.5
			general_damage_message = "My body stings slightly."
		if(5 to 10)
			general_message_prob = 1
			general_damage_message = "My body hurts a little."
		if(10 to 20)
			general_message_prob = 1
			general_damage_message = "My whole body hurts."
		if(20 to 30)
			general_message_prob = 2
			general_damage_message = "My whole body hurts badly."
		if(30 to INFINITY)
			general_message_prob = 3
			general_damage_message = "My whole body aches, it's driving me mad!"

	if(general_damage_message && DT_PROB(general_message_prob, delta_time))
		custom_pain(general_damage_message, general_damage)

/mob/living/carbon/handle_shock_stage(delta_time, times_fired)
	. = ..()
	if(!can_feel_pain())
		setShockStage(0)
		remove_movespeed_modifier(/datum/movespeed_modifier/shock_stage, FALSE)
		remove_movespeed_modifier(/datum/movespeed_modifier/cardiac_arrest, TRUE)
		hud_used?.update_chromatic_aberration(intensity = 0)
		return

	var/previous_shock_stage = shock_stage
	var/our_endurance = max(1, GET_MOB_ATTRIBUTE_VALUE(src, STAT_ENDURANCE))

	//Cardiac arrest automatically throws us into sofcrit territory
	if(undergoing_cardiac_arrest())
		setShockStage(max(shock_stage, SHOCK_STAGE_4))
		add_movespeed_modifier(/datum/movespeed_modifier/cardiac_arrest, TRUE)
	else
		remove_movespeed_modifier(/datum/movespeed_modifier/cardiac_arrest, TRUE)

	if(traumatic_shock >= max(SHOCK_STAGE_2, 0.8 * shock_stage))
		adjustShockStage(0.5 * delta_time * (ATTRIBUTE_MIDDLING/our_endurance))
	else if(!undergoing_cardiac_arrest())
		setShockStage(min(shock_stage, SHOCK_STAGE_7))
		var/recovery = 0.5 * delta_time
		//Lower shock faster the less pain we feel
		if(traumatic_shock < 0.5 * shock_stage)
			recovery += 0.5 * delta_time
		if(traumatic_shock < 0.25 * shock_stage)
			recovery += 0.5 * delta_time
		adjustShockStage(-recovery * (our_endurance/ATTRIBUTE_MIDDLING))

	//Shock makes us slow
	if(shock_stage >= (SHOCK_STAGE_2 * (our_endurance/ATTRIBUTE_MIDDLING)))
		add_movespeed_modifier(/datum/movespeed_modifier/shock_stage, TRUE)
	else
		remove_movespeed_modifier(/datum/movespeed_modifier/shock_stage, TRUE)

	if((stat >= UNCONSCIOUS) || (shock_stage <= 0))
		return

	if((shock_stage >= SHOCK_STAGE_1) && (previous_shock_stage < SHOCK_STAGE_1))
		/** Please be very careful when calling custom_pain() from within code that relies on pain/trauma values. There's the
		 * possibility of a feedback loop from custom_pain() being called with a positive power, incrementing pain on a limb,
		 * which triggers this proc, which calls custom_pain(), etc. Make sure you call it with nopainloss = TRUE in these cases!
		 */
		custom_pain("[pick("It hurts so much", "I really need some painkillers", "Ooh, the pain")]!", 10, nopainloss = TRUE)

	if((shock_stage >= SHOCK_STAGE_2) && (previous_shock_stage < SHOCK_STAGE_2))
		visible_message("is having trouble keeping [p_their()] eyes open.", visible_message_flags = EMOTE_MESSAGE)
		//Attempt to inject combat cocktail for the first time
		endorphinate()

	if((shock_stage >= SHOCK_STAGE_2) && (previous_shock_stage >= SHOCK_STAGE_2))
		if(DT_PROB(18, delta_time))
//			blur_eyes(rand(1, 2))
			stuttering = max(stuttering, 5)

	if((shock_stage >= SHOCK_STAGE_3) && (previous_shock_stage < SHOCK_STAGE_3))
		custom_pain("[pick("The pain is excruciating", "Please, just end the pain", "My whole body is going numb")]!", 40, nopainloss = TRUE)

	if((shock_stage >= SHOCK_STAGE_4) && (previous_shock_stage < SHOCK_STAGE_4))
		visible_message("becomes limp.", visible_message_flags = EMOTE_MESSAGE)
		Immobilize(rand(2, 5) SECONDS)
		//Attempt to inject combat cocktail a second time
		endorphinate()

	if((shock_stage >= SHOCK_STAGE_4) && (previous_shock_stage >= SHOCK_STAGE_4))
		if(DT_PROB(1, delta_time))
			custom_pain("[pick("The pain is excruciating", "Please, just end the pain", "My whole body is going numb")]!", shock_stage, nopainloss = TRUE)
			Knockdown(20 SECONDS)
		if(DT_PROB(1, delta_time) && (getFatigueLoss() < 50))
			setFatigueLoss(50)
		if(DT_PROB(2, delta_time))
			agony_gasp()

	if((shock_stage >= SHOCK_STAGE_5) && (previous_shock_stage >= SHOCK_STAGE_5))
		if(DT_PROB(2.5, delta_time))
			custom_pain("[pick("The pain is excruciating", "Please, just end the pain", "My whole body is going numb")]!", shock_stage, nopainloss = TRUE)
			Paralyze(40 SECONDS)

	if((shock_stage >= SHOCK_STAGE_6) && (previous_shock_stage >= SHOCK_STAGE_6))
		if(DT_PROB(1, delta_time))
			if(!IsUnconscious())
				custom_pain("[pick("I black out", "I feel like i could die at any moment now", "I'm about to lose consciousness")]!", shock_stage, nopainloss = TRUE)
			Unconscious(10 SECONDS)
		if(DT_PROB(1, delta_time) && (getFatigueLoss() < 85))
			setFatigueLoss(85)

	if((shock_stage >= SHOCK_STAGE_7) && (previous_shock_stage < SHOCK_STAGE_7))
		if(body_position != LYING_DOWN)
			visible_message("can no longer stand, collapsing!", visible_message_flags = EMOTE_MESSAGE)
		adjustStaminaLoss(150)
		adjustFatigueLoss(80)
		agony_gargle()
		Paralyze(40 SECONDS)
		//Attempt to inject combat cocktail, even though at this point it won't help much
		endorphinate()

	if((shock_stage >= SHOCK_STAGE_7) && (previous_shock_stage >= SHOCK_STAGE_7))
		Paralyze(40 SECONDS)
		if(DT_PROB(1, delta_time))
			Unconscious(10 SECONDS)
		if(DT_PROB(4, delta_time))
			agony_gargle()

	if((shock_stage >= SHOCK_STAGE_8) && (previous_shock_stage < SHOCK_STAGE_8))
		//Attempt to inject combat cocktail - ONE FINAL TIME
		endorphinate()
		//Death is near...
		death_scream()
		Unconscious(20 SECONDS)

	if((shock_stage >= SHOCK_STAGE_8) && (previous_shock_stage >= SHOCK_STAGE_8))
		//How the fuck are we still alive?
		if(!IsUnconscious())
			visible_message(PAIN_KNOCKOUT_MESSAGE, visible_message_flags = EMOTE_MESSAGE)
			custom_pain(PAIN_KNOCKOUT_MESSAGE_SELF, 100, nopainloss = TRUE)
			death_rattle()
		Unconscious(20 SECONDS)

/**
 * Adds pain onto a limb while giving the player a message styled depending on the powerf of the pain added.
 *
 * Arguments:
 * * Message is the custom message to be displayed
 * * Power decides how much painkillers will stop the message, as well as how much pain it causes
 * * Forced means it ignores anti-spam timer
 */
/mob/living/carbon/custom_pain(message, power, forced, obj/item/bodypart/affecting, nopainloss = FALSE)
	if((stat >= UNCONSCIOUS) || !can_feel_pain() || (world.time < next_pain_time))
		return FALSE

	if(affecting && !affecting.can_feel_pain())
		return FALSE

	// Take the edge off
	power -= get_chem_effect(CE_PAINKILLER)
	if(power <= 0)
		return FALSE

	// Share the pain
	if(!nopainloss && power)
		if(affecting)
			affecting.add_pain(CEILING(power, 1))
		else
			adjustPainLoss(CEILING(power, 1))

	// Anti message spam checks
	if(forced || (message != last_pain_message) || (world.time >= next_pain_message_time))
		last_pain_message = message
		if(world.time >= next_pain_message_time)
			to_chat(src, span_animatedpain("[message]"))

		var/force_emote
		if(ishuman(src))
			var/mob/living/carbon/human/human_src = src
			if(human_src.dna?.species)
				force_emote = human_src.dna.species.get_pain_emote(power)
		if(force_emote && prob(power))
			emote(force_emote)

	// Briefly flash the pain overlay
	flash_pain(power)
	next_pain_time = world.time + (rand(100, 150) + power)
	next_pain_message_time = world.time + (200 + power)
	return TRUE

/mob/living/carbon/check_self_for_injuries(detailed = FALSE)
	if(stat < UNCONSCIOUS)
		visible_message(span_notice("<b>[src]</b> examines [p_themselves()]."), \
						span_notice("<b>I check myself.</b>"))

	var/list/return_text = list("<span class='infoplain'><div class='infobox'>")
	return_text += span_notice("<EM>Let's see how I am doing.</EM>")
	if(stat < DEAD)
		return_text += span_notice("\nI am still alive[stat < UNCONSCIOUS ? "" : ", but i am [HAS_TRAIT(src, TRAIT_TRYINGTOSLEEP) ? "sleeping" :"unconscious"]"].")
	else
		return_text += span_dead("\nI am dead.")
	for(var/X in ALL_BODYPARTS_CHECKSELF)
		var/obj/item/bodypart/LB = get_bodypart(X)

		if(!LB)
			return_text += span_info("\n• [capitalize(parse_zone(X))]: <span class='dead'><b>MISSING</b></span>")
			continue

		if(LB.is_stump())
			return_text += span_info("\n• [capitalize(parse_zone(X))]: <span class='dead'><b>STUMP</b></span>")
			continue

		var/limb_max_damage = LB.max_damage
		var/limb_max_pain = min(100, LB.max_pain_damage)
		var/list/status = list()
		var/brutedamage = LB.brute_dam
		var/burndamage = LB.burn_dam
		var/paindamage = LB.get_shock(TRUE, TRUE)
		if(hallucination)
			if(prob(30))
				brutedamage += rand(30,40)
			if(prob(30))
				burndamage += rand(30,40)
			if(prob(30))
				paindamage += rand(30,40)

		if(HAS_TRAIT(src, TRAIT_SELF_AWARE))
			if(brutedamage)
				status += "<span class='[brutedamage >= 5 ? "danger" : "notice"]'>[brutedamage] BRUTE</span>"
			if(burndamage)
				status += "<span class='[burndamage >= 5 ? "danger" : "notice"]'>[burndamage] BURN</span>"
			if(paindamage)
				status += "<span class='[paindamage >= 10 ? "danger" : "notice"]'>[paindamage] PAIN</span>"
		else
			if(brutedamage >= (limb_max_damage*0.75))
				status += span_userdanger("<b>[uppertext(LB.heavy_brute_msg)]</b>")
			else if(brutedamage >= (limb_max_damage*0.5))
				status += span_userdanger("[uppertext(LB.heavy_brute_msg)]")
			else if(brutedamage >= (limb_max_damage*0.25))
				status += span_danger("[uppertext(LB.medium_brute_msg)]")
			else if(brutedamage > 0)
				status += span_warning("[uppertext(LB.light_brute_msg)]")

			if(burndamage >= (limb_max_damage*0.75))
				status += span_userdanger("<b>[uppertext(LB.heavy_burn_msg)]</b>")
			else if(burndamage >= (limb_max_damage*0.5))
				status += span_userdanger("[uppertext(LB.heavy_burn_msg)]")
			else if(burndamage >= (limb_max_damage*0.25))
				status += span_danger("[uppertext(LB.medium_burn_msg)]")
			else if(burndamage > 0)
				status += span_warning("[uppertext(LB.light_burn_msg)]")

			if(paindamage >= (limb_max_pain*0.75))
				status += span_userdanger("<b>[uppertext(LB.heavy_pain_msg)]</b>")
			else if(paindamage >= (limb_max_pain*0.5))
				status += span_danger("<b>[uppertext(LB.heavy_pain_msg)]</b>")
			else if(paindamage >= (limb_max_pain*0.25))
				status += span_lowpain("[uppertext(LB.medium_pain_msg)]")
			else if(paindamage > 0)
				status += span_lowestpain("[lowertext(LB.light_pain_msg)]")

		for(var/thing in LB.wounds)
			var/datum/wound/hurted = thing
			var/woundmsg
			woundmsg = "[uppertext(hurted.name)]"
			switch(hurted.severity)
				if(WOUND_SEVERITY_TRIVIAL)
					status += span_warning("[woundmsg]")
				if(WOUND_SEVERITY_MODERATE)
					status += span_warning("[woundmsg]")
				if(WOUND_SEVERITY_SEVERE)
					status += span_danger("<b>[woundmsg]</b>")
				if(WOUND_SEVERITY_CRITICAL)
					status += span_userdanger("<b>[woundmsg]</b>")
			if(hurted.show_wound_topic(src))
				status = "<a href='?src=[REF(hurted)];'>[woundmsg]</a>"

		if(LB.embedded_objects)
			for(var/obj/item/I in LB.embedded_objects)
				status += span_warning("<a href='?src=[REF(src)];embedded_object=[REF(I)];embedded_limb=[REF(LB)]'><b>[I.isEmbedHarmless() ? "STUCK" : "EMBEDDED"] [uppertext(I.name)]</b></a>")

		if(LB.get_bleed_rate())
			if(LB.get_bleed_rate() >= 3) //Totally arbitrary value
				status += span_danger("<b>BLEEDING</b>")
			else
				status += span_danger("BLEEDING")

		if(LB.bodypart_disabled)
			status += span_danger("<b>DISABLED</b>")

		if(LB.body_zone == BODY_ZONE_PRECISE_MOUTH)
			var/obj/item/bodypart/mouth/jaw = LB
			if(jaw.tapered)
				if(!wear_mask)
					status += span_warning("<a href='?src=[REF(jaw)];tape=[jaw.tapered];'>TAPED</a>")

		if(LB.current_gauze)
			status += span_info("<a href='?src=[REF(LB)];gauze=1;'><b>GAUZED</b></a>")

		if(LB.current_splint)
			status += span_info("<a href='?src=[REF(LB)];splint=1;'><b>SPLINTED</b></a>")

		if(!length(status))
			status += span_nicegreen("<b>OK</b>")

		return_text += span_info("\n• [capitalize(LB.name)]: <span class='info'>[jointext(status, " | ")]")
	return_text += "</div></span>" //div infobox
	to_chat(src, jointext(return_text, ""))
	return TRUE

/mob/living/carbon/proc/print_pain(detailed = FALSE)
	return check_self_for_injuries(detailed)

/mob/living/carbon/proc/InShock()
	return (shock_stage >= SHOCK_STAGE_4)

/mob/living/carbon/proc/InFullShock()
	return (shock_stage >= SHOCK_STAGE_6)

/mob/living/carbon/proc/get_painable_bodyparts(status)
	var/list/obj/item/bodypart/parts = list()
	for(var/X in bodyparts)
		var/obj/item/bodypart/BP = X
		if(status && (BP.status != status))
			continue
		if(BP.pain_dam < BP.max_pain_damage)
			parts += BP
	return parts

/mob/living/carbon/proc/get_pained_bodyparts(status)
	var/list/obj/item/bodypart/parts = list()
	for(var/X in bodyparts)
		var/obj/item/bodypart/BP = X
		if(status && (BP.status != status))
			continue
		if(BP.pain_dam)
			parts += BP
	return parts

/mob/living/carbon/proc/endorphinate(forced = FALSE, silent = FALSE, local_sound = TRUE, flash = TRUE, special_sound)
	var/endurance = GET_MOB_ATTRIBUTE_VALUE(src, STAT_ENDURANCE)
	if(!forced && (TIMER_COOLDOWN_CHECK(src, COOLDOWN_CARBON_ENDORPHINATION) || (diceroll(endurance, context = DICE_CONTEXT_MENTAL) <= DICE_FAILURE)))
		return

	var/endorphin_amount = clamp(endurance, 5, 29)
	reagents?.add_reagent(/datum/reagent/medicine/endorphin, endorphin_amount)
	TIMER_COOLDOWN_START(src, COOLDOWN_CARBON_ENDORPHINATION, ENDORPHINATION_COOLDOWN_DURATION)
	if(!silent)
		var/final_sound = special_sound || 'modular_septic/sound/heart/combatcocktail.ogg'
		if(local_sound)
			playsound_local(src, final_sound, 80, FALSE)
		else
			playsound(src, final_sound, 80, FALSE)
	if(!flash)
		return
	flash_pain_endorphine()

//Hacker shit
/mob/living/carbon/proc/neural_entanglement()
	var/obj/item/bodypart/head/head = get_bodypart(BODY_ZONE_HEAD)
	var/exploodie_sounds = list(
		'modular_septic/sound/gore/hacker_head1.ogg',
		'modular_septic/sound/gore/hacker_head2.ogg',
	)
	playsound(src, exploodie_sounds, 100, FALSE, 2)
	head.dismember(destroy = TRUE, wounding_type = WOUND_PIERCE)

#define cap_for sleep

//////////////////////////////////////////////////////////////////////
// https://www.youtube.com/watch?v=Hoz9l4l8LYw&ab_channel=FamilyGuy //
//////////////////////////////////////////////////////////////////////

/mob/living/carbon/proc/sexual_vomit(amount_of_sex = 6, rapid = FALSE)
	var/YES_PLEASE = 0.2 SECONDS
	var/sex_time = YES_PLEASE // yes please
	if(rapid)
		sex_time = 0.1 //rapid
		YES_PLEASE = 0.1
	var/static/list/fuck = list("OAHUHUHHHHH?", "OHHHUHHHHHHHHH!!!", "AHHHHHH OHHH AHH!!", "FUUCK...AHUHHH!!", "OHHHHHHHH!", "AH~", "AAAAAAAAAAAAAAAAAAAAAAAHHHHHH!!!", "NOOOO!!!!!", "OH MY GOODNESS GRACIOUS")
	vomit(stun = TRUE, vomit_type = VOMIT_PURPLE, purge_ratio = 1, force = TRUE)
	to_chat(src, span_boldwarning("ooOUHUHHH FUUUCCKK!"))
	flash_pain(100)
	for(var/projectile_vomit = 0 to amount_of_sex)
		cap_for(sex_time) //cap
		if(prob(35))
			emote(act = "cry", intentional = FALSE) //cry
		else
			emote(act = "deathscream", intentional = FALSE) //scream
		vomit(stun = TRUE, vomit_type = VOMIT_PURPLE, purge_ratio = 1, force = TRUE) //vomit
		flash_pain(85)
		to_chat(src, span_boldwarning("[pick(fuck)]"))
		sex_time += YES_PLEASE // at the same time too
		if(sex_time > 10.2)
			sex_time = YES_PLEASE

#undef cap_for
