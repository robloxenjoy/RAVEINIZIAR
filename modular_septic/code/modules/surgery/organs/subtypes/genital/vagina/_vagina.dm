/obj/item/organ/genital/vagina
	name = "cunt"
	desc = "Shut the fuck up. You're a fucking cunt. Shut the fuck up, you're a stupid cunt, suck my dick."
	icon = 'modular_septic/icons/obj/items/genitalia/cunt.dmi'
	icon_state = "vagina"
	base_icon_state = "vagina"
	organ_efficiency = list(ORGAN_SLOT_VAGINA = 100)
	zone = BODY_ZONE_PRECISE_GROIN
	fluid_reagent = /datum/reagent/consumable/femcum
	splatter_type = /obj/effect/decal/cleanable/blood/femcum
	mutantpart_key = "vagina"
	mutantpart_info = list(MUTANT_INDEX_NAME = "Human", MUTANT_INDEX_COLOR = list("FFEEBB"))
	greyscale_config = /datum/greyscale_config/vagina
	skintoned_colors = "#fcccb3"

/obj/item/organ/genital/vagina/update_sprite_suffix()
	sprite_suffix = "[genital_type]"
	return sprite_suffix

/obj/item/organ/genital/vagina/translate_size_to_suffix(size = genital_size)
	return

/obj/item/organ/genital/vagina/translate_size_to_examine(size = genital_size)
	return

/obj/item/organ/genital/vagina/get_arousal_examine()
	var/returned_string = ""
	switch(arousal_state)
		if(AROUSAL_PARTIAL)
			returned_string = span_notice(" It's glistening with arousal.")
		if(AROUSAL_FULL)
			returned_string = span_notice(" It's bright and dripping with arousal.")
	return returned_string

/obj/item/organ/genital/vagina/get_direct_examine()
	var/parsed_name = lowertext(genital_name)
	var/result = span_notice("[uppertext(prefix_a_or_an(parsed_name))] [parsed_name] [name].")
	var/arousal = get_arousal_examine()
	if(arousal)
		result += arousal
	return result

/obj/item/organ/genital/vagina/get_owner_examine()
	var/parsed_name = lowertext(genital_name)
	var/result = span_notice("[owner.p_they(TRUE)] [owner.p_have()] \a [parsed_name][parsed_name == "cloaca" ? "" : " [name]"].")
	var/arousal = get_arousal_examine()
	if(arousal)
		result += arousal
	return result

/// Femcummies
/obj/item/organ/genital/vagina/cum_on_face(mob/living/carbon/human/target)
	target.AddComponent(/datum/component/creamed/femcum)
