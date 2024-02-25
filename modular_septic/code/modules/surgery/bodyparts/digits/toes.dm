/obj/item/digit/toe
	name = "toe"
	desc = "I stubbed my toe."
	icon_state = "toe"
	base_icon_state = "toe"
	digit_type = "toe"

/obj/item/digit/toe/desc_chaser(mob/user)
	. = list()
	var/image_src = image2html('modular_septic/images/kidnamedtoe.jpg', user, format = "jpg", sourceonly = TRUE)
	. += "<img src='[image_src]' width=160 height=90>"

/obj/item/digit/toe/big
	name = "big toe"
	digit_type = "big toe"

/obj/item/digit/toe/index
	name = "index toe"
	digit_type = "index toe"

/obj/item/digit/toe/middle
	name = "middle toe"
	digit_type = "middle toe"

/obj/item/digit/toe/ring
	name = "ring toe"
	digit_type = "ring toe"

/obj/item/digit/toe/pinky
	name = "pinky toe"
	digit_type = "pinky toe"
