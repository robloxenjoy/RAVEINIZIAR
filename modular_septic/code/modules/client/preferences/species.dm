/datum/preference/choiced/species/apply_to_human(mob/living/carbon/human/target, value, datum/preferences/preferences)
	target.set_species(value, icon_update = FALSE, pref_load = preferences)
