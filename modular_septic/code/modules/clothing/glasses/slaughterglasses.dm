/obj/item/clothing/glasses/sunglasses/slaughter
	name = "\improper slaughter goggles"
	desc = "Imputatively produced and Clean goggles with ballistic glass, protecting the eyes from shrapnel and even bullets. \
	There's a label on the interior of the goggles written with black ink. \
	JUST DO. \
	WHAT COMES NATURAL."
	icon = 'modular_septic/icons/obj/clothing/glasses.dmi'
	icon_state = "glownigger"
	worn_icon = 'modular_septic/icons/mob/clothing/eyes.dmi'
	worn_icon_state = "glownigger"
	glass_colour_type = /datum/client_colour/glass_colour/red

/obj/item/clothing/glasses/sunglasses/slaughter/equipped(mob/living/carbon/human/user, slot)
	. = ..()
	if(slot == ITEM_SLOT_EYES)
		user.attributes?.add_attribute_modifier(/datum/attribute_modifier/slaughter, TRUE)

/obj/item/clothing/glasses/sunglasses/slaughter/dropped(mob/living/carbon/human/user)
	..()
	user.attributes?.remove_attribute_modifier(/datum/attribute_modifier/slaughter, TRUE)
