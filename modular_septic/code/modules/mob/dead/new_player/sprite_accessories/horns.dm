/datum/sprite_accessory/horns
	key = "horns"
	generic = "Horns"
	relevant_layers = list(BODY_FRONT_LAYER)
	recommended_species = list(SPECIES_LIZARD, SPECIES_LIZARD_ASH, SPECIES_LIZARD_SILVER, SPECIES_MAMMAL, SPECIES_SYNTHMAMMAL)
	icon = 'modular_septic/icons/mob/human/sprite_accessory/horns.dmi'
	default_color = "555555"
	genetic = TRUE
	organ_type = /obj/item/organ/external/horns

/datum/sprite_accessory/horns/get_preview_color()
	switch(color_src)
		if(COLOR_SRC_MATRIXED, USE_MATRIXED_COLORS)
			return list(COLOR_WHITE, COLOR_WHITE, COLOR_WHITE)
		else
			return COLOR_WHITE

/datum/sprite_accessory/horns/is_hidden(mob/living/carbon/human/H, obj/item/bodypart/BP)
	. = ..()
	if(body_zone && !BP?.advanced_rendering)
		return TRUE
	if((H.head && (H.head.flags_inv & HIDEHAIR)) || (H.wear_mask && (H.wear_mask.flags_inv & HIDEHAIR)))
		return TRUE

/datum/sprite_accessory/horns/angler
	default_color = DEFAULT_SECONDARY

/datum/sprite_accessory/horns/ram
	name = "Ram"
	icon_state = "ram"

/datum/sprite_accessory/horns/guilmon
	name = "Guilmon"
	icon_state = "guilmon"

/datum/sprite_accessory/horns/drake
	name = "Drake"
	icon_state = "drake"

/datum/sprite_accessory/horns/knight
	name = "Knight"
	icon_state = "knight"
