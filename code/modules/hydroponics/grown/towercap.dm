/obj/item/seeds/tower
	name = "pack of tower-cap mycelium"
	desc = "This mycelium grows into tower-cap mushrooms."
	icon_state = "mycelium-tower"
	species = "towercap"
	plantname = "Tower Caps"
	product = /obj/item/grown/log
	lifespan = 80
	endurance = 50
	maturation = 15
	production = 1
	yield = 5
	potency = 50
	growthstages = 3
	growing_icon = 'icons/obj/hydroponics/growing_mushrooms.dmi'
	icon_dead = "towercap-dead"
	genes = list(/datum/plant_gene/trait/plant_type/fungal_metabolism)
	mutatelist = list(/obj/item/seeds/tower/steel)
	reagents_add = list(/datum/reagent/cellulose = 0.05)
	graft_gene = /datum/plant_gene/trait/plant_type/fungal_metabolism

/obj/item/seeds/tower/steel
	name = "pack of steel-cap mycelium"
	desc = "This mycelium grows into steel logs."
	icon_state = "mycelium-steelcap"
	species = "steelcap"
	plantname = "Steel Caps"
	product = /obj/item/grown/log/steel
	mutatelist = null
	reagents_add = list(/datum/reagent/cellulose = 0.05, /datum/reagent/iron = 0.05)
	rarity = 20

/obj/item/grown/log
	seed = /obj/item/seeds/tower
	name = "tower-cap log"
	desc = "It's better than bad, it's good!"
	icon_state = "logs"
	force = 5
	throwforce = 5
	w_class = WEIGHT_CLASS_NORMAL
	throw_speed = 2
	throw_range = 3
	attack_verb_continuous = list("bashes", "batters", "bludgeons", "whacks")
	attack_verb_simple = list("bash", "batter", "bludgeon", "whack")
	var/plank_type = /obj/item/stack/sheet/mineral/wood
	var/plank_name = "wooden planks"
	var/static/list/accepted = typecacheof(list(/obj/item/food/grown/tobacco,
	/obj/item/food/grown/tea,
	/obj/item/food/grown/ash_flora/mushroom_leaf,
	/obj/item/food/grown/ambrosia/vulgaris,
	/obj/item/food/grown/ambrosia/deus,
	/obj/item/food/grown/wheat))

/obj/item/grown/log/attackby(obj/item/W, mob/user, params)
	if(W.get_sharpness())
		user.show_message(span_notice("You make [plank_name] out of \the [src]!"), MSG_VISUAL)
		var/seed_modifier = 0
		if(seed)
			seed_modifier = round(seed.potency / 25)
		var/obj/item/stack/plank = new plank_type(user.loc, 1 + seed_modifier, FALSE)
		var/old_plank_amount = plank.amount
		for (var/obj/item/stack/ST in user.loc)
			if (ST != plank && istype(ST, plank_type) && ST.amount < ST.max_amount)
				ST.attackby(plank, user) //we try to transfer all old unfinished stacks to the new stack we created.
		if (plank.amount > old_plank_amount)
			to_chat(user, span_notice("You add the newly-formed [plank_name] to the stack. It now contains [plank.amount] [plank_name]."))
		qdel(src)

	if(CheckAccepted(W))
		var/obj/item/food/grown/leaf = W
		if(HAS_TRAIT(leaf, TRAIT_DRIED))
			user.show_message(span_notice("You wrap \the [W] around the log, turning it into a torch!"))
			var/obj/item/flashlight/flare/torch/T = new /obj/item/flashlight/flare/torch(user.loc)
			usr.dropItemToGround(W)
			usr.put_in_active_hand(T)
			qdel(leaf)
			qdel(src)
			return
		else
			to_chat(usr, span_warning("You must dry this first!"))
	else
		return ..()

/obj/item/grown/log/proc/CheckAccepted(obj/item/I)
	return is_type_in_typecache(I, accepted)

/obj/item/grown/log/tree
	seed = null
	name = "wood log"
	desc = "TIMMMMM-BERRRRRRRRRRR!"

/obj/item/grown/log/tree/evil
	seed = null
	name = "Evil Wood Stub"
	desc = "It's cursed, warlocks is bad!"
	icon_state = "evilstub"
	min_force = 7
	force = 13
	throwforce = 13
	min_force_strength = 1.2
	force_strength = 1.6
	wound_bonus = 6
	bare_wound_bonus = 10
	carry_weight = 4.5 KILOGRAMS
	skill_melee = SKILL_IMPACT_WEAPON_TWOHANDED
	w_class = WEIGHT_CLASS_BULKY
	attack_delay = 25
	throw_speed = 2
	throw_range = 5
	drop_sound = 'modular_septic/sound/effects/fallmedium.ogg'
	pickup_sound = 'modular_septic/sound/effects/pickupdefault.wav'
	havedurability = TRUE
	durability = 200
	slowdown = 1
	var/logs_amount = 3

/obj/item/grown/log/tree/evil/attackby(obj/item/W, mob/living/carbon/user, params)
	if(logs_amount)
		if(W.get_sharpness() && W.force > 0)
			if(W.isAxe)
				if(W.hitsound)
					playsound(get_turf(src), 'modular_septic/sound/weapons/melee/hitree.ogg', 100, FALSE, FALSE)
				user.visible_message(span_notice("[user] begins to chopping [src] with [W]."),span_notice("You begin to cut down [src] with [W]."), span_hear("You hear the sound of sawing."))
				user.changeNext_move(W.attack_delay)
				user.adjustFatigueLoss(W.attack_fatigue_cost)
				W.damageItem("SOFT")
				sound_hint()
				if(do_after(user, 1000/W.force, target = src)) //5 seconds with 20 force, 8 seconds with a hatchet, 20 seconds with a shard.
					user.visible_message(span_notice("[user] chopped [src] with the [W]."),span_notice("You chopped [src] with the [W]."), span_hear("You hear the sound of a chopping. Chop chop!"))
					user.changeNext_move(W.attack_delay)
					user.adjustFatigueLoss(W.attack_fatigue_cost)
					W.damageItem("MEDIUM")
					sound_hint()
					playsound(get_turf(src), 'sound/effects/drova.ogg', 100 , FALSE, FALSE)
//				user.log_message("cut down [src] at [AREACOORD(src)]", LOG_ATTACK)
					for(var/i=1 to logs_amount)
						new /obj/item/stack/grown/log/tree/evil/logg(get_turf(src))
//				var/obj/structure/flora/stump/S = new(loc)
//				S.name = "[name] stump"
					qdel(src)
	else
		return ..()

/obj/item/stack/grown/log/tree/evil/logg
	name = "Evil Wood Log"
	desc = "It's cursed, warlocks is bad! Also, it's chopped."
	icon = 'icons/obj/hydroponics/harvest.dmi'
	icon_state = "evilog"
	base_icon_state = "evilog"
	max_amount = MAXLOG
	amount = 1
	merge_type = /obj/item/stack/grown/log/tree/evil/logg
	novariants = TRUE
	min_force = 4
	force = 8
	throwforce = 8
	min_force_strength = 1
	force_strength = 1.5
	wound_bonus = 3
	bare_wound_bonus = 5
	throw_speed = 2
	throw_range = 8
	attack_verb_continuous = list("bashes", "batters", "bludgeons", "whacks")
	attack_verb_simple = list("bash", "batter", "bludgeon", "whack")
	carry_weight = 1 KILOGRAMS
	skill_melee = SKILL_IMPACT_WEAPON
	w_class = WEIGHT_CLASS_NORMAL
	tetris_width = 32
	tetris_height = 64
	durability = 100
	drop_sound = 'modular_septic/sound/effects/fallsmall.ogg'
	pickup_sound = 'modular_septic/sound/effects/pickupdefault.wav'

/obj/item/stack/grown/log/tree/evil/logg/update_name()
	. = ..()
	name = "Log [(amount < 2) ? "Unit" : "Pile"]"

/obj/item/stack/grown/log/tree/evil/logg/update_desc()
	. = ..()
	desc = "A [(amount < 2) ? "unit" : "pile"] of wood. It's cursed, warlocks is bad! Also, it's chopped."
/*
/obj/item/grown/log/tree/evil/logg/update_icon_state()
	. = ..()
	icon_state = "[base_icon_state][amount < 3 ? amount : ""]"
*/
/obj/item/stack/grown/log/tree/evil/logg/attackby(obj/item/W, mob/living/carbon/user, params)
	if(src.amount == 1)
		if(W.get_sharpness() && W.force > 5)
			if(W.hitsound)
				playsound(get_turf(src), W.hitsound, 100, FALSE, FALSE)
			user.visible_message(span_notice("[user] begins to sawing [src] with [W]."),span_notice("You begin to sawing [src] with [W]."), span_hear("You hear the sound of sawing."))
			user.changeNext_move(W.attack_delay)
			user.adjustFatigueLoss(W.attack_fatigue_cost)
			W.damageItem("SOFT")
			sound_hint()
			if(do_after(user, 500/W.force, target = src))
				user.visible_message(span_notice("[user] sawed [src] with the [W]."),span_notice("You sawed [src] with the [W]."), span_hear("You hear the sound of a sawing."))
				user.changeNext_move(W.attack_delay)
				user.adjustFatigueLoss(W.attack_fatigue_cost)
				W.damageItem("SOFT")
				sound_hint()
				playsound(get_turf(src), 'modular_septic/sound/effects/saw.ogg', 100 , FALSE, FALSE)
				new /obj/item/melee/bita/evil(get_turf(src))
				qdel(src)

/obj/item/stack/grown/log/tree/evil/logg/three
	amount = 3

/obj/item/stack/grown/log/tree/evil/logg/four
	amount = 4

/obj/item/stack/grown/log/tree/evil/logg/five
	amount = 5

/obj/item/craftitem/piece
	name = "A Blue Piece"
	desc = "It's a piece of midnightberry thickets"
	icon = 'icons/obj/hydroponics/harvest.dmi'
	icon_state = "pieceblue"

/obj/item/craftitem/piece/attackby(obj/item/W, mob/living/carbon/user, params)
	if(istype(W, /obj/item/craftitem/piece))
		user.visible_message(span_notice("[user] begins to crafting..."),span_notice("You begin to crafting..."), span_hear("You hear the sound of craft."))
		var/time = 13 SECONDS
		time -= (GET_MOB_SKILL_VALUE(user, SKILL_MASONRY) * 0.75 SECONDS)
		if(do_after(user, time, target = src))
			var/diceroll = user.diceroll(GET_MOB_SKILL_VALUE(user, SKILL_MASONRY), context = DICE_CONTEXT_PHYSICAL)	
			if(diceroll > DICE_CRIT_FAILURE)
				user.visible_message(span_notice("[user] craft..."),span_notice("You crafted..."), span_hear("You hear the sound of craft."))
				user.changeNext_move(CLICK_CD_MELEE)
				user.adjustFatigueLoss(10)
				sound_hint()
//				playsound(get_turf(src), '', 100 , FALSE, FALSE)
				new /obj/item/craftitem/plexus(get_turf(src))
				qdel(src)
				qdel(W)
			else
				user.visible_message(span_notice("[user] failed to craft..."),span_notice("You failed to craft..."), span_hear("You hear the sound of craft."))
				user.changeNext_move(CLICK_CD_MELEE)
				user.adjustFatigueLoss(10)
				sound_hint()
//				playsound(get_turf(src), '', 100 , FALSE, FALSE)
				new /obj/item/craftorshit/retardedthing(get_turf(src))
				qdel(src)
				qdel(W)

/obj/item/craftitem/plexus
	name = "A Blue Plexus"
	desc = "It's a plexus of midnightberry thickets"
	icon = 'icons/obj/hydroponics/harvest.dmi'
	icon_state = "plexusblue"

/obj/item/craftitem/plexus/attackby(obj/item/W, mob/living/carbon/user, params)
	if(istype(W, /obj/item/craftitem/plexus))
		user.visible_message(span_notice("[user] begins to crafting..."),span_notice("You begin to crafting..."), span_hear("You hear the sound of craft."))
		var/time = 13 SECONDS
		time -= (GET_MOB_SKILL_VALUE(user, SKILL_MASONRY) * 0.75 SECONDS)
		if(do_after(user, time, target = src))
			var/diceroll = user.diceroll(GET_MOB_SKILL_VALUE(user, SKILL_MASONRY), context = DICE_CONTEXT_PHYSICAL)	
			if(diceroll > DICE_FAILURE)
				user.visible_message(span_notice("[user] craft..."),span_notice("You crafted..."), span_hear("You hear the sound of craft."))
				user.changeNext_move(CLICK_CD_MELEE)
				user.adjustFatigueLoss(10)
				sound_hint()
//				playsound(get_turf(src), '', 100 , FALSE, FALSE)
				new /obj/item/storage/backpack/basket(get_turf(src))
				qdel(src)
				qdel(W)
			else
				user.visible_message(span_notice("[user] failed to craft..."),span_notice("You failed to craft..."), span_hear("You hear the sound of craft."))
				user.changeNext_move(CLICK_CD_MELEE)
				user.adjustFatigueLoss(10)
				sound_hint()
//				playsound(get_turf(src), '', 100 , FALSE, FALSE)
				new /obj/item/craftorshit/retardedthing(get_turf(src))
				qdel(src)
				qdel(W)

/obj/item/craftitem/bladegrass
	name = "Longrass Blade"
	desc = "It's a blade of longrass"
	icon = 'modular_pod/icons/obj/things/things.dmi'
	icon_state = "longrass_blade"

/obj/item/craftitem/bladegrass/attackby(obj/item/W, mob/living/carbon/user, params)
	if(istype(W, /obj/item/craftitem/bladegrass))
		user.visible_message(span_notice("[user] begins to crafting..."),span_notice("You begin to crafting..."), span_hear("You hear the sound of craft."))
		var/time = 13 SECONDS
		time -= (GET_MOB_SKILL_VALUE(user, SKILL_MASONRY) * 0.75 SECONDS)
		if(do_after(user, time, target = src))
			if(user.a_intent == INTENT_HELP)
				var/diceroll = user.diceroll(GET_MOB_SKILL_VALUE(user, SKILL_MASONRY), context = DICE_CONTEXT_PHYSICAL)	
				if(diceroll > DICE_CRIT_FAILURE)
					user.visible_message(span_notice("[user] craft..."),span_notice("You crafted..."), span_hear("You hear the sound of craft."))
					user.changeNext_move(CLICK_CD_MELEE)
					user.adjustFatigueLoss(10)
					sound_hint()
//					playsound(get_turf(src), '', 100 , FALSE, FALSE)
					new /obj/item/stack/medical/gauze/improvised/one(get_turf(src))
					qdel(src)
					qdel(W)
				else
					user.visible_message(span_notice("[user] failed to craft..."),span_notice("You failed to craft..."), span_hear("You hear the sound of craft."))
					user.changeNext_move(CLICK_CD_MELEE)
					user.adjustFatigueLoss(10)
					sound_hint()
//					playsound(get_turf(src), '', 100 , FALSE, FALSE)
					new /obj/item/craftorshit/retardedthing(get_turf(src))
					qdel(src)
					qdel(W)

/obj/item/grown/log/steel
	seed = /obj/item/seeds/tower/steel
	name = "steel-cap log"
	desc = "It's made of metal."
	icon_state = "steellogs"
	plank_type = /obj/item/stack/rods
	plank_name = "rods"

/obj/item/grown/log/steel/CheckAccepted(obj/item/I)
	return FALSE

/obj/structure/punji_sticks
	name = "punji sticks"
	desc = "Don't step on this."
	icon = 'icons/obj/hydroponics/equipment.dmi'
	icon_state = "punji"
	resistance_flags = FLAMMABLE
	max_integrity = 30
	density = FALSE
	anchored = TRUE

/obj/structure/punji_sticks/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/caltrop, min_damage = 20, max_damage = 30, flags = CALTROP_BYPASS_SHOES)

/obj/structure/punji_sticks/spikes
	name = "wooden spikes"
	icon_state = "woodspike"
