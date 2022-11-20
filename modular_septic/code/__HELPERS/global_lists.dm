/proc/make_preferences_datum_references()
	make_sprite_accessory_references()
	make_body_marking_references()
	make_body_marking_set_references()
	make_body_marking_dna_block_references()
	make_augment_references()
	make_culture_references()

/proc/make_culture_references()
	if(!LAZYLEN(GLOB.culture_birthsigns))
		for(var/path in subtypesof(/datum/cultural_info/birthsign))
			var/datum/cultural_info/birthsign = path
			if(!initial(birthsign.name))
				continue
			birthsign = new path()
			GLOB.culture_birthsigns[path] = birthsign

/proc/make_sprite_accessory_references()
	// Here we build the global list for all accessories
	for(var/path in subtypesof(/datum/sprite_accessory))
		var/datum/sprite_accessory/sprite_accessory = path
		if(initial(sprite_accessory.key) && initial(sprite_accessory.name))
			sprite_accessory = new path()
			if(!GLOB.sprite_accessories[sprite_accessory.key])
				GLOB.sprite_accessories[sprite_accessory.key] = list()
			GLOB.sprite_accessories[sprite_accessory.key][sprite_accessory.name] = sprite_accessory
			if(sprite_accessory.genetic)
				if(!GLOB.dna_mutant_bodypart_blocks[sprite_accessory.key])
					GLOB.dna_mutant_bodypart_blocks[sprite_accessory.key] = GLOB.dna_total_feature_blocks+1
				if(!GLOB.genetic_accessories[sprite_accessory.key])
					GLOB.genetic_accessories[sprite_accessory.key] = list()
					GLOB.dna_total_feature_blocks += DNA_BLOCKS_PER_FEATURE
				GLOB.genetic_accessories[sprite_accessory.key] += sprite_accessory.name
			//TODO: Replace "generic" definitions with something better
			GLOB.generic_accessories[sprite_accessory.key] = sprite_accessory.generic

/proc/make_body_marking_references()
	// Here we build the global list for all body markings
	for(var/path in subtypesof(/datum/body_marking))
		var/datum/body_marking/body_marking = path
		if(initial(body_marking.name))
			body_marking = new path()
			GLOB.body_markings[body_marking.name] = body_marking
			//We go through all the possible affected bodyparts and a name reference where applicable
			for(var/marking_zone in GLOB.marking_zones)
				var/bitflag = GLOB.bodyzone_to_bitflag[marking_zone]
				if(body_marking.affected_bodyparts & bitflag)
					LAZYINITLIST(GLOB.body_markings_per_limb[marking_zone])
					GLOB.body_markings_per_limb[marking_zone] += body_marking.name

/proc/make_body_marking_set_references()
	// Here we build the global list for all body markings sets
	for(var/path in subtypesof(/datum/body_marking_set))
		var/datum/body_marking_set/body_marking_set = new path()
		if(body_marking_set.name)
			body_marking_set = new path()
			GLOB.body_marking_sets[body_marking_set.name] = body_marking_set

/proc/make_body_marking_dna_block_references()
	for(var/marking_zone in GLOB.marking_zones)
		GLOB.dna_body_marking_blocks[marking_zone] = GLOB.dna_total_feature_blocks+1
		GLOB.dna_total_feature_blocks += DNA_BLOCKS_PER_MARKING_ZONE

/proc/make_augment_references()
	// Here we build the global augment lists
	for(var/path in subtypesof(/datum/augment_item))
		var/datum/augment_item/augment_item = path
		//Should not be displayed to player
		if(!initial(augment_item.name))
			continue
		augment_item = new path()
		GLOB.augment_item_datums[augment_item.type] = augment_item
		if(!GLOB.augment_slot_to_items[augment_item.slot])
			GLOB.augment_slot_to_items[augment_item.slot] = list()
		GLOB.augment_slot_to_items[augment_item.slot] += augment_item.type
		if(!GLOB.augment_categories_to_slots_to_items[augment_item.category])
			GLOB.augment_categories_to_slots_to_items[augment_item.category] = list()
		if(!GLOB.augment_categories_to_slots_to_items[augment_item.category][augment_item.slot])
			GLOB.augment_categories_to_slots_to_items[augment_item.category][augment_item.slot] = list()
		GLOB.augment_categories_to_slots_to_items[augment_item.category][augment_item.slot] += augment_item.type

/proc/generate_selectable_species()
	var/list/selectable_species = list()
	for(var/species_type in subtypesof(/datum/species))
		var/datum/species/species = new species_type()
		if(species.check_roundstart_eligible())
			selectable_species += species.id
			GLOB.customizable_races += species.id
		else if(species.always_customizable)
			GLOB.customizable_races += species.id
		qdel(species)
	if(!LAZYLEN(selectable_species))
		selectable_species += SPECIES_HUMAN
	return selectable_species
