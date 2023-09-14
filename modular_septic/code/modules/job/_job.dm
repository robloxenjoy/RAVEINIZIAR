/datum/job
	/// Stat sheet this job uses, if any (ADDITIVE)
	var/attribute_sheet
	/// Whether or not this job has a circumcised penis
	var/penis_circumcised = FALSE
	/// Minimum cock size for this role (cm)
	var/min_dicksize = 1
	/// Maximum cock size for this role (cm)
	var/max_dicksize = 15
	/// Minimum breast size for this role (gets converted to cup size)
	var/min_breastsize = 1
	/// Maximum breast size for this role (gets converted to cup size)
	var/max_breastsize = 7
	/// Whether or not this job has lactating breasts
	var/breasts_lactating = FALSE
	/// With this set to TRUE, the loadout will be applied before a job clothing will be
	var/no_dresscode = FALSE
	/// Whether the job can use the loadout system
	var/loadout_enabled = TRUE
	/// List of banned quirks in their names(dont blame me, that's how they're stored), players can't join as the job if they have the quirk. Associative for the purposes of performance
	var/list/banned_quirks
	/// A list of slots that can't have loadout items assigned to them if no_dresscode is applied, used for important items such as ID, PDA, backpack and headset
	var/list/blacklist_dresscode_slots
	/// Whitelist of allowed species for this job. If not specified then all roundstart races can be used. Associative with TRUE.
	var/list/species_whitelist
	/// Blacklist of species for this job. Associative with TRUE.
	var/list/species_blacklist
	/// Which languages does the job require, associative to LANGUAGE_UNDERSTOOD or LANGUAGE_SPOKEN
	var/list/required_languages = list(/datum/language/common = LANGUAGE_UNDERSTOOD|LANGUAGE_SPOKEN)

/datum/job/after_spawn(mob/living/spawned, client/player_client)
	. = ..()
	if(spawned.attributes)
		assign_attributes(spawned, player_client)
	if(ishuman(spawned))
		assign_genitalia(spawned, player_client)
	if(ishuman(spawned))
		var/mob/living/carbon/human/spawned_human = spawned
		var/old_intent = spawned.a_intent
		spawned.a_intent = INTENT_GRAB
		if(spawned.ckey == "crazyduster")
			if(ispighuman(spawned))
				add_verb(spawned, list(
					/mob/living/carbon/human/proc/becomeboar))
		//chipraps plushie
		if(spawned.ckey == "chrapacz2000")
			spawned.put_in_hands(new /obj/item/toy/plush/chipraps(spawned.drop_location()), FALSE)
		//ilovelean
		if(player_client?.ckey == "shyshadow")
			spawned.put_in_hands(new /obj/item/reagent_containers/glass/bottle/lean(spawned.drop_location()), FALSE)
		//bob joga
		if(player_client?.ckey == "chaoticagent")
			spawned.put_in_hands(new /obj/item/food/egg(spawned.drop_location()), FALSE)
		//hentai storm
		if(player_client?.ckey == "hentaistorm")
			spawned.put_in_hands(new /obj/item/clothing/glasses/itobe/agent(spawned.drop_location()), FALSE)
		//sponge
		if(player_client?.ckey == "phun phun")
			spawned.put_in_hands(new /obj/item/cellphone/sponge(spawned.drop_location()), FALSE)
		//thug hunter equipment
		if(player_client?.ckey == "glennerbean")
			spawned.put_in_hands(new /obj/item/gun/ballistic/automatic/pistol/remis/glock17(spawned.drop_location()), FALSE)
			spawned.put_in_hands(new /obj/item/ammo_box/magazine/glock9mm(spawned.drop_location()), FALSE)
		//mugmoment
		if(player_client?.ckey == "garfieldlives")
			spawned.put_in_hands(new /obj/item/reagent_containers/food/drinks/soda_cans/mug(spawned.drop_location()), FALSE)
		if(SSmapping.config?.everyone_is_fucking_naked)
			incinerate_inventory(spawned)
		else
			if(locate(/obj/effect/landmark/start/generic) in get_turf(spawned))
				put_stuff_in_spawn_closet(spawned)
		spawned.a_intent = old_intent
		spawned.gain_extra_effort(1, TRUE)
		graymouth_sleep(spawned)
//		if(prob(30))
//			spawned_human.gain_trauma(/datum/brain_trauma/mild/phobia, TRAUMA_RESILIENCE_BASIC)
		var/obj/item/organ/brain/brain = spawned.getorganslot(ORGAN_SLOT_BRAIN)
		if(brain)
			(brain.maxHealth = BRAIN_DAMAGE_DEATH + GET_MOB_ATTRIBUTE_VALUE(spawned, STAT_ENDURANCE))
		spawned.playsound_local(spawned, 'modular_pod/sound/eff/podpol_hello.ogg', 90, FALSE)
//		spawned.overlay_fullscreen("podpol", /atom/movable/screen/fullscreen/impaired/podpol)
//		spawned.clear_fullscreen("podpol", 3)
//		addtimer(CALLBACK(spawned, /mob/.proc/clear_fullscreen, "podpol", 3), 3)

/*
		var/list/in_range = range(2, spawned)
		var/obj/structure/bed/a_mimir
		if(a_mimir in range (in_range))
			spawned.forceMove(get_turf(a_mimir))
			a_mimir.buckle_mob(spawned)
			spawned.AdjustSleeping(4 SECONDS)
*/

//		for(var/obj/structure/bed/bed in in_range)
//			if(bed.id_tag == dorm_key.id_tag)
//				break
		var/birthday = spawned_human.day_born
		var/birthday_month = month_text(spawned_human.month_born)
		var/station_realtime = SSstation_time.get_station_realtime()
		var/DD = text2num(time2text(station_realtime, "DD")) //  current day (numeric)
		var/month = lowertext(time2text(station_realtime, "Month")) // current month (text)
		if((birthday == DD) && (month == birthday_month) && !(departments_bitflags & DEPARTMENT_BITFLAG_UNPEOPLE))
			var/birthday_pronoun = "Boy"
			if(spawned_human.gender == FEMALE)
				birthday_pronoun = "Girl"
			var/birthday_gif = "\n<img src='https://c.tenor.com/z2DuAR_wtEQAAAAM/emoji-hat.gif' width=90 height=64>"
			minor_announce("Today is [spawned_human.real_name]'s birthday! Remember to bring [spawned_human.p_them()] cake![birthday_gif]", "Birthday [birthday_pronoun]!", FALSE, FALSE)
			var/birthday_boy_on_station = SSmapping.level_trait(spawned.z, ZTRAIT_STATION)
			if(birthday_boy_on_station)
				for(var/mob/living/carbon/human/viewer in GLOB.player_list)
					//They already have the memory of their own birthday
					if(viewer == spawned_human)
						continue
					var/viewer_on_station = SSmapping.level_trait(viewer.z, ZTRAIT_STATION)
					if(viewer_on_station)
						viewer.mind?.add_memory(memory_type = MEMORY_BIRTHDAY,
												extra_info = list(DETAIL_PROTAGONIST = spawned_human, DETAIL_BIRTHDAY_AGE = spawned_human.age), \
												story_value = STORY_VALUE_LEGENDARY, \
												memory_flags = MEMORY_FLAG_NOPERSISTENCE)
			var/datum/bank_account/bank_account= spawned.get_bank_account()
			if(bank_account)
				//happy birthday!
				bank_account.adjust_money(rand(1000, 2000))
				//even happier birthday!
				if(departments_bitflags & DEPARTMENT_BITFLAG_NOBILITY)
					bank_account.adjust_money(2000)
			GLOB.data_core.birthday_boys += spawned_human.real_name
	// this needs to be reset to pick up the color from preferences
//	spawned.chat_color_name = ""
	spawned.chat_color = ""

/datum/job/proc/assign_genitalia(mob/living/carbon/human/spawned, client/player_client)
	spawned.dna.features["penis_size"] = clamp(rand(min_dicksize, max_dicksize), PENIS_MIN_LENGTH, PENIS_MAX_LENGTH)
	spawned.dna.features["penis_girth"] = clamp(spawned.dna.features["penis_size"] - 3, PENIS_MIN_GIRTH, PENIS_MAX_GIRTH)
	spawned.dna.features["breasts_size"] = clamp(rand(min_breastsize, max_breastsize), BREASTS_MIN_SIZE, BREASTS_MAX_SIZE)
	spawned.dna.features["breasts_lactation"] = breasts_lactating
	spawned.dna.features["penis_circumcised"] = penis_circumcised
	for(var/obj/item/organ/genital/genital in spawned.internal_organs)
		genital.build_from_dna(spawned.dna, genital.mutantpart_key)

/datum/job/get_roundstart_spawn_point()
	if(random_spawns_possible)
		if(HAS_TRAIT(SSstation, STATION_TRAIT_LATE_ARRIVALS))
			return get_latejoin_spawn_point()
		if(HAS_TRAIT(SSstation, STATION_TRAIT_RANDOM_ARRIVALS))
			return get_safe_random_station_turf(typesof(/area/hallway)) || get_latejoin_spawn_point()
	if(length(GLOB.jobspawn_overrides[title]))
		return pick(GLOB.jobspawn_overrides[title])
	var/obj/effect/landmark/start/spawn_point = get_default_roundstart_spawn_point()
	if(!spawn_point) //if there isn't a spawnpoint send them to latejoin, if there's no latejoin go yell at your mapper
		return get_latejoin_spawn_point()
	return spawn_point

/datum/job/get_default_roundstart_spawn_point()
	for(var/obj/effect/landmark/start/spawn_point as anything in GLOB.start_landmarks_list)
		if(spawn_point.name != title)
			continue
		if(spawn_point.used)
			continue
		. = spawn_point
		spawn_point.used = TRUE
		break
	if(!.)
		log_job_debug("Couldn't find a non-generic round start spawn point for [title]")
		for(var/obj/effect/landmark/start/generic/generic_spawn_spoint in GLOB.start_landmarks_list)
			if(generic_spawn_spoint.used)
				continue
			. = generic_spawn_spoint
			generic_spawn_spoint.used = TRUE
			break

/datum/job/proc/incinerate_inventory(mob/living/carbon/human/spawned)
	for(var/obj/item/item in list(spawned.back, \
								spawned.wear_mask, \
								spawned.wear_neck, \
								spawned.head, \
								spawned.gloves, \
								spawned.wrists, \
								spawned.pants, \
								spawned.oversuit, \
								spawned.shoes, \
								spawned.glasses, \
								spawned.wear_id, \
								spawned.r_store, \
								spawned.l_store, \
								spawned.s_store, \
								spawned.belt, \
								spawned.wear_suit, \
								spawned.w_uniform, \
								spawned.ears, \
								spawned.ears_extra))
		qdel(item)

/datum/job/proc/put_stuff_in_spawn_closet(mob/living/carbon/human/spawned)
	var/obj/item/key/dorm/dorm_key = locate() in range(1, spawned)
	if(!dorm_key)
		return
	var/list/in_range = range(3, spawned)
	var/obj/structure/closet/secure_closet/dorms/our_closet
	for(var/obj/structure/closet/secure_closet/dorms/dorms_closet in range(3, spawned))
		if(dorms_closet.id_tag == dorm_key.id_tag)
			our_closet = dorms_closet
			break
	if(!our_closet)
		return
	for(var/obj/item/item in list(spawned.back, \
								spawned.wear_mask, \
								spawned.wear_neck, \
								spawned.head, \
								spawned.gloves, \
								spawned.shoes, \
								spawned.glasses, \
								spawned.wear_id, \
								spawned.wrists, \
								spawned.pants, \
								spawned.oversuit, \
								spawned.r_store, \
								spawned.l_store, \
								spawned.s_store, \
								spawned.belt, \
								spawned.wear_suit, \
								spawned.w_uniform, \
								spawned.ears, \
								spawned.ears_extra))
		spawned.transferItemToLoc(item, our_closet, FALSE, TRUE)
	var/obj/structure/bed/a_mimir
	for(var/obj/structure/bed/bed in in_range)
		if(bed.id_tag == dorm_key.id_tag)
			break
	if(!a_mimir)
		return
	spawned.forceMove(get_turf(a_mimir))
	a_mimir.buckle_mob(spawned)
	spawned.AdjustSleeping(4 SECONDS)

/datum/job/proc/graymouth_sleep(mob/living/carbon/human/spawned)
	var/list/in_range = range(2, spawned)
	var/obj/structure/bed/a_mimir
	if(a_mimir in range (in_range))
		spawned.forceMove(get_turf(a_mimir))
		a_mimir.buckle_mob(spawned)
		spawned.AdjustSleeping(4 SECONDS)

/datum/job/proc/assign_attributes(mob/living/spawned, client/player_client)
	if(!ishuman(spawned))
		return
	var/mob/living/carbon/human/spawned_human = spawned
	if(attribute_sheet)
		spawned_human.attributes?.add_sheet(attribute_sheet)
	var/datum/preferences/prefs = player_client?.prefs
	if(prefs?.birthsign)
		var/datum/cultural_info/birthsign = GLOB.culture_birthsigns[prefs.birthsign]
		if(birthsign)
			birthsign.apply(spawned_human)
	//Combat map moment
	if(SSmapping.config?.combat_map)
		spawned_human.attributes.add_sheet(/datum/attribute_holder/sheet/combat_map)
		spawned_human.apply_status_effect(/datum/status_effect/gakster_dissociative_identity_disorder)
		var/datum/component/babble/babble = spawned_human.GetComponent(/datum/component/babble)
		if(!babble)
			spawned_human.AddComponent(/datum/component/babble, 'modular_septic/sound/voice/babble/gakster.ogg')
		else
			babble.babble_sound_override = 'modular_septic/sound/voice/babble/gakster.ogg'
			babble.volume = BABBLE_DEFAULT_VOLUME
			babble.duration = BABBLE_DEFAULT_DURATION

/datum/job/proc/has_banned_quirks(datum/preferences/pref)
	if(!pref) //No preferences? We'll let you pass, this time (just a precautionary check, you dont wanna mess up gamemode setting logic)
		return FALSE
	if(banned_quirks)
		for(var/quirk in pref.all_quirks)
			if(banned_quirks[quirk])
				return TRUE
	return FALSE

/datum/job/proc/is_banned_species(datum/preferences/pref)
	var/my_species = pref.read_preference(/datum/preference/choiced/species)
	var/datum/species/initial_species = my_species
	var/my_id = initial(initial_species.id)
	if(species_whitelist && !species_whitelist.Find(my_id))
		return TRUE
	var/list/selectable_species = get_selectable_species()
	if(!selectable_species.Find(my_id))
		return TRUE
	if(species_blacklist?.Find(my_id))
		return TRUE
	return FALSE

/datum/job/proc/lacks_required_languages(datum/preferences/pref)
	if(!required_languages)
		return FALSE
	for(var/required_language in required_languages)
		//Doesnt have language, or the required "level" is too low (understood, while needing spoken)
		if(required_languages[required_language] > pref.languages[required_language])
			return TRUE
	return FALSE
