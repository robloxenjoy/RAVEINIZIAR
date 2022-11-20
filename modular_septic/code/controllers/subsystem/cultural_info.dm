//Used to handle cultural information stuff
SUBSYSTEM_DEF(cultural_info)
	name = "Cultural Info"
	flags = SS_NO_FIRE

/datum/controller/subsystem/cultural_info/Initialize(start_timeofday)
	. = ..()
	if(!LAZYLEN(GLOB.species_to_available_birthsigns))
		for(var/species_type in subtypesof(/datum/species))
			var/datum/species/species = new species_type()
			GLOB.species_to_available_birthsigns[species_type] = species.available_birthsigns.Copy()
			qdel(species)
