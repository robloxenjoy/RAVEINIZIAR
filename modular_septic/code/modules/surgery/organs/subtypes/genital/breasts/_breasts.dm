/obj/item/organ/genital/breasts
	name = "jugs"
	desc = "Does not belong on reptiles."
	organ_efficiency = list(ORGAN_SLOT_BREASTS = 100)
	icon = 'modular_septic/icons/obj/items/genitalia/jugs.dmi'
	icon_state = "breasts"
	base_icon_state = "breasts"
	zone = BODY_ZONE_CHEST
	fluid_reagent = /datum/reagent/consumable/milk
	splatter_type = null
	genital_type = "pair"
	mutantpart_key = "breasts"
	mutantpart_info = list(MUTANT_INDEX_NAME = "Pair", MUTANT_INDEX_COLOR = list("FEB"))
	greyscale_config = /datum/greyscale_config/breasts
	skintoned_colors = "#fcccb3"

/obj/item/organ/genital/breasts/update_sprite_suffix()
	sprite_suffix = "[genital_type]_[translate_size_to_suffix(genital_size)]"
	return sprite_suffix

/obj/item/organ/genital/breasts/translate_size_to_examine(size = genital_size)
	var/size_string = capitalize_like_old_man(translate_jug_size(size))
	if(size_string == "Flatchested")
		return "flatchested"
	else
		return "[capitalize_like_old_man(translate_jug_size(size))]-cup"

/obj/item/organ/genital/breasts/translate_size_to_suffix(size = genital_size)
	var/size_suffix = "[clamp(FLOOR(genital_size, 1), 1, 5)]"
	return size_suffix

/obj/item/organ/genital/breasts/get_arousal_examine()
	var/returned_string = ""
	if(arousal_state == AROUSAL_FULL)
		if(fluid_production_rate)
			returned_string += span_notice(" The nipples seem hard and perky, and are also leaking milk.")
		else
			returned_string += span_notice(" The nipples seem hard and perky.")
	return returned_string

/obj/item/organ/genital/breasts/get_direct_examine()
	var/parsed_name = lowertext(genital_name)
	if(parsed_name == "pair")
		parsed_name = "pair of"
	var/result = span_notice("[uppertext(prefix_a_or_an(parsed_name))] [translate_size_to_examine(genital_size)] [parsed_name] [name].")
	var/arousal = get_arousal_examine()
	if(arousal)
		result += arousal
	return result

/obj/item/organ/genital/breasts/get_owner_examine()
	var/parsed_name = lowertext(genital_name)
	if(parsed_name == "pair")
		parsed_name = "pair of"
	var/result = span_notice("[owner.p_they(TRUE)] [owner.p_have()] [prefix_a_or_an(parsed_name)] [translate_size_to_examine(genital_size)] [parsed_name] [name].")
	var/arousal = get_arousal_examine()
	if(arousal)
		result += arousal
	return result

/obj/item/organ/genital/breasts/build_from_dna(datum/dna/dna_datum, associated_key)
	. = ..()
	if(!dna_datum.species.mutant_bodyparts[associated_key])
		return
	fluid_production_rate = initial(fluid_production_rate) * dna_datum.features["breasts_lactation"]
	set_size(dna_datum.features["breasts_size"])

// breasts shouldn't cum
/obj/item/organ/genital/breasts/handle_climax(atom/target, method)
	return
