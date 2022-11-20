#define OWNER 0
#define STRANGER 1

/datum/brain_trauma/severe/earfuck
	name = "Earfuck Brain Transfer"
	desc = "There is a neuro tripmine that has detonated in the patient's brain, causing a new conciousness to remotely control it."
	scan_desc = "complete lobe separation"
	gain_text = "<span class='boldwarning'>My mind is violated in every way It's possible to be violated.</span>"
	lose_text = "<span class='boldnotice'>My mind feels like It only has one occupant again.</span>"
	var/current_controller = OWNER
	var/initialized = FALSE //to prevent personalities deleting themselves while we wait for ghosts
	var/control = 100 // the amount of control they have over the body, starts full
	var/total_control = FALSE //used for debug
	var/old_left_eye_color = "#000000"
	var/old_right_eye_color = "#000000"
	var/mob/living/carbon/original_stranger
	var/mob/living/earfuck/stranger_backseat //there's two so they can swap without overwriting
	var/mob/living/earfuck/owner_backseat

/datum/brain_trauma/severe/earfuck/on_gain()
	var/mob/living/living_owner = owner
	if((living_owner.stat == DEAD) || !living_owner.client) //No use assigning people to a corpse or braindead
		qdel(src)
		return
	make_backseats()
	return ..()

/datum/brain_trauma/severe/earfuck/proc/make_backseats()
	stranger_backseat = new(owner, src)
	owner_backseat = new(owner, src)

/datum/brain_trauma/severe/earfuck/on_life(delta_time, times_fired)
	//If they're dead, make sure that the intruder gets ghosted.
	if(owner.stat == DEAD)
		// and make it so they automatically switch back to their initial body after the possession is done
		if(current_controller != OWNER)
			switch_minds(FALSE)
		if(!original_stranger)
			stranger_backseat.ghostize(FALSE)
			qdel(src)
			return
		else if(original_stranger.stat == DEAD)
			switch_minds(FALSE, TRUE, 75, FALSE) //Hopefully gives them a seizure and kills them
			qdel(src)
			return
	if(owner_backseat.ckey == stranger_backseat.ckey)
		owner.emote("agonyscream")
		owner.flash_pain(100)
		to_chat(owner, span_bigdanger("NEURAL ENTANGLEMENT!"))
		playsound(owner, 'modular_septic/sound/efn/hacker_fucked.ogg', 90, FALSE)
		addtimer(CALLBACK(owner, /mob/living/carbon.proc/neural_entanglement), 1.67 SECONDS)
		return
	if(control <= 0)
		if(!(original_stranger.key || original_stranger.mind))
			switch_minds(TRUE)
			qdel(src)
		switch_minds(FALSE)
		owner.vomit(10, blood = FALSE, stun = TRUE, vomit_type = VOMIT_PURPLE, purge_ratio = 1)
		switch_minds(FALSE, TRUE, rand(3, 12), FALSE)
		qdel(src)
		return
	if(!total_control)
		sap_control(sap_chance = 16, sap_amount = rand(10, 20))
	return ..()

/datum/brain_trauma/severe/earfuck/proc/set_eyecolors(color)
	if(!color)
		return
	var/mob/living/carbon/human/human_owner = owner
	if(current_controller == STRANGER)
		old_right_eye_color = human_owner.right_eye_color
		old_left_eye_color = human_owner.left_eye_color
		human_owner.right_eye_color = color
		human_owner.left_eye_color = color
	else
		human_owner.right_eye_color = old_right_eye_color
		human_owner.left_eye_color = old_left_eye_color
	human_owner.update_body()

/datum/brain_trauma/severe/earfuck/proc/sap_control(sap_chance = 16, sap_amount = 10)
	if(!prob(sap_chance))
		return
	control -= sap_amount
	var/rounded_control = round(control/10, 1)
	if(owner)
		if(control <= 0)
			to_chat(owner, span_bigdanger("[fail_msg()]... I have lost control."))
		else
			to_chat(owner, span_warning("I am losing control. \n<b>\[[chat_progress_characters(rounded_control, 10)]\]</b>."))
		playsound(owner, 'modular_septic/sound/efn/earfuck_losecontrol.ogg', 20, TRUE)
	if(owner_backseat)
		if(control <= 0)
			to_chat(owner_backseat, span_bigdanger("Their control is destroyed.\n<b>\[[chat_progress_characters(rounded_control, 10)]\]</b>"))
		else
			to_chat(owner_backseat, span_boldwarning("I make progress.\n<b>\[[chat_progress_characters(rounded_control, 10)]\]</b>"))

/datum/brain_trauma/severe/earfuck/on_lose()
	if(current_controller != OWNER) //it would be funny to cure a guy only to be left with the other personality, but it seems too cruel
		to_chat(owner, span_boldwarning("The intruder is forcibly removed!"))
		switch_minds(TRUE)
		owner.vomit(10, blood = TRUE, stun = TRUE, vomit_type = VOMIT_PURPLE, purge_ratio = 1)
	QDEL_NULL(stranger_backseat)
	QDEL_NULL(owner_backseat)
	return ..()

/datum/brain_trauma/severe/earfuck/Destroy()
	if(stranger_backseat)
		QDEL_NULL(stranger_backseat)
	if(owner_backseat)
		QDEL_NULL(owner_backseat)
	return ..()

/datum/brain_trauma/severe/earfuck/proc/assign_earfucker(mob/living/earfucker)
	if(!earfucker)
		qdel(src)
		return
	stranger_backseat.ckey = earfucker.ckey
	to_chat(stranger_backseat, span_notice("I HAVE SUCCESSFULLY ENTERED THEIR MIND. I HAVE A MINUTE UNTIL THEY FIGHT BACK.\n\
								IF I DIE IN THIS BODY, I WON'T BE ABLE TO GET BACK TO MY OLD BODY!"))

/datum/brain_trauma/severe/earfuck/proc/switch_minds(reset_to_owner = FALSE, cancel_possession = FALSE, violence = 0, silent = FALSE)
	if(QDELETED(owner) || QDELETED(stranger_backseat) || QDELETED(owner_backseat))
		return

	var/mob/living/earfuck/current_backseat
	var/mob/living/earfuck/new_backseat
	if(current_controller == STRANGER || reset_to_owner)
		current_backseat = owner_backseat
		new_backseat = stranger_backseat
	else
		current_backseat = stranger_backseat
		new_backseat = owner_backseat

	to_chat(owner, span_userdanger("MY BODY HAS BEEN SEIZED!"))
	to_chat(current_backseat, span_userdanger("I seize this body."))
	if(!(silent && cancel_possession))
		playsound(owner, 'modular_septic/sound/efn/earfuck_laugh.ogg', 65, FALSE, 2)
		current_backseat.playsound_local(owner.loc, 'modular_septic/sound/efn/earfuck_switch.ogg', 70, FALSE)
		owner.emote("custom", message = "makes otherwordly noises as [owner.p_their()] head snaps and switches!")

	set_eyecolors(color = "#E10600")

	//Body to backseat

	var/h2b_id = owner.computer_id
	var/h2b_ip= owner.lastKnownIP
	owner.computer_id = null
	owner.lastKnownIP = null

	new_backseat.ckey = owner.ckey

	new_backseat.name = owner.name

	if(owner.mind)
		new_backseat.mind = owner.mind

	if(!new_backseat.computer_id)
		new_backseat.computer_id = h2b_id

	if(!new_backseat.lastKnownIP)
		new_backseat.lastKnownIP = h2b_ip

	if(reset_to_owner && new_backseat.mind)
		new_backseat.ghostize(FALSE)

	//Backseat to body

	var/s2h_id = current_backseat.computer_id
	var/s2h_ip= current_backseat.lastKnownIP
	current_backseat.computer_id = null
	current_backseat.lastKnownIP = null

	owner.ckey = current_backseat.ckey
	owner.mind = current_backseat.mind

	if(!owner.computer_id)
		owner.computer_id = s2h_id

	if(!owner.lastKnownIP)
		owner.lastKnownIP = s2h_ip

	current_controller = !current_controller

	if(cancel_possession)
		if(current_controller == STRANGER) // It shouldn't ever not be the stranger.
			original_stranger.ckey = owner.ckey
			original_stranger.mind = owner.mind

			owner.ckey = owner_backseat.ckey
			owner.mind = owner_backseat.mind

		if(!original_stranger || original_stranger.stat == DEAD)
			to_chat(stranger_backseat, span_bigdanger("My old body is unusable."))
			stranger_backseat.ghostize(FALSE)
			qdel(src)
			return

		if(current_controller == OWNER)
			original_stranger.ckey = stranger_backseat.ckey
			original_stranger.mind = stranger_backseat.mind

		owner.flash_screen_flash(60)
		original_stranger.flash_screen_flash(60)

		set_eyecolors(color = "#ffc813")

		var/end_possession_noise = pick('modular_septic/sound/efn/possession/p_shake1.ogg', 'modular_septic/sound/efn/possession/p_shake2.ogg', 'modular_septic/sound/efn/possession/p_shake3.ogg') // The possession shaker
		var/bad_message = "shakes their head, their eyes blinking rapidly."
		switch(violence)
			if(11 to 20)
				bad_message = "shakes their head violently while clenching their teeth!"
				original_stranger.HeadRape(4 SECONDS)
			if(21 to 50)
				bad_message = "shudders, wincing in pain!"
				original_stranger.emote("deathscream")
				var/bangs = pick("bangs", "sears", "swirls")
				to_chat(original_stranger, span_boldwarning("My head [bangs] in agony!"))
				original_stranger.flash_pain(50)
				original_stranger.HeadRape(6 SECONDS)
			if(51 to 75) //Anything above 50 should only happen due to enemy hackers
				var/rapid_hangover = pick("DYING", "SEIZING", "FRANTICALLY GASPING", "PERISHING")
				bad_message = "falls down to the floor and starts <b>FUCKING [rapid_hangover]!</b>"
				original_stranger.emote(act = "agonyscream", intentional = FALSE)
				INVOKE_ASYNC(original_stranger, /mob/living/carbon.proc/sexual_vomit) // Don't ask
			if(76 to INFINITY)
				original_stranger.emote("agonyscream", intentional = FALSE)
				original_stranger.flash_pain(100)
				to_chat(original_stranger, span_bigdanger("NEURAL DEGRADATION!"))
				playsound(original_stranger, 'modular_septic/sound/efn/hacker_fucked.ogg', 90, FALSE)
				addtimer(CALLBACK(original_stranger, /mob/living/carbon.proc/neural_entanglement), 1.67 SECONDS)
				return
		if(violence > 0)
			if(!silent && (original_stranger.stat == CONSCIOUS) || (violence < 75))
				original_stranger.emote(act = "custom", message = bad_message)
			playsound(original_stranger, end_possession_noise, 65, FALSE)
		qdel(src)
		return

	set_eyecolors(color = "#E10600")

/mob/living/earfuck
	name = "earfuck victim"
	real_name = "original mind trapped in an synthetic fate."
	var/mob/living/carbon/body
	var/datum/brain_trauma/severe/earfuck/earfuck

/mob/living/earfuck/Initialize(mapload, earfuck_trauma)
	if(iscarbon(loc))
		body = loc
		name = body.real_name
		real_name = body.real_name
		if(earfuck_trauma)
			earfuck = earfuck_trauma
	return ..()

/mob/living/earfuck/Life(delta_time = SSMOBS_DT, times_fired)
	apply_status_effect(/datum/status_effect/earfuck_hud)
	if(QDELETED(body))
		qdel(src) //in case trauma deletion doesn't already do it
		return

	if((body.stat == DEAD && earfuck.owner_backseat == src))
		earfuck.switch_minds()
		qdel(earfuck)
		return

	//if one of the two ghosts, they switch back
	if(!body.client && earfuck.initialized)
		earfuck.switch_minds(FALSE, TRUE, 5, FALSE)
		qdel(earfuck)
		return

	return ..()

/mob/living/earfuck/Login()
	. = ..()
	if(!. || !client)
		return FALSE
	to_chat(src, span_boldwarning("I'm regaining my conciousness back from this wretched intruder, everything is unavailable to me, I just have to keep fighting idly until I'm back in my rightful place."))

/mob/living/earfuck/Exited(atom/movable/gone, direction)
	. = ..()
	if((loc != body) || QDELETED(body))
		qdel(src)

/mob/living/earfuck/say(message, bubble_type, list/spans = list(), sanitize = TRUE, datum/language/language = null, ignore_spam = FALSE, forced = null, filterproof = null)
	to_chat(src, span_bolddanger("Something is controlling MY body, I can't speak using MY mouth."))
	return FALSE

/mob/living/earfuck/emote(act, m_type = null, message = null, intentional = FALSE, force_silence = FALSE)
	to_chat(src, span_bolddanger("Something is controlling MY body, I can't speak using MY mouth."))
	return FALSE

#undef OWNER
#undef STRANGER
