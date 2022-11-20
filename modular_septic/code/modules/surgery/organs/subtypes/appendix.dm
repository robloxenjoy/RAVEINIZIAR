/obj/item/organ/appendix
	name = "appendix"
	icon_state = "appendix"
	base_icon_state = "appendix"
	desc = "The most famous useless organ of the human body!"
	w_class = WEIGHT_CLASS_TINY

	zone = BODY_ZONE_PRECISE_GROIN
	organ_efficiency = list(ORGAN_SLOT_APPENDIX = 100)

	food_reagents = list(
		/datum/reagent/consumable/nutriment = 5, \
		/datum/reagent/toxin/bad_food = 5,
	)
	grind_results = list(
		/datum/reagent/toxin/bad_food = 5,
	)

	maxHealth = STANDARD_ORGAN_THRESHOLD * 0.5 // weak to mirror real life
	high_threshold = STANDARD_ORGAN_THRESHOLD * 0.4
	low_threshold =  STANDARD_ORGAN_THRESHOLD * 0.1
	healing_factor = 0 // just cut this nigga out lmao

	now_failing = span_warning("An explosion of pain erupts in my lower right abdomen!")
	now_fixed = span_info("The pain in my abdomen has subsided.")

	// a small resource hog
	organ_volume = 0.5
	max_blood_storage = 2.5
	current_blood = 2.5
	blood_req = 0.5
	oxygen_req = 0.25
	nutriment_req = 0.5
	hydration_req = 0.5

	var/inflamation_stage = 0

/obj/item/organ/appendix/update_name()
	. = ..()
	name = "[inflamation_stage ? "inflamed " : null][initial(name)]"

/obj/item/organ/appendix/update_icon_state()
	. = ..()
	icon_state = "[base_icon_state][inflamation_stage ? "inflamed" : ""]"

/obj/item/organ/appendix/organ_failure(delta_time)
	. = ..()
	inflamation_stage = TRUE
	owner.adjustToxLoss(0.5 * delta_time, TRUE, TRUE) //forced to ensure people don't use it to gain tox as slime person

/obj/item/organ/appendix/get_availability(datum/species/S)
	return !(TRAIT_NOHUNGER in S.inherent_traits)
