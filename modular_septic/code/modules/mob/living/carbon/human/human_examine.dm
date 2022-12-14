/mob/living/carbon/human/examine(mob/user)
	//hehe
	if(user.zone_selected in list(BODY_ZONE_PRECISE_L_EYE, BODY_ZONE_PRECISE_R_EYE))
		user.handle_eye_contact(src)
	var/mob/living/carbon/human/human_user = user
	var/get_aroused = FALSE
	if(user.zone_selected == BODY_ZONE_PRECISE_GROIN)
		get_aroused = TRUE

	var/t_He = p_they(TRUE)
	var/t_he = p_they()
	var/t_His = p_their(TRUE)
	var/t_his = p_their()
	var/t_him = p_them()
	var/t_has = p_have()
	var/t_is = p_are()
	var/t_isnt = "[t_is]n't"
	var/t_es = p_es()
	if(user == src)
		t_He = "I"
		t_he = "i"
		t_His = "My"
		t_his = "my"
		t_him = "me"
		t_has = "have"
		t_is = "am"
		t_isnt = "am not"
		t_es = ""

	var/sanitized_chat_color = sanitize_hexcolor(chat_color)
	var/fancy_name = name
	if(chat_color)
		fancy_name = "<span style='color: [sanitized_chat_color];text-shadow: 0 0 3px [sanitized_chat_color];'>[name]</span>"
	var/obscure_name = FALSE
	var/skipface = (wear_mask && (wear_mask.flags_inv & HIDEFACE)) || (head && (head.flags_inv & HIDEFACE))
	var/obscure_species = (skipface || obscure_name || (name == "Unknown"))
	var/obscured = check_obscured_slots()
	var/distance = get_dist(user, src)
	if(isliving(user))
		var/mob/living/living_user = user
		if(HAS_TRAIT(living_user, TRAIT_PROSOPAGNOSIA))
			obscure_name = TRUE
			obscure_species = TRUE

	. = list()
	if(obscure_species)
		. += "[icon2html(dna.species.examine_icon, user, "human")] <span class='info'>Oh, this is <EM>[obscure_name ? "Unknown" : fancy_name]</EM>, a <EM>Human</EM>?</span>"
	else
		. += "[icon2html(dna.species.examine_icon, user, dna.species.examine_icon_state)] <span class='info'>Oh, this is <EM>[obscure_name ? "Unknown" : fancy_name]</EM>, [prefix_a_or_an(dna.species.name)] <EM>[dna.species.name]</EM>!</span>"
	. += "<br><hr class='infohr'>"

	//TODO: Add a social recordkeeping mechanic and datum to keep tracker of who the viewer knows
	//This will do it for now, i guess
	var/visible_job = get_assignment(if_no_id = "", if_no_job = "", hand_first = FALSE)
	var/job_message = "<span class='info'>"
	if(visible_job)
		job_message += "I'm pretty sure [t_he] [t_is] [prefix_a_or_an(visible_job)] <b>[visible_job]</b>."
	else
		job_message += "I don't know [t_his] occupation."
	. += job_message

	var/visible_gender = t_he
	switch(visible_gender)
		if("he", "she", "am")
			visible_gender = "[t_He] [t_is] [get_aged_gender(TRUE, TRUE)]."
		if("i")
			visible_gender = "[t_He] [t_is] [get_aged_gender(TRUE, TRUE)]."
		else
			if(user != src)
				visible_gender = "I don't know their gender."
			else
				visible_gender = "I don't know my gender."
	. += visible_gender

	//lips
	var/obj/item/bodypart/mouth = get_bodypart(BODY_ZONE_PRECISE_MOUTH)
	if(mouth)
		var/list/covered_lips = list()
		for(var/component_type in GLOB.creamed_types)
			var/datum/component/creamed/creampie = GetComponent(component_type)
			if(creampie?.cover_lips)
				covered_lips += creampie.cover_lips
		if(HAS_TRAIT(src, TRAIT_SSD_INDICATOR))
			covered_lips |= "<span style='color: #[COLOR_BLUE_WATER];'>drool</span>"
		if(LAZYLEN(covered_lips))
			. += "Mmm, [t_his] lips are covered with [english_list(covered_lips)]!"

	//head
	if(head && !(obscured & ITEM_SLOT_HEAD) && !(head.item_flags & EXAMINE_SKIP) && !(head.item_flags & ABSTRACT))
		. += "[t_He] [t_is] wearing <b>[head.get_examine_string(user)]</b> on [t_his] head."

	//uniform
	if(w_uniform && !(obscured & ITEM_SLOT_ICLOTHING) && !(w_uniform.item_flags & EXAMINE_SKIP) && !(w_uniform.item_flags & ABSTRACT))
		//accessory
		var/accessory_msg
		if(istype(w_uniform, /obj/item/clothing/under))
			var/obj/item/clothing/under/U = w_uniform
			if(U.attached_accessory && !(U.attached_accessory.item_flags & EXAMINE_SKIP) && !(U.attached_accessory.item_flags & ABSTRACT))
				accessory_msg += " with \a <b>[U.attached_accessory.get_examine_string(user, FALSE)]</b>"

		. += "[t_He] [t_is] wearing <b>[w_uniform.get_examine_string(user)]</b>[accessory_msg]."

	//suit/armor
	if(wear_suit && !(obscured & ITEM_SLOT_OCLOTHING) && !(wear_suit.item_flags & EXAMINE_SKIP) && !(wear_suit.item_flags & ABSTRACT))
		. += "[t_He] [t_is] wearing <b>[wear_suit.get_examine_string(user)]</b>."

	//back
	if(back && !(obscured & ITEM_SLOT_BACKPACK) && !(back.item_flags & EXAMINE_SKIP) && !(back.item_flags & ABSTRACT))
		. += "[t_He] [t_has] <b>[back.get_examine_string(user)]</b> on [t_his] back."

	//back 2 storage boogaloo
	if(s_store && !(obscured & ITEM_SLOT_SUITSTORE) && !(s_store.item_flags & EXAMINE_SKIP) && !(s_store.item_flags & ABSTRACT))
		. += "[t_He] [t_has] <b>[s_store.get_examine_string(user)]</b> on [t_his] back."

	//wrists
	if(wrist_r && !(obscured & ITEM_SLOT_RWRIST) && !(wrist_r.item_flags & EXAMINE_SKIP) && !(wrist_r.item_flags & ABSTRACT))
		. += "[t_He] [t_has] [wrist_r.get_examine_string(user)] on [t_his] right wrist."

	if(wrist_l && !(obscured & ITEM_SLOT_LWRIST) && !(wrist_l.item_flags & EXAMINE_SKIP) && !(wrist_l.item_flags & ABSTRACT))
		. += "[t_He] [t_has] [wrist_l.get_examine_string(user)] on [t_his] left wrist."

	//hands
	for(var/obj/item/I in held_items)
		if(!(I.item_flags & ABSTRACT) && !(I.item_flags & EXAMINE_SKIP))
			. += "[t_He] [t_is] holding <b>[I.get_examine_string(user)]</b> in [t_his] [get_held_index_name(get_held_index_of_item(I))]."

	//gloves
	if(!(obscured & ITEM_SLOT_GLOVES))
		if(gloves && !(gloves.item_flags & EXAMINE_SKIP) && !(gloves.item_flags & ABSTRACT))
			. += "[t_He] [t_has] <b>[gloves.get_examine_string(user)]</b> on [t_his] hands."
		else if(!(obscured & ITEM_SLOT_GLOVES) && num_hands)
			if(blood_in_hands)
				. += "<span class='warning'>[t_He] [t_has][num_hands > 1 ? "" : " a"] <span class='bloody'><b>blood-stained</b></span> hand[num_hands > 1 ? "s" : ""]!</span>"
			if(shit_in_hands)
				. += "<span class='warning'>[t_He] [t_has][num_hands > 1 ? "" : " a"] <span class='shitty'><b>shit-stained</b></span> hand[num_hands > 1 ? "s" : ""]!</span>"
			if(cum_in_hands)
				. += "<span class='warning'>[t_He] [t_has][num_hands > 1 ? "" : " a"] <span class='cummy'><b>cum-stained</b></span> hand[num_hands > 1 ? "s" : ""]!</span>"
			if(femcum_in_hands)
				. += "<span class='warning'>[t_He] [t_has][num_hands > 1 ? "" : " a"] <span class='femcummy'><b>femcum-stained</b></span> hand[num_hands > 1 ? "s" : ""]!</span>"

	//handcuffed
	if(handcuffed && !(obscured & ITEM_SLOT_HANDCUFFED) && !(handcuffed.item_flags & EXAMINE_SKIP))
		. += "<span class='warning'>[t_He] [t_is] handcuffed with <b>[handcuffed.get_examine_string(user)]</b>!</span>"

	//belt
	if(belt && !(obscured & ITEM_SLOT_BELT) && !(belt.item_flags & EXAMINE_SKIP))
		. += "[t_He] [t_has] <b>[belt.get_examine_string(user)]</b> about [t_his] waist."

	//shoes
	if(shoes && !(obscured & ITEM_SLOT_FEET)  && !(shoes.item_flags & EXAMINE_SKIP))
		. += "[t_He] [t_is] wearing <b>[shoes.get_examine_string(user)]</b> on [t_his] feet."

	//mask
	if(wear_mask && !(obscured & ITEM_SLOT_MASK) && !(wear_mask.item_flags & EXAMINE_SKIP))
		. += "[t_He] [t_has] [wear_mask.get_examine_string(user)] on [t_his] face."

	if(wear_neck && !(obscured & ITEM_SLOT_NECK) && !(wear_neck.item_flags & EXAMINE_SKIP))
		. += "[t_He] [t_is] wearing <b>[wear_neck.get_examine_string(user)]</b> around [t_his] neck."

	//eyes
	if(!(obscured & ITEM_SLOT_EYES))
		if(glasses && !(glasses.item_flags & EXAMINE_SKIP))
			. += "[t_He] [t_has] <b>[glasses.get_examine_string(user)]</b> covering [t_his] eyes."
		if(HAS_TRAIT(src, TRAIT_UNNATURAL_RED_GLOWY_EYES))
			. += "<span class='warning'><B>[t_His] eyes are glowing an unnatural red!</B></span>"
		if(HAS_TRAIT(src, TRAIT_FLUORIDE_STARE))
			. += "<span class='animated'>[t_He] [t_has] a vacant, fluoridated stare.</B></span>"
		if(HAS_TRAIT(src, TRAIT_BLOODARN))
			. += "<span class='warning'>[t_He] [t_has] a large pupils. Mysteriously.</B></span>"
		if(HAS_TRAIT(src, TRAIT_HORROR_STARE))
			. += "<span class='animated'>[t_He] [t_has] a deep, horror stare.</B></span>"

	//left ear
	if(ears && !(obscured & ITEM_SLOT_LEAR) && !(ears.item_flags & EXAMINE_SKIP))
		. += "[t_He] [t_has] <b>[ears.get_examine_string(user)]</b> on [t_his] left ear."

	//right ear
	if(ears_extra && !(obscured & ITEM_SLOT_REAR) && !(ears_extra.item_flags & EXAMINE_SKIP))
		. += "[t_He] [t_has] <b>[ears_extra.get_examine_string(user)]</b> on [t_his] right ear."

	//ID
	if(wear_id && !(wear_id.item_flags & EXAMINE_SKIP))
		. += "[t_He] [t_is] wearing <b>[wear_id.get_examine_string(user)]</b>."

	//Status effects
	var/list/status_examines = status_effect_examines()
	if (length(status_examines))
		. += status_examines

	//Jitters
	switch(jitteriness)
		if(300 to INFINITY)
			. += "<span class='warning'><B>[t_He] [t_is] convulsing violently!</B></span>"
		if(200 to 300)
			. += "<span class='warning'>[t_He] [t_is] extremely jittery.</span>"
		if(100 to 200)
			. += "<span class='warning'>[t_He] [t_is] twitching ever so slightly.</span>"

	if(pulling)
		switch(grab_state)
			if(GRAB_PASSIVE)
				. += "<span class='notice'>[t_He] is pulling \the [pulling].</span>"
			if(GRAB_AGGRESSIVE)
				. += "<span class='warning'>[t_He] is grabbing \the [pulling].</span>"
			if(GRAB_NECK)
				. += "<span class='danger'>[t_He] is grabbing \the [pulling] by [pulling.p_their()] neck!</span>"
			if(GRAB_KILL)
				. += "<span class='danger'><b>[t_He] is strangling \the [pulling]!</b></span>"

	var/list/msg = list()
	//stores stumps
	var/list/stumps = list()
	//stores missing limbs
	var/list/missing = get_missing_limbs()
	for(var/X in bodyparts)
		var/obj/item/bodypart/bodypart = X
		if(bodypart.is_stump())
			msg += "<span class='dead'><b>[t_His] [parse_zone(bodypart.body_zone)] is a stump!</b></span>"
			//stumps count as missing
			missing += bodypart.body_zone
			stumps += bodypart.body_zone
		if(bodypart.max_teeth)
			var/teeth = bodypart.get_teeth_amount()
			if(((bodypart.body_zone != BODY_ZONE_PRECISE_MOUTH) && !LAZYLEN(clothingonpart(bodypart))) || !is_mouth_covered())
				if(teeth < bodypart.max_teeth)
					var/missing_teeth = bodypart.max_teeth - teeth
					msg += "<span class='danger'>[t_His] [bodypart.name] is missing [missing_teeth] [missing_teeth == 1 ? "tooth" : "teeth"]!</span>"
		var/max_fingers = bodypart.get_max_digits()
		if(max_fingers)
			var/fingers = bodypart.get_digits_amount()
			var/finger_type = "finger"
			var/static/list/toe_zones = list(BODY_ZONE_PRECISE_R_FOOT, BODY_ZONE_PRECISE_L_FOOT)
			if(bodypart.body_zone in toe_zones)
				finger_type = "toe"
			if(!LAZYLEN(clothingonpart(bodypart)))
				if(fingers < max_fingers)
					var/missing_fingers = max_fingers - fingers
					msg += "<span class='danger'>[t_His] [bodypart.name] is missing [missing_fingers] [finger_type][missing_fingers > 1 ? "s" : ""]!</span>"
	for(var/zone in missing)
		//redundancy checks
		if((zone in stumps) || (GLOB.bodyzone_to_parent[zone] && (GLOB.bodyzone_to_parent[zone] in missing)))
			continue
		msg += "<span class='dead'><b>[capitalize(t_his)] [parse_zone(zone)] is gone!</b></span>"
	var/damage_value = 0
	if(!((user == src) && (src.hal_screwyhud == SCREWYHUD_HEALTHY))) //fake healthy
		var/hyperbole = ((user == src) && (hal_screwyhud == SCREWYHUD_CRIT) ? 50 : 0)
		var/wound_injured = 0
		for(var/thing in all_wounds)
			var/datum/wound/wound = thing
			wound_injured += (wound.severity - WOUND_SEVERITY_TRIVIAL) * 20
		damage_value = getBruteLoss() + getFireLoss() + getCloneLoss() + hyperbole + wound_injured
		switch(damage_value)
			if(5 to 25)
				msg += "[t_He] [t_is] barely injured."
			if(25 to 50)
				msg += "[t_He] [t_is] <B>moderately</B> injured!"
				get_aroused = FALSE
			if(50 to INFINITY)
				msg += "<B>[t_He] [t_is] severely injured!</B>"
				get_aroused = FALSE
	var/datum/component/irradiated/irradiated = GetComponent(/datum/component/irradiated)
	if(!skipface && (irradiated?.radiation_sickness >= RADIATION_SICKNESS_STAGE_1) && get_bodypart_nostump(BODY_ZONE_PRECISE_FACE))
		msg += "[t_His] nose is bleeding."
	if(fire_stacks > 0)
		msg += "[t_He] [t_is] covered in something flammable."
	if(fire_stacks < 0)
		msg += "[t_He] look[p_s()] a little soaked."
	if(nutrition < NUTRITION_LEVEL_STARVING - 50)
		msg += "[t_He] [t_is] severely malnourished."
	else if(nutrition >= NUTRITION_LEVEL_FAT)
		if(user.nutrition < NUTRITION_LEVEL_STARVING - 50)
			msg += "[t_He] [t_is] plump and delicious looking - Like a fat little piggy. A tasty piggy."
		else
			msg += "[t_He] [t_is] quite chubby."
	switch(disgust)
		if(DISGUST_LEVEL_GROSS to DISGUST_LEVEL_VERYGROSS)
			msg += "[t_He] look[p_s()] a bit grossed out."
		if(DISGUST_LEVEL_VERYGROSS to DISGUST_LEVEL_DISGUSTED)
			msg += "[t_He] look[p_s()] really grossed out."
		if(DISGUST_LEVEL_DISGUSTED to INFINITY)
			msg += "[t_He] look[p_s()] extremely disgusted."

	var/apparent_blood_volume = get_blood_circulation()
	if(dna.species.use_skintones && skin_tone == "albino")
		apparent_blood_volume -= ALBINO_BLOOD_REDUCTION // enough to knock you down one tier
	switch(apparent_blood_volume)
		if(BLOOD_VOLUME_OKAY to BLOOD_VOLUME_SAFE)
			msg += "[t_His] skin is pale."
		if(BLOOD_VOLUME_BAD to BLOOD_VOLUME_OKAY)
			msg += "<B>[t_His] skin is very pale.</B>"
		if(-INFINITY to BLOOD_VOLUME_BAD)
			msg += "<span class='artery'><B>[t_His] skin is extremely pale and sickly.</B></span>"

	if(reagents.has_reagent(/datum/reagent/teslium, needs_metabolizing = TRUE))
		msg += "[t_He] [t_is] emitting a gentle blue glow!"

	if(islist(stun_absorption))
		for(var/i in stun_absorption)
			if(stun_absorption[i]["end_time"] > world.time && stun_absorption[i]["examine_message"])
				msg += "[t_He] [t_is][stun_absorption[i]["examine_message"]]"
	//dirtiness
	switch(germ_level)
		if(GERM_LEVEL_FILTHY to GERM_LEVEL_SMASHPLAYER)
			msg += "[t_He] looks filthy!"
		if(GERM_LEVEL_SMASHPLAYER to INFINITY)
			msg += "<b>Good lord, [t_he] stinks!</b>"
	//strength diff
	if(user.attributes && (user != src))
		switch(GET_MOB_SKILL_VALUE_RAW(user, STAT_STRENGTH)-GET_MOB_SKILL_VALUE_RAW(src, STAT_STRENGTH))
			if(-INFINITY to -3)
				msg += span_danger("[t_He] [t_is] much stronger than me.")
			if(-2, -1)
				msg += "[t_He] [t_is] stronger than me."
			if(0)
				msg += span_notice("[t_He] [t_is] about as strong as me.")
			if(1, 2)
				msg += span_notice("[t_He] [t_is] weaker than me.")
			if(3 to INFINITY)
				msg += span_boldnotice("[t_He] [t_is] much weaker than me.")
	if(stat < DEAD)
		if(src != user)
			if(drunkenness && !skipface) //Drunkenness
				switch(drunkenness)
					if(11 to 21)
						msg += "[t_He] [t_is] slightly flushed."
					if(21.01 to 41) //.01s are used in case drunkenness ends up to be a small decimal
						msg += "[t_He] [t_is] flushed."
					if(41.01 to 51)
						msg += "[t_He] [t_is] quite flushed and [t_his] breath smells of alcohol."
					if(51.01 to 61)
						msg += "[t_He] [t_is] very flushed and [t_his] movements are jerky, with breath reeking of alcohol."
					if(61.01 to 91)
						msg += "[t_He] look[p_s()] like a drunken mess."
					if(91.01 to INFINITY)
						msg += "[t_He] [t_is] a shitfaced, slobbering wreck."
			var/datum/component/mood/mood = src.GetComponent(/datum/component/mood)
			if(mood)
				switch(mood.shown_mood)
					if(-INFINITY to MOOD_LEVEL_SAD4)
						msg += "[t_He] look[p_s()] <span style='color: [RUNE_COLOR_DARKRED];'><b>miserable</b></span>."
					if(MOOD_LEVEL_SAD4 to MOOD_LEVEL_SAD3)
						msg += "[t_He] look[p_s()] <b>very sad</b>."
					if(MOOD_LEVEL_SAD3 to MOOD_LEVEL_SAD2)
						msg += "[t_He] look[p_s()] a bit upset."
					if(MOOD_LEVEL_SAD2 to MOOD_LEVEL_HAPPY2)
						msg += "<span class='notice'>[t_He] do[t_es]n't seem one way or the other.</span>"
					if(MOOD_LEVEL_HAPPY2 to MOOD_LEVEL_HAPPY3)
						msg += "<span class='notice'>[t_He] look[p_s()] quite content.</span>"
					if(MOOD_LEVEL_HAPPY3 to MOOD_LEVEL_HAPPY4)
						msg += "<span class='notice'>[t_He] look[p_s()] very happy.</span>"
					if(MOOD_LEVEL_HAPPY4 to INFINITY)
						msg += "<span class='notice'>[t_He] look[p_s()] <b>ecstatic</b>!</span>"
			if(HAS_TRAIT(user, TRAIT_EMPATH))
				if(combat_mode)
					msg += "[t_He] seem[p_s()] to be on guard."
				if(getOxyLoss() >= 10)
					msg += "[t_He] seem[p_s()] winded."
				if(getToxLoss() >= 10)
					msg += "[t_He] seem[p_s()] sickly."
				if(mood.sanity <= SANITY_DISTURBED)
					msg += "[t_He] seem[p_s()] significantly distressed."
					SEND_SIGNAL(user, COMSIG_ADD_MOOD_EVENT, "empath", /datum/mood_event/sad_empath, src)
				if(is_blind())
					msg += "[t_He] appear[p_s()] to be staring off into space."
				if(HAS_TRAIT(src, TRAIT_DEAF))
					msg += "[t_He] appear[p_s()] to not be responding to noises."
				if(bodytemperature > dna.species.bodytemp_heat_damage_limit)
					msg += "[t_He] [t_is] flushed and wheezing."
				if(bodytemperature < dna.species.bodytemp_cold_damage_limit)
					msg += "[t_He] [t_is] shivering."
			if(HAS_TRAIT(user, TRAIT_SPIRITUAL))
				msg += "[t_He] [t_has] a holy aura about [t_him]."
				SEND_SIGNAL(user, COMSIG_ADD_MOOD_EVENT, "religious_comfort", /datum/mood_event/religiously_comforted)
		switch(stat)
			if(DEAD, UNCONSCIOUS, HARD_CRIT)
				msg += "[t_He] [t_isnt] responding to anything around [t_him] and seem[p_s()] to be unconscious."
			if(SOFT_CRIT)
				msg += "[t_He] [t_is] barely conscious."
			if(CONSCIOUS)
				if(HAS_TRAIT(src, TRAIT_DUMB))
					msg += "[t_He] [t_has] a stupid expression on [t_his] face."
		if(needs_lungs() && (distance <= 2) && (losebreath || undergoing_cardiac_arrest() || undergoing_nervous_system_failure()) )
			msg += "[t_He] do[t_es]n't appear to be breathing."
		if(getorganslot(ORGAN_SLOT_BRAIN))
			if(!key && !ai_controller)
				msg += "<span class='dead'>[t_He] [t_is] totally catatonic. Any recovery is unlikely.</span>"
			else if(!client)
				msg += "[t_He] [t_has] a blank, absent-minded stare."
	else
		msg += "[t_He] [t_isnt] responding to anything around [t_him] and seem[p_s()] to be unconscious."
		if(distance <= 2)
			msg += "[t_He] do[t_es]n't appear to be breathing."

	var/scar_severity = 0
	for(var/datum/scar/scar as anything in all_scars)
		if(scar.is_visible(user))
			scar_severity += scar.severity

	switch(scar_severity)
		if(1 to 4)
			msg += "<span class='tinynoticeital'>[t_He] [t_has] visible scarring, you can look again to take a closer look...</span>"
		if(5 to 8)
			msg += "<span class='smallnoticeital'>[t_He] [t_has] several bad scars, you can look again to take a closer look...</span>"
		if(9 to 11)
			msg += "<span class='notice'><i>[t_He] [t_has] significantly disfiguring scarring, you can look again to take a closer look...</i></span>"
		if(12 to INFINITY)
			msg += "<span class='notice'><b><i>[t_He] [t_is] just absolutely fucked up, you can look again to take a closer look...</i></b></span>"

	if(LAZYLEN(msg))
		. += "<span class='warning'>[msg.Join("\n")]</span>"

	var/trait_exam = common_trait_examine()
	if(!isnull(trait_exam))
		. += trait_exam
	//NOOOOO AHHHHHHHH
	var/list/slot_to_name = list(ORGAN_SLOT_PENIS = "knob",\
								ORGAN_SLOT_TESTICLES = "gonads",\
								ORGAN_SLOT_VAGINA = "cunt",\
								ORGAN_SLOT_BREASTS = "jugs",\
								ORGAN_SLOT_WOMB = "womb",\
								ORGAN_SLOT_ANUS = "asshole",\
								)
	for(var/genital_slot in slot_to_name)
		var/list/genitals = getorganslotlist(genital_slot)
		if(!length(genitals) && should_have_genital(genital_slot) && genital_visible(genital_slot))
			. += "<span class='danger'>[t_He] [t_has] no [slot_to_name[genital_slot]]!</span>"
		else
			for(var/thing in genitals)
				var/obj/item/organ/genital/genital = thing
				var/examine_message = genital.get_genital_examine()
				if(examine_message)
					. += genital.get_genital_examine()
				if(genital.is_visible() && damage_value < 50)
					get_aroused = TRUE
	if((user != src) && get_aroused && istype(human_user) && (stat < DEAD) && (human_user.stat == CONSCIOUS))
		//OwO what's this
		human_user.adjust_arousal(20)
	var/perpname = get_face_name(get_id_name(""))
	if(perpname && (HAS_TRAIT(user, TRAIT_SECURITY_HUD) || HAS_TRAIT(user, TRAIT_MEDICAL_HUD)))
		var/datum/data/record/R = find_record("name", perpname, GLOB.data_core.general)
		if(R)
			. += "<span class='deptradio'>Rank:</span> [R.fields["rank"]]\n<a href='?src=[REF(src)];hud=1;photo_front=1'>\[Front photo\]</a><a href='?src=[REF(src)];hud=1;photo_side=1'>\[Side photo\]</a>"
		if(HAS_TRAIT(user, TRAIT_MEDICAL_HUD))
			var/cyberimp_detect
			for(var/obj/item/organ/cyberimp/CI in internal_organs)
				if(CI.status == ORGAN_ROBOTIC && !CI.scanner_hidden)
					cyberimp_detect += "[!cyberimp_detect ? "[CI.get_examine_string(user)]" : ", [CI.get_examine_string(user)]"]"
			if(cyberimp_detect)
				. += "<span class='notice ml-1'>Detected cybernetic modifications:</span>"
				. += "<span class='notice ml-2'>[cyberimp_detect]</span>"
			if(R)
				var/health_r = R.fields["p_stat"]
				. += "<a href='?src=[REF(src)];hud=m;p_stat=1'>\[[health_r]\]</a>"
				health_r = R.fields["m_stat"]
				. += "<a href='?src=[REF(src)];hud=m;m_stat=1'>\[[health_r]\]</a>"
			R = find_record("name", perpname, GLOB.data_core.medical)
			if(R)
				. += "<a href='?src=[REF(src)];hud=m;evaluation=1'>\[Medical evaluation\]</a><br>"
			. += "<a href='?src=[REF(src)];hud=m;quirk=1'>\[See quirks\]</a>"

		if(HAS_TRAIT(user, TRAIT_SECURITY_HUD))
			if(user.stat < UNCONSCIOUS && !HAS_TRAIT(user, TRAIT_HANDS_BLOCKED))
				var/criminal = "None"

				R = find_record("name", perpname, GLOB.data_core.security)
				if(R)
					criminal = R.fields["criminal"]

				. += "<span class='deptradio'>Criminal status:</span> <a href='?src=[REF(src)];hud=s;status=1'>\[[criminal]\]</a>"
				. += jointext(list("<span class='deptradio'>Security record:</span> <a href='?src=[REF(src)];hud=s;view=1'>\[View\]</a>",
					"<a href='?src=[REF(src)];hud=s;add_citation=1'>\[Add citation\]</a>",
					"<a href='?src=[REF(src)];hud=s;add_crime=1'>\[Add crime\]</a>",
					"<a href='?src=[REF(src)];hud=s;view_comment=1'>\[View comment log\]</a>",
					"<a href='?src=[REF(src)];hud=s;add_comment=1'>\[Add comment\]</a>"), "")
	if(isobserver(user))
		. += "<span class='info'><b>Quirks:</b> [get_quirk_string(FALSE, CAT_QUIRK_ALL)]</span>"
	. += "</span>"

	SEND_SIGNAL(src, COMSIG_PARENT_EXAMINE, user, .)
	if(on_examined_check(user, FALSE))
		user.on_examine_atom(src, FALSE)

/mob/living/carbon/human/examine_more(mob/user)
	var/sanitized_chat_color = sanitize_hexcolor(chat_color)
	var/fancy_name = name
	if(chat_color)
		fancy_name = "<span style='color: [sanitized_chat_color];text-shadow: 0 0 3px [sanitized_chat_color];'>[name]</span>"
	var/obscure_name = FALSE
	if(isliving(user))
		var/mob/living/living_user = user
		if(HAS_TRAIT(living_user, TRAIT_PROSOPAGNOSIA))
			obscure_name = TRUE

	. = list(span_notice("<i>I examine <EM>[obscure_name ? "Unknown" : fancy_name]</EM> closer, and note the following...</i>"), "<br><hr class='infohr'>")

	var/box = ""
	var/t_He = p_they(TRUE)
	var/distance = get_dist(user, src)

	var/t_His = p_their(TRUE)
	var/t_his = p_their()
	var/t_has = p_have()

	var/list/damaged_bodypart_text = list()
	var/list/clothing = list(head, wear_mask, wear_neck, wear_suit, w_uniform, wear_id, belt, back, s_store, ears, ears_extra, gloves, shoes)
	for(var/thingprequel in bodyparts)
		var/obj/item/bodypart/limb = thingprequel
		var/obj/item/hidden
		//yes the splint will cover gauze up
		if(limb.current_splint)
			hidden = limb.current_splint
			damaged_bodypart_text += "<span class='info'>[t_His] [limb.name] is splinted with <a href='?src=[REF(limb)];gauze=1;'>[limb.current_splint]</a>.</span>"
			if(limb.current_gauze)
				damaged_bodypart_text += "<span class='info'>[t_His] [limb.name] is gauzed with [limb.current_gauze].</span>"
		else if(limb.current_gauze)
			hidden = limb.current_gauze
			damaged_bodypart_text += "<span class='info'>[t_His] [limb.name] is gauzed with <a href='?src=[REF(limb)];gauze=1;'>[limb.current_gauze]</a>.</span>"

		if(!hidden)
			for(var/thing in clothing)
				var/obj/item/clothing/clothes = thing
				if(istype(clothes) && CHECK_BITFIELD(clothes.body_parts_covered, limb.body_part))
					hidden = clothes
					break
			if(hidden)
				damaged_bodypart_text += "<span class='info'>[t_His] [limb.name] is covered up by [hidden.name]."

		if(limb.etching && !hidden)
			damaged_bodypart_text += "<span class='warning'>[t_His] [limb.name] has \"[limb.etching]\" etched on it!</span>"

		for(var/thing in limb.embedded_objects)
			var/obj/item/embedded = thing
			if(embedded.isEmbedHarmless())
				damaged_bodypart_text += "<span class='info'>[t_He] [t_has] [icon2html(embedded, user)] \a [embedded] stuck to [t_his] [limb.name]!</span>"

		for(var/i in limb.wounds)
			var/datum/wound/iter_wound = i
			if(hidden && !CHECK_BITFIELD(iter_wound.wound_flags, WOUND_VISIBLE_THROUGH_CLOTHING))
				continue
			damaged_bodypart_text += "[iter_wound.get_examine_description(user)]"

		if(hidden)
			var/thicc = FALSE
			var/obj/item/clothing/clothing_thing = hidden
			if(istype(clothing_thing) && (clothing_thing.clothing_flags & THICKMATERIAL))
				thicc = TRUE
			if(limb.get_bleed_rate() && !thicc)
				damaged_bodypart_text += "<span class='warning'>[t_He] [t_has] blood soaking through [t_his] [hidden.name] around [t_his] [limb.name]!</span>"
		else
			var/hurted = limb.get_injuries_desc()
			if(hurted)
				damaged_bodypart_text += "<span class='danger'>[t_He] [t_has] [hurted] on [t_his] [limb.name].</span>"

		if(distance <= 1)
			if(HAS_TRAIT(limb, TRAIT_ROTTEN))
				damaged_bodypart_text += "<span class='necrosis'><B>[t_His] [limb.name] is gangrenous!</B></span>"
			if(HAS_TRAIT(limb, TRAIT_DEFORMED))
				damaged_bodypart_text += "<span class='danger'><B>[t_His] [limb.name] is gruesomely deformed!</B></span>"
			if(limb.is_compound_fractured())
				damaged_bodypart_text += "<span class='danger'><B><U>[t_His] [limb.name] is flaccid and swollen!</U></B></span>"
			else if(limb.is_fractured())
				damaged_bodypart_text += "<span class='danger'><B>[t_His] [limb.name] is dented and swollen!</B></span>"
			else if(limb.is_dislocated())
				damaged_bodypart_text += "<span class='alert'>[t_His] [limb.name] is dislocated!</span>"
		else if(HAS_TRAIT(limb, TRAIT_ROTTEN) || HAS_TRAIT(limb, TRAIT_DEFORMED) || limb.is_fractured() || limb.is_dislocated())
			damaged_bodypart_text += "<span class='alert'>[t_His] [limb.name] seems to be in poor condition.</span>"
	if(length(damaged_bodypart_text))
		box += jointext(damaged_bodypart_text, "\n")
	else
		box += "<span class='info'>[t_He] [t_has] no visibly damaged bodyparts.</span>"
	. += box
	if(on_examined_check(user, TRUE))
		user.on_examine_atom(src, TRUE)
