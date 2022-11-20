/obj/item/organ/eyes/fly
	name = "fly eye"
	desc = "This eye seem to stare back no matter the direction you look at it from."

/obj/item/organ/eyes/fly/l
	zone = BODY_ZONE_PRECISE_L_EYE

/obj/item/organ/eyes/fly/Insert(mob/living/carbon/new_owner, special = FALSE, drop_if_replaced = TRUE, new_zone = null)
	. = ..()
	ADD_TRAIT(new_owner, TRAIT_FLASH_SENSITIVE, ORGAN_TRAIT)

/obj/item/organ/eyes/fly/Remove(mob/living/carbon/old_owner, special = FALSE)
	REMOVE_TRAIT(old_owner, TRAIT_FLASH_SENSITIVE, ORGAN_TRAIT)
	return ..()
