// Wings
/datum/preference/choiced/wings
	category = PREFERENCE_CATEGORY_FEATURES
	savefile_identifier = PREFERENCE_CHARACTER
	savefile_key = "feature_wings"
	priority = PREFERENCE_PRIORITY_MUTANT_PART
	main_feature_name = "Wings"
	relevant_mutant_bodypart = "wings"
	can_randomize = FALSE
	should_generate_icons = TRUE

/datum/preference/choiced/wings/create_informed_default_value(datum/preferences/preferences)
	. = ..()
	var/species_type = preferences.read_preference(/datum/preference/choiced/species)
	var/datum/species/species = new species_type()
	if(species.default_mutant_bodyparts[relevant_mutant_bodypart])
		if(species.default_mutant_bodyparts[relevant_mutant_bodypart] == ACC_RANDOM)
			qdel(species)
			return pick(GLOB.sprite_accessories[relevant_mutant_bodypart]-"None")
		qdel(species)
		return species.default_mutant_bodyparts[relevant_mutant_bodypart]
	return "None"

/datum/preference/choiced/wings/init_possible_values()
	return generate_possible_values_for_sprite_accessories_on_chest(GLOB.sprite_accessories[relevant_mutant_bodypart], NORTH)

/datum/preference/choiced/wings/apply_to_human(mob/living/carbon/human/target, value)
	if(!target.dna.mutant_bodyparts[relevant_mutant_bodypart])
		target.dna.mutant_bodyparts[relevant_mutant_bodypart] = list(MUTANT_INDEX_NAME = "None", \
											MUTANT_INDEX_COLOR = list("FFFFFF", "FFFFFF", "FFFFFF"))
	target.dna.mutant_bodyparts[relevant_mutant_bodypart][MUTANT_INDEX_NAME] = value

/datum/preference/choiced/wings/compile_constant_data()
	var/list/data = ..()

	data[SUPPLEMENTAL_FEATURE_KEY] = "wings_color"

	return data

// Wings color
/datum/preference/tri_color/wings
	category = PREFERENCE_CATEGORY_SUPPLEMENTAL_FEATURES
	savefile_identifier = PREFERENCE_CHARACTER
	savefile_key = "wings_color"
	priority = PREFERENCE_PRIORITY_MUTANT_COLORS
	can_randomize = FALSE
	relevant_mutant_bodypart = "wings"

/datum/preference/tri_color/wings/create_informed_default_value(datum/preferences/preferences)
	var/part_type = preferences.read_preference(/datum/preference/choiced/tail)
	if(part_type)
		var/datum/sprite_accessory/sprite_accessory = GLOB.sprite_accessories[relevant_mutant_bodypart][part_type]
		if(sprite_accessory)
			var/pref_species = preferences.read_preference(/datum/preference/choiced/species)
			var/color = sprite_accessory.get_default_color(preferences.get_features(), pref_species)
			if(LAZYLEN(color) == 3)
				return list(sanitize_hexcolor(color[1], 6), sanitize_hexcolor(color[2], 6), sanitize_hexcolor(color[3], 6))
			else if(LAZYLEN(color) == 1)
				return list(sanitize_hexcolor(color[1], 6), sanitize_hexcolor(color[1], 6), sanitize_hexcolor(color[1], 6))
	return list("FFFFFF", "FFFFFF", "FFFFFF")

/datum/preference/tri_color/wings/apply_to_human(mob/living/carbon/human/target, value)
	if(!target.dna.mutant_bodyparts[relevant_mutant_bodypart])
		target.dna.mutant_bodyparts[relevant_mutant_bodypart] = list(MUTANT_INDEX_NAME = "None", \
												MUTANT_INDEX_COLOR = list("FFFFFF", "FFFFFF", "FFFFFF"))
	target.dna.mutant_bodyparts[relevant_mutant_bodypart][MUTANT_INDEX_COLOR] = list(sanitize_hexcolor(value[1], 6), sanitize_hexcolor(value[2], 6), sanitize_hexcolor(value[3], 6))
