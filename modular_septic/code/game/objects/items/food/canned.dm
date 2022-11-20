/obj/item/food/canned
	tetris_width = 32
	tetris_height = 32

/obj/item/food/canned/proc/open_can(mob/user)
	to_chat(user, span_notice("I pop the tab of \the [src]."))
	playsound(user.loc, 'modular_septic/sound/food/foodcan_preopen.wav', 65)
	if(!do_after(user, 5, src))
		return
	to_chat(user, span_notice("I pull back the lid of \the [src]."))
	playsound(user.loc, 'modular_septic/sound/food/foodcan_open.wav', 65)
	reagents.flags |= OPENCONTAINER
	preserved_food = FALSE
	MakeDecompose()

/obj/item/food/canned/beef
	name = "tin of delicious beef stew"
	desc = "A large can of stew from genetically modified beef, could feed an entire starving african family! Or a pig. "
	icon = 'modular_septic/icons/obj/food/canned.dmi'
	icon_state = "beef"
	trash_type = /obj/item/trash/can/food/beef
	food_reagents = list(/datum/reagent/consumable/nutriment = 8, /datum/reagent/consumable/nutriment/protein = 12, /datum/reagent/consumable/mug = 6)
	tastes = list("tushonka" = 1)
	foodtypes = MEAT
