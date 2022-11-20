/// Randomizes the character according to preferences.
/datum/preferences/apply_character_randomization_prefs(antag_override = FALSE)
	if(!randomise[RANDOM_BODY] && !(antag_override && randomise[RANDOM_BODY_ANTAG]))
		return // Prefs say "no, thank you"
	if(randomise[RANDOM_GENDER] || (randomise[RANDOM_GENDER_ANTAG] && antag_override))
		gender = pick(MALE,FEMALE)
		body_type = gender
	if(randomise[RANDOM_SPECIES])
		random_species()
	if(randomise[RANDOM_NAME])
		real_name = pref_species.random_name(gender,TRUE)
	if(randomise[RANDOM_AGE] || (randomise[RANDOM_AGE_ANTAG] && antag_override))
		age = rand(AGE_MIN,AGE_MAX)
	if(randomise[RANDOM_BACKPACK])
		backpack = random_backpack()
	if(randomise[RANDOM_JUMPSUIT_STYLE])
		jumpsuit_style = pick(GLOB.jumpsuitlist)
	if(randomise[RANDOM_HAIRSTYLE])
		hairstyle = random_hairstyle(gender)
	if(randomise[RANDOM_FACIAL_HAIRSTYLE])
		facial_hairstyle = random_facial_hairstyle(gender)
	if(randomise[RANDOM_HAIR_COLOR])
		hair_color = random_short_color()
	if(randomise[RANDOM_FACIAL_HAIR_COLOR])
		facial_hair_color = random_short_color()
	if(randomise[RANDOM_SKIN_TONE])
		set_skin_tone(random_skin_tone())
	if(randomise[RANDOM_EYE_COLOR])
		left_eye_color = random_eye_color()
		right_eye_color = left_eye_color
	if(randomise[RANDOM_FEATURES])
		var/list/new_features = pref_species.get_random_features() //We do this to keep flavor text, genital sizes etc.
		for(var/key in new_features)
			features[key] = new_features[key]
		mutant_bodyparts = pref_species.get_random_mutant_bodyparts(features)
		body_markings = pref_species.get_random_body_markings(features)

/// Fully randomizes everything in the character.
/datum/preferences/randomise_appearance_prefs(randomise_flags = ALL)
	if(randomise_flags & RANDOMIZE_GENDER)
		gender = pick(MALE,FEMALE)
		body_type = gender
	if(randomise_flags & RANDOMIZE_SPECIES)
		var/rando_race = GLOB.species_list[pick(GLOB.roundstart_races)]
		pref_species = new rando_race()
	if(randomise_flags & RANDOMIZE_NAME)
		real_name = pref_species.random_name(gender,TRUE)
	if(randomise_flags & RANDOMIZE_AGE)
		age = rand(AGE_MIN,AGE_MAX)
	if(randomise_flags & RANDOMIZE_BACKPACK)
		backpack = random_backpack()
	if(randomise_flags & RANDOMIZE_JUMPSUIT_STYLE)
		jumpsuit_style = pick(GLOB.jumpsuitlist)
	if(randomise_flags & RANDOMIZE_HAIRSTYLE)
		hairstyle = random_hairstyle(gender)
	if(randomise_flags & RANDOMIZE_FACIAL_HAIRSTYLE)
		facial_hairstyle = random_facial_hairstyle(gender)
	if(randomise_flags & RANDOMIZE_HAIR_COLOR)
		hair_color = random_short_color()
	if(randomise_flags & RANDOMIZE_FACIAL_HAIR_COLOR)
		facial_hair_color = random_short_color()
	if(randomise_flags & RANDOMIZE_SKIN_TONE)
		set_skin_tone(random_skin_tone())
	if(randomise_flags & RANDOMIZE_EYE_COLOR)
		left_eye_color = random_eye_color()
		right_eye_color = left_eye_color
	if(randomise_flags & RANDOMIZE_FEATURES)
		var/list/new_features = pref_species.get_random_features() //We do this to keep flavor text, genital sizes etc.
		for(var/key in new_features)
			features[key] = new_features[key]
		mutant_bodyparts = pref_species.get_random_mutant_bodyparts(features)
		body_markings = pref_species.get_random_body_markings(features)

//This proc makes sure that we only have the parts that the species should have, add missing ones, remove extra ones(should any be changed)
//Also, this handles missing color keys
/datum/preferences/proc/validate_species_parts()
	if(!pref_species)
		return

	var/list/target_bodyparts = pref_species.default_mutant_bodyparts.Copy()

	//Remove all "extra" accessories
	for(var/key in mutant_bodyparts)
		if(!GLOB.sprite_accessories[key]) //That accessory no longer exists, remove it
			mutant_bodyparts -= key
			continue
		if(!pref_species.default_mutant_bodyparts[key])
			mutant_bodyparts -= key
			continue
		if(!GLOB.sprite_accessories[key][mutant_bodyparts[key][MUTANT_INDEX_NAME]]) //The individual accessory no longer exists
			mutant_bodyparts[key][MUTANT_INDEX_NAME] = pref_species.default_mutant_bodyparts[key]
		validate_color_keys_for_part(key) //Validate the color count of each accessory that wasnt removed

	//Add any missing accessories
	for(var/key in target_bodyparts)
		if(!mutant_bodyparts[key])
			var/datum/sprite_accessory/SA
			if(target_bodyparts[key] == ACC_RANDOM)
				SA = random_accessory_of_key_for_species(key, pref_species)
			else
				SA = GLOB.sprite_accessories[key][target_bodyparts[key]]
			var/final_list = list()
			final_list[MUTANT_INDEX_NAME] = SA.name
			final_list[MUTANT_INDEX_COLOR] = SA.get_default_color(features, pref_species)
			mutant_bodyparts[key] = final_list

	if(!allow_advanced_colors)
		reset_colors()

/datum/preferences/proc/validate_color_keys_for_part(key)
	var/datum/sprite_accessory/SA = GLOB.sprite_accessories[key][mutant_bodyparts[key][MUTANT_INDEX_NAME]]
	var/list/colorlist = mutant_bodyparts[key][MUTANT_INDEX_COLOR]
	if(SA.color_src == USE_MATRIXED_COLORS && LAZYLEN(colorlist) != 3)
		mutant_bodyparts[key][MUTANT_INDEX_COLOR] = SA.get_default_color(features, pref_species)
	else if(SA.color_src == USE_ONE_COLOR && LAZYLEN(colorlist) != 1)
		mutant_bodyparts[key][MUTANT_INDEX_COLOR] = SA.get_default_color(features, pref_species)

/datum/preferences/proc/set_new_species(new_species_path)
	pref_species = new new_species_path()
	var/list/new_features = pref_species.get_random_features() //We do this to keep flavor text, genital sizes etc.
	for(var/key in new_features)
		features[key] = new_features[key]
	mutant_bodyparts = pref_species.get_random_mutant_bodyparts(features)
	body_markings = pref_species.get_random_body_markings(features)
	if(pref_species.use_skintones)
		features["uses_skintones"] = TRUE
	//We reset the quirk-based stuff
	augments = list()
	all_quirks = list()
	//Reset cultural stuff
	pref_birthsign = pref_species.culture_birthsigns[1]
	try_get_common_language()
	validate_languages()

/datum/preferences/proc/reset_colors()
	for(var/key in mutant_bodyparts)
		var/datum/sprite_accessory/SA = GLOB.sprite_accessories[key][mutant_bodyparts[key][MUTANT_INDEX_NAME]]
		if(SA.always_color_customizable)
			continue
		mutant_bodyparts[key][MUTANT_INDEX_COLOR] = SA.get_default_color(features, pref_species)

	for(var/zone in body_markings)
		var/list/bml = body_markings[zone]
		for(var/key in bml)
			var/datum/body_marking/BM = GLOB.body_markings[key]
			bml[key] = BM.get_default_color(features, pref_species)

/datum/preferences/random_species()
	var/random_species_type = GLOB.species_list[pick(GLOB.roundstart_races)]
	set_new_species(random_species_type)
	if(randomise[RANDOM_NAME])
		real_name = pref_species.random_name(gender,1)

/datum/preferences/update_preview_icon()
	// Determine what job is marked as 'High' priority, and dress them up as such.
	var/datum/job/previewJob
	var/highest_pref = 0
	for(var/job in job_preferences)
		if(job_preferences[job] > highest_pref)
			previewJob = SSjob.GetJob(job)
			highest_pref = job_preferences[job]
	if(previewJob)
		// Silicons only need a very basic preview since there is no customization for them.
		if(istype(previewJob,/datum/job/ai))
			parent.show_character_previews(image('icons/mob/ai.dmi', icon_state = resolve_ai_icon(preferred_ai_core_display), dir = SOUTH))
			return
		if(istype(previewJob,/datum/job/cyborg))
			parent.show_character_previews(image('icons/mob/robots.dmi', icon_state = "robot", dir = SOUTH))
			return
	// Set up the dummy for its photoshoot
	var/mob/living/carbon/human/dummy/mannequin = generate_or_wait_for_human_dummy(DUMMY_HUMAN_SLOT_PREFERENCES)
	switch(preview_pref)
		if(PREVIEW_PREF_JOB)
			if(previewJob)
				mannequin.job = previewJob.title
				mannequin.dress_up_as_job(previewJob, TRUE)
			mannequin.underwear_visibility = NONE
		if(PREVIEW_PREF_LOADOUT)
			mannequin.underwear_visibility = NONE
			equip_preference_loadout(mannequin, TRUE, previewJob)
			mannequin.underwear_visibility = NONE
		if(PREVIEW_PREF_NAKED)
			mannequin.underwear_visibility = UNDERWEAR_HIDE_UNDIES | UNDERWEAR_HIDE_SHIRT | UNDERWEAR_HIDE_SOCKS
	apply_prefs_to(mannequin, TRUE, TRUE, TRUE)

	COMPILE_OVERLAYS(mannequin)
	var/mutable_appearance/appearance_thing = new /mutable_appearance(mannequin)
	parent.show_character_previews(appearance_thing)
	unset_busy_human_dummy(DUMMY_HUMAN_SLOT_PREFERENCES)

/datum/preferences/proc/equip_preference_loadout(mob/living/carbon/human/backpacker, just_preview = FALSE, datum/job/chosen_job, blacklist, initial)
	if(!ishuman(backpacker))
		return
	var/list/items_to_pack = list()
	for(var/item_name in loadout)
		var/datum/loadout_item/loadout_item = GLOB.loadout_items[item_name]
		var/obj/item/item = loadout_item.get_spawned_item(loadout[item_name])
		//Skip the item if the job doesn't match, but only if that not used for the preview
		if(!just_preview && (loadout_item.restricted_roles && chosen_job.type && !(chosen_job in loadout_item.restricted_roles)))
			continue
		if(!backpacker.equip_to_appropriate_slot(item))
			if(!just_preview)
				items_to_pack += item
				//Here we stick it into a bag, if possible
				if(!backpacker.equip_to_slot_if_possible(item, ITEM_SLOT_BACKPACK, disable_warning = TRUE, bypass_equip_delay_self = TRUE, initial=initial))
					//Otherwise - on the ground
					item.forceMove(get_turf(backpacker))
			else
				qdel(item)
	return items_to_pack

//This needs to be a seperate proc because the character could not have the proper backpack during the moment of loadout equip
/datum/preferences/proc/add_packed_items(mob/living/carbon/human/backpacker, list/packed_items, del_on_fail = TRUE)
	//Here we stick loadout items that couldn't be equipped into a bag.
	var/obj/item/back_item = backpacker.back
	for(var/thing in packed_items)
		var/obj/item/item = thing
		if(back_item)
			SEND_SIGNAL(back_item, COMSIG_TRY_STORAGE_INSERT, item, backpacker, TRUE, TRUE)
		else if (del_on_fail)
			qdel(item)
		else
			item.forceMove(get_turf(backpacker))
