#define MINOR_INSANITY_PEN 5
#define MAJOR_INSANITY_PEN 10

/datum/component/mood/print_mood(mob/user)
	var/msg = "<span class='infoplain'><div class='infobox'>"
	msg += span_notice("<EM>My memory</EM>")
	if(ishuman(user))
		var/mob/living/carbon/human/H = user
		var/sanitized_chat_color = sanitize_hexcolor(H.chat_color)
		var/fancy_name = H.name
		if(H.chat_color)
			fancy_name = "<span style='color: [sanitized_chat_color];text-shadow: 0 0 3px [sanitized_chat_color];'>[H.real_name]</span>"
		msg += span_info("\nI remember my name, it is <b>[fancy_name]</b>.")
		msg += span_info("\nI am, chronologically, <b>[H.age]</b> years old.")
		if(H.mind.assigned_role)
			msg += span_info("\nI am [prefix_a_or_an(H.mind.assigned_role.title)] <b>[lowertext(H.mind.assigned_role.title)]</b> by trade.")
		for(var/thing in H.mind.antag_datums)
			var/datum/antagonist/antag = thing
			msg += span_info("\nI am <span class='red'><span style='text-shadow: 0 0 3px #FF0000'>\a [lowertext(antag.name)]</span></span>.")
		if((H.handed_flags & AMBIDEXTROUS) || CHECK_MULTIPLE_BITFIELDS(H.handed_flags, RIGHT_HANDED|LEFT_HANDED))
			msg += span_info("\nI am <i>ambidextrous</i>.")
		else if(H.handed_flags & RIGHT_HANDED)
			msg += span_info("\nI am <i>right-handed</i>.")
		else if(H.handed_flags & LEFT_HANDED)
			msg += span_info("\nI am <i>left-handed</i>.")
		msg += span_info("\nMy gender is <i>[lowertext(H.gender)]</i>.")
		msg += span_info("\nMy species is <i>[lowertext(H.dna.species.name)]</i>.")
		if(!(H.dna.species.exotic_blood))
			msg += span_info("\nMy blood type is <span class='artery'>[H.dna.blood_type]</span>.")
		else
			var/datum/reagent/blood_reagent = H.dna.species.exotic_blood
			var/blood_name = initial(blood_reagent.name)
			msg += span_info("\nMy blood type is <span class='artery'>[blood_name]</span>.")
		if(!H.is_literate())
			msg += span_info("\nI am proudly iliterate.")
		if(length(H.quirks))
			msg += span_info("\nI am <i>\"special\"</i>:")
			for(var/datum/quirk/quirk as anything in H.quirks)
				if(quirk.mood_desc)
					msg += span_info("\n<i><b><u>[quirk.name]</u></i></b> - [quirk.mood_desc]</i>")
				else
					msg += span_info("\n<i><b><u>[quirk.name]</u></b></i>")
	msg += "\n<br><hr class='infohr'>"
	msg += span_notice("\n<EM>My feelings:</EM>") //Short term
	var/left_symbols = get_signs_from_number(mood_level - 5, 1)
	var/right_symbols = get_signs_from_number(mood_level - 5, 0)
	if(HAS_TRAIT(user, TRAIT_CAPITALIST_MOOD) || (user.mind && HAS_TRAIT(user.mind, TRAIT_CAPITALIST_MOOD)))
		switch(mood_level)
			if(1)
				msg += span_boldwarning("\n[left_symbols]The great depression![right_symbols]")
			if(2)
				msg += span_boldwarning("\n[left_symbols]Absolute market crash.[right_symbols]")
			if(3)
				msg += span_boldwarning("\n[left_symbols]This is terrible for the economy.[right_symbols]")
			if(4)
				msg += span_boldwarning("\n[left_symbols]My stocks are dipping.[right_symbols]")
			if(5)
				msg += span_nicegreen("\n[left_symbols]Quiet day trading.[right_symbols]")
			if(6)
				msg += span_nicegreen("\n[left_symbols]My stocks are rising.[right_symbols]")
			if(7)
				msg += span_nicegreen("\n[left_symbols]This is great for the economy.[right_symbols]")
			if(8)
				msg += span_nicegreen("\n[left_symbols]CEO mindset.[right_symbols]")
			if(9)
				msg += span_nicegreen("\n[left_symbols]I feel like a crypto millionaire![right_symbols]")
			else
				msg += span_nicegreen("\n[left_symbols]Quiet day trading.[right_symbols]")
	else
		switch(mood_level)
			if(1)
				msg += span_boldwarning("\n[left_symbols]This day is ruined![right_symbols]")
			if(2)
				msg += span_boldwarning("\n[left_symbols]I feel awful.[right_symbols]")
			if(3)
				msg += span_boldwarning("\n[left_symbols]I feel quite upset.[right_symbols]")
			if(4)
				msg += span_boldwarning("\n[left_symbols]I feel a bit sad.[right_symbols]")
			if(5)
				msg += span_nicegreen("\n[left_symbols]I'm alright.[right_symbols]")
			if(6)
				msg += span_nicegreen("\n[left_symbols]I feel pretty okay.[right_symbols]")
			if(7)
				msg += span_nicegreen("\n[left_symbols]I feel quite good.[right_symbols]")
			if(8)
				msg += span_nicegreen("\n[left_symbols]I feel amazing.[right_symbols]")
			if(9)
				msg += span_nicegreen("\n[left_symbols]This day is great![right_symbols]")
			else
				msg += span_nicegreen("\n[left_symbols]I'm alright.[right_symbols]")
	msg += span_notice("\n<EM>My thoughts:</EM>")//All moodlets
	if(LAZYLEN(mood_events))
		var/datum/mood_event/event
		for(var/i in mood_events)
			event = mood_events[i]
			left_symbols = get_signs_from_number(event.mood_change, 1)
			right_symbols = get_signs_from_number(event.mood_change, 0)
			var/event_desc = replacetext(event.description, "\n", "")
			msg += "\n[left_symbols][event_desc][right_symbols]"
	else
		msg += span_nicegreen("\nI don't have much of a reaction to anything right now.")
	var/mob/living/living_user = user
	if(istype(living_user))
		var/list/additional_info = list()
		if(living_user.getFatigueLoss())
			if(living_user.getFatigueLoss() >= 35)
				additional_info += span_info("\nI'm exhausted.")
			else
				additional_info += span_info("\nI feel tired.")
		if(living_user.losebreath)
			additional_info += span_danger("\nI can't breathe!")
		if(HAS_TRAIT(living_user, TRAIT_SELF_AWARE))
			var/toxloss = living_user.getToxLoss()
			if(toxloss)
				if(toxloss >= 10)
					additional_info += span_danger("\nI feel nauseous.")
				else if(toxloss >= 20)
					additional_info += span_danger("\nI feel sick.")
				else if(toxloss >= 40)
					additional_info += span_danger("\nI feel very unwell!")
			var/oxyloss = living_user.getOxyLoss()
			if(oxyloss)
				if(oxyloss >= 10)
					additional_info += span_danger("\nI feel lightheaded.")
				else if(oxyloss >= 20)
					additional_info += span_danger("\nI need more air.</span>")
				else if(oxyloss >= 30)
					additional_info += span_danger("\nI'm choking!")
		if(LAZYLEN(additional_info))
			msg += span_notice("\n<b>Additional thoughts:</b>")
			msg += jointext(additional_info, "")
	msg += "</div></span>" //div infobox
	to_chat(user || parent, msg)

/datum/component/mood/update_mood()
	var/old_mood = mood_level
	. = ..()
	if(mood_level < old_mood)
		to_chat(parent, span_danger("My mood worsens."))
	else if(mood_level > old_mood)
		to_chat(parent, span_nicegreen("My mood improves."))
	var/mob/living/living_parent = parent
	if(istype(living_parent))
		if((old_mood != mood_level) && (living_parent.attributes))
			var/mood_malus = min(1, mood_level - 5)
			living_parent.attributes.add_or_update_variable_diceroll_modifier(/datum/diceroll_modifier/mood, mood_malus)
		if(living_parent.hud_used?.sadness)
			switch(mood_level)
				if(4)
					living_parent.hud_used.sadness.alpha = 32
				if(3)
					living_parent.hud_used.sadness.alpha = 64
				if(2)
					living_parent.hud_used.sadness.alpha = 128
				if(1)
					living_parent.hud_used.sadness.alpha = 160
				else
					living_parent.hud_used.sadness.alpha = 0

/datum/component/mood/setSanity(amount, minimum=SANITY_INSANE, maximum=SANITY_GREAT, override = FALSE)
	// If we're out of the acceptable minimum-maximum range move back towards it in steps of 0.7
	// If the new amount would move towards the acceptable range faster then use it instead
	if(amount < minimum)
		amount += clamp(minimum - amount, 0, 0.7)
	if((!override && HAS_TRAIT(parent, TRAIT_UNSTABLE)) || amount > maximum)
		amount = min(sanity, amount)
	if(amount == sanity) //Prevents stuff from flicking around.
		return
	sanity = amount
	var/mob/living/master = parent
	switch(sanity)
		if(SANITY_INSANE to SANITY_CRAZY)
			setInsanityEffect(MAJOR_INSANITY_PEN)
			master.add_movespeed_modifier(/datum/movespeed_modifier/sanity/insane)
			master.add_actionspeed_modifier(/datum/actionspeed_modifier/low_sanity)
			sanity_level = 6
		if(SANITY_CRAZY to SANITY_UNSTABLE)
			setInsanityEffect(MINOR_INSANITY_PEN)
			master.add_movespeed_modifier(/datum/movespeed_modifier/sanity/crazy)
			master.add_actionspeed_modifier(/datum/actionspeed_modifier/low_sanity)
			sanity_level = 5
		if(SANITY_UNSTABLE to SANITY_DISTURBED)
			setInsanityEffect(0)
			master.add_movespeed_modifier(/datum/movespeed_modifier/sanity/disturbed)
			master.add_actionspeed_modifier(/datum/actionspeed_modifier/low_sanity)
			sanity_level = 4
		if(SANITY_DISTURBED to SANITY_NEUTRAL)
			setInsanityEffect(0)
			master.remove_movespeed_modifier(MOVESPEED_ID_SANITY)
			master.remove_actionspeed_modifier(ACTIONSPEED_ID_SANITY)
			sanity_level = 3
		if(SANITY_NEUTRAL+1 to SANITY_GREAT+1) //shitty hack but +1 to prevent it from responding to super small differences
			setInsanityEffect(0)
			master.remove_movespeed_modifier(MOVESPEED_ID_SANITY)
			master.add_actionspeed_modifier(/datum/actionspeed_modifier/high_sanity)
			sanity_level = 2
		if(SANITY_GREAT+1 to INFINITY)
			setInsanityEffect(0)
			master.remove_movespeed_modifier(MOVESPEED_ID_SANITY)
			master.add_actionspeed_modifier(/datum/actionspeed_modifier/high_sanity)
			sanity_level = 1
	update_mood_icon()

/datum/component/mood/HandleNutrition()
	var/mob/living/L = parent
	if(ishuman(L))
		var/mob/living/carbon/human/H = L
		if(locate(/obj/item/organ/stomach/ethereal) in H.internal_organs)
			handle_charge(H)
			return
	if(!HAS_TRAIT(L, TRAIT_NOHUNGER))
		switch(L.nutrition)
			if(NUTRITION_LEVEL_FULL to INFINITY)
				if (!HAS_TRAIT(L, TRAIT_VORACIOUS))
					add_event(null, "nutrition", /datum/mood_event/fat)
				else
					add_event(null, "nutrition", /datum/mood_event/wellfed) // round and full
			if(NUTRITION_LEVEL_WELL_FED to NUTRITION_LEVEL_FULL)
				add_event(null, "nutrition", /datum/mood_event/wellfed)
			if(NUTRITION_LEVEL_FED to NUTRITION_LEVEL_WELL_FED)
				add_event(null, "nutrition", /datum/mood_event/fed)
			if(NUTRITION_LEVEL_HUNGRY to NUTRITION_LEVEL_FED)
				clear_event(null, "nutrition")
			if(NUTRITION_LEVEL_STARVING to NUTRITION_LEVEL_HUNGRY)
				add_event(null, "nutrition", /datum/mood_event/hungry)
			if(0 to NUTRITION_LEVEL_STARVING)
				add_event(null, "nutrition", /datum/mood_event/starving)
	if(!HAS_TRAIT(L, TRAIT_NOTHIRST))
		switch(L.hydration)
			if(HYDRATION_LEVEL_THIRSTY to INFINITY)
				clear_event(null, "hydration")
			if(HYDRATION_LEVEL_DEHYDRATED to HYDRATION_LEVEL_THIRSTY)
				add_event(null, "hydration", /datum/mood_event/thirsty)
			if(0 to HYDRATION_LEVEL_DEHYDRATED)
				add_event(null, "hydration", /datum/mood_event/dehydrated)

/datum/component/mood/proc/handle_charge(mob/living/carbon/human/H)
	var/obj/item/organ/stomach/ethereal/stomach = (locate(/obj/item/organ/stomach/ethereal) in H.internal_organs)
	switch(stomach.crystal_charge)
		if(ETHEREAL_CHARGE_NONE to ETHEREAL_CHARGE_LOWPOWER)
			add_event(null, "charge", /datum/mood_event/decharged)
		if(ETHEREAL_CHARGE_LOWPOWER to ETHEREAL_CHARGE_NORMAL)
			add_event(null, "charge", /datum/mood_event/lowpower)
		if(ETHEREAL_CHARGE_NORMAL to ETHEREAL_CHARGE_ALMOSTFULL)
			clear_event(null, "charge")
		if(ETHEREAL_CHARGE_ALMOSTFULL to ETHEREAL_CHARGE_FULL)
			add_event(null, "charge", /datum/mood_event/charged)
		if(ETHEREAL_CHARGE_FULL to ETHEREAL_CHARGE_OVERLOAD)
			add_event(null, "charge", /datum/mood_event/overcharged)
		if(ETHEREAL_CHARGE_OVERLOAD to ETHEREAL_CHARGE_DANGEROUS)
			add_event(null, "charge", /datum/mood_event/supercharged)

#undef MINOR_INSANITY_PEN
#undef MAJOR_INSANITY_PEN
