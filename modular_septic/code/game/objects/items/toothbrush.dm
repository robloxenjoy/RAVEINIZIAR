/obj/item/toothbrush
	name = "toothbrush"
	desc = "A brush used to clean your teeth."
	icon = 'modular_septic/icons/obj/items/toothbrush.dmi'
	icon_state = "toothbrush"
	base_icon_state = "toothbrush"
	w_class = WEIGHT_CLASS_SMALL

/obj/item/toothbrush/random
	name = "random toothbrush"
	icon_state = "toothbrush_random"

/obj/item/toothbrush/random/Initialize()
	. = ..()
	var/picked_color = pick("purple", "pink", "red", "green", "blue", "yellow")
	name = "[picked_color] toothbrush"
	icon_state = "toothbrush_[picked_color]"
