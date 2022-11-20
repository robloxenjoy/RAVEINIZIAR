// Skin tone toggle comes before skin tones
#define PREFERENCE_PRIORITY_SKINTONES_TOGGLE 6
// Skin tones come before mutant colors
#define PREFERENCE_PRIORITY_SKINTONES 7
// Mutant colors come before mutant parts
#define PREFERENCE_PRIORITY_MUTANT_COLORS 8
// Mutant parts should be almost the last thing to mess with
#define PREFERENCE_PRIORITY_MUTANT_PART 9
// Genital colors come after other mutant colors
#define PREFERENCE_PRIORITY_GENITAL_COLOR 10

// 6 hex colors
/datum/preference/color/is_valid(value)
	return findtext(sanitize_hexcolor(value, 6, TRUE), GLOB.is_color)

/datum/preference/color/deserialize(input, datum/preferences/preferences)
	return sanitize_hexcolor(input, 6, TRUE)

/datum/preference/color/create_default_value()
	return random_color()

// Triple colors
/datum/preference/tri_color
	abstract_type = /datum/preference/tri_color

/datum/preference/tri_color/create_default_value()
	return list("#FFFFFF", "#FFFFFF", "#FFFFFF")

/datum/preference/tri_color/is_valid(value)
	. = TRUE
	var/list/value_list = value
	if(!islist(value_list))
		return FALSE
	if(LAZYLEN(value) != 3)
		return FALSE
	if(!(findtext(sanitize_hexcolor(value[1], 6, TRUE), GLOB.is_color) && findtext(sanitize_hexcolor(value[2], 6, TRUE), GLOB.is_color) && findtext(sanitize_hexcolor(value[3], 6, TRUE), GLOB.is_color)))
		return FALSE

/datum/preference/tri_color/deserialize(input, datum/preferences/preferences)
	if(!islist(input))
		return list("FFFFFF", "FFFFFF", "FFFFFF")
	var/list/input_colors = input
	return list(sanitize_hexcolor(input_colors[1], 6, TRUE), sanitize_hexcolor(input_colors[2], 6, TRUE), sanitize_hexcolor(input_colors[3], 6, TRUE))

// Text input
/datum/preference/text
	abstract_type = /datum/preference/text

/datum/preference/text/deserialize(input, datum/preferences/preferences)
	return STRIP_HTML_SIMPLE(input, MAX_FLAVOR_LENGTH)

/datum/preference/text/create_default_value()
	return ""

/datum/preference/text/is_valid(value)
	return istext(value)

// Mismatched parts support
/datum/preference/is_accessible(datum/preferences/preferences)
	if(!isnull(relevant_mutant_bodypart) || !isnull(relevant_species_trait))
		var/species_type = preferences.read_preference(/datum/preference/choiced/species)
		var/datum/species/species = new species_type
		if(!(savefile_key in species.get_features()) && !preferences.read_preference(/datum/preference/toggle/mismatched_parts))
			qdel(species)
			return FALSE
		qdel(species)

	if(!should_show_on_page(preferences.current_window))
		return FALSE

	return TRUE

// Adds preferences argument for ease of use
/datum/preference/apply_to_human(mob/living/carbon/human/target, value, datum/preferences/preferences)
	SHOULD_CALL_PARENT(FALSE)
	CRASH("`apply_to_human()` was not implemented for [type]!")

/datum/preference/apply_to_client(client/client, value, datum/preferences/preferences)
	SHOULD_CALL_PARENT(FALSE)

/datum/preference/apply_to_client_updated(client/client, value, datum/preferences/preferences)
	apply_to_client(client, value, preferences)

/datum/preference/proc/should_apply_to_client(client/client, value, datum/preferences/preferences)
	if(savefile_identifier != PREFERENCE_CHARACTER)
		return TRUE
	return FALSE

/datum/preference/proc/should_apply_to_human(mob/living/carbon/human/target, value, datum/preferences/preferences)
	if(savefile_identifier != PREFERENCE_PLAYER)
		return is_accessible(preferences)
	return FALSE

/datum/preference/proc/is_bad_preference(client/client, value, datum/preferences/preferences)
	return FALSE

/datum/preference/proc/bad_preference_warning(client/client, value, datum/preferences/preferences)
	return div_infobox(span_userdanger("Uh oh this is a bad preference. You sure?"))