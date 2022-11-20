/datum/dna
	features = MANDATORY_FEATURE_LIST
	///Mutant parts of the DNA's owner - This is for storing their original state for re-creating the character; They'll get changed on species mutation
	var/list/list/mutant_bodyparts = list()
	///Body markings of the DNA's owner - This is for storing their original state for re-creating the character; They'll get changed on species mutation
	var/list/list/body_markings = list()
	///Current body size, used for proper re-sizing and keeping track of that
	var/current_body_size = BODY_SIZE_NORMAL

/datum/dna/initialize_dna(newblood_type, skip_index = FALSE)
	if(newblood_type)
		blood_type = newblood_type
	unique_enzymes = generate_unique_enzymes()
	unique_identity = generate_unique_identity()
	// I hate this
	if(!skip_index)
		generate_dna_blocks()
	features = species.get_random_features()
	mutant_bodyparts = species.get_random_mutant_bodyparts(features)
	unique_features = generate_unique_features()

/datum/dna/proc/generate_unique_features()
	var/list/data = list()

	if(features["mcolor"])
		data += sanitize_hexcolor(features["mcolor"], DNA_BLOCK_SIZE, FALSE)
	else
		data += random_string(DNA_BLOCK_SIZE,GLOB.hex_characters)
	if(features["mcolor2"])
		data += sanitize_hexcolor(features["mcolor2"], DNA_BLOCK_SIZE, FALSE)
	else
		data += random_string(DNA_BLOCK_SIZE,GLOB.hex_characters)
	if(features["mcolor3"])
		data += sanitize_hexcolor(features["mcolor3"], DNA_BLOCK_SIZE, FALSE)
	else
		data += random_string(DNA_BLOCK_SIZE,GLOB.hex_characters)
	if(features["ethcolor"])
		data += sanitize_hexcolor(features["ethcolor"], DNA_BLOCK_SIZE, FALSE)
	else
		data += random_string(DNA_BLOCK_SIZE,GLOB.hex_characters)
	if(features["skin_color"])
		data += sanitize_hexcolor(features["skin_color"], DNA_BLOCK_SIZE, FALSE)
	else
		data += random_string(DNA_BLOCK_SIZE,GLOB.hex_characters)
	for(var/key in GLOB.genetic_accessories)
		if(LAZYACCESS(mutant_bodyparts, key) && ((LAZYACCESSASSOC(mutant_bodyparts, key, MUTANT_INDEX_NAME)) in GLOB.genetic_accessories[key]) )
			var/list/accessories_for_key = GLOB.genetic_accessories[key]
			data += construct_block(accessories_for_key.Find(mutant_bodyparts[key][MUTANT_INDEX_NAME]), accessories_for_key.len)
			var/colors_to_randomize = DNA_BLOCKS_PER_FEATURE-1
			for(var/color in mutant_bodyparts[key][MUTANT_INDEX_COLOR])
				colors_to_randomize--
				data += sanitize_hexcolor(color, DNA_BLOCK_SIZE, FALSE)
			if(colors_to_randomize)
				data += random_string(DNA_BLOCK_SIZE*colors_to_randomize,GLOB.hex_characters)
		else
			data += random_string(DNA_BLOCK_SIZE*DNA_BLOCKS_PER_FEATURE,GLOB.hex_characters)
	for(var/zone in GLOB.marking_zones)
		if(body_markings[zone])
			data += construct_block(LAZYLEN(body_markings[zone])+1, MAXIMUM_MARKINGS_PER_LIMB+1)
			var/list/marking_list = GLOB.body_markings_per_limb[zone]
			var/markings_to_randomize = MAXIMUM_MARKINGS_PER_LIMB
			for(var/marking in body_markings[zone])
				markings_to_randomize--
				data += construct_block(marking_list.Find(marking), marking_list.len)
				data += sanitize_hexcolor(body_markings[zone][marking], DNA_BLOCK_SIZE, FALSE)
			if(markings_to_randomize)
				data += random_string(DNA_BLOCK_SIZE*markings_to_randomize*DNA_BLOCKS_PER_MARKING,GLOB.hex_characters)
		else
			data += construct_block(1, MAXIMUM_MARKINGS_PER_LIMB+1)
			data += random_string(DNA_BLOCK_SIZE*MAXIMUM_MARKINGS_PER_LIMB*DNA_BLOCKS_PER_MARKING,GLOB.hex_characters)
	return data.Join()

/datum/dna/proc/update_uf_block(blocknumber)
	if(!blocknumber)
		CRASH("UF block index is null")
	if(blocknumber<1 || blocknumber>DNA_FEATURE_BLOCKS)
		CRASH("UF block index out of bounds")
	if(!ishuman(holder))
		CRASH("Non-human mobs shouldn't have DNA")
	if(blocknumber <= DNA_MANDATORY_COLOR_BLOCKS)
		switch(blocknumber)
			if(DNA_MUTANT_COLOR_BLOCK)
				setblock(unique_features, blocknumber, sanitize_hexcolor(features["mcolor"], DNA_BLOCK_SIZE, FALSE))
			if(DNA_MUTANT_COLOR_2_BLOCK)
				setblock(unique_features, blocknumber, sanitize_hexcolor(features["mcolor2"], DNA_BLOCK_SIZE, FALSE))
			if(DNA_MUTANT_COLOR_3_BLOCK)
				setblock(unique_features, blocknumber, sanitize_hexcolor(features["mcolor3"], DNA_BLOCK_SIZE, FALSE))
			if(DNA_ETHEREAL_COLOR_BLOCK)
				setblock(unique_features, blocknumber, sanitize_hexcolor(features["ethcolor"], DNA_BLOCK_SIZE, FALSE))
			if(DNA_SKIN_COLOR_BLOCK)
				setblock(unique_features, blocknumber, sanitize_hexcolor(features["skin_color"], DNA_BLOCK_SIZE, FALSE))
	else if(blocknumber <= DNA_MANDATORY_COLOR_BLOCKS+(LAZYLEN(GLOB.genetic_accessories)*DNA_BLOCKS_PER_FEATURE))
		var/block_index = blocknumber - DNA_MANDATORY_COLOR_BLOCKS
		var/block_zero_index = block_index-1
		var/bodypart_index = (block_zero_index/DNA_BLOCKS_PER_FEATURE)+1
		var/color_index = block_zero_index%DNA_BLOCKS_PER_FEATURE
		var/key = GLOB.genetic_accessories[bodypart_index]
		if(LAZYACCESS(mutant_bodyparts, key))
			var/list/color_list = LAZYACCESSASSOC(mutant_bodyparts, key, MUTANT_INDEX_COLOR)
			if(color_index && color_index <= LAZYLEN(color_list))
				setblock(unique_features, blocknumber, sanitize_hexcolor(color_list[color_index], DNA_BLOCK_SIZE, FALSE))
			else
				var/list/accessories_for_key = GLOB.genetic_accessories[key]
				if((LAZYACCESSASSOC(mutant_bodyparts, key, MUTANT_INDEX_NAME)) in accessories_for_key)
					setblock(unique_features, blocknumber, construct_block(mutant_bodyparts.Find(mutant_bodyparts[key][MUTANT_INDEX_NAME]), LAZYLEN(accessories_for_key)))
	else
		var/block_index = blocknumber - (DNA_MANDATORY_COLOR_BLOCKS+(LAZYLEN(GLOB.genetic_accessories)*DNA_BLOCKS_PER_FEATURE))
		var/block_zero_index = block_index-1
		var/zone_index = (block_zero_index/DNA_BLOCKS_PER_MARKING_ZONE)+1
		var/zone = GLOB.marking_zones[zone_index]
		if(blocknumber == GLOB.dna_body_marking_blocks[zone])
			var/markings = 0
			if(body_markings[zone])
				markings = LAZYLEN(body_markings[zone])
			setblock(unique_features, blocknumber, construct_block(markings+1, MAXIMUM_MARKINGS_PER_LIMB+1))
		else
			var/color_block = ((block_zero_index%DNA_BLOCKS_PER_MARKING_ZONE)+1)%DNA_BLOCKS_PER_MARKING
			var/marking_index = (((block_zero_index-1)%DNA_BLOCKS_PER_MARKING_ZONE)/DNA_BLOCKS_PER_MARKING)+1
			if(body_markings[zone] && marking_index <= body_markings[zone].len)
				var/marking = body_markings[zone][marking_index]
				if(color_block)
					setblock(unique_features, blocknumber, sanitize_hexcolor(body_markings[zone][marking], DNA_BLOCK_SIZE, FALSE))
				else
					var/list/marking_list = GLOB.body_markings_per_limb[zone]
					setblock(unique_features, blocknumber, construct_block(marking_list.Find(marking), marking_list.len))

/datum/dna/proc/update_body_size()
	if(!holder || current_body_size == features["body_size"])
		return
	//We update the translation to make sure our character doesn't go out of the southern bounds of the tile
	var/change_multiplier = features["body_size"] / current_body_size
	var/translate = ((change_multiplier-1) * 32)/2
	holder.transform = holder.transform.Scale(change_multiplier)
	holder.transform = holder.transform.Translate(0, translate)
	current_body_size = features["body_size"]

/mob/living/carbon/set_species(datum/species/mrace, icon_update = TRUE, datum/preferences/pref_load, list/override_features, \
							list/override_mutantparts, list/override_markings, retain_features = FALSE, retain_mutantparts = FALSE, retain_markings = FALSE)
	if(mrace && has_dna())
		var/datum/species/new_race
		if(ispath(mrace))
			new_race = new mrace
		else if(istype(mrace))
			new_race = mrace
		else
			return
		deathsound = new_race.deathsound
		dna.species.on_species_loss(src, new_race, pref_load)
		var/datum/species/old_species = dna.species
		dna.species = new_race

		//BODYPARTS AND FEATURES
		if(!retain_features)
			var/list/new_features = MANDATORY_FEATURE_LIST
			if(LAZYLEN(override_features))
				for(var/thing in override_features)
					if(override_features[thing])
						new_features[thing] = override_features[thing]
			else
				var/list/random_features = new_race.get_random_features()
				for(var/thing in random_features)
					if(random_features[thing])
						new_features[thing] = random_features[thing]
			dna.features = new_features
		if(!retain_mutantparts)
			dna.mutant_bodyparts = override_mutantparts || new_race.get_random_mutant_bodyparts(dna.features)
		else
			var/list/list/random_parts = new_race.get_random_mutant_bodyparts(dna.features)
			var/list/list/compiled_list = list()
			for(var/key in (random_parts|dna.mutant_bodyparts))
				if(dna.mutant_bodyparts[key])
					compiled_list[key] = dna.mutant_bodyparts[key].Copy()
				else
					compiled_list[key] = random_parts[key].Copy()
		if(!retain_markings)
			dna.body_markings = override_markings || new_race.get_random_body_markings(dna.features)

		assimilate_dna_to_species()
		build_all_organs_from_dna()

		dna.unique_features = dna.generate_unique_features()
		dna.update_body_size()

		dna.species.on_species_gain(src, old_species, pref_load)
		//END OF BODYPARTS AND FEATURES

		if(ishuman(src))
			qdel(language_holder)
			var/species_holder = initial(mrace.species_language_holder)
			language_holder = new species_holder(src, pref_load)
		update_atom_languages()

/mob/living/carbon/human/set_species(datum/species/mrace, icon_update = TRUE, datum/preferences/pref_load, list/override_features, \
							list/override_mutantparts, list/override_markings, retain_features = FALSE, retain_mutantparts = FALSE)
	. = ..()
	if(icon_update)
		update_body()
		update_hair()
		update_body_parts()
		update_mutations_overlay()// no lizard with human hulk overlay please.

/mob/living/carbon/updateappearance(icon_update=TRUE, mutcolor_update=FALSE, mutations_overlay_update=FALSE)
	if(!has_dna())
		return

	switch(deconstruct_block(getblock(dna.unique_identity, DNA_GENDER_BLOCK), 3))
		if(G_MALE)
			gender = MALE
		if(G_FEMALE)
			gender = FEMALE
		else
			gender = PLURAL

/mob/living/carbon/human/updateappearance(icon_update=TRUE, mutcolor_update=FALSE, mutations_overlay_update=FALSE)
	. = ..()
	var/structure = dna.unique_identity
	hair_color = sanitize_hexcolor(getblock(structure, DNA_HAIR_COLOR_BLOCK), DNA_BLOCK_SIZE, FALSE)
	facial_hair_color = sanitize_hexcolor(getblock(structure, DNA_FACIAL_HAIR_COLOR_BLOCK), DNA_BLOCK_SIZE, FALSE)
	skin_tone = GLOB.skin_tones[deconstruct_block(getblock(structure, DNA_SKIN_TONE_BLOCK), LAZYLEN(GLOB.skin_tones))]
	height = GLOB.human_heights[deconstruct_block(getblock(structure, DNA_HEIGHT_BLOCK), LAZYLEN(GLOB.human_heights))]
	left_eye_color = sanitize_hexcolor(getblock(structure, DNA_LEFT_EYE_COLOR_BLOCK), DNA_BLOCK_SIZE, FALSE)
	right_eye_color = sanitize_hexcolor(getblock(structure, DNA_LEFT_EYE_COLOR_BLOCK), DNA_BLOCK_SIZE, FALSE)
	facial_hairstyle = GLOB.facial_hairstyles_list[deconstruct_block(getblock(structure, DNA_FACIAL_HAIRSTYLE_BLOCK), LAZYLEN(GLOB.facial_hairstyles_list))]
	hairstyle = GLOB.hairstyles_list[deconstruct_block(getblock(structure, DNA_HAIRSTYLE_BLOCK), LAZYLEN(GLOB.hairstyles_list))]
	var/features = dna.unique_features
	if(dna.features["mcolor"])
		dna.features["mcolor"] = sanitize_hexcolor(getblock(features, DNA_MUTANT_COLOR_BLOCK), DNA_BLOCK_SIZE, FALSE)
	if(dna.features["mcolor2"])
		dna.features["mcolor2"] = sanitize_hexcolor(getblock(features, DNA_MUTANT_COLOR_2_BLOCK), DNA_BLOCK_SIZE, FALSE)
	if(dna.features["mcolor3"])
		dna.features["mcolor3"] = sanitize_hexcolor(getblock(features, DNA_MUTANT_COLOR_3_BLOCK), DNA_BLOCK_SIZE, FALSE)
	if(dna.features["ethcolor"])
		dna.features["ethcolor"] = sanitize_hexcolor(getblock(features, DNA_ETHEREAL_COLOR_BLOCK), DNA_BLOCK_SIZE, FALSE)
	if(dna.features["skin_color"])
		dna.features["skin_color"] = sanitize_hexcolor(getblock(features, DNA_SKIN_COLOR_BLOCK), DNA_BLOCK_SIZE, FALSE)
	for(var/key in GLOB.genetic_accessories)
		if(dna.mutant_bodyparts[key] && (dna.mutant_bodyparts[key][MUTANT_INDEX_NAME] in GLOB.genetic_accessories[key]))
			var/bodypart_block = GLOB.dna_mutant_bodypart_blocks[key]
			var/list/accessories_for_key = GLOB.sprite_accessories[key]
			var/list/possible_accessories = GLOB.genetic_accessories[key]
			var/accessory_name = GLOB.genetic_accessories[key][deconstruct_block(getblock(features, bodypart_block), possible_accessories.len)]
			dna.mutant_bodyparts[key][MUTANT_INDEX_NAME] = accessory_name
			var/datum/sprite_accessory/accessory_to_apply = accessories_for_key[accessory_name]
			if(accessory_to_apply.factual)
				switch(accessory_to_apply.color_src)
					if(USE_ONE_COLOR)
						dna.mutant_bodyparts[key][MUTANT_INDEX_COLOR] = list(sanitize_hexcolor(getblock(features,bodypart_block+1), DNA_BLOCK_SIZE, FALSE))
					if(USE_MATRIXED_COLORS)
						dna.mutant_bodyparts[key][MUTANT_INDEX_COLOR] = list()
						dna.mutant_bodyparts[key][MUTANT_INDEX_COLOR] += sanitize_hexcolor(getblock(features,bodypart_block+1), DNA_BLOCK_SIZE, FALSE)
						dna.mutant_bodyparts[key][MUTANT_INDEX_COLOR] += sanitize_hexcolor(getblock(features,bodypart_block+2), DNA_BLOCK_SIZE, FALSE)
						dna.mutant_bodyparts[key][MUTANT_INDEX_COLOR] += sanitize_hexcolor(getblock(features,bodypart_block+3), DNA_BLOCK_SIZE, FALSE)
	for(var/zone in GLOB.marking_zones)
		var/marking_count_block = GLOB.dna_body_marking_blocks[zone]
		var/first_marking_block = marking_count_block+1
		var/marking_count = deconstruct_block(getblock(features, marking_count_block), 4)-1
		if(!marking_count && dna.body_markings[zone])
			dna.body_markings -= zone
		if(marking_count)
			if(!dna.body_markings[zone])
				dna.body_markings[zone] = list()
			dna.body_markings[zone].len = marking_count
			for(var/i in 1 to marking_count)
				var/marking = GLOB.body_markings_per_limb[zone][deconstruct_block(getblock(features, first_marking_block+(i-1)*DNA_BLOCKS_PER_MARKING), LAZYLEN(GLOB.body_markings_per_limb[zone]))]
				dna.body_markings[zone][i] = marking
				dna.body_markings[zone][marking] = sanitize_hexcolor(getblock(features, first_marking_block+(i-1)*DNA_BLOCKS_PER_MARKING+1), DNA_BLOCK_SIZE, FALSE)

	assimilate_dna_to_species()
	build_all_organs_from_dna()

	if(icon_update)
		// We want 'update_body_parts()' to be called only if mutcolor_update is TRUE, so no 'update_body()' here.
		dna.species.handle_body(src)
		update_hair()
		if(mutcolor_update)
			update_body_parts()
		if(mutations_overlay_update)
			update_mutations_overlay()

/mob/living/carbon/proc/assimilate_dna_to_species()
	if(!has_dna())
		CRASH("assimilate_dna_to_species() called but [src] does not have DNA!")
	dna.species.body_markings = LAZYCOPY(dna.body_markings)
	var/list/bodyparts_to_add = LAZYCOPY(dna.mutant_bodyparts)
	for(var/key in bodyparts_to_add)
		var/datum/sprite_accessory/accessory = LAZYACCESSASSOC(GLOB.sprite_accessories, key, bodyparts_to_add[key][MUTANT_INDEX_NAME])
		if(!accessory?.factual)
			bodyparts_to_add -= key
			continue
	dna.species.mutant_bodyparts = bodyparts_to_add

/mob/living/carbon/proc/build_all_organs_from_dna()
	if(!has_dna())
		CRASH("build_all_organs_from_dna() called but [src] does not have DNA!")
	for(var/obj/item/organ/organ as anything in internal_organs)
		if(!organ.mutantpart_key)
			continue
		organ.build_from_dna(dna, organ.mutantpart_key)
