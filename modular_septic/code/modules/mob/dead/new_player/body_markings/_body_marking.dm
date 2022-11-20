//This datum is quite close to the sprite accessory one, containing a bit of copy pasta code
//Those DO NOT have a customizable cases for rendering, or any special stuff, and are meant to be simpler than accessories
//One definition can stand for a whole set of accessories, make sure to set affected bodyparts
/datum/body_marking
	///The icon file the body markign is located in
	var/icon
	///The icon_state of the body marking
	var/icon_state
	///The preview name of the body marking - NEEDS A UNIQUE NAME
	var/name
	///The color the marking defaults to, important for randomisations. either a hex color ie."FFFFFF" or a define like DEFAULT_PRIMARY
	var/default_color
	///Which bodyparts does the marking affect in BITFLAGS!! (HEAD, CHEST, ARM_LEFT, ARM_RIGHT, HAND_LEFT, HAND_RIGHT, LEG_RIGHT, LEG_LEFT)
	var/affected_bodyparts
	///Which species is this marking recommended to. Important for randomisations.
	var/recommended_species = list(SPECIES_WEREWOLF, SPECIES_WERECAT)
	///If this is on the color customization will show up despite the pref settings, it will also cause the marking to not reset colors to match the defaults
	var/always_color_customizable
	///Whether the body marking sprite is the same for both sexes or not. Only relevant for chest right now.
	var/gendered = TRUE

/datum/body_marking/New()
	if(!default_color)
		default_color = "FFFFFF"

/datum/body_marking/proc/get_default_color(list/features, datum/species/pref_species) //Needs features for the color information
	var/color = default_color
	switch(default_color)
		if(DEFAULT_PRIMARY)
			color = features["mcolor"]
		if(DEFAULT_SECONDARY)
			color = features["mcolor2"]
		if(DEFAULT_TERTIARY)
			color = features["mcolor3"]
		if(DEFAULT_SKIN_OR_PRIMARY)
			if(features["uses_skintones"] && pref_species && initial(pref_species.use_skintones))
				color = features["skin_color"]
			else
				color = features["mcolor"]

	return color
