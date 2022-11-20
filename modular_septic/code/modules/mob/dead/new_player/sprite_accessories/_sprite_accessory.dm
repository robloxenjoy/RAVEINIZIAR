/datum/sprite_accessory
	///Unique key of an accessory. All tails should have "tail", ears "ears" etc.
	var/key = null
	///If an accessory is special, it wont get included in the normal accessory lists
	var/special = FALSE
	///Species we get normally slapped on.
	var/list/recommended_species
	///Which color we default to on acquisition of the accessory (such as switching species, default color for character customization etc)
	///You can also put down a a HEX color, to be used instead as the default
	var/default_color
	///Set this to a name, then the accessory will be shown in preferences, if a species can have it. Most accessories have this
	///Notable things that have it set to FALSE are things that need special setup, such as genitals
	var/generic

	color_src = USE_ONE_COLOR

	///Which layers does this accessory affect (BODY_BEHIND_LAYER, BODY_ADJ_LAYER, BODY_FRONT_LAYER)
	var/relevant_layers = list(BODY_BEHIND_LAYER, BODY_ADJ_LAYER, BODY_FRONT_LAYER)

	///This is used to determine whether an accessory gets added to someone - This is important for accessories that are "None", which should have this set to false
	var/factual = TRUE

	///Use this as a type path to an organ that this sprite_accessory will be associated. Make sure the organ has 'mutantpart_info' set properly.
	var/organ_type

	///Body zone associated with the bodypart
	var/body_zone = BODY_ZONE_HEAD

	///Set this to true to make an accessory appear as color customizable in preferences despite advanced color settings being off, will also prevent the accessory from being reset
	var/always_color_customizable
	///Whether the accessory can have a special icon_state to render, i.e. wagging tails
	var/special_render_case
	///Special case of whether the accessory should be shifted in the X dimension, check taur genitals for example
	var/special_x_dimension
	///Special case of whether the accessory should have a different icon, check taur genitals for example
	var/special_icon_case
	///Special case of applying a different color, like hardsuit tails
	var/special_colorize
	///Whether it has any extras to render, and their appropriate color sources
	var/extra = FALSE
	var/extra_color_src
	var/extra2 = FALSE
	var/extra2_color_src
	///Whether this feature is genetic, and thus modifiable by DNA consoles
	var/genetic = FALSE

/datum/sprite_accessory/New()
	if(!default_color)
		switch(color_src)
			if(USE_ONE_COLOR)
				default_color = DEFAULT_PRIMARY
			if(USE_MATRIXED_COLORS)
				default_color = DEFAULT_MATRIXED
			else
				default_color = "#FFFFFF"
	if(color_src == USE_MATRIXED_COLORS)
		default_color = DEFAULT_MATRIXED
	if(name == "None")
		factual = FALSE

/datum/sprite_accessory/proc/get_preview_color()
	switch(color_src)
		if(COLOR_SRC_MATRIXED, USE_MATRIXED_COLORS)
			return list(COLOR_ORANGE_BROWN, COLOR_WHITE, COLOR_WHITE)
		else
			return COLOR_ORANGE_BROWN

/datum/sprite_accessory/proc/is_hidden(mob/living/carbon/human/H, obj/item/bodypart/BP)
	return FALSE

/datum/sprite_accessory/proc/get_special_render_state(mob/living/carbon/human/H)
	return

/datum/sprite_accessory/proc/get_special_render_colour(mob/living/carbon/human/H, passed_state)
	return

/datum/sprite_accessory/proc/get_special_icon(mob/living/carbon/human/H, passed_state)
	return

/datum/sprite_accessory/proc/get_special_x_dimension(mob/living/carbon/human/H, passed_state)
	return 0

/datum/sprite_accessory/proc/get_special_color(mob/living/carbon/human/H)
	return

//Needs features for the color information
/datum/sprite_accessory/proc/get_default_color(list/features, datum/species/pref_species)
	var/list/colors = list(default_color)
	switch(default_color)
		if(DEFAULT_PRIMARY)
			colors = list(features["mcolor"])
		if(DEFAULT_SECONDARY)
			colors = list(features["mcolor2"])
		if(DEFAULT_TERTIARY)
			colors = list(features["mcolor3"])
		if(DEFAULT_MATRIXED)
			colors = list(features["mcolor"], features["mcolor2"], features["mcolor3"])
		if(DEFAULT_SKIN_OR_PRIMARY)
			if(features["uses_skintones"] && pref_species && initial(pref_species.use_skintones))
				colors = list(features["skin_color"])
			else
				colors = list(features["mcolor"])

	return colors
