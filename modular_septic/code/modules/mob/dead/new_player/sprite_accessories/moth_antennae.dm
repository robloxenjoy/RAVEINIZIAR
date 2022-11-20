/datum/sprite_accessory/moth_antennae
	generic = "Insect Antennae"
	key = "moth_antennae"
	recommended_species = list(SPECIES_MOTH, SPECIES_INSECT)
	relevant_layers = list(BODY_BEHIND_LAYER, BODY_FRONT_LAYER)
	genetic = TRUE

/datum/sprite_accessory/moth_antennae/is_hidden(mob/living/carbon/human/H, obj/item/bodypart/BP)
	. = ..()
	if(body_zone && !BP?.advanced_rendering)
		return TRUE
	if((H.head && (H.head.flags_inv & HIDEHAIR)) || (H.wear_mask && (H.wear_mask.flags_inv & HIDEHAIR)))
		return TRUE

//thx fulp lmao
/datum/sprite_accessory/moth_antennae/rosy
	icon = 'modular_septic/icons/mob/human/sprite_accessory/moth_antennas.dmi'
	name = "Rosy"
	icon_state = "rosy"

/datum/sprite_accessory/moth_antennae/dreamhead
	icon = 'modular_septic/icons/mob/human/sprite_accessory/moth_antennas.dmi'
	name = "Dreamhead"
	icon_state = "dreamhead"

/datum/sprite_accessory/moth_antennae/delirious
	icon = 'modular_septic/icons/mob/human/sprite_accessory/moth_antennas.dmi'
	name = "Delirious"
	icon_state = "delirious"

/datum/sprite_accessory/moth_antennae/feathery
	icon = 'modular_septic/icons/mob/human/sprite_accessory/moth_antennas.dmi'
	name = "Feathery"
	icon_state = "feathery"

/datum/sprite_accessory/moth_antennae/brown
	icon = 'modular_septic/icons/mob/human/sprite_accessory/moth_antennas.dmi'
	name = "Brown"
	icon_state = "brown"

/datum/sprite_accessory/moth_antennae/plasmafire
	icon = 'modular_septic/icons/mob/human/sprite_accessory/moth_antennas.dmi'
	name = "Plasmafire"
	icon_state = "plasmafire"

/datum/sprite_accessory/moth_antennae/aspen
	icon = 'modular_septic/icons/mob/human/sprite_accessory/moth_antennas.dmi'
	name = "Aspen"
	icon_state = "aspen"
