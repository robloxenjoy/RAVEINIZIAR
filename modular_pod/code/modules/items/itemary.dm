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

/obj/item/craftorshit/instrument/teether
	name = "Teether"
	desc = "Your tool."
	icon = 'modular_pod/icons/obj/items/otherobjects.dmi'
	icon_state = "teether"

/obj/item/craftorshit/thing
	var/metallic = FALSE
	var/statustate = "NOT_READY"
	var/condition = 100
	var/hits = 5
	var/attached_handle = FALSE

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
	hits = 5
	var/handle = FALSE

/obj/item/craftorshit/thing/wooden/attackby(obj/item/I, mob/living/carbon/user, params)
	. = ..()
	if(istype(I, /obj/item/craftorshit/instrument/swopper))
		if(user.a_intent == INTENT_GRAB)
			if(condition > 0)
				if(statustate == "NOT_READY")
					user.visible_message(span_notice("[user] readies the using of [src]."),span_notice("You ready the using of [src]."), span_hear("You hear the interesting sound."))
					sound_hint()
					statustate = "READY_HANDLE"
				else if(statustate == "READY_HANDLE")
					user.visible_message(span_notice("[user] changes the way of using [src]."),span_notice("You changing the way of using [src]."), span_hear("You hear the interesting sound."))
					sound_hint()
					statustate = "READY_OTHER"
				else if(statustate == "READY_OTHER")
					user.visible_message(span_notice("[user] changes the way of using [src]."),span_notice("You changing the way of using [src]."), span_hear("You hear the interesting sound."))
					sound_hint()
					statustate = "READY_HANDLE"
	else if(istype(I, /obj/item/craftorshit/instrument/teether))
		if(user.a_intent == INTENT_DISARM)
			if(condition > 0)
				if(statustate == "READY_HANDLE")
					if(hits > 0)
						if(!handle)
							hits -= 1
							user.visible_message(span_notice("[user] sawing [src]."),span_notice("You saw [src]."), span_hear("You hear the interesting sound."))
							sound_hint()
							user.changeNext_move(10)
							user.adjustFatigueLoss(5)
						else
							var/diceroll = user.diceroll(GET_MOB_SKILL_VALUE(user, SKILL_SMITHING), context = DICE_CONTEXT_PHYSICAL)
							if(diceroll >= DICE_SUCCESS)
								user.visible_message(span_notice("[user] made a handle!"),span_notice("You made the handle."), span_hear("You hear the sound of smithing."))
								sound_hint()
								user.changeNext_move(10)
								user.adjustFatigueLoss(5)
								handle = TRUE
							else
								user.visible_message(span_notice("[user] failed to make handle."),span_notice("You failed to make handle."), span_hear("You hear the sound of smithing."))
								sound_hint()
								user.changeNext_move(10)
								user.adjustFatigueLoss(5)
								new /obj/item/craftorshit/thing/retarded(get_turf(src))
								qdel(src)

/obj/item/craftorshit/thing/steel
	name = "Steel Thing"
	desc = "Its strange. Can be used for crafting."
	icon = 'modular_pod/icons/obj/items/otherobjects.dmi'
	icon_state = "steelthing"
	metallic = TRUE
	hits = 10

/obj/item/craftorshit/thing/steel/attackby(obj/item/I, mob/living/carbon/user, params)
	. = ..()
	if(istype(I, /obj/item/craftorshit/instrument/swopper))
		if(user.a_intent == INTENT_GRAB)
			if(condition > 0)
				if(statustate == "NOT_READY")
					user.visible_message(span_notice("[user] readies the using of [src]."),span_notice("You ready the using of [src]."), span_hear("You hear the interesting sound."))
					sound_hint()
					statustate = "READY_WEAPON"
				else if(statustate == "READY_WEAPON")
					user.visible_message(span_notice("[user] changes the way of using [src]."),span_notice("You changing the way of using [src]."), span_hear("You hear the interesting sound."))
					sound_hint()
					statustate = "READY_ARMOR"
					hits = 10
				else if(statustate == "READY_ARMOR")
					user.visible_message(span_notice("[user] changes the way of using [src]."),span_notice("You changing the way of using [src]."), span_hear("You hear the interesting sound."))
					sound_hint()
					statustate = "READY_WEAPON"
					hits = 10
	else if(istype(I, /obj/item/melee/bita/hammer/stone))
		if(user.a_intent == INTENT_HARM)
			if(condition > 0)
				if(statustate == "READY_WEAPON")
					if(user.zone_selected == BODY_ZONE_PRECISE_L_HAND)
						if(attached_handle)
							if(hits > 0)
								hits -= 1
								user.visible_message(span_notice("[user] forges [src]."),span_notice("You forge [src]."), span_hear("You hear the sound of smithing."))
								sound_hint()
								var/obj/item/melee/bita/hammer/stone/V = I
								V.damageItem("HARD")
								user.changeNext_move(V.attack_delay)
								user.adjustFatigueLoss(10)
							else
								var/diceroll = user.diceroll(GET_MOB_SKILL_VALUE(user, SKILL_SMITHING), context = DICE_CONTEXT_PHYSICAL)
								if(diceroll >= DICE_SUCCESS)
									user.visible_message(span_notice("[user] forged the sword!"),span_notice("You forge the sword."), span_hear("You hear the sound of smithing."))
									sound_hint()
									var/obj/item/melee/bita/hammer/stone/V = I
									V.damageItem("HARD")
									user.changeNext_move(V.attack_delay)
									user.adjustFatigueLoss(10)
									new /obj/item/changeable_attacks/slashstabbash/sword/medium/steel(get_turf(src))
									qdel(src)
								else
									user.visible_message(span_notice("[user] failed to forge [src]."),span_notice("You failed to forge [src]."), span_hear("You hear the sound of smithing."))
									sound_hint()
									var/obj/item/melee/bita/hammer/stone/V = I
									V.damageItem("HARD")
									user.changeNext_move(V.attack_delay)
									user.adjustFatigueLoss(10)
									new /obj/item/craftorshit/thing/retarded(get_turf(src))
									qdel(src)
	else if(istype(I, /obj/item/craftorshit/thing/wooden))
		if(user.a_intent == INTENT_DISARM)
			if(condition > 0)
				if(statustate == "READY_WEAPON")
					if(attached_handle)
						return
					var/obj/item/craftorshit/thing/wooden/V = I
					if(V.handle)
						user.visible_message(span_notice("[user] attaches the handle to [src]."),span_notice("You attach the handle to [src]."), span_hear("You hear the sound of smithing."))
						sound_hint()
						attached_handle = TRUE
						qdel(V)

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