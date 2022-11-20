// Note: tails only work in humans. They use human-specific parameters and rely on human code for displaying.
/obj/item/organ/tail
	name = "tail"
	desc = "A severed tail. What did you cut this off of?"
	icon_state = "tail"
	zone = BODY_ZONE_PRECISE_GROIN
	organ_efficiency = list(ORGAN_SLOT_TAIL = 100)
	dna_block = DNA_HUMAN_TAIL_BLOCK
	mutantpart_key = "tail"
	mutantpart_colored = TRUE
	mutantpart_info = list(MUTANT_INDEX_NAME = "Smooth", MUTANT_INDEX_COLOR = list("FFFFFF"))
	/// The sprite accessory this tail gives to the human it's attached to. If null, it will inherit its value from the human's DNA once attached.
	var/tail_type = "None"
	var/can_wag = TRUE
	var/wagging = FALSE

/obj/item/organ/tail/Insert(mob/living/carbon/new_owner, special = FALSE, drop_if_replaced = TRUE, new_zone = null)
	. = ..()
	new_owner?.dna?.species?.on_tail_regain(new_owner, src, special)

/obj/item/organ/tail/Remove(mob/living/carbon/old_owner, special = FALSE)
	. = ..()
	old_owner?.dna?.species?.on_tail_lost(old_owner, src, special)
