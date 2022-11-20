/mob/living/taste(datum/reagents/from)
	if(HAS_TRAIT(src, TRAIT_AGEUSIA))
		return

	if(last_taste_time + 50 < world.time)
		var/taste_sensitivity = get_taste_sensitivity()
		if(taste_sensitivity <= 0)
			return
		var/text_output = from.generate_taste_message(src, taste_sensitivity)
		// Radiation makes everything smell and taste like lood
		if(HAS_TRAIT(src, TRAIT_METALLIC_TASTES) && !(mob_biotypes & MOB_ROBOTIC))
			text_output = "iron"
		// We dont want to spam the same message over and over again at the
		// person. Give it a bit of a buffer.
		if((hallucination > 50) && prob(25))
			text_output = pick("spiders","dreams","nightmares","the future","the past","victory",\
			"defeat","pain","bliss","revenge","poison","time","space","death","life","truth","lies","justice","memory",\
			"regrets","my soul","suffering","music","noise","blood","hunger","the american way", "torment")
		if(text_output != last_taste_text || (world.time >= last_taste_time + 100))
			// "something indescribable" -> too many tastes, not enough flavor.
			if(mob_biotypes & MOB_ROBOTIC)
				to_chat(src, span_notice("My taste receptors sense [text_output]."))
			else
				to_chat(src, span_notice("I can taste [text_output]."))

			last_taste_time = world.time
			last_taste_text = text_output
