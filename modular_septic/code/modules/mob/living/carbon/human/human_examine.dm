/mob/living/carbon/human/examine(mob/user)
	//hehe
	if(user.zone_selected in list(BODY_ZONE_PRECISE_L_EYE, BODY_ZONE_PRECISE_R_EYE))
		user.handle_eye_contact(src)
	var/mob/living/carbon/human/human_user = user
	var/get_aroused = FALSE
	if(user.zone_selected == BODY_ZONE_PRECISE_GROIN)
		get_aroused = TRUE

	var/t_he = p_they()
	if(user == src)
		t_he = "i"

	var/sanitized_chat_color = sanitize_hexcolor(chat_color)
	var/fancy_name = name
	if(chat_color)
		fancy_name = "<span style='color: [sanitized_chat_color];text-shadow: 0 0 3px [sanitized_chat_color];'>[name]</span>"
	var/obscure_name = FALSE
	var/skipface = (wear_mask && (wear_mask.flags_inv & HIDEFACE)) || (head && (head.flags_inv & HIDEFACE))
	var/obscure_species = (skipface || obscure_name || (name == "Неизвестный"))
	var/obscured = check_obscured_slots()
	var/distance = get_dist(user, src)
	if(isliving(user))
		var/mob/living/living_user = user
		if(HAS_TRAIT(living_user, TRAIT_PROSOPAGNOSIA))
			obscure_name = TRUE
			obscure_species = TRUE

	. = list()
	if(obscure_species)
		. += "[icon2html(dna.species.examine_icon, user, "human")] <span class='info'>Ох, это же <EM>[obscure_name ? "Неизвестный" : fancy_name]</EM>, <EM>Человек</EM>!</span>"
		if(HAS_TRAIT(src, TRAIT_FRAGGOT))
			if(!(obscured & ITEM_SLOT_NECK))
				if(!wear_neck)
					var/necky = get_bodypart_nostump(BODY_ZONE_PRECISE_NECK)
					if(!LAZYLEN(clothingonpart(necky)))
						. += span_flashingdanger("[emoji_parse(":fatal:")] [uppertext(src.name)] ФАТАЛ! ОН ДОЛЖЕН БЫТЬ УБИТ!")
	else
		. += "[icon2html(dna.species.examine_icon, user, dna.species.examine_icon_state)] <span class='info'>Ох, это же <EM>[obscure_name ? "Неизвестный" : fancy_name]</EM>, <EM>[dna.species.name]</EM>!</span>"
		if(HAS_TRAIT(src, TRAIT_FRAGGOT))
			if(!(obscured & ITEM_SLOT_NECK))
				if(!wear_neck)
					var/necky = get_bodypart_nostump(BODY_ZONE_PRECISE_NECK)
					if(!LAZYLEN(clothingonpart(necky)))
						. += span_flashingdanger("[emoji_parse(":fatal:")] [uppertext(src.name)] ФАТАЛ! ОН ДОЛЖЕН БЫТЬ УБИТ!")
	. += "<br><hr class='infohr'>"

	//TODO: Add a social recordkeeping mechanic and datum to keep tracker of who the viewer knows
	//This will do it for now, i guess
//	var/visible_job = get_assignment(if_no_id = "", if_no_job = "", hand_first = FALSE)
	var/job_message = "<span class='info'>"
	if(truerole)
		if(!skipface)
			if(!special_zvanie)
				job_message += "Я уверен, он <b>[truerole]</b>."
			else
				job_message += "Я уверен, он <b>[truerole]</b>. Ну и ого, он <span class='yellowteamradio'><b>[special_zvanie]</b></span>"
		else
			job_message += "Я не знаю его роли."
	. += job_message

	var/visible_gender = t_he
	switch(visible_gender)
		if("he", "she", "am")
			visible_gender = "Это [get_aged_gender(TRUE, TRUE)]."
		if("i")
			visible_gender = "Это [get_aged_gender(TRUE, TRUE)]."
		else
			if(user != src)
				visible_gender = "Я не знаю его пола."
			else
				visible_gender = "Я не знаю свой пол."
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
			covered_lips |= "<span style='color: #[COLOR_BLUE_WATER];'>слюнями</span>"
		if(LAZYLEN(covered_lips))
			. += "Вот блять, его губы покрыты [english_list(covered_lips)]!"
		if(belief == "Hadot")
			. += "У него усы ебанутые."

	//head
	if(head && !(obscured & ITEM_SLOT_HEAD) && !(head.item_flags & EXAMINE_SKIP) && !(head.item_flags & ABSTRACT))
		. += "У него <b>[head.get_examine_string(user)]</b> на его голове."

	//uniform
	if(w_uniform && !(obscured & ITEM_SLOT_ICLOTHING) && !(w_uniform.item_flags & EXAMINE_SKIP) && !(w_uniform.item_flags & ABSTRACT))
		//accessory
		var/accessory_msg
		if(istype(w_uniform, /obj/item/clothing/under))
			var/obj/item/clothing/under/U = w_uniform
			if(U.attached_accessory && !(U.attached_accessory.item_flags & EXAMINE_SKIP) && !(U.attached_accessory.item_flags & ABSTRACT))
				accessory_msg += " с <b>[U.attached_accessory.get_examine_string(user, FALSE)]</b>"

		. += "У него <b>[w_uniform.get_examine_string(user)]</b>[accessory_msg]."

	//suit/armor
	if(wear_suit && !(obscured & ITEM_SLOT_OCLOTHING) && !(wear_suit.item_flags & EXAMINE_SKIP) && !(wear_suit.item_flags & ABSTRACT))
		. += "У него <b>[wear_suit.get_examine_string(user)]</b>."

	//pants
	if(pants && !(obscured & ITEM_SLOT_PANTS) && !(pants.item_flags & EXAMINE_SKIP) && !(pants.item_flags & ABSTRACT))
		. += "У него <b>[pants.get_examine_string(user)]</b> на его ногах."

	//oversuit
	if(oversuit && !(obscured & ITEM_SLOT_OVERSUIT) && !(oversuit.item_flags & EXAMINE_SKIP) && !(oversuit.item_flags & ABSTRACT))
		. += "У него <b>[oversuit.get_examine_string(user)]</b>."

	//back
	if(back && !(obscured & ITEM_SLOT_BACKPACK) && !(back.item_flags & EXAMINE_SKIP) && !(back.item_flags & ABSTRACT))
		. += "У него <b>[back.get_examine_string(user)]</b> на его спине."

	//back 2 storage boogaloo
	if(s_store && !(obscured & ITEM_SLOT_SUITSTORE) && !(s_store.item_flags & EXAMINE_SKIP) && !(s_store.item_flags & ABSTRACT))
		. += "У него <b>[s_store.get_examine_string(user)]</b> на его спине."

	//wrists
	if(wrists && !(obscured & ITEM_SLOT_WRISTS) && !(wrists.item_flags & EXAMINE_SKIP) && !(wrists.item_flags & ABSTRACT))
		. += "У него [wrists.get_examine_string(user)] на его запястьях."

	//hands
	for(var/obj/item/I in held_items)
		if(!(I.item_flags & ABSTRACT) && !(I.item_flags & EXAMINE_SKIP))
			. += "Он держит <b>[I.get_examine_string(user)]</b> в его [get_held_index_name(get_held_index_of_item(I))]."

	//gloves
	if(!(obscured & ITEM_SLOT_GLOVES))
		if(gloves && !(gloves.item_flags & EXAMINE_SKIP) && !(gloves.item_flags & ABSTRACT))
			. += "У него <b>[gloves.get_examine_string(user)]</b> на его кистях."
		else if(!(obscured & ITEM_SLOT_GLOVES) && num_hands)
			if(blood_in_hands)
				. += "<span class='warning'>У него <span class='bloody'><b>в крови</b></span> [num_hands > 1 ? "руки" : "рука"]!</span>"
			if(shit_in_hands)
				. += "<span class='warning'>У него <span class='shitty'><b>в говне</b></span> hand[num_hands > 1 ? "руки" : "рука"]!</span>"
			if(cum_in_hands)
				. += "<span class='warning'>У него <span class='cummy'><b>в сперме</b></span> hand[num_hands > 1 ? "руки" : "рука"]!</span>"
			if(femcum_in_hands)
				. += "<span class='warning'>У него <span class='femcummy'><b>в женской сперме</b></span> hand[num_hands > 1 ? "руки" : "рука"]!</span>"

	//handcuffed
	if(handcuffed && !(obscured & ITEM_SLOT_HANDCUFFED) && !(handcuffed.item_flags & EXAMINE_SKIP))
		. += "<span class='warning'>Он закован в <b>[handcuffed.get_examine_string(user)]</b>!</span>"

	//belt
	if(belt && !(obscured & ITEM_SLOT_BELT) && !(belt.item_flags & EXAMINE_SKIP))
		. += "У него <b>[belt.get_examine_string(user)]</b> на его поясе."

	//shoes
	if(shoes && !(obscured & ITEM_SLOT_FEET)  && !(shoes.item_flags & EXAMINE_SKIP))
		. += "У него <b>[shoes.get_examine_string(user)]</b> на его стопах."

	//mask
	if(wear_mask && !(obscured & ITEM_SLOT_MASK) && !(wear_mask.item_flags & EXAMINE_SKIP))
		. += "У него [wear_mask.get_examine_string(user)] на его лице."

	if(wear_neck && !(obscured & ITEM_SLOT_NECK) && !(wear_neck.item_flags & EXAMINE_SKIP))
		. += "У него <b>[wear_neck.get_examine_string(user)]</b> на его шее."

	//eyes
	if(!(obscured & ITEM_SLOT_EYES))
		if(glasses && !(glasses.item_flags & EXAMINE_SKIP))
			. += "У него <b>[glasses.get_examine_string(user)]</b> прикрывающие его глаза."
		if(HAS_TRAIT(src, TRAIT_UNNATURAL_RED_GLOWY_EYES))
			. += "<span class='warning'><B>У него ебанутые глаза!</B></span>"
		if(HAS_TRAIT(src, TRAIT_FLUORIDE_STARE))
			. += "<span class='animated'>У него пространственный взгляд...</B></span>"
		if(HAS_TRAIT(src, TRAIT_BLOODARN))
			. += "<span class='warning'>У него широкие зрачки.</B></span>"
		if(HAS_TRAIT(src, TRAIT_HORROR_STARE))
			. += "<span class='animated'>У него глубокий, страшный взгляд.</B></span>"
		if(belief == "Gutted")
			. += "<span class='warning'>У него змеиный зрачок.</B></span>"

	//left ear
	if(ears && !(obscured & ITEM_SLOT_LEAR) && !(ears.item_flags & EXAMINE_SKIP))
		. += "У него <b>[ears.get_examine_string(user)]</b> на его левом ухе."

	//right ear
	if(ears_extra && !(obscured & ITEM_SLOT_REAR) && !(ears_extra.item_flags & EXAMINE_SKIP))
		. += "У него <b>[ears_extra.get_examine_string(user)]</b> на его правом ухе."

	//ID
	if(wear_id && !(wear_id.item_flags & EXAMINE_SKIP))
		. += "У него <b>[wear_id.get_examine_string(user)]</b>."

	//Status effects
	var/list/status_examines = status_effect_examines()
	if (length(status_examines))
		. += status_examines

	//Jitters
	switch(jitteriness)
		if(300 to INFINITY)
			. += "<span class='warning'><B>У него конвульсии!</B></span>"
		if(100 to 300)
			. += "<span class='warning'>Он трясётся.</span>"

	if(pulling)
		switch(grab_state)
			if(GRAB_PASSIVE)
				. += "<span class='notice'>Он тащит [pulling].</span>"
			if(GRAB_AGGRESSIVE)
				. += "<span class='warning'>Он схватил [pulling].</span>"
			if(GRAB_NECK)
				. += "<span class='danger'>Он схватил [pulling] за шею!</span>"
			if(GRAB_KILL)
				. += "<span class='danger'><b>Он душит [pulling]!</b></span>"

	var/list/msg = list()
	//stores stumps
	var/list/stumps = list()
	//stores missing limbs
	var/list/missing = get_missing_limbs()
	for(var/obj/item/bodypart/bodypart as anything in bodyparts)
		if(bodypart.is_stump())
			msg += "<span class='dead'><b>Его [parse_zone(bodypart.body_zone)] просто огрызок!</b></span>"
			//stumps count as missing
			missing += bodypart.body_zone
			stumps += bodypart.body_zone
		if(bodypart.max_teeth)
			var/teeth = bodypart.get_teeth_amount()
			if(!clothingonpart(bodypart) || !is_mouth_covered())
				if(teeth < bodypart.max_teeth)
					var/missing_teeth = bodypart.max_teeth - teeth
					msg += "<span class='danger'>Его [bodypart.name] не имеет [missing_teeth] зубов!</span>"
		var/max_fingers = bodypart.get_max_digits()
		if(max_fingers)
			var/fingers = bodypart.get_digits_amount()
			var/finger_type = "палец руки"
			var/static/list/toe_zones = list(BODY_ZONE_PRECISE_R_FOOT, BODY_ZONE_PRECISE_L_FOOT)
			if(bodypart.body_zone in toe_zones)
				finger_type = "палец ноги"
			if(!LAZYLEN(clothingonpart(bodypart)))
				if(fingers < max_fingers)
					var/missing_fingers = max_fingers - fingers
					msg += "<span class='danger'>Его [bodypart.name] не имеет [missing_fingers] [finger_type]!</span>"
	for(var/zone in missing)
		//redundancy checks
		if((GLOB.bodyzone_to_parent[zone] && ((GLOB.bodyzone_to_parent[zone] in missing) || (GLOB.bodyzone_to_parent[zone] in stumps))))
			continue
		msg += "<span class='dead'><b>Его [parse_zone(zone)] потеряно!</b></span>"
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
				msg += "Он немного повреждён."
			if(25 to 50)
				msg += "Он <B>довольно</B> повреждён!"
				get_aroused = FALSE
			if(50 to INFINITY)
				msg += "<B>Он же тяжело ранен!</B>"
				get_aroused = FALSE
/*
	var/datum/component/irradiated/irradiated = GetComponent(/datum/component/irradiated)
	if(!skipface && (irradiated?.radiation_sickness >= RADIATION_SICKNESS_STAGE_1) && get_bodypart_nostump(BODY_ZONE_PRECISE_FACE))
		msg += "[t_His] nose is bleeding."
	if(fire_stacks > 0)
		msg += "[t_He] [t_is] covered in something flammable."
	if(fire_stacks < 0)
		msg += "[t_He] look[p_s()] a little soaked."
*/
	if(nutrition <= NUTRITION_LEVEL_STARVING)
		msg += "Он голодает."
	else if(nutrition >= NUTRITION_LEVEL_FAT)
		if(user.nutrition < NUTRITION_LEVEL_STARVING - 50)
			msg += "Он толстый."
/*
	switch(disgust)
		if(DISGUST_LEVEL_GROSS to DISGUST_LEVEL_VERYGROSS)
			msg += "[t_He] look[p_s()] a bit grossed out."
		if(DISGUST_LEVEL_VERYGROSS to DISGUST_LEVEL_DISGUSTED)
			msg += "[t_He] look[p_s()] really grossed out."
		if(DISGUST_LEVEL_DISGUSTED to INFINITY)
			msg += "[t_He] look[p_s()] extremely disgusted."
*/
	var/apparent_blood_volume = get_blood_circulation()
	if(dna.species.use_skintones && skin_tone == "albino")
		apparent_blood_volume -= ALBINO_BLOOD_REDUCTION // enough to knock you down one tier
	switch(apparent_blood_volume)
		if(BLOOD_VOLUME_BAD to BLOOD_VOLUME_OKAY)
			msg += "<B>Он бледный, как поганка.</B>"
		if(-INFINITY to BLOOD_VOLUME_BAD)
			msg += "<span class='artery'><B>Его кожа нездорово бледная.</B></span>"
/*
	if(reagents.has_reagent(/datum/reagent/teslium, needs_metabolizing = TRUE))
		msg += "[t_He] [t_is] emitting a gentle blue glow!"


	if(islist(stun_absorption))
		for(var/i in stun_absorption)
			if(stun_absorption[i]["end_time"] > world.time && stun_absorption[i]["examine_message"])
				msg += "[t_He] [t_is][stun_absorption[i]["examine_message"]]"
*/
	//dirtiness
	switch(germ_level)
		if(GERM_LEVEL_FILTHY to GERM_LEVEL_SMASHPLAYER)
			msg += "Он выглядит грязно!"
		if(GERM_LEVEL_SMASHPLAYER to INFINITY)
			msg += "<b>Боже, он воняет!</b>"
	//strength diff
	if(user.attributes && (user != src))
		switch(GET_MOB_SKILL_VALUE_RAW(user, STAT_STRENGTH)-GET_MOB_SKILL_VALUE_RAW(src, STAT_STRENGTH))
			if(-INFINITY to -3)
				msg += span_danger("Он намного сильнее меня.")
			if(-2, -1)
				msg += "Он сильнее меня."
			if(0)
				msg += span_notice("Он по силе как и я.")
			if(1, 2)
				msg += span_notice("Он слабее меня.")
			if(3 to INFINITY)
				msg += span_boldnotice("Он намного слабее меня.")
	if(stat < DEAD)
		if(src != user)
			if(drunkenness && !skipface) //Drunkenness
				switch(drunkenness)
					if(11 to INFINITY)
						msg += "Он пьяный."
/*
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
*/
			if(combat_mode)
				msg += "Враждебно настроен."
/*
			if(getOxyLoss() >= 10)
				msg += "[t_He] seem[p_s()] winded."
			if(getToxLoss() >= 10)
				msg += "[t_He] seem[p_s()] sickly."

			if(mood.sanity <= SANITY_DISTURBED)
				msg += "Видно, что психически не в порядке."
				SEND_SIGNAL(user, COMSIG_ADD_MOOD_EVENT, "empath", /datum/mood_event/sad_empath, src)

			if(is_blind())
				msg += "[t_He] appear[p_s()] to be staring off into space."
			if(HAS_TRAIT(src, TRAIT_DEAF))
				msg += "[t_He] appear[p_s()] to not be responding to noises."
			if(bodytemperature > dna.species.bodytemp_heat_damage_limit)
				msg += "[t_He] [t_is] flushed and wheezing."
			if(bodytemperature <= dna.species.bodytemp_cold_damage_limit)
				msg += "[t_He] [t_is] shivering."
			if(HAS_TRAIT(user, TRAIT_SPIRITUAL))
				msg += "[t_He] [t_has] a holy aura about [t_him]."
				SEND_SIGNAL(user, COMSIG_ADD_MOOD_EVENT, "religious_comfort", /datum/mood_event/religiously_comforted)
*/
		switch(stat)
			if(DEAD, UNCONSCIOUS, HARD_CRIT)
				msg += "Он, вроде, без сознания."
			if(SOFT_CRIT)
				msg += "Он почти в сознании."
			if(CONSCIOUS)
				if(HAS_TRAIT(src, TRAIT_DUMB))
					msg += "У него ебало тупое."
		if(needs_lungs() && (distance <= 2) && (losebreath || undergoing_cardiac_arrest() || undergoing_nervous_system_failure()) )
			msg += "Он не дышит."
		if(getorganslot(ORGAN_SLOT_BRAIN))
			if(!key || !client)
				msg += "<span class='dead'>Он не в себе.</span>"
/*
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
*/
	if(LAZYLEN(msg))
		. += "<span class='warning'>[msg.Join("\n")]</span>"

	var/trait_exam = common_trait_examine()
	if(!isnull(trait_exam))
		. += trait_exam
	//NOOOOO AHHHHHHHH
	var/list/slot_to_name = list(ORGAN_SLOT_PENIS = "хуй",\
								ORGAN_SLOT_TESTICLES = "яйца",\
								ORGAN_SLOT_VAGINA = "вагина",\
								ORGAN_SLOT_BREASTS = "сиськи",\
								ORGAN_SLOT_WOMB = "матка",\
								ORGAN_SLOT_ANUS = "анус",\
								)
	for(var/genital_slot in slot_to_name)
		var/list/genitals = getorganslotlist(genital_slot)
		if(!length(genitals) && should_have_genital(genital_slot) && genital_visible(genital_slot))
			. += "<span class='danger'>У него нет [slot_to_name[genital_slot]]!</span>"
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
		. += "<span class='info'><b>Черты:</b> [get_quirk_string(FALSE, CAT_QUIRK_ALL)]</span>"
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

	. = list(span_notice("<i>Я осматриваю <EM>[obscure_name ? "Неизвестный" : fancy_name]</EM> ближе, и замечаю...</i>"), "<br><hr class='infohr'>")

	var/box = ""
	var/distance = get_dist(user, src)

	var/list/damaged_bodypart_text = list()
	var/list/clothing = list(head, wear_mask, wear_neck, wear_suit, w_uniform, wear_id, belt, back, s_store, ears, ears_extra, gloves, shoes)
	for(var/thingprequel in bodyparts)
		var/obj/item/bodypart/limb = thingprequel
		var/obj/item/hidden
		//yes the splint will cover gauze up
		if(limb.current_splint)
			hidden = limb.current_splint
			damaged_bodypart_text += "<span class='info'>Его [limb.name] шинировано с помощью <a href='?src=[REF(limb)];gauze=1;'>[limb.current_splint]</a>.</span>"
			if(limb.current_gauze)
				damaged_bodypart_text += "<span class='info'>Его [limb.name] затянуто бинтом с помощью [limb.current_gauze].</span>"
		else if(limb.current_gauze)
			hidden = limb.current_gauze
			damaged_bodypart_text += "<span class='info'>Его [limb.name] затянуто бинтом с помощью <a href='?src=[REF(limb)];gauze=1;'>[limb.current_gauze]</a>.</span>"

		if(!hidden)
			for(var/thing in clothing)
				var/obj/item/clothing/clothes = thing
				if(istype(clothes) && CHECK_BITFIELD(clothes.body_parts_covered, limb.body_part))
					hidden = clothes
					break
			if(hidden)
				damaged_bodypart_text += "<span class='info'>[limb.name] прикрыто благодаря [hidden.name]."
/*
		if(limb.etching && !hidden)
			damaged_bodypart_text += "<span class='warning'>[t_His] [limb.name] has \"[limb.etching]\" etched on it!</span>"
*/
		for(var/thing in limb.embedded_objects)
			var/obj/item/embedded = thing
			if(embedded.isEmbedHarmless())
				damaged_bodypart_text += "<span class='info'>У него [icon2html(embedded, user)] [embedded] застряло в его [limb.name]!</span>"

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
				damaged_bodypart_text += "<span class='warning'>У него кровь сочится из его [hidden.name] около его <span class='meatymeat'>[limb.name]</span>!</span>"
		else
			var/hurted = limb.get_injuries_desc()
			if(hurted)
				damaged_bodypart_text += "<span class='danger'>У него [hurted] на его <span class='meatymeat'>[limb.name]</span>.</span>"

		if(distance <= 1)
			if(HAS_TRAIT(limb, TRAIT_ROTTEN))
				damaged_bodypart_text += "<span class='necrosis'><B><span class='meatymeat'>[limb.name]</span> гангренозно!</B></span>"
			if(HAS_TRAIT(limb, TRAIT_DEFORMED))
				damaged_bodypart_text += "<span class='danger'><B><span class='meatymeat'>[limb.name]</span> ужасно деформировано!</B></span>"
			if(limb.is_compound_fractured())
				damaged_bodypart_text += "<span class='danger'><B><U><span class='meatymeat'>[limb.name]</span> довольно вялое и опухшее!</U></B></span>"
			else if(limb.is_fractured())
				damaged_bodypart_text += "<span class='danger'><B><span class='meatymeat'>[limb.name]</span> помятое и опухшее!</B></span>"
			else if(limb.is_dislocated())
				damaged_bodypart_text += "<span class='alert'><span class='meatymeat'>[limb.name]</span> выхвинуто!</span>"
		else if(HAS_TRAIT(limb, TRAIT_ROTTEN) || HAS_TRAIT(limb, TRAIT_DEFORMED) || limb.is_fractured() || limb.is_dislocated())
			damaged_bodypart_text += "<span class='alert'>[limb.name] в плохом состоянии.</span>"
	if(length(damaged_bodypart_text))
		box += jointext(damaged_bodypart_text, "\n")
	else
		box += "<span class='info'>У него нет заметных ран.</span>"
	. += box
	if(on_examined_check(user, TRUE))
		user.on_examine_atom(src, TRUE)
