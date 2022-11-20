/obj/item/organ/genital/testicles
	name = "gonads"
	desc = "Some balls are held for charity, and some for fancy dress. But when they're held for pleasure, \
			they're the balls that I like best."
	icon = 'modular_septic/icons/obj/items/genitalia/gonads.dmi'
	icon_state = "testicles"
	base_icon_state = "testicles"
	organ_efficiency = list(ORGAN_SLOT_TESTICLES = 100)
	zone = BODY_ZONE_PRECISE_GROIN
	fluid_reagent = /datum/reagent/consumable/cum
	fluid_receiving_slot = ORGAN_SLOT_PENIS
	genital_flags = NONE
	genital_type = "pair"
	mutantpart_key = "testicles"
	mutantpart_info = list(MUTANT_INDEX_NAME = "Pair", MUTANT_INDEX_COLOR = list("FFEEBB"))
	greyscale_config = /datum/greyscale_config/testicles
	skintoned_colors = "#fcccb3"

/obj/item/organ/genital/testicles/update_sprite_suffix()
	sprite_suffix = "[genital_type]_[translate_size_to_suffix(genital_size)]"
	return sprite_suffix

/obj/item/organ/genital/testicles/translate_size_to_examine(size = genital_size)
	return translate_gonad_size(size)

/obj/item/organ/genital/testicles/translate_size_to_suffix(size = genital_size)
	var/size_suffix = "[clamp(FLOOR(genital_size, 1), 1, 3)]"
	return size_suffix

/obj/item/organ/genital/testicles/get_direct_examine()
	var/parsed_name = lowertext(genital_name)
	if(parsed_name == "pair")
		parsed_name = "pair of"
	var/result = span_notice("[uppertext(prefix_a_or_an(parsed_name))] [translate_size_to_examine(genital_size)] [parsed_name] [name].")
	return result

/obj/item/organ/genital/testicles/get_owner_examine()
	var/parsed_name = lowertext(genital_name)
	if(parsed_name == "pair")
		parsed_name = "pair of"
	var/result = span_notice("[owner.p_they(TRUE)] [owner.p_have()] [prefix_a_or_an(parsed_name)] [translate_size_to_examine(genital_size)] [parsed_name] [name].")
	return result

/obj/item/organ/genital/testicles/build_from_dna(datum/dna/dna_datum, associated_key)
	. = ..()
	set_size(dna_datum.features["balls_size"])

/obj/item/organ/genital/testicles/handle_climax(atom/target, method = INGEST)
	//balls dont cum
	return
