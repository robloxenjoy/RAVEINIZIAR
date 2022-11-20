/obj/item/shrapnel
	name = "shrapnel"
	desc = "A projectile that got inside of someone, then came out."
	icon = 'modular_septic/icons/obj/items/shrapnel.dmi'
	icon_state = "shrapnel"
	base_icon_state = "shrapnel"
	item_flags = NONE
	var/state_variation = 5

/obj/item/shrapnel/Initialize(mapload)
	. = ..()
	if(state_variation)
		icon_state = "[base_icon_state][rand(1, state_variation)]"

/obj/item/shrapnel/bullet
	name = "bullet shrapnel"
	desc = "A bullet that got inside of someone, then came out."
	icon = 'modular_septic/icons/obj/items/shrapnel.dmi'
	icon_state = "bullet_shrapnel"
	base_icon_state = "bullet_shrapnel"
	state_variation = 0
