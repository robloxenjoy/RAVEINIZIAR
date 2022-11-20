// Penis color
/datum/preference/tri_color/penis
	category = PREFERENCE_CATEGORY_SECONDARY_FEATURES
	savefile_identifier = PREFERENCE_CHARACTER
	savefile_key = "penis_color"
	priority = PREFERENCE_PRIORITY_GENITAL_COLOR
	relevant_mutant_bodypart = "penis"

/datum/preference/tri_color/penis/is_accessible(datum/preferences/preferences)
	. = ..()
	if(!.)
		return
	var/genitals_type = preferences.read_preference(/datum/preference/choiced/genitals)
	if(!(ORGAN_SLOT_PENIS in GLOB.genital_sets[genitals_type]))
		return FALSE
	var/datum/species/pref_species = preferences.read_preference(/datum/preference/choiced/species)
	if(initial(pref_species.use_skintones))
		var/use_skintones = preferences.read_preference(/datum/preference/toggle/skin_tone)
		if(use_skintones)
			return FALSE

/datum/preference/tri_color/penis/create_informed_default_value(datum/preferences/preferences)
	var/pref_species = preferences.read_preference(/datum/preference/choiced/species)
	var/datum/species/datum_species = new pref_species()
	var/obj/item/organ/genital = datum_species.default_genitals[ORGAN_SLOT_PENIS]
	qdel(datum_species)
	if(genital && initial(genital.mutantpart_key))
		var/datum/sprite_accessory/sprite_accessory = GLOB.sprite_accessories[relevant_mutant_bodypart][initial(genital.mutantpart_key)]
		if(sprite_accessory)
			var/color = sprite_accessory.get_default_color(preferences.get_features(), datum_species)
			if(LAZYLEN(color) == 3)
				return list(sanitize_hexcolor(color[1], 6), sanitize_hexcolor(color[2], 6), sanitize_hexcolor(color[3], 6))
			else if(LAZYLEN(color))
				return list(sanitize_hexcolor(color[1], 6), sanitize_hexcolor(color[1], 6), sanitize_hexcolor(color[1], 6))
	else
		return list("FFFFFF", "FFFFFF", "FFFFFF")

/datum/preference/tri_color/penis/apply_to_human(mob/living/carbon/human/target, value)
	if(!target.dna.mutant_bodyparts[relevant_mutant_bodypart])
		target.dna.mutant_bodyparts[relevant_mutant_bodypart] = list(MUTANT_INDEX_NAME = "None", \
												MUTANT_INDEX_COLOR = list("FFFFFF", "FFFFFF", "FFFFFF"))
	target.dna.mutant_bodyparts[relevant_mutant_bodypart][MUTANT_INDEX_COLOR] = list(sanitize_hexcolor(value[1], 6, FALSE), sanitize_hexcolor(value[2], 6, FALSE), sanitize_hexcolor(value[3], 6, FALSE))
