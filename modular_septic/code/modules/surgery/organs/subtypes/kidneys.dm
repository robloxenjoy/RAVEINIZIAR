/obj/item/organ/kidneys
	name = "kidney"
	desc = "The organ that hates stoners the most."
	icon_state = "kidneys"
	base_icon_state = "kidney"

	w_class = WEIGHT_CLASS_SMALL
	zone = BODY_ZONE_PRECISE_VITALS
	organ_efficiency = list(ORGAN_SLOT_KIDNEYS = 100)
	side = RIGHT_SIDE

	organ_volume = 0.5
	max_blood_storage = 7.5
	current_blood = 7.5
	blood_req = 1.5
	oxygen_req = 1.5
	nutriment_req = 1.5
	hydration_req = 2

	/// The maximum volume of toxins one kidney will quickly purge
	var/tox_tolerance = KIDNEY_DEFAULT_TOX_TOLERANCE
	/// Scaling factor for how much damage toxins deal to the kidney
	var/tox_lethality = KIDNEY_DEFAULT_TOX_LETHALITY
	/// Whether to filter toxins from the body or not
	var/filter_toxins = TRUE

/obj/item/organ/kidneys/left
	side = LEFT_SIDE

/obj/item/organ/kidneys/get_availability(datum/species/S)
	return (!(TRAIT_NOMETABOLISM in S.inherent_traits))

/obj/item/organ/kidneys/update_icon_state()
	. = ..()
	if(side == RIGHT_SIDE)
		icon_state = "[base_icon_state]-r"
	else
		icon_state = "[base_icon_state]-l"

/obj/item/organ/kidneys/get_availability(datum/species/S)
	return !(NOKIDNEYS in S.species_traits)
