/obj/item/oxygolot
	name = "Oxygolot"
	desc = "You know."
	icon = 'modular_septic/icons/obj/items/melee/pipe.dmi'
	icon_state = "oxygolot"

/obj/item/oxygolot/attack_self(mob/living/carbon/user, modifiers)
	. = ..()
	user.adjustOxyLoss((rand(40, 55)) - GET_MOB_ATTRIBUTE_VALUE(user, STAT_ENDURANCE))

/obj/item/specialuser/vilir
	name = "Vilir"
	desc = "A little slimy."
	icon = 'modular_pod/icons/obj/things/things.dmi'
	icon_state = "vilir"
	var/used = FALSE

/obj/item/specialuser/vilir/ComponentInitialize()
	. = ..()
	AddComponent(/datum/component/slippery, 60)

/obj/item/specialuser/vilir/examine(mob/user)
	. = ..()
	if(used)
		. += "<span class='warning'>Looks like it's already been used.</span>"