/obj/item/stack/ballistic
	name = "kevlar bundles"
	icon = 'modular_septic/icons/obj/items/stacks.dmi'
	icon_state = "kevlar"
	amount = 10
	max_amount = 10

/obj/item/stack/ballistic/plate
	name = "steel armor plates"
	icon = 'modular_septic/icons/obj/items/stacks.dmi'
	icon_state = "plate"
	amount = 1
	max_amount = 1

/obj/item/stack/eviljewel
	name = "Evil Jewel"
	icon = 'modular_pod/icons/obj/items/otherobjects.dmi'
	icon_state = "eviljewel1"
	singular_name = "Evil Jewel"
	amount = 1
	max_amount = 32
//	novariants = FALSE
	merge_type = /obj/item/stack/eviljewel
	drop_sound = 'modular_pod/sound/eff/dropcube.ogg'
	pickup_sound = 'modular_septic/sound/effects/pickupdefault.ogg'
	w_class = WEIGHT_CLASS_TINY
	full_w_class = WEIGHT_CLASS_TINY

/obj/item/stack/eviljewel/update_icon_state()
	switch(amount)
		if(1)
			icon_state = "eviljewel1"
		if(2)
			icon_state = "eviljewel2"
		if(3)
			icon_state = "eviljewel3"
		if(4)
			icon_state = "eviljewel4"
		if(5)
			icon_state = "eviljewel5"
		if(6)
			icon_state = "eviljewel6"
		if(7)
			icon_state = "eviljewel7"
		if(8)
			icon_state = "eviljewel8"
	return ..()

/obj/item/stack/eviljewel/five
	amount = 5

/obj/item/stack/eviljewel/ten
	amount = 10

/obj/item/stack/eviljewel/twenty
	amount = 20

/obj/item/stack/eviljewel/max
	amount = 32