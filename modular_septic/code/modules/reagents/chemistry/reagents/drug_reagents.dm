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
	var/chun = pick("BIG CHUNGUUSUSSSSSSSSS!!!!!!!!", "IS HE REAL?!?!?!?!?! BIG CHUNGUS?!?!?", "BIG CHUNGUS I LOVE YOU I LOVE YOUUU!!!", "CHUNGUS THE BIG, FANTASTIC!!!!!!!!!! OH FUCK!!!")
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