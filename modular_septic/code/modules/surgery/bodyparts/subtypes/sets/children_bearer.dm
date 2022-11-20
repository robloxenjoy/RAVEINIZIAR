/obj/item/bodypart/r_arm/children
	starting_children = list(/obj/item/bodypart/r_hand)

/obj/item/bodypart/l_arm/children
	starting_children = list(/obj/item/bodypart/l_hand)

/obj/item/bodypart/r_leg/children
	starting_children = list(/obj/item/bodypart/r_foot)

/obj/item/bodypart/l_leg/children
	starting_children = list(/obj/item/bodypart/l_foot)

/obj/item/bodypart/chest/children
	starting_children = list(/obj/item/bodypart/neck, /obj/item/bodypart/vitals)

/obj/item/bodypart/vitals/children
	starting_children = list(/obj/item/bodypart/groin)

/obj/item/bodypart/groin/children
	starting_children = list(/obj/item/bodypart/r_leg/children, /obj/item/bodypart/l_leg/children)

/obj/item/bodypart/neck/children
	starting_children = list(/obj/item/bodypart/head/children)

/obj/item/bodypart/head/children
	starting_children = list(/obj/item/bodypart/face, /obj/item/bodypart/mouth, /obj/item/bodypart/r_eyelid, /obj/item/bodypart/l_eyelid)
