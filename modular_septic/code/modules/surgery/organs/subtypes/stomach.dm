/obj/item/organ/stomach
	name = "stomach"
	icon_state = "stomach"
	desc = "When bariatric goes too far."
	attack_verb_continuous = list("gores", "squishes", "slaps", "digests")
	attack_verb_simple = list("gore", "squish", "slap", "digest")

	w_class = WEIGHT_CLASS_SMALL
	zone = BODY_ZONE_PRECISE_VITALS
	organ_efficiency = list(ORGAN_SLOT_STOMACH = 100)

	healing_factor = STANDARD_ORGAN_HEALING

	low_threshold_passed = span_info("My stomach flashes with pain before subsiding. Food doesn't seem like a good idea right now.")
	high_threshold_passed = span_warning("My stomach flares up with constant pain- you can hardly stomach the idea of food right now!")
	high_threshold_cleared = span_info("The pain in my stomach dies down for now, but food still seems unappealing.")
	low_threshold_cleared = span_info("The bouts of pain in my stomach have died out.")

	food_reagents = list(
		/datum/reagent/consumable/nutriment/organ_tissue = 5,
		/datum/reagent/consumable/nutriment/protein = 5,
		/datum/reagent/toxin/acid = 5,
	)
	// This is a reagent user and needs more then the 15u from edible component
	reagent_vol = 140 //125u of stuff max

	// This volume may seem misleading, but the human stomach is about the size of a fist most of the time
	organ_volume = 1
	max_blood_storage = 20
	current_blood = 20
	blood_req = 4
	oxygen_req = 4
	nutriment_req = 3
	hydration_req = 4

	/// The rate that disgust decays
	var/disgust_metabolism = 1

	/// The rate that the stomach will transfer reagents to the body
	var/metabolism_efficiency = 0.05 // the lowest we should go is 0.05

/obj/item/organ/stomach/Initialize()
	. = ..()
	//None edible organs do not get a reagent holder by default
	if(!reagents)
		create_reagents(reagent_vol, REAGENT_HOLDER_ALIVE)
	else
		reagents.flags |= REAGENT_HOLDER_ALIVE

/obj/item/organ/stomach/get_availability(datum/species/S)
	return !(NOSTOMACH in S.species_traits)
