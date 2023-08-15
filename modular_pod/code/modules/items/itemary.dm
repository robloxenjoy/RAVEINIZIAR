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
	var/attached_rings = FALSE
	var/attached_gold = FALSE
	var/attached_steel = FALSE
	var/attached_silver = FALSE

/obj/item/craftorshit/thing/retarded
	name = "Retarded Thing"
	desc = "Its strange and retarded."
	icon = 'modular_pod/icons/obj/items/otherobjects.dmi'
	icon_state = "retardedthing"

/obj/item/craftorshit/thing/retarded/alchemical
	name = "Retarded Thing"
	desc = "Its strange and retarded. Magical."
	icon = 'modular_pod/icons/obj/items/otherobjects.dmi'
	icon_state = "retardedthing_magic"

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
						if(!handle)
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
	else if(istype(I, /obj/item/craftorshit/instrument/teether))
		if(user.a_intent == INTENT_DISARM)
			if(condition > 0)
				if(statustate == "READY_ARMOR")
					if(hits > 0)
						if(!attached_rings)
							hits -= 1
							user.visible_message(span_notice("[user] sawing [src]."),span_notice("You saw [src]."), span_hear("You hear the interesting sound."))
							sound_hint()
							user.changeNext_move(10)
							user.adjustFatigueLoss(5)
						else
							var/diceroll = user.diceroll(GET_MOB_SKILL_VALUE(user, SKILL_SMITHING), context = DICE_CONTEXT_PHYSICAL)
							if(diceroll >= DICE_SUCCESS)
								user.visible_message(span_notice("[user] made ouroboros rings!"),span_notice("You made ouroboros rings."), span_hear("You hear the sound of smithing."))
								sound_hint()
								user.changeNext_move(10)
								user.adjustFatigueLoss(5)
								new /obj/item/craftorshit/thing/ouroboros(get_turf(src))
								qdel(src)
							else
								user.visible_message(span_notice("[user] failed to make ouroboros rings."),span_notice("You failed to make ouroboros rings."), span_hear("You hear the sound of smithing."))
								sound_hint()
								user.changeNext_move(10)
								user.adjustFatigueLoss(5)
								new /obj/item/craftorshit/thing/retarded(get_turf(src))
								qdel(src)
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
				else if(statustate == "READY_ARMOR")
					if(user.zone_selected == BODY_ZONE_CHEST)
						if(attached_rings)
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
									user.visible_message(span_notice("[user] forged the chainmail armor!"),span_notice("You forge the chainmail armor."), span_hear("You hear the sound of smithing."))
									sound_hint()
									var/obj/item/melee/bita/hammer/stone/V = I
									V.damageItem("HARD")
									user.changeNext_move(V.attack_delay)
									user.adjustFatigueLoss(10)
									new /obj/item/clothing/suit/armor/vest/chainmail/steel(get_turf(src))
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
	else if(istype(I, /obj/item/craftorshit/thing/ouroboros))
		if(user.a_intent == INTENT_DISARM)
			if(condition > 0)
				if(statustate == "READY_ARMOR")
					if(attached_rings)
						return
					var/obj/item/craftorshit/thing/ouroboros/V = I
					user.visible_message(span_notice("[user] attaches rings to [src]."),span_notice("You attach rings to [src]."), span_hear("You hear the sound of smithing."))
					sound_hint()
					attached_rings = TRUE
					qdel(V)
	else if(istype(I, /obj/item/craftorshit/thing/steel))
		if(user.a_intent == INTENT_GRAB)
			if(condition > 0)
				if(statustate == "READY_ARMOR")
					if(attached_steel)
						return
					var/diceroll = user.diceroll(GET_MOB_SKILL_VALUE(user, SKILL_SMITHING), context = DICE_CONTEXT_PHYSICAL)
					if(diceroll >= DICE_SUCCESS)
						user.visible_message(span_notice("[user] combined steel!"),span_notice("You combine the steel."), span_hear("You hear the sound of smithing."))
						sound_hint()
						user.changeNext_move(10)
						user.adjustFatigueLoss(5)
						attached_steel = TRUE
					else
						user.visible_message(span_notice("[user] failed to combine steel."),span_notice("You failed to combine steel."), span_hear("You hear the sound of smithing."))
						sound_hint()
						user.changeNext_move(10)
						user.adjustFatigueLoss(5)

/obj/item/craftorshit/thing/golden
	name = "Golden Thing"
	desc = "Its strange. Can be used for crafting."
	icon = 'modular_pod/icons/obj/items/otherobjects.dmi'
	icon_state = "goldenthing"
	metallic = TRUE

/obj/item/craftorshit/thing/golden/attackby(obj/item/I, mob/living/carbon/user, params)
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
				else if(statustate == "READY_ARMOR")
					user.visible_message(span_notice("[user] changes the way of using [src]."),span_notice("You changing the way of using [src]."), span_hear("You hear the interesting sound."))
					sound_hint()
					statustate = "READY_WEAPON"
	else if(istype(I, /obj/item/craftorshit/thing/golden))
		if(user.a_intent == INTENT_GRAB)
			if(condition > 0)
				if(statustate == "READY_ARMOR")
					if(attached_gold)
						return
					var/diceroll = user.diceroll(GET_MOB_SKILL_VALUE(user, SKILL_SMITHING), context = DICE_CONTEXT_PHYSICAL)
					if(diceroll >= DICE_SUCCESS)
						user.visible_message(span_notice("[user] combined gold!"),span_notice("You combine the gold."), span_hear("You hear the sound of smithing."))
						sound_hint()
						user.changeNext_move(10)
						user.adjustFatigueLoss(5)
						attached_gold = TRUE
					else
						user.visible_message(span_notice("[user] failed to combine gold."),span_notice("You failed to combine gold."), span_hear("You hear the sound of smithing."))
						sound_hint()
						user.changeNext_move(10)
						user.adjustFatigueLoss(5)
	else if(istype(I, /obj/item/melee/bita/hammer/stone))
		if(user.a_intent == INTENT_HARM)
			if(condition > 0)
				if(statustate == "READY_ARMOR")
					if(user.zone_selected == BODY_ZONE_HEAD)
						if(attached_gold)
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
									user.visible_message(span_notice("[user] forged the golden helmet!"),span_notice("You forge the golden helmet."), span_hear("You hear the sound of smithing."))
									sound_hint()
									var/obj/item/melee/bita/hammer/stone/V = I
									V.damageItem("HARD")
									user.changeNext_move(V.attack_delay)
									user.adjustFatigueLoss(10)
									new /obj/item/clothing/head/helmet/golden/full(get_turf(src))
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

/obj/item/craftorshit/thing/iron
	name = "Iron Thing"
	desc = "Its strange. Can be used for crafting."
	icon = 'modular_pod/icons/obj/items/otherobjects.dmi'
	icon_state = "ironthing"
	metallic = TRUE

/obj/item/craftorshit/thing/silver
	name = "Silver Thing"
	desc = "Its strange. Can be used for crafting."
	icon = 'modular_pod/icons/obj/items/otherobjects.dmi'
	icon_state = "silverthing"
	metallic = TRUE

/obj/item/craftorshit/thing/silver/attackby(obj/item/I, mob/living/carbon/user, params)
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
				if(statustate == "READY_ARMOR")
					if(user.zone_selected == BODY_ZONE_HEAD)
						if(attached_silver)
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
									user.visible_message(span_notice("[user] forged the silver helmet!"),span_notice("You forge the silver helmet."), span_hear("You hear the sound of smithing."))
									sound_hint()
									var/obj/item/melee/bita/hammer/stone/V = I
									V.damageItem("HARD")
									user.changeNext_move(V.attack_delay)
									user.adjustFatigueLoss(10)
									new /obj/item/clothing/head/helmet/silver/full(get_turf(src))
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

	else if(istype(I, /obj/item/craftorshit/thing/silver))
		if(user.a_intent == INTENT_GRAB)
			if(condition > 0)
				if(statustate == "READY_ARMOR")
					if(attached_silver)
						return
					var/diceroll = user.diceroll(GET_MOB_SKILL_VALUE(user, SKILL_SMITHING), context = DICE_CONTEXT_PHYSICAL)
					if(diceroll >= DICE_SUCCESS)
						user.visible_message(span_notice("[user] combined silver!"),span_notice("You combine the silver."), span_hear("You hear the sound of smithing."))
						sound_hint()
						user.changeNext_move(10)
						user.adjustFatigueLoss(5)
						attached_silver = TRUE
					else
						user.visible_message(span_notice("[user] failed to combine silver."),span_notice("You failed to combine silver."), span_hear("You hear the sound of smithing."))
						sound_hint()
						user.changeNext_move(10)
						user.adjustFatigueLoss(5)

/obj/item/craftorshit/thing/ouroboros
	name = "Ouroboros Rings"
	desc = "Its strange. Can be used for crafting."
	icon = 'modular_pod/icons/obj/items/otherobjects.dmi'
	icon_state = "ouro_rings"
	metallic = TRUE

/obj/item/melee/hehe/pickaxe/iron
	name = "Iron Pickaxe"
	desc = "GET THE STONES, SLAVE!"
	icon = 'modular_pod/icons/obj/items/weapons.dmi'
	lefthand_file = 'modular_septic/icons/mob/inhands/remis_lefthand.dmi'
	righthand_file = 'modular_septic/icons/mob/inhands/remis_righthand.dmi'
	icon_state = "ironpickaxe"
	inhand_icon_state = "ironpickaxe"
	worn_icon = 'modular_septic/icons/mob/clothing/belt.dmi'
	worn_icon_state = "ironpickaxe"
	equip_sound = 'modular_pod/sound/eff/weapon/sheath_default.ogg'
	pickup_sound = 'modular_pod/sound/eff/weapon/draw_default.ogg'
	miss_sound = list('modular_pod/sound/eff/weapon/swing_default.ogg')
	drop_sound = 'modular_septic/sound/effects/fallsmall.ogg'
	hitsound = list('modular_pod/sound/eff/weapon/hit_default.ogg')
	w_class = WEIGHT_CLASS_NORMAL
	wound_bonus = 5
	bare_wound_bonus = 6
	min_force = 15
	force = 18
	min_force_strength = 1
	throwforce = 8
	force_strength = 1.8
	sharpness = SHARP_POINTY
	embedding = list("pain_mult" = 10, "rip_time" = 5, "embed_chance" = 60, "jostle_chance" = 5, "pain_stam_pct" = 2, "pain_jostle_mult" = 9, "fall_chance" = 0.1, "ignore_throwspeed_threshold" = TRUE)
	skill_melee = SKILL_IMPACT_WEAPON
	carry_weight = 2 KILOGRAMS
	attack_fatigue_cost = 15
	attack_delay = 20
	armor_damage_modifier = 3
	edge_protection_penetration = 10
	subtractible_armour_penetration = 510
//	armour_penetration = 10
	parrying_flags = BLOCK_FLAG_UNARMED
	havedurability = TRUE
	durability = 100
	tetris_width = 32
	tetris_height = 64
	slot_flags = ITEM_SLOT_BELT
	can_dig = TRUE
	attack_verb_continuous = list("stabs", "mines", "jabs")
	attack_verb_simple = list("stab", "mine", "jab")

/obj/item/pinker_caller
	name = "PINKER Caller"
	desc = "CALL HIM!"
	icon = 'modular_pod/icons/obj/items/otherobjects.dmi'
	icon_state = "pinker"
	var/usedy = FALSE

/obj/item/pinker_caller/attack_self(mob/living/carbon/user, modifiers)
	. = ..()
	if(usedy)
		return
	var/srd = CONFIG_GET(number/shuttle_refuel_delay)
	if(world.time - SSticker.round_start_time < srd)
		to_chat(user, span_notice("The PINKER is getting ready. Please wait [DisplayTimeText(srd - (world.time - SSticker.round_start_time))] before attempting to call."))
		return
	SSshuttle.emergency.request()
	usedy = TRUE

/obj/item/atrat
	name = "Atrat"
	desc = "Femboy sex."
	icon = 'modular_pod/icons/obj/items/otherobjects.dmi'
	icon_state = "atrat"
	var/usedy = FALSE

/*
/obj/item/atrat/attack_self(mob/living/carbon/user, modifiers)
	. = ..()
	if(usedy)
		return
	usedy = TRUE
	addtimer(CALLBACK(src, .proc/restart_use), 50 SECONDS)
*/

/obj/item/atrat/attack_atom(atom/attacked_atom, mob/living/carbon/user, params)
	if(!isturf(attacked_atom))
		return
	if(isopenspaceturf(attacked_atom) || isspaceturf(attacked_atom))
		return
	if(!usedy)
		new /atom/movable/fire(attacked_atom, 21)
		usedy = TRUE
		addtimer(CALLBACK(src, .proc/restart_use), 50 SECONDS)

/obj/item/atrat/proc/restart_use()
	if(QDELETED(src) || !usedy)
		return
	usedy = FALSE