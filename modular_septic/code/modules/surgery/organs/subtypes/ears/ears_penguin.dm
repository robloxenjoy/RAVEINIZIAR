/obj/item/organ/ears/penguin
	name = "penguin ears"
	desc = "The source of a penguin's happy feet."

/obj/item/organ/ears/penguin/Insert(mob/living/carbon/new_owner, special = FALSE, drop_if_replaced = TRUE, new_zone = null)
	. = ..()
	if(istype(new_owner))
		to_chat(new_owner, span_notice("I suddenly feel like i've lost my balance."))
		new_owner.AddElement(/datum/element/waddling)

/obj/item/organ/ears/penguin/Remove(mob/living/carbon/human/old_owner, special = FALSE)
	. = ..()
	if(istype(old_owner))
		to_chat(old_owner, span_notice("My sense of balance comes back to me."))
		old_owner.RemoveElement(/datum/element/waddling)
