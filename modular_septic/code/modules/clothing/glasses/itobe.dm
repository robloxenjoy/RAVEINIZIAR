/obj/item/clothing/glasses/itobe
	name = "ITOBE eyepiece"
	desc = "A device served to enhance acrobatics on the battlefield, similar to the slaughter mask manufactored by the death sec unit, but with better materials."
	icon = 'modular_septic/icons/obj/clothing/glasses.dmi'
	base_icon_state = "soldat-s"
	icon_state = "soldat-s"
	worn_icon = 'modular_septic/icons/mob/clothing/eyes.dmi'
	worn_icon_state = "soldat-s"
	actions_types = list(/datum/action/item_action/toggle)
	flash_protect = FLASH_PROTECTION_WELDER
	glass_colour_type = /datum/client_colour/glass_colour/yellow

/obj/item/clothing/glasses/itobe/agent
	name = "ITOBE agent sunglasses"
	desc = "Flimsy glasses that wouldn't survive the butt of a rifle being bashed into it at full-force."
	base_icon_state = "agent"
	icon_state = "agent"
	worn_icon_state = "agent"
	actions_types = null
	glass_colour_type = /datum/client_colour/glass_colour/red

/obj/item/clothing/glasses/itobe/hank
	name = "MK2 slaughter glasses"
	desc = "An experimental version of the slaughter goggles, lightweight glasses that make the user have a vicious appetite for bloodlust as well as being a more proficient shooter."
	base_icon_state = "hank"
	icon_state = "hank"
	worn_icon_state = "hank"
	actions_types = null
	glass_colour_type = /datum/client_colour/glass_colour/darkred

/obj/item/clothing/glasses/itobe/sanfo
	name = "SanfBenchs sunglasses"
	desc = "An ordinary dollarstore pair of round sunglasses that will instantly get you bitches."
	base_icon_state = "sanfo"
	icon_state = "sanfo"
	worn_icon_state = "sanfo"
	actions_types = null
	glass_colour_type = /datum/client_colour/glass_colour/gray

/obj/item/clothing/glasses/itobe/soldat
	flash_protect = FLASH_PROTECTION_WELDER
	lighting_alpha = LIGHTING_PLANE_ALPHA_MOSTLY_INVISIBLE
	glass_colour_type = /datum/client_colour/glass_colour/yellow

/obj/item/clothing/glasses/itobe/soldat/equipped(mob/living/carbon/human/user, slot)
	. = ..()
	if(slot == ITEM_SLOT_EYES)
		user.attributes?.add_attribute_modifier(/datum/attribute_modifier/soldat, TRUE)

/obj/item/clothing/glasses/itobe/soldat/dropped(mob/living/carbon/human/user)
	..()
	user.attributes?.remove_attribute_modifier(/datum/attribute_modifier/soldat, TRUE)
