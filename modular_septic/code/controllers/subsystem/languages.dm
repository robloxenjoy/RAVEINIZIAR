/datum/controller/subsystem/language/Initialize(start_timeofday)
	. = ..()
	if(!LAZYLEN(GLOB.name_to_language_datum))
		for(var/language_type in GLOB.all_languages)
			var/datum/language/instance = GLOB.language_datum_instances[language_type]
			GLOB.name_to_language_datum[instance.name] = instance
	if(!LAZYLEN(GLOB.species_to_learnable_languages) || !LAZYLEN(GLOB.species_to_necessary_languages) || !LAZYLEN(GLOB.species_to_default_languages))
		for(var/species_type in subtypesof(/datum/species))
			var/datum/species/species = new species_type()
			GLOB.species_to_learnable_languages[species_type] = species.learnable_languages.Copy()
			GLOB.species_to_necessary_languages[species_type] = species.necessary_languages.Copy()
			GLOB.species_to_default_languages[species_type] = species.default_languages.Copy()
			qdel(species)
