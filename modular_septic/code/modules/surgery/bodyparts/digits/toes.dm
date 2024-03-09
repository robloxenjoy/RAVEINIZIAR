/obj/item/digit/toe
	name = "Палец ноги"
	desc = "Пальцы ног на руках, пальцы рук на ногах."
	icon_state = "toe"
	base_icon_state = "toe"
	digit_type = "toe"

/*
/obj/item/digit/toe/desc_chaser(mob/user)
	. = list()
	var/image_src = image2html('modular_septic/images/kidnamedtoe.jpg', user, format = "jpg", sourceonly = TRUE)
	. += "<img src='[image_src]' width=160 height=90>"
*/

/obj/item/digit/toe/big
	name = "Большой палец ноги"
	digit_type = "big toe"

/obj/item/digit/toe/index
	name = "Указательный палец ноги"
	digit_type = "index toe"

/obj/item/digit/toe/middle
	name = "Средний палец ноги"
	digit_type = "middle toe"

/obj/item/digit/toe/ring
	name = "Безымянный палец ноги"
	digit_type = "ring toe"

/obj/item/digit/toe/pinky
	name = "Мизинец ноги"
	digit_type = "pinky toe"
