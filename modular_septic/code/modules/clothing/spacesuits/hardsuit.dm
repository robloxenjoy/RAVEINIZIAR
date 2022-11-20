//Hardsuits assumedly have hydraulics, and thus weigh less than spacesuits
/obj/item/clothing/head/helmet/space/hardsuit
	carry_weight = 5 KILOGRAMS

/obj/item/clothing/suit/space/hardsuit
	carry_weight = 15 KILOGRAMS

/obj/item/clothing/suit/space/hardsuit/get_carry_weight()
	. = ..()
	if(istype(helmet) && (helmet.loc == src))
		. += helmet.get_carry_weight()
	if(istype(jetpack))
		. += jetpack.get_carry_weight()

