/obj/item/organ/anus
	name = "asshole"
	desc = "Space asshole. In a truck, flying off a ridge. Space asshole. Smashing through a bridge."
	icon = 'modular_septic/icons/obj/items/genitalia/asshole.dmi'
	icon_state = "anus"
	base_icon_state = "anus"

	w_class = WEIGHT_CLASS_SMALL
	zone = BODY_ZONE_PRECISE_GROIN

	organ_efficiency = list(ORGAN_SLOT_ANUS = 100)

	healing_factor = STANDARD_ORGAN_HEALING

	// Extension of the intestines
	organ_volume = 1
	max_blood_storage = 15
	current_blood = 15
	blood_req = 3
	oxygen_req = 1
	nutriment_req = 2
	hydration_req = 3

/obj/item/organ/anus/get_availability(datum/species/S)
	return !(NOINTESTINES in S.species_traits)
