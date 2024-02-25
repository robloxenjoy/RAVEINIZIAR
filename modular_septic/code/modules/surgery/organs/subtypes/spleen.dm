//Spleen: Regenerates blood over time
//Without it, you cannot generate blood without transfusions.
/obj/item/organ/spleen
	name = "Селезёнка"
	desc = "Самый недооцененный орган человеческого тела."
	icon = 'modular_septic/icons/obj/items/surgery.dmi'
	icon_state = "spleen"
	zone = BODY_ZONE_CHEST
	organ_efficiency = list(ORGAN_SLOT_SPLEEN = 100)

	maxHealth = STANDARD_ORGAN_THRESHOLD * 0.7
	high_threshold = STANDARD_ORGAN_THRESHOLD * 0.6
	low_threshold = STANDARD_ORGAN_THRESHOLD * 0.2
	w_class = WEIGHT_CLASS_SMALL

	organ_volume = 0.5
	max_blood_storage = 20
	current_blood = 20
	blood_req = 2
	oxygen_req = 2
	nutriment_req = 2
	hydration_req = 3

	var/blood_regen_factor = 0.005 // how much blood the spleen regenerates per efficiency point, per 2 seconds

/obj/item/organ/spleen/get_availability(datum/species/S)
	return (!(NOBLOOD in S.species_traits))

/obj/item/organ/spleen/vilir
	name = "Vilir"
	desc = "It's like spleen, but something other."
	icon = 'modular_pod/icons/obj/things/things.dmi'
	icon_state = "vilir"
	var/used = FALSE

/obj/item/organ/spleen/vilir/ComponentInitialize()
	. = ..()
	AddComponent(/datum/component/slippery, 60)

/obj/item/organ/spleen/vilir/examine(mob/user)
	. = ..()
	if(used)
		. += "<span class='warning'>Looks like it's already been used.</span>"

/obj/item/organ/spleen/halber
	maxHealth = 120
	high_threshold = 110
	low_threshold = 100
	blood_regen_factor = 0.5