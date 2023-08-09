/datum/disease/beesease
	name = "Beesease"
	form = "Infection"
	max_stages = 4
	spread_text = "On contact"
	spread_flags = DISEASE_SPREAD_BLOOD | DISEASE_SPREAD_CONTACT_SKIN | DISEASE_SPREAD_CONTACT_FLUIDS
	cure_text = "Sugar"
	cures = list(/datum/reagent/consumable/sugar)
	agent = "Apidae Infection"
	viable_mobtypes = list(/mob/living/carbon/human)
	desc = "If left untreated subject will regurgitate bees."
	severity = DISEASE_SEVERITY_MEDIUM
	infectable_biotypes = MOB_ORGANIC|MOB_UNDEAD //bees nesting in corpses

/datum/disease/beesease/stage_act(delta_time, times_fired)
	. = ..()
	if(!.)
		return

	switch(stage)
		if(2) //also changes say, see say.dm
			if(DT_PROB(1, delta_time))
				to_chat(affected_mob, span_notice("You taste honey in your mouth."))
		if(3)
			if(DT_PROB(5, delta_time))
				to_chat(affected_mob, span_notice("Your stomach rumbles."))
			if(DT_PROB(1, delta_time))
				to_chat(affected_mob, span_danger("Your stomach stings painfully."))
				if(prob(20))
					affected_mob.adjustToxLoss(2)
		if(4)
			if(DT_PROB(5, delta_time))
				affected_mob.visible_message(span_danger("[affected_mob] buzzes."), \
												span_userdanger("Your stomach buzzes violently!"))
			if(DT_PROB(2.5, delta_time))
				to_chat(affected_mob, span_danger("You feel something moving in your throat."))
			if(DT_PROB(0.5, delta_time))
				affected_mob.visible_message(span_danger("[affected_mob] coughs up a swarm of bees!"), \
													span_userdanger("You cough up a swarm of bees!"))
				new /mob/living/simple_animal/hostile/bee(affected_mob.loc)

/datum/disease/femboyza
	name = "Femboyza"
	form = "Infection"
	max_stages = 4
	spread_text = "On contact"
	spread_flags = DISEASE_SPREAD_BLOOD | DISEASE_SPREAD_CONTACT_SKIN | DISEASE_SPREAD_CONTACT_FLUIDS
	cure_text = "Gule berries"
	cures = list(/datum/reagent/drug/kravsa)
	agent = "Sexual revolution"
	viable_mobtypes = list(/mob/living/carbon/human)
	desc = "If left untreated subject will become a femboy."
	severity = DISEASE_SEVERITY_MEDIUM
	infectable_biotypes = MOB_ORGANIC

/datum/disease/femboyza/stage_act(delta_time, times_fired)
	. = ..()
	if(!.)
		return

	if(ishuman(affected_mob))
		var/mob/living/carbon/human/femboy = affected_mob
		if((femboy.gender = FEMALE) || (femboy.body_type = FEMALE))
			cure()
			return FALSE

		switch(stage)
			if(1 to 2)
				if(DT_PROB(1, delta_time))
					to_chat(femboy, span_notice("You feel that you getting more feminine..."))
			if(3)
				if(DT_PROB(5, delta_time))
					to_chat(femboy, span_notice("A little more and something will happen."))
			if(4)
				to_chat(femboy, span_danger("I AM FEMBOY!"))
				playsound(get_turf(femboy), "modular_pod/sound/eff/anime-wow-1.ogg", 100)
				new /obj/effect/temp_visual/heart(femboyyy.loc)
				femboy.gender = FEMALE
				femboy.body_type = FEMALE
				femboy.dna.update_ui_block(DNA_GENDER_BLOCK)
				femboy.update_body()
				femboy.update_mutations_overlay()
				cure()
				return FALSE