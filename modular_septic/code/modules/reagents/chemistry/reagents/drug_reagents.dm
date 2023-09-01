/datum/reagent/drug/lean
	name = "lean"
	description = "I LOVE LEAN."
	reagent_state = LIQUID
	taste_description = "purple"
	color = "#7E399090"
	overdose_threshold = 35
	metabolization_rate = 0.5 * REAGENTS_METABOLISM
	ph = 3
	addiction_types = list(/datum/addiction/maintenance_drugs = 20)

/datum/reagent/drug/lean/on_mob_life(mob/living/carbon/lean_monster, delta_time, times_fired)
	. = ..()
	lean_monster.adjustToxLoss(-1 * REM * delta_time)
	//Chance of Willador Afton
	if(DT_PROB(3, delta_time))
		INVOKE_ASYNC(src, .proc/handle_lean_monster_hallucinations, lean_monster)

/datum/reagent/drug/lean/on_mob_metabolize(mob/living/lean_monster, delta_time)
	. = ..()
	lean_monster.add_chem_effect(CE_ANTITOX, 10, "[type]")
	var/leanfeel = pick("Dope dick give your bitch withdrawals", "But envy may kill, still don't give a fuck how they feel", "Oh man, I been gettin' in my zone", "Invested in my fucking self I need a loan, I'm alone")
	if(DT_PROB(2.5, delta_time))
		to_chat(lean_monster, span_horny("[leanfeel]"))
	to_chat(lean_monster, span_horny(span_big("Lean... I LOVE LEAAAANNNNNNN!!!")))
	ADD_TRAIT(lean_monster, TRAIT_LEAN, "[type]")
	lean_monster.attributes?.add_attribute_modifier(/datum/attribute_modifier/lean, TRUE)
	to_chat(lean_monster, span_warning("I feel myself stronger, so nice!"))
	SEND_SIGNAL(lean_monster, COMSIG_ADD_MOOD_EVENT, "forbidden_sizzup", /datum/mood_event/lean, lean_monster)
	SSdroning.area_entered(get_area(lean_monster), lean_monster?.client)
	lean_monster.playsound_local(lean_monster, 'modular_septic/sound/insanity/leanlaugh.ogg', 50)

	if(!lean_monster.hud_used)
		return

	//Chance of Willador Afton
	if(prob(10))
		INVOKE_ASYNC(src, .proc/handle_lean_monster_hallucinations, lean_monster)

	var/atom/movable/screen/plane_master/rendering_plate/filter_plate = lean_monster.hud_used.plane_masters["[RENDER_PLANE_GAME]"]

	var/list/col_filter_full = list(1,0,0,0, 0,1.00,0,0, 0,0,1,0, 0,0,0,1, 0,0,0,0)
	var/list/col_filter_twothird = list(1,0,0,0, 0,0.68,0,0, 0,0,1,0, 0,0,0,1, 0,0,0,0)
	var/list/col_filter_half = list(1,0,0,0, 0,0.42,0,0, 0,0,1,0, 0,0,0,1, 0,0,0,0)
	var/list/col_filter_empty = list(1,0,0,0, 0,0,0,0, 0,0,1,0, 0,0,0,1, 0,0,0,0)

	filter_plate.add_filter("lean_filter", 100, color_matrix_filter(col_filter_twothird, FILTER_COLOR_HCY))

	animate(filter_plate.get_filter("lean_filter"), loop = -1, color = col_filter_full, time = 4 SECONDS, easing = CIRCULAR_EASING|EASE_IN, flags = ANIMATION_PARALLEL)
	animate(color = col_filter_twothird, time = 6 SECONDS, easing = LINEAR_EASING)
	animate(color = col_filter_half, time = 3 SECONDS, easing = LINEAR_EASING)
	animate(color = col_filter_empty, time = 2 SECONDS, easing = CIRCULAR_EASING|EASE_OUT)
	animate(color = col_filter_half, time = 24 SECONDS, easing = CIRCULAR_EASING|EASE_IN)
	animate(color = col_filter_twothird, time = 12 SECONDS, easing = LINEAR_EASING)

	filter_plate.add_filter("lean_blur", 101, list("type" = "radial_blur", "size" = 0))

	animate(filter_plate.get_filter("lean_blur"), loop = -1, size = 0.04, time = 2 SECONDS, easing = ELASTIC_EASING|EASE_OUT, flags = ANIMATION_PARALLEL)
	animate(size = 0, time = 6 SECONDS, easing = CIRCULAR_EASING|EASE_IN)

/datum/reagent/drug/lean/on_mob_end_metabolize(mob/living/lean_monster)
	. = ..()
	to_chat(lean_monster, span_love(span_big("NOOOO... I NEED MORE LEAN...")))
	lean_monster.remove_chem_effect(CE_ANTITOX, 10, "[type]")
	lean_monster.attributes?.remove_attribute_modifier(/datum/attribute_modifier/lean, TRUE)
	to_chat(lean_monster, span_warning("I feel myself weaker, so bad!"))
	if(!lean_monster.hud_used)
		return

	var/atom/movable/screen/plane_master/rendering_plate/filter_plate = lean_monster.hud_used.plane_masters["[RENDER_PLANE_GAME]"]
	lean_monster.playsound_local(lean_monster, 'modular_septic/sound/insanity/leanend.ogg', 50)
	lean_monster.flash_pain(30)

	filter_plate.remove_filter("lean_filter")
	filter_plate.remove_filter("lean_blur")
	REMOVE_TRAIT(lean_monster, TRAIT_LEAN, "[type]")
	SSdroning.play_area_sound(get_area(lean_monster), lean_monster?.client)

/datum/reagent/drug/lean/proc/handle_lean_monster_hallucinations(mob/living/lean_monster)
	if(!lean_monster)
		return
	var/purple_msg = pick("SAVE THEM!", "IT'S ME!", "I AM STILL HERE!", "I ALWAYS COME BACK!")
	var/turf/turfie
	var/list/turf/turfies = list()
	for(var/turf/torf in view(lean_monster))
		turfies += torf
	if(length(turfies))
		turfie = pick(turfies)
	if(!turfie)
		return
	var/image/purple_guy = image('modular_septic/icons/mob/lean.dmi', turfie, "ILOVELEAN", FLOAT_LAYER, get_dir(turfie, lean_monster))
	purple_guy.plane = GAME_PLANE_FOV_HIDDEN
	purple_guy.layer = lean_monster.layer + 10
	lean_monster.client?.images += purple_guy
	to_chat(lean_monster, span_purple(span_big("[purple_msg]")))
	sleep(0.5 SECONDS)
	var/hallsound = 'modular_septic/sound/insanity/purpleappear.ogg'
	var/catchsound = 'modular_septic/sound/insanity/purplecatch.ogg'
	lean_monster.playsound_local(get_turf(lean_monster), hallsound, 100, 0)
	var/chase_tiles = 7
	var/chase_wait_per_tile = rand(4,6)
	var/caught_monster = FALSE
	while(chase_tiles > 0)
		turfie = get_step(turfie, get_dir(turfie, lean_monster))
		if(turfie)
			purple_guy.loc = turfie
			if(turfie == get_turf(lean_monster))
				caught_monster = TRUE
				sleep(chase_wait_per_tile)
				break
		chase_tiles--
		sleep(chase_wait_per_tile)
	lean_monster.client?.images -= purple_guy
	if(!QDELETED(purple_guy))
		qdel(purple_guy)
	if(caught_monster)
		lean_monster.playsound_local(lean_monster, catchsound, 100)
		lean_monster.Paralyze(rand(2, 5) SECONDS)
		var/pain_msg = pick("NO!", "HE GOT ME!", "AGH!")
		to_chat(lean_monster, span_userdanger("<b>[pain_msg]</b>"))
		lean_monster.flash_pain_mental(100)

/datum/reagent/drug/carbonylmethamphetamine
	name = "carbonylmethamphetamine"
	description = "finally some good fucking drugs."
	reagent_state = LIQUID
	taste_description = "grape"
	color = "#D3D3D390"
	overdose_threshold = 40
	metabolization_rate = 0.3 * REAGENTS_METABOLISM
	ph = 3

/datum/reagent/drug/carbonylmethamphetamine/on_mob_metabolize(mob/living/crack_addict)
	. = ..()
	crack_addict.crack_addict()
	crack_addict.attributes?.add_attribute_modifier(/datum/attribute_modifier/crack_addict, TRUE)
	crack_addict.playsound_local(crack_addict, 'modular_septic/sound/insanity/bass.ogg', 100)
	to_chat(crack_addict, span_achievementrare("My brain swells and my muscles become faster."))
	crack_addict.flash_pain_manic(100)
	var/client/C = crack_addict.client
	var/intensity = 12
	animate(C, pixel_y = (C.pixel_y + intensity), time = intensity/2)
	sleep(intensity/4)
	animate(C, pixel_y = (C.pixel_y - intensity), time = intensity/2)
	sleep(intensity/4)

/datum/reagent/drug/carbonylmethamphetamine/on_mob_end_metabolize(mob/living/crack_addict)
	. = ..()
	crack_addict.attributes?.remove_attribute_modifier(/datum/attribute_modifier/crack_addict, TRUE)

/datum/reagent/drug/kravsa
	name = "Kravsa"
	description = "cool."
	reagent_state = LIQUID
	taste_description = "interesting"
	color = "#8a001a80"
	overdose_threshold = 60
	metabolization_rate = 0.20 * REAGENTS_METABOLISM
	ph = 3

/datum/reagent/drug/kravsa/on_mob_metabolize(mob/living/crack_addict)
	. = ..()
//	crack_addict.crack_addict()
	crack_addict.attributes?.add_attribute_modifier(/datum/attribute_modifier/kravsa_addict, TRUE)
	to_chat(crack_addict, span_achievementrare("I'm getting stronger!"))

/datum/reagent/drug/kravsa/on_mob_end_metabolize(mob/living/crack_addict)
	. = ..()
	crack_addict.attributes?.remove_attribute_modifier(/datum/attribute_modifier/kravsa_addict, TRUE)

/datum/reagent/drug/chungusum
	name = "Chungusum"
	description = "cool."
	reagent_state = LIQUID
	taste_description = "interesting"
	color = "#ffffff80"
	overdose_threshold = 50
	metabolization_rate = 0.15 * REAGENTS_METABOLISM
	ph = 3

/datum/reagent/drug/chungusum/on_mob_metabolize(mob/living/crack_addict, delta_time)
	. = ..()
	var/chun = pick("BIG CHUNGUUSUSSSSSSSSS!!!!!!!!", "IS HE REAL?!?!?!?!?! BIG CHUNGUS?!?!?", "BIG CHUNGUS I LOVE YOU I LOVE YOUUU!!!", "CHUNGUS THE BIG, FANTASTIC!!!!!!!!!!", "OH FUCK!!!")
	if(DT_PROB(2.5, delta_time))
		to_chat(crack_addict, span_horny("[chun]"))
	crack_addict.overlay_fullscreen("chungus", /atom/movable/screen/fullscreen/chungus)
	ADD_TRAIT(crack_addict, TRAIT_CHUNG, "[type]")
	SSdroning.area_entered(get_area(crack_addict), crack_addict?.client)

/datum/reagent/drug/chungusum/on_mob_end_metabolize(mob/living/crack_addict)
	. = ..()
	crack_addict.clear_fullscreen("chungus")
	REMOVE_TRAIT(crack_addict, TRAIT_CHUNG, "[type]")
	SSdroning.play_area_sound(get_area(crack_addict), crack_addict?.client)

//aphrodisiac & anaphrodisiac

/datum/reagent/drug/aphrodisiac
	name = "Crocin"
	description = "Naturally found in the crocus and gardenia flowers, this drug acts as a natural and safe aphrodisiac."
	taste_description = "strawberries"
	color = "#FFADFF"//PINK, rgb(255, 173, 255)

/datum/reagent/drug/aphrodisiac/on_mob_life(mob/living/M)
	if((prob(min(current_cycle/2,5))))
		M.emote(pick("moan","blush"))
	if(prob(min(current_cycle/4,10)))
		var/aroused_message = pick("You feel frisky.", "You're having trouble suppressing your urges.", "You feel in the mood.")
		to_chat(M, "<span class='userlove'>[aroused_message]</span>")
	if(ishuman(M))
		var/mob/living/carbon/human/H = M
		var/list/genits = H.adjust_arousal(current_cycle, aphro = TRUE) // redundant but should still be here
		for(var/g in genits)
			var/obj/item/organ/genital/G = g
			to_chat(M, "<span class='userlove'>[G.arousal_verb]!</span>")
	..()

/datum/reagent/drug/aphrodisiacplus
	name = "Hexacrocin"
	description = "Chemically condensed form of basic crocin. This aphrodisiac is extremely powerful and addictive in most animals.\
					Addiction withdrawals can cause brain damage and shortness of breath. Overdosage can lead to brain damage and a \
					permanent increase in libido (commonly referred to as 'bimbofication')."
	taste_description = "liquid desire"
	color = "#FF2BFF"//dark pink
	addiction_types = list(/datum/addiction/maintenance_drugs = 20)

/datum/reagent/drug/aphrodisiacplus/on_mob_life(mob/living/M)
	if(prob(5))
		if(prob(current_cycle))
			M.say(pick("Hnnnnngghh...", "Ohh...", "Mmnnn..."))
		else
			M.emote(pick("moan","blush"))
	if(prob(5))
		var/aroused_message
		if(current_cycle>25)
			aroused_message = pick("You need to fuck someone!", "You're bursting with sexual tension!", "You can't get sex off your mind!")
		else
			aroused_message = pick("You feel a bit hot.", "You feel strong sexual urges.", "You feel in the mood.", "You're ready to go down on someone.")
		to_chat(M, "<span class='userlove'>[aroused_message]</span>")
		REMOVE_TRAIT(M,TRAIT_NEVERBONER,APHRO_TRAIT)
	if(ishuman(M))
		var/mob/living/carbon/human/H = M
		var/list/genits = H.adjust_arousal(100, aphro = TRUE) // redundant but should still be here
		for(var/g in genits)
			var/obj/item/organ/genital/G = g
			to_chat(M, "<span class='userlove'>[G.arousal_verb]!</span>")
	..()

/datum/reagent/drug/aphrodisiacplus/addiction_act_stage2(mob/living/M)
	if(prob(30))
		M.adjustBrainLoss(2)
	..()
/datum/reagent/drug/aphrodisiacplus/addiction_act_stage3(mob/living/M)
	if(prob(30))
		M.adjustBrainLoss(3)

		..()
/datum/reagent/drug/aphrodisiacplus/addiction_act_stage4(mob/living/M)
	if(prob(30))
		M.adjustBrainLoss(4)
	..()

/datum/reagent/drug/aphrodisiacplus/overdose_process(mob/living/M)
	if(prob(5) && ishuman(M) && M.has_dna())
		if(!HAS_TRAIT(M,TRAIT_PERMABONER))
			to_chat(M, "<span class='userlove'>Your libido is going haywire!</span>")
			ADD_TRAIT(M,TRAIT_PERMABONER,APHRO_TRAIT)
	..()

/datum/reagent/drug/anaphrodisiac
	name = "Camphor"
	description = "Naturally found in some species of evergreen trees, camphor is a waxy substance. When injested by most animals, it acts as an anaphrodisiac\
					, reducing libido and calming them. Non-habit forming and not addictive."
	taste_description = "dull bitterness"
	taste_mult = 2
	color = "#D9D9D9"//rgb(217, 217, 217)
	reagent_state = SOLID

/datum/reagent/drug/anaphrodisiac/on_mob_life(mob/living/M)
	if(prob(16))
		if(ishuman(M))
			var/mob/living/carbon/human/H = M
			var/list/genits = H.adjust_arousal(-100, aphro = TRUE)
			if(genits.len)
				to_chat(M, "<span class='notice'>You no longer feel aroused.")
	..()

/datum/reagent/drug/anaphrodisiacplus
	name = "Hexacamphor"
	description = "Chemically condensed camphor. Causes an extreme reduction in libido and a permanent one if overdosed. Non-addictive."
	taste_description = "tranquil celibacy"
	color = "#D9D9D9"//rgb(217, 217, 217)
	reagent_state = SOLID
	overdose_threshold = 20

/datum/reagent/drug/anaphrodisiacplus/on_mob_life(mob/living/M)
	if(M)
		REMOVE_TRAIT(M,TRAIT_PERMABONER,APHRO_TRAIT)
		if(ishuman(M))
			var/mob/living/carbon/human/H = M
			var/list/genits = H.adjust_arousal(-100, aphro = TRUE)
			if(genits.len)
				to_chat(M, "<span class='notice'>You no longer feel aroused.")

	..()

/datum/reagent/drug/anaphrodisiacplus/overdose_process(mob/living/M)
	if(M)
		to_chat(M, "<span class='userlove'>You feel like you'll never feel aroused again...</span>")
		ADD_TRAIT(M,TRAIT_NEVERBONER,APHRO_TRAIT)
	..()