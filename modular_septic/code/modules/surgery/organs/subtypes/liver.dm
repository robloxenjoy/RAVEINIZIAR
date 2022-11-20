/obj/item/organ/liver
	name = "liver"
	desc = "It's called liver, because it'd be weird for it to be called deader."
	icon_state = "liver"
	base_icon_state = "liver"
	zone = BODY_ZONE_CHEST
	organ_efficiency = list(ORGAN_SLOT_LIVER = 100)
	w_class = WEIGHT_CLASS_SMALL

	food_reagents = list(
		/datum/reagent/consumable/nutriment = 5,
		/datum/reagent/iron = 5,
	)
	grind_results = list(
		/datum/reagent/consumable/nutriment/peptides = 5,
	)

	// the liver is large as fuck
	organ_volume = 2
	max_blood_storage = 25
	current_blood = 25
	blood_req = 4
	oxygen_req = 4
	nutriment_req = 4
	hydration_req = 4

	toxin_pain_factor = LIVER_TOXIN_PAIN_FACTOR

	/// Affects how much damage the liver takes from alcohol
	var/alcohol_tolerance = ALCOHOL_RATE

/obj/item/organ/liver/get_availability(datum/species/S)
	return (!(TRAIT_NOMETABOLISM in S.inherent_traits))

/obj/item/organ/liver/Initialize()
	. = ..()
	// If the liver handles foods like a clown, it honks like a bike horn
	// Don't think about it too much.
	RegisterSignal(src, SIGNAL_ADDTRAIT(TRAIT_COMEDY_METABOLISM), .proc/on_add_comedy_metabolism)

/obj/item/organ/liver/surgical_examine(mob/user)
	. = ..()
	if(HAS_TRAIT(user, TRAIT_ENTRAILS_READER) || (user.mind && HAS_TRAIT(user.mind, TRAIT_ENTRAILS_READER)) || isobserver(user))
		if(HAS_TRAIT(src, TRAIT_LAW_ENFORCEMENT_METABOLISM))
			. += "Fatty deposits and sprinkle residue, imply that this is the liver of someone in <em>security</em>."
		if(HAS_TRAIT(src, TRAIT_CULINARY_METABOLISM))
			. += "The high iron content and slight smell of garlic, implies that this is the liver of a <em>cook</em>."
		if(HAS_TRAIT(src, TRAIT_COMEDY_METABOLISM))
			. += "A smell of bananas, a slippery sheen and <span class='clown'>honking</span> when depressed, implies that this is the liver of a <em>clown</em>."
		if(HAS_TRAIT(src, TRAIT_MEDICAL_METABOLISM))
			. += "Marks of stress and a faint whiff of medicinal alcohol, imply that this is the liver of a <em>medical worker</em>."
		if(HAS_TRAIT(src, TRAIT_GREYTIDE_METABOLISM))
			. += "Greyer than most with electrical burn marks, this is the liver of an <em>assistant</em>."
		if(HAS_TRAIT(src, TRAIT_ENGINEER_METABOLISM))
			. += "Signs of radiation exposure and space adaption, implies that this is the liver of an <em>engineer</em>."

		// royal trumps pretender royal
		if(HAS_TRAIT(src, TRAIT_ROYAL_METABOLISM))
			. += "A rich diet of luxury food, suppleness from soft beds, implies that this is the liver of a <em>head of staff</em>."
		else if(HAS_TRAIT(src, TRAIT_PRETENDER_ROYAL_METABOLISM))
			. += "A diet of imitation caviar, and signs of insomnia, implies that this is the liver of <em>someone who wants to be a head of staff</em>."

/obj/item/organ/liver/handle_failing_organ(delta_time)
	if(HAS_TRAIT(src, TRAIT_STABLELIVER) || HAS_TRAIT(src, TRAIT_NOMETABOLISM))
		return
	return ..()

/obj/item/organ/liver/organ_failure(delta_time)
	var/obj/item/bodypart/parent_bodypart = owner.get_bodypart(current_zone)
	if(failure_time == 1)
		owner.custom_pain("I feel a gut-wrenching pain in my abdomen!", 40, affecting = parent_bodypart, nopainloss = TRUE)
		to_chat(owner,span_danger("I feel a gut-wrenching pain in my abdomen!"))
	switch(failure_time/LIVER_FAILURE_STAGE_SECONDS)
		if(1)
			owner.custom_pain("I feel a stabbing pain in my abdomen!", 60, affecting = parent_bodypart, nopainloss = TRUE)
		if(2)
			owner.custom_pain("I feel a burning sensation in my gut!", 50, affecting = parent_bodypart, nopainloss = TRUE)
			owner.vomit()
		if(3)
			owner.custom_pain("I feel painful acid burn in my throat!", 40, affecting = parent_bodypart, nopainloss = TRUE)
			owner.vomit(blood = TRUE)
		if(4)
			owner.custom_pain("Overwhelming pain knocks me out!", 100, affecting = parent_bodypart, nopainloss = TRUE)
			owner.vomit(blood = TRUE, distance = rand(1,2))
			owner.agony_scream()
			owner.AdjustUnconscious(2.5 SECONDS)
		if(5)
			owner.custom_pain("My insides are melting!", 120, affecting = parent_bodypart, nopainloss = TRUE)
			owner.vomit(blood = TRUE, distance = rand(1,3))
			owner.agony_scream()
			owner.AdjustUnconscious(5 SECONDS)
	switch(failure_time)
		// After 60 seconds we begin to feel the effects
		if((1 * LIVER_FAILURE_STAGE_SECONDS) to (2 * LIVER_FAILURE_STAGE_SECONDS - 1))
			if(!add_toxins(0.2 * delta_time))
				owner.adjustToxLoss(0.2 * delta_time, forced = TRUE)
			owner.adjust_disgust(0.1 * delta_time)

		if((2 * LIVER_FAILURE_STAGE_SECONDS) to (3 * LIVER_FAILURE_STAGE_SECONDS - 1))
			if(!add_toxins(0.4 * delta_time))
				owner.adjustToxLoss(0.4 * delta_time, forced = TRUE)
			owner.drowsyness += 0.25 * delta_time
			owner.adjust_disgust(0.3 * delta_time)

		if((3 * LIVER_FAILURE_STAGE_SECONDS) to (4 * LIVER_FAILURE_STAGE_SECONDS - 1))
			if(!add_toxins(0.6 * delta_time))
				owner.adjustToxLoss(0.6 * delta_time, forced = TRUE)
			owner.adjustOrganLoss(pick(ORGAN_SLOT_HEART,ORGAN_SLOT_LUNGS,ORGAN_SLOT_STOMACH,ORGAN_SLOT_KIDNEYS,ORGAN_SLOT_INTESTINES,ORGAN_SLOT_BLADDER,ORGAN_SLOT_EYES,ORGAN_SLOT_EARS), 0.2 * delta_time)
			owner.drowsyness += 0.5 * delta_time
			owner.adjust_disgust(0.6 * delta_time)
			if(DT_PROB(1.5, delta_time))
				owner.emote("drool")

		if(4 * LIVER_FAILURE_STAGE_SECONDS to INFINITY)
			if(!add_toxins(0.8 * delta_time))
				owner.adjustToxLoss(0.8 * delta_time, forced = TRUE)
			owner.adjustOrganLoss(pick(ORGAN_SLOT_HEART,ORGAN_SLOT_LUNGS,ORGAN_SLOT_STOMACH,ORGAN_SLOT_KIDNEYS,ORGAN_SLOT_INTESTINES,ORGAN_SLOT_BLADDER,ORGAN_SLOT_EYES,ORGAN_SLOT_EARS), 0.5 * delta_time)
			owner.drowsyness += 0.8 * delta_time
			owner.adjust_disgust(1.2 * delta_time)
			if(DT_PROB(3, delta_time))
				owner.agony_gargle()

/obj/item/organ/liver/on_owner_examine(datum/source, mob/user, list/examine_list)
	if(!ishuman(owner) || !is_failing())
		return

	var/mob/living/carbon/human/humie_owner = owner
	if(!humie_owner.getorganslot(ORGAN_SLOT_EYES) || humie_owner.is_eyes_covered())
		return
	var/eyes_amount = LAZYLEN(humie_owner.getorganslotlist(ORGAN_SLOT_EYES))
	switch(failure_time)
		if(0 to 3 * LIVER_FAILURE_STAGE_SECONDS - 1)
			examine_list += span_notice("<b>[owner]</b>'s eye[eyes_amount > 1 ? "s" : ""] [eyes_amount > 1 ? "are" : "is"] slightly yellow.")
		if(3 * LIVER_FAILURE_STAGE_SECONDS to 4 * LIVER_FAILURE_STAGE_SECONDS - 1)
			examine_list += span_notice("<b>[owner]</b>'s eye[eyes_amount > 1 ? "s" : ""] [eyes_amount > 1 ? "are" : "is"] completely yellow.")
		if(4 * LIVER_FAILURE_STAGE_SECONDS to INFINITY)
			examine_list += span_danger("<b>[owner]</b>'s eye[eyes_amount > 1 ? "s" : ""] [eyes_amount > 1 ? "are" : "is"] completely yellow and swelling with pus.")

/* Signal handler for the liver gaining the TRAIT_COMEDY_METABOLISM trait
 *
 * Adds the "squeak" component, so clown livers will act just like their
 * bike horns, and honk when you hit them with things, or throw them
 * against things, or step on them.
 *
 * The removal of the component, if this liver loses that trait, is handled
 * by the component itself.
 */
/obj/item/organ/liver/proc/on_add_comedy_metabolism()
	SIGNAL_HANDLER
	// Are clown "bike" horns made from the livers of ex-clowns?
	// Would that make the clown more or less likely to honk it
	LoadComponent(/datum/component/squeak, list('sound/items/bikehorn.ogg'=1), 50, falloff_exponent = 20)
