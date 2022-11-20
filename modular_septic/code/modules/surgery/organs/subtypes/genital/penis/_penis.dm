/obj/item/organ/genital/penis
	name = "knob"
	desc = "I staple tapeworms on my penis, so the flesh will drink brainjuice from your fetus."
	icon = 'modular_septic/icons/obj/items/genitalia/knob.dmi'
	icon_state = "penis"
	base_icon_state = "penis"
	organ_efficiency = list(ORGAN_SLOT_PENIS = 100)
	zone = BODY_ZONE_PRECISE_GROIN
	fluid_reagent = /datum/reagent/consumable/cum
	splatter_type = /obj/effect/decal/cleanable/blood/cum
	pollutant_type = /datum/pollutant/cum
	pollutant_amount = 15
	mutantpart_key = "penis"
	mutantpart_info = list(MUTANT_INDEX_NAME = "Human", MUTANT_INDEX_COLOR = list("FFEEBB"))
	greyscale_config = /datum/greyscale_config/penis
	skintoned_colors = "#fcccb3"
	genital_size = PENIS_DEFAULT_GIRTH
	var/genital_girth = PENIS_DEFAULT_GIRTH
	var/genital_sheath = SHEATH_NONE
	var/circumcised = FALSE

/obj/item/organ/genital/penis/update_sprite_suffix()
	if(genital_sheath && (genital_sheath != SHEATH_NONE) && (arousal_state < AROUSAL_FULL))
		sprite_suffix = "[lowertext(genital_sheath)]_[arousal_state >= AROUSAL_PARTIAL ? TRUE : FALSE]"
		return sprite_suffix
	sprite_suffix = "[genital_type]_[translate_size_to_suffix(genital_size)]_[arousal_state >= AROUSAL_FULL ? TRUE : FALSE]"
	return sprite_suffix

/obj/item/organ/genital/penis/translate_size_to_suffix(size = genital_size)
	var/size_suffix = "1"
	switch(FLOOR(genital_size, 1))
		//king
		if(-INFINITY to 12)
			size_suffix = "1"
		//acceptable human being
		if(12 to 16)
			size_suffix = "2"
		//dongoloid
		if(16 to 24)
			size_suffix = "3"
		//dumbass
		else
			size_suffix = "4"
	return size_suffix

/obj/item/organ/genital/penis/update_icon_state()
	. = ..()
	//ignore the arousal state of the knob
	icon_state = "[base_icon_state][copytext(sprite_suffix, 1, length(sprite_suffix)-1)]"

/obj/item/organ/genital/penis/translate_size_to_examine(size = genital_size)
	return translate_knob_size(size)

/obj/item/organ/genital/penis/get_arousal_examine()
	var/returned_string = ""
	switch(arousal_state)
		if(AROUSAL_PARTIAL)
			returned_string = span_notice(" It is partially erect.")
		if(AROUSAL_FULL)
			returned_string = span_notice(" It is rock hard.")
		else
			returned_string = span_notice(" It is flaccid.")
	return returned_string

/obj/item/organ/genital/penis/get_direct_examine()
	var/parsed_name = lowertext(genital_name)
	var/circumcised_text = (circumcised ? "circumcised" : "intact")
	var/result = span_notice("[uppertext(prefix_a_or_an(circumcised_text))] [circumcised_text] [translate_size_to_examine(genital_size)] long, [translate_girth_to_examine(genital_girth)] circumference [parsed_name] [name].")
	var/arousal = get_arousal_examine()
	if(arousal)
		result += arousal
	return result

/obj/item/organ/genital/penis/get_owner_examine()
	var/parsed_name = lowertext(genital_name)
	var/circumcised_text = (circumcised ? "circumcised" : "intact")
	var/result = span_notice("[owner.p_they(TRUE)] [owner.p_have()] [prefix_a_or_an(circumcised_text)] [circumcised_text] [translate_size_to_examine(genital_size)] long, [translate_girth_to_examine(genital_girth)] circumference [parsed_name] [name].")
	var/arousal = get_arousal_examine()
	if(arousal)
		result += arousal
	return result

/obj/item/organ/genital/penis/build_from_dna(datum/dna/dna_datum, associated_key)
	. = ..()
	if(!dna_datum.species.mutant_bodyparts[associated_key])
		return
	circumcised = dna_datum.features["penis_circumcised"]
	genital_girth = dna_datum.features["penis_girth"]
	var/datum/sprite_accessory/genital/penis/penis_accessory = GLOB.sprite_accessories[associated_key][dna_datum.species.mutant_bodyparts[associated_key][MUTANT_INDEX_NAME]]
	if(penis_accessory.can_have_sheath)
		genital_sheath = dna_datum.features["penis_sheath"]
	set_size(dna_datum.features["penis_size"])

/// Balls produce cummies, not penis
/obj/item/organ/genital/penis/regenerate_cummies()
	return

/// Cummies
/obj/item/organ/genital/penis/cum_on_face(mob/living/carbon/human/target)
	target.AddComponent(/datum/component/creamed/cum)

/obj/item/organ/genital/penis/proc/translate_girth_to_examine(girth = genital_girth)
	return "[girth]cm"
