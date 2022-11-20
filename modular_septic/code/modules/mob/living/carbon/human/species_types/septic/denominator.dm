/datum/species/denominator
	name = "DENOMINATOR"
	id = SPECIES_DENOMINATOR
	default_color = "#4B4B4B"
	sexes = TRUE
	species_traits = list(
		NO_UNDERWEAR,
		HAS_FLESH,
		HAS_BONE
	)
	inherent_traits = list(
		TRAIT_ADVANCEDTOOLUSER,
		TRAIT_CAN_STRIP,
	)
	inherent_biotypes = MOB_ORGANIC | MOB_HUMANOID
	mutant_bodyparts = list()
	heatmod = 4
	coldmod = 0
	liked_food = VEGETABLES | MEAT //Balanced Diet
	disliked_food = RAW
	changesource_flags = MIRROR_BADMIN | WABBAJACK | MIRROR_MAGIC | MIRROR_PRIDE | ERT_SPAWN | RACE_SWAP | SLIME_EXTRACT
	say_mod = list("berates", "sputters", "dictates")
	attack_verb = "punch"
	bite_sharpness = SHARP_POINTY
