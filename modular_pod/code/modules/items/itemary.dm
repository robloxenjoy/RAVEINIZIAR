/obj/item/oxygolot
	name = "Oxygolot"
	desc = "You know."
	icon = 'modular_septic/icons/obj/items/melee/pipe.dmi'
	icon_state = "oxygolot"

/obj/item/oxygolot/attack_self(mob/living/carbon/user, modifiers)
	. = ..()
	user.adjustOxyLoss((rand(40, 55)) - GET_MOB_ATTRIBUTE_VALUE(user, STAT_ENDURANCE))

/obj/item/craftorshit/instrument/swopper
	name = "Swopper"
	desc = "Your tool."
	icon = 'modular_pod/icons/obj/items/otherobjects.dmi'
	icon_state = "swopper"

/obj/item/craftorshit/thing
	var/metallic = FALSE
	var/statustate = NOT_READY
	var/maxcondition = 100
	var/condition = maxcondition
	var/canbeswopped = FALSE

/obj/item/craftorshit/thing/retarded
	name = "Retarded Thing"
	desc = "Its strange and retarded."
	icon = 'modular_pod/icons/obj/items/otherobjects.dmi'
	icon_state = "retardedthing"

/obj/item/craftorshit/thing/wooden
	name = "Evil Wooden Thing"
	desc = "Its strange. Can be used for crafting."
	icon = 'modular_pod/icons/obj/items/otherobjects.dmi'
	icon_state = "woodenthing"

/obj/item/craftorshit/thing/steel
	name = "Steel Thing"
	desc = "Its strange. Can be used for crafting."
	icon = 'modular_pod/icons/obj/items/otherobjects.dmi'
	icon_state = "steelthing"
	metallic = TRUE
	canbeswopped = TRUE

/obj/item/craftorshit/thing/steel/attackby(obj/item/I, mob/living/carbon/user, params)
	. = ..()
	if(istype(I, /obj/item/craftorshit/instrument/swopper))
		if(user.a_intent == INTENT_GRAB)
			if(condition > 0)
				if(statustate == NOT_READY)
					user.visible_message(span_notice("[user] readies the using of [src]."),span_notice("You ready the using of [src]."), span_hear("You hear the interesting sound."))
					sound_hint()
					statuestate == READY_WEAPON
				else if(statustate == READY_WEAPON)
					user.visible_message(span_notice("[user] changes the way of using [src]."),span_notice("You changing the way of using [src]."), span_hear("You hear the interesting sound."))
					sound_hint()
					statuestate == READY_ARMOR

/obj/item/craftorshit/thing/golden
	name = "Golden Thing"
	desc = "Its strange. Can be used for crafting."
	icon = 'modular_pod/icons/obj/items/otherobjects.dmi'
	icon_state = "goldenthing"
	metallic = TRUE

/obj/item/craftorshit/thing/iron
	name = "Iron Thing"
	desc = "Its strange. Can be used for crafting."
	icon = 'modular_pod/icons/obj/items/otherobjects.dmi'
	icon_state = "ironthing"
	metallic = TRUE