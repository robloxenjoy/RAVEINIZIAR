/datum/sprite_accessory/frills
	key = "frills"
	generic = "Frills"
	recommended_species = list(SPECIES_LIZARD, SPECIES_LIZARD_ASH, SPECIES_LIZARD_SILVER)
	default_color = DEFAULT_SECONDARY
	relevant_layers = list(BODY_ADJ_LAYER)
	genetic = TRUE
	organ_type = /obj/item/organ/external/frills

/datum/sprite_accessory/frills/is_hidden(mob/living/carbon/human/H, obj/item/bodypart/BP)
	. = ..()
	if(body_zone && !BP?.advanced_rendering)
		return TRUE
	if(H.head && (HAS_TRAIT(H, TRAIT_HIDING_MUTANTPARTS) || (H.head.flags_inv & HIDEEARS)))
		return TRUE

/datum/sprite_accessory/frills/divinity
	name = "Divinity"
	icon_state = "divinity"
	icon = 'modular_septic/icons/mob/human/sprite_accessory/frills.dmi'

/datum/sprite_accessory/frills/horns
	name = "Horns"
	icon_state = "horns"
	icon = 'modular_septic/icons/mob/human/sprite_accessory/frills.dmi'

/datum/sprite_accessory/frills/hornsdouble
	name = "Horns Double"
	icon_state = "hornsdouble"
	icon = 'modular_septic/icons/mob/human/sprite_accessory/frills.dmi'

/datum/sprite_accessory/frills/big
	name = "Big"
	icon_state = "big"
	icon = 'modular_septic/icons/mob/human/sprite_accessory/frills.dmi'

/datum/sprite_accessory/frills/cobrahood
	name = "Cobra Hood"
	icon_state = "cobrahood"
	icon = 'modular_septic/icons/mob/human/sprite_accessory/frills.dmi'
	color_src = USE_MATRIXED_COLORS

/datum/sprite_accessory/frills/cobrahoodears
	name = "Cobra Hood (Ears)"
	icon_state = "cobraears"
	icon = 'modular_septic/icons/mob/human/sprite_accessory/frills.dmi'
	color_src = USE_MATRIXED_COLORS
