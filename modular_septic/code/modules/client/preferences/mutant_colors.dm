// Mutant colors
/datum/preference/color/mutant_color/is_accessible(datum/preferences/preferences)
	return FALSE

/datum/preference/tri_color/mutant_colors
	category = PREFERENCE_CATEGORY_SECONDARY_FEATURES
	savefile_identifier = PREFERENCE_CHARACTER
	savefile_key = "mutant_colors"
	priority = PREFERENCE_PRIORITY_MUTANT_COLORS
	can_randomize = FALSE

/datum/preference/tri_color/mutant_colors/create_informed_default_value(datum/preferences/preferences)
	. = list("FFFFFF", "FFFFFF", "FFFFFF")
	var/species_type = preferences.read_preference(/datum/preference/choiced/species)
	if(species_type)
		var/datum/species/species = new species_type()
		var/list/features = species.get_random_features()
		if(LAZYLEN(features) && features["mcolor"] && features["mcolor2"] && features["mcolor3"])
			. = list(sanitize_hexcolor(features["mcolor"], 6), sanitize_hexcolor(features["mcolor2"], 6), sanitize_hexcolor(features["mcolor3"], 6))
		qdel(species)

/datum/preference/tri_color/mutant_colors/apply_to_human(mob/living/carbon/human/target, list/value)
	target.dna.features["mcolor"] = sanitize_hexcolor(value[1], 6)
	target.dna.features["mcolor2"] = sanitize_hexcolor(value[2], 6)
	target.dna.features["mcolor3"] = sanitize_hexcolor(value[3], 6)
	for(var/obj/item/bodypart/bodypart in target.bodyparts)
		bodypart.update_limb()
