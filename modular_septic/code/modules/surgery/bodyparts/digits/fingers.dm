/obj/item/digit/finger
	name = "finger"
	desc = "Okay class, today we are going to finger paint."
	icon_state = "finger"
	base_icon_state = "finger"
	digit_type = "finger"

/obj/item/digit/finger/desc_chaser(mob/user)
	. = list()
	var/image_src = image2html('modular_septic/images/kidnamedfinger.jpg', user, format = "jpg", sourceonly = TRUE)
	. += "<img src='[image_src]' width=160 height=90>"

/obj/item/digit/finger/thumb
	name = "thumb"
	digit_type = "thumb"

/obj/item/digit/finger/index
	name = "index finger"
	digit_type = "index finger"

/obj/item/digit/finger/middle
	name = "middle finger"
	digit_type = "middle finger"

/obj/item/digit/finger/ring
	name = "ring finger"
	digit_type = "ring finger"

/obj/item/digit/finger/pinky
	name = "pinky finger"
	digit_type = "pinky finger"
