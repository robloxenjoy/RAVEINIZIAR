/datum/body_marking_set
	///The preview name of the body marking set. HAS to be unique
	var/name
	///List of the body markings in this set
	var/body_marking_list
	///Which species is this marking recommended to. Important for randomisations.
	var/recommended_species = list(SPECIES_SYNTHMAMMAL, SPECIES_WERECAT, SPECIES_WEREWOLF, SPECIES_AQUATIC)
