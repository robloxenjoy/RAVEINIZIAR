/obj/item/organ/genital/anus
	name = "asshole"
	desc = "Space asshole. In a truck, flying off a ridge. Space asshole. Smashing through a bridge."
	icon = 'modular_septic/icons/obj/items/genitalia/asshole.dmi'
	icon_state = "anus"
	base_icon_state = "anus"
	organ_efficiency = list(ORGAN_SLOT_ANUS = 100)
	zone = BODY_ZONE_PRECISE_GROIN
	genital_type = "none"
	mutantpart_key = "anus"
	mutantpart_info = list(MUTANT_INDEX_NAME = "Normal", MUTANT_INDEX_COLOR = list("FFEEBB"))
	genital_flags = NONE
	genital_visibility = GENITAL_HIDDEN_BY_CLOTHES
	arousal_state = AROUSAL_CANT
	skintoned_colors = "#fcccb3"

/obj/item/organ/genital/anus/build_from_dna(datum/dna/dna_datum, associated_key)
	return

/obj/item/organ/genital/anus/get_availability(datum/species/S)
	return !(NOINTESTINES in S.species_traits)
