/obj/item/organ/bladder
	name = "bladder"
	icon_state = "bladder"
	desc = "Where water goes to die."
	attack_verb_continuous = list("gores", "urinates", "pisses", "leaks")
	attack_verb_simple = list("gore", "urinate", "piss", "leak")
	w_class = WEIGHT_CLASS_SMALL

	zone = BODY_ZONE_PRECISE_GROIN
	organ_efficiency = list(ORGAN_SLOT_BLADDER = 100)

	healing_factor = STANDARD_ORGAN_HEALING

	food_reagents = list(
		/datum/reagent/consumable/nutriment/organ_tissue = 5,
		/datum/reagent/water = 5,
		/datum/reagent/consumable/piss = 5,
	)

	//This is a reagent user and needs more then the 10u from edible component
	reagent_vol = 115 //100u of piss will fill us up

	// Bladder is somewhat small
	organ_volume = 0.5
	max_blood_storage = 15
	current_blood = 15
	blood_req = 3
	oxygen_req = 4
	nutriment_req = 3
	hydration_req = 4

/obj/item/organ/bladder/Initialize()
	. = ..()
	//None edible organs do not get a reagent holder by default
	if(!reagents)
		create_reagents(reagent_vol, REAGENT_HOLDER_ALIVE)
	else
		reagents.flags |= REAGENT_HOLDER_ALIVE

/obj/item/organ/bladder/get_availability(datum/species/S)
	return !(NOBLADDER in S.species_traits)
