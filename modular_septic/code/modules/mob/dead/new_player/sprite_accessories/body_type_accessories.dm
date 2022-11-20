// Body type accessories (dixel, tits)
/datum/sprite_accessory/body_type
	icon = 'modular_septic/icons/mob/human/sprite_accessory/body_type.dmi'
	relevant_layers = list(BODYPARTS_EXTENSION_BEHIND_LAYER, BODYPARTS_EXTENSION_LAYER)
	default_color = DEFAULT_SKIN_OR_PRIMARY
	special_colorize = TRUE
	special_render_case = TRUE
	genetic = FALSE
	var/color_is_always_default_color = TRUE
	var/list/associated_body_types = list()

/datum/sprite_accessory/body_type/is_hidden(mob/living/carbon/human/H, obj/item/bodypart/BP)
	. = ..()
	if(!(H.body_type in associated_body_types) || HAS_TRAIT(H, TRAIT_HUSK))
		return TRUE
	if(body_zone && (!BP?.advanced_rendering || !BP.is_organic_limb() || BP.is_dead() || HAS_TRAIT(BP, TRAIT_HUSK) || HAS_TRAIT(BP, TRAIT_PLASMABURNT) || LAZYLEN(H.clothingonpart(BP))) )
		return TRUE

/datum/sprite_accessory/body_type/get_special_render_state(mob/living/carbon/human/H)
	CHECK_DNA_AND_SPECIES(H)
	. = icon_state
	if(H.dna.species.use_skintones)
		. += "_s"

/datum/sprite_accessory/body_type/get_special_color(mob/living/carbon/human/H)
	CHECK_DNA_AND_SPECIES(H)
	. = LAZYACCESS(H.dna.features, "mcolor")
	if(H.dna.species.use_skintones)
		. = skintone2hex(H.skin_tone)

/datum/sprite_accessory/body_type/dick
	name = "Dick"
	generic = "Dick"
	body_zone = BODY_ZONE_PRECISE_GROIN
	associated_body_types = list(BODY_TYPE_MASCULINE)

/datum/sprite_accessory/body_type/tits
	name = "Tits"
	generic = "Tits"
	body_zone = BODY_ZONE_CHEST
	associated_body_types = list(BODY_TYPE_FEMININE)
