/obj/structure/closet/crate/wooden
	name = "Wooden Chest"
	desc = "Good and hard."
	material_drop = /obj/item/stack/sheet/mineral/wood
	material_drop_amount = 6
	icon_state = "wooden"
	open_sound = 'sound/machines/wooden_closet_open.ogg'
	close_sound = 'sound/machines/wooden_closet_close.ogg'
	open_sound_volume = 25
	close_sound_volume = 50

/obj/structure/closet/crate/wooden/toy
	name = "toy box"
	desc = "It has the words \"Clown + Mime\" written underneath of it with marker."

/obj/structure/closet/crate/wooden/toy/PopulateContents()
	. = ..()
	new /obj/item/megaphone/clown(src)
	new /obj/item/reagent_containers/food/drinks/soda_cans/canned_laughter(src)
	new /obj/item/pneumatic_cannon/pie(src)
	new /obj/item/food/pie/cream(src)
	new /obj/item/storage/crayons(src)

/obj/structure/closet/crate/wooden/crazy

/obj/structure/closet/crate/wooden/crazy/PopulateContents()
	..()
	if(prob(50))
		if(prob(50))
			new /obj/item/ammo_box/magazine/ammo_stack/c38/loaded(src)
		else
			new /obj/item/grenade/gas/incredible_gas(src)
	else
		new /obj/item/shit(src)
