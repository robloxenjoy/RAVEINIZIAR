/datum/sprite_accessory/moth_markings
	key = "moth_markings"
	generic = "Moth markings"

/datum/sprite_accessory/moth_antennae/none
	name = "None"
	icon_state = "none"

/datum/sprite_accessory/spines
	key = "spines"
	generic = "Spines"
	icon = 'modular_septic/icons/mob/human/sprite_accessory/mutant_bodyparts.dmi'
	special_render_case = TRUE
	default_color = DEFAULT_SECONDARY
	recommended_species = list(SPECIES_LIZARD, SPECIES_LIZARD_ASH, SPECIES_LIZARD_SILVER)
	relevant_layers = list(BODY_BEHIND_LAYER, BODY_ADJ_LAYER)
	body_zone = BODY_ZONE_PRECISE_GROIN
	genetic = TRUE

/datum/sprite_accessory/spines/is_hidden(mob/living/carbon/human/H, obj/item/bodypart/BP)
	. = ..()
	if(body_zone && !BP?.advanced_rendering)
		return TRUE
	var/list/tails = H.getorganslotlist(ORGAN_SLOT_TAIL)
	if(!length(tails) || (H.wear_suit && (HAS_TRAIT(H, TRAIT_HIDING_MUTANTPARTS) || (H.wear_suit.flags_inv & HIDEJUMPSUIT))))
		return TRUE

/datum/sprite_accessory/spines/get_special_render_state(mob/living/carbon/human/H)
	var/list/tails = H.getorganslotlist(ORGAN_SLOT_TAIL)
	for(var/thing in tails)
		var/obj/item/organ/tail/tail = thing
		if(tail.wagging)
			return "[icon_state]_wagging"
	return icon_state

/datum/sprite_accessory/caps
	key = "caps"
	generic = "Caps"

/datum/sprite_accessory/body_markings
	key = "body_markings"
	generic = "Body Markings"
	default_color = DEFAULT_TERTIARY

/datum/sprite_accessory/legs
	key = "legs"
	generic = "Leg Type"
	color_src = null
	genetic = TRUE

/datum/sprite_accessory/legs/digitigrade_lizard
	name = null

/datum/sprite_accessory/socks
	icon = 'modular_septic/icons/mob/clothing/underwear.dmi'
	use_static = TRUE

/datum/sprite_accessory/socks/socks_knee
	name = "Knee-high"
	icon_state = "socks_knee"
	use_static = null

/datum/sprite_accessory/socks/striped_knee
	name = "Knee-high - Striped"
	icon_state = "striped_knee"
	use_static = null

/datum/sprite_accessory/socks/thin_knee
	name = "Knee-high - Thin"
	icon_state = "thin_knee"
	use_static = null

/datum/sprite_accessory/socks/socks_norm
	name = "Normal"
	icon_state = "socks_norm"
	use_static = null

/datum/sprite_accessory/socks/socks_short
	name = "Short"
	icon_state = "socks_short"
	use_static = null

/datum/sprite_accessory/socks/socks_thigh
	name = "Thigh-high"
	icon_state = "socks_thigh"
	use_static = null

/datum/sprite_accessory/socks/bee_thigh
	name = "Thigh-high - Bee (Old)"
	icon_state = "bee_thigh_old"

/datum/sprite_accessory/socks/bee_knee
	name = "Knee-high - Bee (Old)"
	icon_state = "bee_knee_old"

/datum/sprite_accessory/underwear/socks/christmas_norm
	name = "Normal - Christmas"
	icon_state = "christmas_norm"

/datum/sprite_accessory/underwear/socks/candycaner_norm
	name = "Normal - Red Candy Cane"
	icon_state = "candycaner_norm"

/datum/sprite_accessory/underwear/socks/candycaneg_norm
	name = "Normal - Green Candy Cane"
	icon_state = "candycaneg_norm"

/datum/sprite_accessory/socks/christmas_knee
	name = "Knee-High - Christmas"
	icon_state = "christmas_knee"

/datum/sprite_accessory/socks/candycaner_knee
	name = "Knee-High - Red Candy Cane"
	icon_state = "candycaner_knee"

/datum/sprite_accessory/socks/candycaneg_knee
	name = "Knee-High - Green Candy Cane"
	icon_state = "candycaneg_knee"

/datum/sprite_accessory/socks/christmas_thigh
	name = "Thigh-high - Christmas"
	icon_state = "christmas_thigh"

/datum/sprite_accessory/socks/candycaner_thigh
	name = "Thigh-high - Red Candy Cane"
	icon_state = "candycaner_thigh"

/datum/sprite_accessory/socks/candycaneg_thigh
	name = "Thigh-high - Green Candy Cane"
	icon_state = "candycaneg_thigh"

/datum/sprite_accessory/socks/rainbow_knee
	name = "Knee-high - Rainbow"
	icon_state = "rainbow_knee"

/datum/sprite_accessory/socks/rainbow_thigh
	name = "Thigh-high - Rainbow"
	icon_state = "rainbow_thigh"

/datum/sprite_accessory/socks/fishnet_thigh
	name = "Thigh-high - Fishnet"
	icon_state = "fishnet"

/datum/sprite_accessory/socks/fishnet_thigh
	name = "Pantyhose - Ripped"
	icon_state = "pantyhose_ripped"
	use_static = null

/datum/sprite_accessory/underwear
	icon = 'modular_septic/icons/mob/clothing/underwear.dmi'
	///Whether the underwear uses a special sprite for digitigrade style (i.e. briefs, not panties). Adds a "_d" suffix to the icon state
	var/has_digitigrade = FALSE

/datum/sprite_accessory/underwear/male_bee
	name = "Boxers - Bee"
	icon_state = "bee_shorts"
	has_digitigrade = TRUE
	gender = MALE
	use_static = TRUE

/datum/sprite_accessory/underwear/female_beekini
	name = "Panties - Bee-kini"
	icon_state = "panties_bee-kini"
	gender = FEMALE
	use_static = TRUE

/datum/sprite_accessory/underwear/panties
	name = "Panties"
	icon_state = "panties"
	gender = FEMALE

/datum/sprite_accessory/underwear/panties_alt
	name = "Panties - Alt"
	icon_state = "panties_alt"
	gender = FEMALE

/datum/sprite_accessory/underwear/fishnet_lower
	name = "Panties - Fishnet"
	icon_state = "fishnet_lower"
	gender = FEMALE
	use_static = TRUE

/datum/sprite_accessory/underwear/female_beekini
	name = "Panties - Bee-kini"
	icon_state = "panties_bee-kini"
	gender = FEMALE
	use_static = TRUE

/datum/sprite_accessory/underwear/female_commie
	name = "Panties - Commie"
	icon_state = "panties_commie"
	gender = FEMALE
	use_static = TRUE

/datum/sprite_accessory/underwear/female_usastripe
	name = "Panties - Freedom"
	icon_state = "panties_assblastusa"
	gender = FEMALE
	use_static = TRUE

/datum/sprite_accessory/underwear/female_kinky
	name = "Panties - Kinky Black"
	icon_state = "panties_kinky"
	gender = FEMALE
	use_static = TRUE

/datum/sprite_accessory/underwear/panties_uk
	name = "Panties - UK"
	icon_state = "panties_uk"
	gender = FEMALE
	use_static = TRUE

/datum/sprite_accessory/underwear/panties_neko
	name = "Panties - Neko"
	icon_state = "panties_neko"
	gender = FEMALE

/datum/sprite_accessory/underwear/panties_slim
	name = "Panties - Slim"
	icon_state = "panties_slim"
	gender = FEMALE

/datum/sprite_accessory/underwear/striped_panties
	name = "Panties - Striped"
	icon_state = "striped_panties"
	gender = FEMALE

/datum/sprite_accessory/underwear/panties_swimsuit
	name = "Panties - Swimsuit"
	icon_state = "panties_swimming"
	gender = FEMALE

/datum/sprite_accessory/underwear/panties_thin
	name = "Panties - Thin"
	icon_state = "panties_thin"
	gender = FEMALE

/datum/sprite_accessory/underwear/longjon
	name = "Long John Bottoms"
	icon_state = "ljonb"
	has_digitigrade = TRUE

/datum/sprite_accessory/underwear/swimsuit_red
	name = "Swimsuit, One Piece - Red"
	icon_state = "swimming_red"
	gender = FEMALE
	use_static = TRUE

/datum/sprite_accessory/underwear/swimsuit
	name = "Swimsuit, One Piece - Black"
	icon_state = "swimming_black"
	gender = FEMALE
	use_static = TRUE

/datum/sprite_accessory/underwear/swimsuit_blue
	name = "Swimsuit, One Piece - Striped Blue"
	icon_state = "swimming_blue"
	gender = FEMALE
	use_static = TRUE

/datum/sprite_accessory/underwear/thong
	name = "Thong"
	icon_state = "thong"
	gender = FEMALE
	use_static = TRUE

/datum/sprite_accessory/underwear/thong_babydoll
	name = "Thong - Alt"
	icon_state = "thong_babydoll"
	gender = FEMALE

/datum/sprite_accessory/underwear/chastbelt
	name = "Chastity Belt"
	icon_state = "chastbelt"
	use_static = TRUE

/datum/sprite_accessory/underwear/chastcage
	name = "Chastity Cage"
	icon_state = "chastcage"
	use_static = null


/datum/sprite_accessory/underwear/male_briefs
	has_digitigrade = TRUE

/datum/sprite_accessory/underwear/male_boxers
	has_digitigrade = TRUE

/datum/sprite_accessory/underwear/male_stripe
	has_digitigrade = TRUE

/datum/sprite_accessory/underwear/male_midway
	has_digitigrade = TRUE

/datum/sprite_accessory/underwear/male_longjohns
	has_digitigrade = TRUE

/datum/sprite_accessory/underwear/male_hearts
	has_digitigrade = TRUE

/datum/sprite_accessory/underwear/male_commie
	has_digitigrade = TRUE

/datum/sprite_accessory/underwear/male_usastripe
	has_digitigrade = TRUE

/datum/sprite_accessory/underwear/male_uk
	has_digitigrade = TRUE


/datum/sprite_accessory/undershirt
	icon = 'modular_septic/icons/mob/clothing/underwear.dmi'
	use_static = TRUE

/datum/sprite_accessory/undershirt/tanktop_alt
	name = "Tank Top - Alt"
	icon_state = "tanktop_alt"
	use_static = null

/datum/sprite_accessory/undershirt/tanktop_midriff
	name = "Tank Top - Midriff"
	icon_state = "tank_midriff"
	gender = FEMALE
	use_static = null

/datum/sprite_accessory/undershirt/tanktop_midriff_alt
	name = "Tank Top - Midriff Halterneck"
	icon_state = "tank_midriff_alt"
	gender = FEMALE
	use_static = null

/datum/sprite_accessory/undershirt/tankstripe
	name = "Tank Top - Striped"
	icon_state = "tank_stripes"
	use_static = TRUE

/datum/sprite_accessory/undershirt/tank_top_sun
	name = "Tank top - Sun"
	icon_state = "tank_sun"
	use_static = TRUE

/datum/sprite_accessory/undershirt/babydoll
	name = "Baby-Doll"
	icon_state = "babydoll"
	gender = FEMALE
	use_static = null

/datum/sprite_accessory/undershirt/bra
	name = "Bra"
	icon_state = "bra"
	gender = FEMALE
	use_static = null

/datum/sprite_accessory/undershirt/bra_alt
	name = "Bra - Alt"
	icon_state = "bra_alt"
	gender = FEMALE
	use_static = null

/datum/sprite_accessory/undershirt/bra_thin
	name = "Bra - Thin"
	icon_state = "bra_thin"
	gender = FEMALE
	use_static = null

/datum/sprite_accessory/undershirt/bra_kinky
	name = "Bra - Kinky Black"
	icon_state = "bra_kinky"
	gender = FEMALE
	use_static = TRUE

/datum/sprite_accessory/undershirt/bra_freedom
	name = "Bra - Freedom"
	icon_state = "bra_assblastusa"
	gender = FEMALE
	use_static = TRUE

/datum/sprite_accessory/undershirt/bra_commie
	name = "Bra - Commie"
	icon_state = "bra_commie"
	gender = FEMALE
	use_static = TRUE

/datum/sprite_accessory/undershirt/bra_beekini
	name = "Bra - Bee-kini"
	icon_state = "bra_bee-kini"
	gender = FEMALE
	use_static = TRUE

/datum/sprite_accessory/undershirt/bra_uk
	name = "Bra - UK"
	icon_state = "bra_uk"
	gender = FEMALE
	use_static = TRUE

/datum/sprite_accessory/undershirt/bra_neko
	name = "Bra - Neko"
	icon_state = "bra_neko"
	gender = FEMALE
	use_static = null

/datum/sprite_accessory/undershirt/halterneck_bra
	name = "Bra - Halterneck"
	icon_state = "halterneck_bra"
	gender = FEMALE
	use_static = null

/datum/sprite_accessory/undershirt/sports_bra
	name = "Bra, Sports"
	icon_state = "sports_bra"
	gender = FEMALE
	use_static = null

/datum/sprite_accessory/undershirt/sports_bra_alt
	name = "Bra, Sports - Alt"
	icon_state = "sports_bra_alt"
	gender = FEMALE
	use_static = null

/datum/sprite_accessory/undershirt/bra_strapless
	name = "Bra, Strapless"
	icon_state = "bra_strapless"
	gender = FEMALE
	use_static = null

/datum/sprite_accessory/undershirt/bra_strapless_alt
	name = "Bra, Strapless - Alt"
	icon_state = "bra_blue"
	gender = FEMALE
	use_static = null

/datum/sprite_accessory/undershirt/striped_bra
	name = "Bra - Striped"
	icon_state = "striped_bra"
	gender = FEMALE
	use_static = null

/datum/sprite_accessory/undershirt/fishnet_sleeves
	name = "Fishnet - sleeves"
	icon_state = "fishnet_sleeves"
	gender = FEMALE
	use_static = TRUE

/datum/sprite_accessory/undershirt/fishnet_gloves
	name = "Fishnet - gloves"
	icon_state = "fishnet_gloves"
	gender = FEMALE
	use_static = TRUE

/datum/sprite_accessory/undershirt/fishnet_base
	name = "Fishnet - top"
	icon_state = "fishnet_body"
	gender = FEMALE
	use_static = TRUE

/datum/sprite_accessory/undershirt/swimsuit
	name = "Swimsuit Top"
	icon_state = "bra_swimming"
	gender = FEMALE
	use_static = null

/datum/sprite_accessory/undershirt/swimsuit_alt
	name = "Swimsuit Top - Strapless"
	icon_state = "bra_swimming_alt"
	gender = FEMALE
	use_static = null

/datum/sprite_accessory/undershirt/tubetop
	name = "Tube Top"
	icon_state = "tubetop"
	gender = FEMALE
	use_static = null

/datum/sprite_accessory/undershirt/chastbra
	name = "Chastity Bra"
	icon_state = "chastbra"
	gender = FEMALE
	use_static = TRUE

/datum/sprite_accessory/undershirt/pasties
	name = "Pasties"
	icon_state = "pasties"
	gender = FEMALE
	use_static = null

/datum/sprite_accessory/undershirt/pasties_alt
	name = "Pasties - Alt"
	icon_state = "pasties_alt"
	gender = FEMALE
	use_static = null

/datum/sprite_accessory/undershirt/shibari
	name = "Shibari"
	icon_state = "shibari"
	gender = FEMALE
	use_static = null

/datum/sprite_accessory/undershirt/shibari_sleeves
	name = "Shibari Sleeves"
	icon_state = "shibari_sleeves"
	gender = FEMALE
	use_static = null
