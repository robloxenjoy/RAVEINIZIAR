/obj/item/healthanalyzer
	carry_weight = 500 GRAMS
	var/datum/weakref/analyzing
	var/current_dummy_key = ""
	var/current_funny_quote = ""

/obj/item/healthanalyzer/interact(mob/user)
	add_fingerprint(user)

/obj/item/healthanalyzer/attack_self(mob/user, modifiers)
	. = ..()
	if(user.is_blind())
		to_chat(user, span_warning("The scanner doesn't support braille. Damn."))
		return
	/* fucked up for now
	if(analyzing)
		ui_interact(user)
	*/

/obj/item/healthanalyzer/attack(mob/living/M, mob/living/user, params)
	. = ..()
	if(user.is_blind())
		to_chat(user, span_warning("The scanner doesn't support braille. Damn."))
		return
	if(DOING_INTERACTION_WITH_TARGET(user, M))
		return
	user.visible_message(span_notice("<b>[user]</b> tries to scan <b>[M]</b> with [src]."),
					span_notice("I try to scan <b>[M]</b> with [src]."),
					ignored_mobs = M)
	if(!M.is_blind())
		to_chat(M, span_notice("<b>[user]</b> tries to scan me with [src]."))
	if(!do_mob(user, M, 1 SECONDS))
		to_chat(user, span_warning("I must stay still!"))
		return
	user.visible_message(span_notice("<b>[user]</b> scans <b>[M]</b> with [src]."),
					span_notice("I scan <b>[M]</b> with [src]."),
					ignored_mobs = M)
	if(!M.is_blind())
		to_chat(M, span_notice("<b>[user]</b> scans me with [src]."))
	analyzing = WEAKREF(M)
	var/mob/living/carbon/human/human_mob
	if(ishuman(M))
		human_mob = M
	var/patient_initials = get_name_initials(M.name)
	var/patient_age = (human_mob ? human_mob.age : 1)
	var/list/funny_quotes = list(
		"-emia meaning presence in blood.",
		"\"[patient_initials]\" is a [patient_age] year old [M.gender] presenting to the emergency room...",
		"This is what happened to [M.p_their()] [pick("heart", "liver", "stomach", "brain", "kidneys", "organs", "intestines")].",
		"This is how [M.p_their()] [pick("organs", "kidneys", "stomach", "intestines", "liver")] shut down.",
		"Heme Review!",
		"150 gummy vitamins.",
		"25 packs of silica gel.",
		"2 liters of fiber supplement.",
		"3 laundry pods.",
		"An apple a day keeps the doctor away.",
		"Surgeon Simulator [GLOB.year_integer]",
	)
	current_funny_quote = pick(funny_quotes)
	/* fucked up for now
	ui_interact(user)
	*/
	healthscan(user, M, mode, advanced)

/obj/item/healthanalyzer/ui_interact(mob/user, datum/tgui/ui)
	ui = SStgui.try_update_ui(user, src, ui)
	if(!ui)
		ui = new(user, src, "HealthAnalyzer")
		ui.open()

/obj/item/healthanalyzer/ui_status(mob/user)
	var/mob/living/analyzed_mob = analyzing?.resolve()
	if(!analyzed_mob)
		return UI_CLOSE
	if(!(user.is_holding(src)))
		return UI_CLOSE
	return min(
		ui_status_user_is_advanced_tool_user(user),
		ui_status_only_living(user, src),
		ui_status_user_has_free_hands(user, src),
		ui_status_user_is_adjacent(user, src),
		ui_status_user_is_adjacent(user, analyzed_mob),
		max(
			ui_status_user_is_conscious_and_lying_down(user),
			ui_status_user_is_abled(user, src),
		),
	)

/obj/item/healthanalyzer/ui_data(mob/user)
	var/list/data = list()
	var/mob/living/analyzed_mob = analyzing?.resolve()
	if(!istype(analyzed_mob))
		return data
	var/mob/living/carbon/carbon_mob
	if(iscarbon(analyzed_mob))
		carbon_mob = analyzed_mob
	var/mob/living/carbon/human/human_mob
	if(ishuman(analyzed_mob))
		human_mob = analyzed_mob
	var/is_advanced = (advanced || analyzed_mob.has_reagent(/datum/reagent/inverse/technetium))
	switch(analyzed_mob.stat)
		if(DEAD)
			data["status"] = "Dead"
		if(UNCONSCIOUS, HARD_CRIT)
			data["status"] = "Unconcious"
		else
			if(HAS_TRAIT(analyzed_mob, TRAIT_FAKEDEATH) && !is_advanced)
				data["status"] = "Dead"
			else
				data["status"] = "Conscious"
	data["catatonic"] = FALSE
	if(!analyzed_mob.key && !(analyzed_mob.ai_controller?.ai_status == AI_STATUS_ON))
		data["catatonic"] = "Catatonic"
	else if(!analyzed_mob.client)
		data["catatonic"] = "Space Sleep Disorder"
	data["anencephalic"] = (!analyzed_mob.getorganslot(ORGAN_SLOT_BRAIN) ? "Anencephalic" : FALSE)
	data["brain_activity"] = CEILING(analyzed_mob.health/analyzed_mob.maxHealth*100, 1)
	data["overall_damage"] = analyzed_mob.get_physical_damage()
	data["oxyloss"] = analyzed_mob.getOxyLoss()
	data["toxloss"] = analyzed_mob.getToxLoss()
	data["cloneloss"] = analyzed_mob.getCloneLoss()
	data["fireloss"] = analyzed_mob.getFireLoss()
	data["bruteloss"] = analyzed_mob.getBruteLoss()
	data["staminaloss"] = analyzed_mob.getStaminaLoss()
	data["traumatic_shock"] = analyzed_mob.getShock()
	data["shock_stage"] = analyzed_mob.getShockStage()
	data["husked"] = FALSE
	if(is_advanced && HAS_TRAIT_FROM(analyzed_mob, TRAIT_HUSK, BURN))
		data["husked"] = "Husked by burns"
	else if(is_advanced && HAS_TRAIT_FROM(analyzed_mob, TRAIT_HUSK, CHANGELING_DRAIN))
		data["husked"] = "Husked by dessication"
	else if(HAS_TRAIT(analyzed_mob, TRAIT_HUSK))
		data["husked"] = "Husked by unknown source"
	data["disfigured"] = FALSE
	if(is_advanced && HAS_TRAIT_FROM(analyzed_mob, TRAIT_DISFIGURED, BRUTE))
		data["disfigured"] = "Disfigured by brute trauma"
	else if(is_advanced && HAS_TRAIT_FROM(analyzed_mob, TRAIT_DISFIGURED, BURN))
		data["disfigured"] = "Disfigured by burns"
	else if(is_advanced && HAS_TRAIT_FROM(analyzed_mob, TRAIT_DISFIGURED, GERM_LEVEL_TRAIT))
		data["disfigured"] = "Disfigured by necrosis"
	else if(HAS_TRAIT(analyzed_mob, TRAIT_DISFIGURED))
		data["disfigured"] = "Disfigured by unknown source"
	data["brain_traumas"] = list()
	for(var/datum/brain_trauma/brain_trauma as anything in carbon_mob.get_traumas())
		var/list/this_trauma = list()
		this_trauma["name"] = brain_trauma.name
		switch(brain_trauma.resilience)
			if(TRAUMA_RESILIENCE_BASIC)
				this_trauma["resilience"] = "Moderate"
			if(TRAUMA_RESILIENCE_SURGERY)
				this_trauma["resilience"] = "Severe"
			if(TRAUMA_RESILIENCE_LOBOTOMY)
				this_trauma["resilience"] = "Deep-Rooted "
			if(TRAUMA_RESILIENCE_WOUND)
				this_trauma["resilience"] = "Trauma-derived "
			if(TRAUMA_RESILIENCE_MAGIC, TRAUMA_RESILIENCE_ABSOLUTE)
				this_trauma["resilience"] = "Permanent"
		this_trauma["scan_desc"] = brain_trauma.desc

		data["brain_traumas"] += list(this_trauma)
	data["major_disabilities"] = list()
	if(carbon_mob)
		for(var/datum/quirk/disability in carbon_mob.get_quirks(CAT_QUIRK_MAJOR_DISABILITY))
			var/list/this_disability = list()
			this_disability["name"] = disability.name
			this_disability["desc"] = disability.desc
			this_disability["scan_desc"] = disability.medical_record_text

			data["major_disabilities"] += list(this_disability)
	data["minor_disabilities"] = list()
	if(carbon_mob)
		for(var/datum/quirk/disability in carbon_mob.get_quirks(CAT_QUIRK_MINOR_DISABILITY))
			var/list/this_disability = list()
			this_disability["name"] = disability.name
			this_disability["desc"] = disability.desc
			this_disability["scan_desc"] = disability.medical_record_text

			data["minor_disabilities"] += list(this_disability)
	data["neutral_disabilities"] = list()
	if(is_advanced && carbon_mob)
		for(var/datum/quirk/disability in carbon_mob.get_quirks(CAT_QUIRK_NOTES))
			var/list/this_disability = list()
			this_disability["name"] = disability.name
			this_disability["desc"] = disability.desc
			this_disability["scan_desc"] = disability.medical_record_text

			data["neutral_disabilities"] += list(this_disability)
	data["cardiac_arrest"] = (carbon_mob?.undergoing_cardiac_arrest() ? "Cardiac Arest" : FALSE)
	data["radiation"] = (analyzed_mob.GetComponent(/datum/component/irradiated) ? TRUE : FALSE)
	data["hallucinating"] = FALSE
	if(is_advanced)
		data["hallucinating"] = (analyzed_mob.hallucinating() ? "Hallucinating" : FALSE)
	data["bodyparts"] = list()
	data["organs"] = list()
	if(carbon_mob)
		data["bodyparts"] = list()
		for(var/zone in ALL_BODYPARTS_CHECKSELF)
			var/obj/item/bodypart/bodypart = carbon_mob.get_bodypart_nostump(zone)
			var/list/this_bodypart = list()
			this_bodypart["zone"] = capitalize_like_old_man(parse_zone(zone))
			if(!bodypart)
				this_bodypart["name"] = "Missing"
			else
				this_bodypart["name"] = capitalize_like_old_man(bodypart.name)
				switch(bodypart.status)
					if(BODYPART_ORGANIC)
						this_bodypart["status"] = "Organic"
					else
						this_bodypart["status"] = "Robotic"
				this_bodypart["max_damage"] = bodypart.max_damage
				this_bodypart["overall_damage"] = (bodypart.brute_dam + bodypart.burn_dam)
				this_bodypart["bruteloss"] = bodypart.brute_dam
				this_bodypart["fireloss"] = bodypart.burn_dam
				this_bodypart["max_stam_damage"] = bodypart.max_stamina_damage
				this_bodypart["staminaloss"] = bodypart.stamina_dam
				this_bodypart["max_pain"] = bodypart.max_pain_damage
				this_bodypart["traumatic_shock"] = bodypart.get_shock(TRUE, TRUE)
				this_bodypart["germ_level"] = CEILING(bodypart.germ_level/INFECTION_LEVEL_THREE*100, 1)
				this_bodypart["organs"] = list()
				for(var/obj/item/organ/organ as anything in bodypart.get_organs())
					if(organ.scanner_hidden)
						continue
					var/list/this_organ = list()
					this_organ["name"] = capitalize_like_old_man(organ.name)
					switch(organ.status)
						if(ORGAN_ORGANIC)
							this_organ["status"] = "Organic"
						else
							this_organ["status"] = "Robotic"
					this_organ["overall_damage"] = "Healthy"
					if(organ.is_necrotic())
						this_organ["overall_damage"] = "Necrotic"
					else if(organ.is_dead())
						this_organ["overall_damage"] = "Destroyed"
					else if(organ.is_failing())
						this_organ["overall_damage"] = "Failing"
					else if(organ.damage >= organ.high_threshold)
						this_organ["overall_damage"] = "Severely Damaged"
					else if(organ.damage >= organ.low_threshold)
						this_organ["overall_damage"] = "Mildly Damaged"
					else if(organ.damage && is_advanced)
						this_organ["overall_damage"] = "Minorly Damaged"
					this_organ["max_damage"] = organ.maxHealth
					this_organ["damage"] = organ.damage
					this_organ["germ_level"] = CEILING(organ.germ_level/INFECTION_LEVEL_THREE*100, 1)
					var/list/efficiencies = list()
					for(var/slot in organ.organ_efficiency)
						var/list/this_efficiency = list()
						this_efficiency["slot"] = capitalize_like_old_man(slot)
						this_efficiency["value"] = organ.organ_efficiency[slot]

						efficiencies += list(this_efficiency)
					this_organ["efficiencies"] = efficiencies

					this_bodypart["organs"] += list(this_organ)
			data["bodyparts"] += list(this_bodypart)

	data["genetic_stability"] = 100
	if(is_advanced && carbon_mob)
		data["genetic_stability"] = carbon_mob.dna.stability
	data["species"] = "Unknown"
	data["core_temperature"] = analyzed_mob.bodytemperature
	if(human_mob)
		data["core_temperature"] = human_mob.coretemperature
		data["species"] = human_mob.dna.species.name
	data["body_temperature"] = analyzed_mob.bodytemperature
	data["timeofdeath"] = DisplayTimeText(analyzed_mob.timeofdeath)
	data["diseases"] = list()
	for(var/datum/disease/disease as anything in analyzed_mob.diseases)
		var/list/disease_data = list()
		disease_data["name"] = disease.name
		disease_data["form"] = disease.form
		disease_data["agent"] = disease.agent
		disease_data["type"] = disease.spread_text
		disease_data["stage"] = disease.stage
		disease_data["max_stage"] = disease.max_stages
		disease_data["cure"] = disease.cure_text
		disease_data["severity"] = disease.severity
		disease_data["hopelessness"] = disease.hopelessness

		data["diseases"] += list(disease_data)
	var/blood_id = analyzed_mob.get_blood_id()
	var/datum/reagent/bloodreagent = blood_id
	data["blood_id"] = blood_id
	data["blood_name"] = "Blood"
	if(blood_id)
		data["blood_name"] = initial(bloodreagent.name)
	data["blood_type"] = "Unknown"
	data["bleed_rate"] = 0
	if(carbon_mob)
		data["bleed_rate"] = carbon_mob.get_total_bleed_rate()
		if(carbon_mob.has_dna())
			var/blood_type = carbon_mob.dna.blood_type
			if(blood_id != /datum/reagent/blood) // special blood substance
				var/datum/reagent/R = GLOB.chemical_reagents_list[blood_id]
				blood_type = R ? R.name : blood_id
			data["blood_type"] = blood_type
		data["pulse"] = carbon_mob.get_pulse(is_advanced ? GETPULSE_ADVANCED : GETPULSE_BASIC)
		var/normal_volume = GET_EFFECTIVE_BLOOD_VOL(BLOOD_VOLUME_NORMAL, carbon_mob.total_blood_req)
		data["normal_blood_volume"] = normal_volume
		var/okay_volume = GET_EFFECTIVE_BLOOD_VOL(BLOOD_VOLUME_NORMAL, carbon_mob.total_blood_req)
		data["okay_blood_volume"] = okay_volume
		var/safe_volume = GET_EFFECTIVE_BLOOD_VOL(BLOOD_VOLUME_SAFE, carbon_mob.total_blood_req)
		data["safe_blood_volume"] = safe_volume
		var/volume = carbon_mob.blood_volume
		data["blood_volume"] = volume
		data["blood_volume_perc"] = CEILING(volume/normal_volume*100, 1)
		var/circulation = carbon_mob.get_blood_circulation()
		data["blood_circulation"] = circulation
		data["blood_circulation_perc"] = CEILING(circulation/normal_volume*100, 1)
		var/oxygenation = carbon_mob.get_blood_oxygenation()
		data["blood_oxygenation"] = oxygenation
		data["blood_oxygenation_perc"] = CEILING(oxygenation/normal_volume*100, 1)
	if(analyzed_mob.reagents)
		data["blood_reagents"] = list()
		for(var/datum/reagent/reagent as anything in analyzed_mob.reagents.reagent_list)
			//Don't show hidden chems
			if(reagent.chemical_flags & REAGENT_INVISIBLE)
				continue
			else if(!is_advanced && (reagent.chemical_flags & REAGENT_VISIBLE_ADVANCED))
				continue
			var/list/this_reagent = list()
			this_reagent["name"] = capitalize_like_old_man(reagent.name)
			this_reagent["volume"] = CEILING(reagent.volume, 0.001)
			this_reagent["overdosing"] = reagent.overdosed

			data["blood_reagents"] += list(this_reagent)
		data["stomach_reagents"] = list()
		var/list/stomachs = analyzed_mob.getorganslotlist(ORGAN_SLOT_STOMACH)
		for(var/obj/item/organ/belly as anything in stomachs)
			for(var/datum/reagent/nommed as anything in belly.reagents?.reagent_list)
				//Don't show hidden chems
				if(nommed.chemical_flags & REAGENT_INVISIBLE)
					continue
				var/list/this_reagent = list()
				var/this_volume = nommed.volume
				if(belly.food_reagents[nommed.type])
					this_volume = max(this_volume - belly.food_reagents[nommed.type], 0)
				if(!this_volume)
					continue
				this_reagent["name"] = capitalize_like_old_man(nommed.name)
				this_reagent["volume"] = CEILING(this_volume, 0.001)
				this_reagent["overdosing"] = nommed.overdosed

				data["stomach_reagents"] += list(this_reagent)
		data["intestine_reagents"] = list()
		var/list/intestines = analyzed_mob.getorganslotlist(ORGAN_SLOT_INTESTINES)
		for(var/obj/item/organ/shitter as anything in intestines)
			for(var/datum/reagent/shitted as anything in shitter.reagents?.reagent_list)
				//Don't show hidden chems
				if(shitted.chemical_flags & REAGENT_INVISIBLE)
					continue
				var/list/this_reagent = list()
				var/this_volume = shitted.volume
				if(shitter.food_reagents[shitted.type])
					this_volume = max(this_volume - shitter.food_reagents[shitted.type], 0)
				if(!this_volume)
					continue
				this_reagent["name"] = capitalize_like_old_man(shitted.name)
				this_reagent["volume"] = CEILING(this_volume, 0.001)
				this_reagent["overdosing"] = shitted.overdosed

				data["intestine_reagents"] += list(this_reagent)
		data["bladder_reagents"] = list()
		var/list/bladder = analyzed_mob.getorganslotlist(ORGAN_SLOT_BLADDER)
		for(var/obj/item/organ/pisser as anything in bladder)
			for(var/datum/reagent/pissed as anything in pisser.reagents?.reagent_list)
				//Don't show hidden chems
				if(pissed.chemical_flags & REAGENT_INVISIBLE)
					continue
				var/list/this_reagent = list()
				var/this_volume = pissed.volume
				if(pisser.food_reagents[pissed.type])
					this_volume = max(this_volume - pisser.food_reagents[pissed.type], 0)
				if(!this_volume)
					continue
				this_reagent["name"] = capitalize_like_old_man(pissed.name)
				this_reagent["volume"] = CEILING(this_volume, 0.001)
				this_reagent["overdosing"] = pissed.overdosed

				data["bladder_reagents"] += list(this_reagent)
		data["addictions"] = list()
		for(var/datum/addiction/addiction as anything in analyzed_mob.mind?.active_addictions)
			var/list/this_addiction = list()
			this_addiction["name"] = capitalize_like_old_man(initial(addiction.name))
			this_addiction["addiction_points"] = analyzed_mob.mind.addiction_points[addiction]

			data["addictions"] += list(this_addiction)
	return data

/obj/item/healthanalyzer/ui_static_data(mob/user)
	var/list/data = list()

	var/mob/living/analyzed_mob = analyzing?.resolve()
	if(!istype(analyzed_mob))
		data["patient"] = "literally no one"
		return data
	var/is_advanced = (advanced || analyzed_mob.has_reagent(/datum/reagent/inverse/technetium))
	data["advanced"] = is_advanced
	data["patient"] = analyzed_mob.name
	data["funnyquote"] = current_funny_quote
	current_dummy_key = ""
	init_dummy()
	// We tried to init dummykey, but this may be a simple mob
	if(current_dummy_key)
		var/icon/dummysprite = get_flat_human_icon(null,
			dummy_key = current_dummy_key,
			showDirs = list(SOUTH))
		data["icon64"] = icon2base64(dummysprite)
		unset_busy_human_dummy(current_dummy_key)

	return data

/obj/item/healthanalyzer/ui_close(mob/user)
	. = ..()
	clear_human_dummy(current_dummy_key)

/obj/item/healthanalyzer/proc/init_dummy()
	var/mob/living/carbon/human/analyzed_human = analyzing?.resolve()
	if(!istype(analyzed_human))
		return
	current_dummy_key = "healthanalyzerUI_[analyzed_human]"
	generate_dummy_lookalike(current_dummy_key, analyzed_human)
