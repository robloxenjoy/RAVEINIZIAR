/datum/round_event_control/denominators
	name = "Denominators"
	typepath = /datum/round_event/denominators
	weight = 0
	max_occurrences = 1
	min_players = 8
	dynamic_should_hijack = FALSE

#define DENOMINATORS_MOTHERLESS "Motherless"
#define DENOMINATORS_FOUNDLING "Foundling"
#define DENOMINATORS_STINGER "Stinger"

/datum/round_event/denominators/start()
	return

/datum/round_event_control/denominators/preRunEvent()
	return ..()

/*
/proc/spawn_denominators(datum/comm_message/threat, ship_template, skip_answer_check)
	if(!skip_answer_check && threat?.answered == 1)
		return

	var/list/candidates = poll_ghost_candidates("Do you wish to be apart of the Denominator cult?", ROLE_TRAITOR)
	playsound_local(candidates, 'modular_septic/sound/effects/ghostcue.wav', 60)
	shuffle_inplace(candidates)

	var/datum/map_template/shuttle/pirate/ship = new ship_template
	var/x = rand(TRANSITIONEDGE,world.maxx - TRANSITIONEDGE - ship.width)
	var/y = rand(TRANSITIONEDGE,world.maxy - TRANSITIONEDGE - ship.height)
	var/z = SSmapping.empty_space.z_value
	var/turf/T = locate(x,y,z)
	if(!T)
		CRASH("Pirate event found no turf to load in")

	if(!ship.load(T))
		CRASH("Loading pirate ship failed!")

	for(var/turf/A in ship.get_affected_turfs(T))
		for(var/obj/effect/mob_spawn/human/pirate/spawner in A)
			if(candidates.len > 0)
				var/mob/our_candidate = candidates[1]
				spawner.create(our_candidate)
				candidates -= our_candidate
				notify_ghosts("The pirate ship has an object of interest: [our_candidate]!", source=our_candidate, action=NOTIFY_ORBIT, header="Something's Interesting!")
			else
				notify_ghosts("The pirate ship has an object of interest: [spawner]!", source=spawner, action=NOTIFY_ORBIT, header="Something's Interesting!")

	priority_announce("Unidentified armed ship detected near the station.")
*/

/obj/item/keycard/red
	name = "red keycard"
	desc = "A highly valuable, sleek, red keycard."
	icon = 'modular_septic/icons/obj/items/keys.dmi'
	icon_state = "redkey"
	puzzle_id = "denom"
	pickup_sound = 'modular_septic/sound/effects/card_pickup.wav'
	drop_sound = 'modular_septic/sound/effects/card_drop.wav'

/obj/item/keycard/inborn
	name = "yellow keycard"
	desc = "Nevermind."
	icon = 'modular_septic/icons/obj/items/keys.dmi'
	icon_state = "yellowkey"
	puzzle_id = "InBor"
	pickup_sound = 'modular_septic/sound/effects/card_pickup.wav'
	drop_sound = 'modular_septic/sound/effects/card_drop.wav'

/obj/item/keycard/bomj
	name = "yellow keycard"
	desc = "Nevermind."
	icon = 'modular_septic/icons/obj/items/keys.dmi'
	icon_state = "yellowkey"
	puzzle_id = "Bomj"
	pickup_sound = 'modular_septic/sound/effects/card_pickup.wav'
	drop_sound = 'modular_septic/sound/effects/card_drop.wav'

/obj/item/keycard/entry_three
	name = "violet keycard"
	desc = "A violet, nice!"
	icon = 'modular_septic/icons/obj/items/keys.dmi'
	icon_state = "purplekey"
	puzzle_id = "entry"
	pickup_sound = 'modular_septic/sound/effects/card_pickup.wav'
	drop_sound = 'modular_septic/sound/effects/card_drop.wav'

/obj/machinery/door/keycard/denominator
	name = "red airlock"
	desc = "This door only opens when a keycard is swiped. It looks like It's been heavily armored."
	icon = 'modular_septic/icons/obj/machinery/tall/doors/airlocks/secretdoor.dmi'
	icon_state = "door_closed"
	base_icon_state = "door"
	explosion_block = 1
	heat_proof = TRUE
	max_integrity = 600
	armor = list(MELEE = 100, BULLET = 100, LASER = 100, ENERGY = 100, BOMB = 20, BIO = 100, FIRE = 100, ACID = 100)
	resistance_flags = INDESTRUCTIBLE | FIRE_PROOF | ACID_PROOF | LAVA_PROOF
	damage_deflection = 70
	/// Make sure that the key has the same puzzle_id as the keycard door!
	puzzle_id = "denom"
	/// Message that occurs when the door is opened
	open_message = "The door beeps, and slides opens."
	/// Message that occurs when the door is closed.
	var/close_message = "The door buzzes, and slides closed."

/obj/machinery/door/keycard/denominator/podozl/akt
	name = "Wooden Door"
	desc = "Maybe I need a key for this wooden door."
	icon = 'modular_septic/icons/obj/machinery/tall/doors/airlocks/door_akt.dmi'
	icon_state = "koor_closed"
	base_icon_state = "koor"
	explosion_block = 0
	heat_proof = TRUE
	max_integrity = 600
	armor = list(MELEE = 65, BULLET = 65, LASER = 65, ENERGY = 65, BOMB = 20, BIO = 65, FIRE = 65, ACID = 65)
	damage_deflection = 40
	puzzle_id = "housekey"
	open_message = "The door moves with a some sound, and opens."
	close_message = "The door moves with a some sound, and closes."
	var/forty = TRUE

/obj/machinery/door/keycard/denominator/podozl/akt/attackby(obj/item/I, mob/living/carbon/user, params)
	if(istype(I,/obj/item/keycard))
		var/obj/item/keycard/key = I
		if((!puzzle_id || puzzle_id == key.puzzle_id)  && density)
			to_chat(user, span_notice("[open_message]"))
			playsound(src, 'modular_septic/sound/effects/card_accepted_horror.wav', 70, FALSE, 3)
			sleep(6)
			playsound(src, 'modular_septic/sound/effects/movedoor.wav', 70, FALSE, 4)
			open()
			return
		else if((!puzzle_id || puzzle_id == key.puzzle_id)  && !density)
			to_chat(user, span_notice("[close_message]"))
			playsound(src, 'modular_septic/sound/effects/card_accepted_horror.wav', 70, FALSE, 3)
			sleep(6)
			playsound(src, 'modular_septic/sound/effects/movedoor.wav', 70, FALSE, 4)
			close()
			return
		else
			to_chat(user, span_notice("Not that key..."))
			playsound(src, 'modular_septic/sound/effects/card_declined_horror.wav', 60, FALSE, 1)
			return
	if(I.get_sharpness() && I.force)
		if(forty)
			to_chat(user, span_notice("This door has fortifications - it cannot be cut so easily."))
			return
		var/duration = (48/I.force) * 2 //In seconds, for now.
		if(I.hitsound)
			playsound(get_turf(src), I.hitsound, 100, FALSE, FALSE)
		user.visible_message(span_notice("[user] begins to sawing [src] with [I]."),span_notice("You begin to sawing [src] with [I]."), span_hear("You hear the sound of sawing."))
		user.changeNext_move(I.attack_delay)
		user.adjustFatigueLoss(I.attack_fatigue_cost)
		I.damageItem("SOFT")
		sound_hint()
		if(do_after(user, duration*10, target=src)) //Into deciseconds.
			user.visible_message(span_notice("[user] sawed [src] with the [I]."),span_notice("You sawed [src] with the [I]."), span_hear("You hear the sound of a sawing."))
			user.changeNext_move(I.attack_delay)
			user.adjustFatigueLoss(I.attack_fatigue_cost)
			I.damageItem("HARD")
			sound_hint()
			playsound(get_turf(src), 'modular_septic/sound/effects/saw.ogg', 100 , FALSE, FALSE)
			qdel(src)
			return
	return ..()

/obj/item/keycard/akt
	name = "Wooden Key"
	desc = "This key is for house in Akt Village..."
	icon = 'modular_septic/icons/obj/items/keys.dmi'
	icon_state = "woodenkey"
	puzzle_id = "housekey"
	drop_sound = 'modular_septic/sound/effects/fallmedium.ogg'
	pickup_sound = 'modular_septic/sound/effects/pickupdefault.wav'
	havedurability = TRUE
	durability = 100
	carry_weight = 1 KILOGRAMS
	skill_melee = SKILL_IMPACT_WEAPON
	w_class = WEIGHT_CLASS_SMALL
	slot_flags = ITEM_SLOT_ID
	min_force = 2
	force = 3
	throwforce = 2
	min_force_strength = 1
	force_strength = 1
	wound_bonus = 1
	bare_wound_bonus = 1
	throw_speed = 3
	throw_range = 8
	attack_verb_continuous = list("bashes", "batters", "bludgeons", "whacks")
	attack_verb_simple = list("bash", "batter", "bludgeon", "whack")
	tetris_width = 32
	tetris_height = 64

/obj/item/keycard/akt/gargostore
	desc = "This key is for Gargostore in Akt Village..."
	puzzle_id = "gargostore"

/obj/machinery/door/keycard/denominator/podozl/akt/gargostore
	puzzle_id = "gargostore"

/obj/item/keycard/akt/alchem
	desc = "This key is for al-chemists houses in Akt Village..."
	puzzle_id = "alchem"

/obj/machinery/door/keycard/denominator/podozl/akt/alchem
	puzzle_id = "alchem"

/obj/item/keycard/akt/controller
	desc = "This key is for controller palace in Akt Village..."
	puzzle_id = "controller"

/obj/machinery/door/keycard/denominator/podozl/akt/controller
	puzzle_id = "controller"

/obj/item/keycard/akt/granger
	desc = "This key is for granger house in Akt Village..."
	puzzle_id = "granger"

/obj/machinery/door/keycard/denominator/podozl/akt/granger
	puzzle_id = "granger"

/obj/item/keycard/akt/nailer
	desc = "This key is for nailer house in Akt Village..."
	puzzle_id = "nailer"

/obj/machinery/door/keycard/denominator/podozl/akt/nailer
	puzzle_id = "nailer"

/obj/item/keycard/akt/carehouse
	desc = "This key is for carehouse in the forest..."
	puzzle_id = "carehouse"

/obj/machinery/door/keycard/denominator/podozl/akt/carehouse
	puzzle_id = "carehouse"
	forty = FALSE

/obj/item/keycard/akt/infirmary
	desc = "This key is for infirmary in the Akt Village..."
	puzzle_id = "infirmary"

/obj/machinery/door/keycard/denominator/podozl/akt/infirmary
	puzzle_id = "infirmary"

/obj/item/keycard/akt/lair
	desc = "This key is for lair in Akt Village..."
	puzzle_id = "lair"

/obj/machinery/door/keycard/denominator/podozl/akt/lair
	puzzle_id = "lair"

/obj/item/keycard/akt/chantry
	desc = "This key is for chantry in Akt Village..."
	puzzle_id = "chantry"

/obj/machinery/door/keycard/denominator/podozl/akt/chantry
	puzzle_id = "chantry"

/obj/item/keycard/akt/barroom
	desc = "This key is for chantry in Akt Village..."
	puzzle_id = "barroom"

/obj/machinery/door/keycard/denominator/podozl/akt/barroom
	puzzle_id = "barroom"

/obj/item/keycard/akt/sewer
	desc = "This key is for canalization in Akt Village..."
	puzzle_id = "canal"

/obj/machinery/door/keycard/denominator/podozl/akt/sewer
	puzzle_id = "canal"

/obj/item/keycard/akt/lost
	desc = "This key is for lost thing in the forest..."

/obj/item/keycard/akt/lost/abandoned_f
	puzzle_id = "abandoned_f"

/obj/machinery/door/keycard/denominator/podozl/akt/abandoned_f
	puzzle_id = "abandoned_f"

/obj/item/keycard/akt/lost/abandoned_x
	puzzle_id = "abandoned_x"

/obj/machinery/door/keycard/denominator/podozl/akt/abandoned_x
	puzzle_id = "abandoned_x"

/obj/item/keycard/akt/lost/abandoned_m
	puzzle_id = "abandoned_m"

/obj/machinery/door/keycard/denominator/podozl/akt/abandoned_m
	puzzle_id = "abandoned_m"

/obj/item/keycard/akt/lost/abandoned_a
	puzzle_id = "abandoned_a"

/obj/machinery/door/keycard/denominator/podozl/akt/abandoned_a
	puzzle_id = "abandoned_a"

/obj/item/keycard/akt/lost/abandoned_q
	puzzle_id = "abandoned_q"

/obj/machinery/door/keycard/denominator/podozl/akt/abandoned_q
	puzzle_id = "abandoned_q"

/obj/item/keycard/akt/lost/abandoned_zz
	puzzle_id = "abandoned_zz"

/obj/machinery/door/keycard/denominator/podozl/akt/abandoned_zz
	puzzle_id = "abandoned_zz"

/obj/item/keycard/akt/lost/abandoned_m
	puzzle_id = "abandoned_m"

/obj/machinery/door/keycard/denominator/podozl/akt/abandoned_m
	puzzle_id = "abandoned_m"

/obj/machinery/door/keycard/denominator/podozl/chaot
	name = "Chaot Door"
	desc = "Maybe I need a seal for this smooth stone door."
	icon = 'modular_septic/icons/obj/machinery/tall/doors/airlocks/secretdoor_chaot.dmi'
	icon_state = "boor_closed"
	base_icon_state = "boor"
	explosion_block = 0
	heat_proof = TRUE
	max_integrity = 600
	armor = list(MELEE = 95, BULLET = 95, LASER = 95, ENERGY = 95, BOMB = 20, BIO = 95, FIRE = 95, ACID = 95)
	resistance_flags = FIRE_PROOF | ACID_PROOF | LAVA_PROOF
	damage_deflection = 70
	puzzle_id = "chaot"
	open_message = "The door moves with a monstrous stone sound, and opens."
	close_message = "The door moves with a monstrous stone sound, and closes."

/obj/machinery/door/keycard/denominator/podozl/chaot/attackby(obj/item/I, mob/user, params)
	if(istype(I,/obj/item/keycard))
		var/obj/item/keycard/key = I
		if((!puzzle_id || puzzle_id == key.puzzle_id)  && density)
			to_chat(user, span_notice("[open_message]"))
			playsound(src, 'modular_septic/sound/effects/card_accepted_horror.wav', 70, FALSE, 3)
			sleep(6)
			playsound(src, 'modular_septic/sound/effects/movedoor.wav', 70, FALSE, 4)
			open()
			return
		else if((!puzzle_id || puzzle_id == key.puzzle_id)  && !density)
			to_chat(user, span_notice("[close_message]"))
			playsound(src, 'modular_septic/sound/effects/card_accepted_horror.wav', 70, FALSE, 3)
			sleep(6)
			playsound(src, 'modular_septic/sound/effects/movedoor.wav', 70, FALSE, 4)
			close()
			return
		else
			to_chat(user, span_notice("[src] makes strange sound. Not that key..."))
			playsound(src, 'modular_septic/sound/effects/card_declined_horror.wav', 60, FALSE, 1)
			return

/obj/item/keycard/chaot
	name = "Violet Seal"
	desc = "Chaot stone seal."
	icon = 'modular_septic/icons/obj/items/keys.dmi'
	icon_state = "chaotseal"
	puzzle_id = "chaot"
	drop_sound = 'modular_septic/sound/effects/fallmedium.ogg'
	pickup_sound = 'modular_septic/sound/effects/pickupdefault.wav'
	havedurability = TRUE
	durability = 150
	carry_weight = 1 KILOGRAMS
	skill_melee = SKILL_IMPACT_WEAPON
	w_class = WEIGHT_CLASS_SMALL
	slot_flags = ITEM_SLOT_ID
	min_force = 6
	force = 10
	throwforce = 9
	min_force_strength = 1
	force_strength = 1.5
	wound_bonus = 3
	bare_wound_bonus = 4
	throw_speed = 2
	throw_range = 7
	attack_verb_continuous = list("bashes", "batters", "bludgeons", "whacks")
	attack_verb_simple = list("bash", "batter", "bludgeon", "whack")
	tetris_width = 32
	tetris_height = 64

/obj/machinery/door/keycard/denominator/podozl/inborn
	name = "yellow airlock"
	desc = "This door only opens when a keycard is swiped. It looks like It's been heavily armored."
	icon = 'modular_septic/icons/obj/machinery/tall/doors/airlocks/secretdoor_yellow.dmi'
	icon_state = "door_closed"
	base_icon_state = "door"
	/// Make sure that the key has the same puzzle_id as the keycard door!
	puzzle_id = "InBor"
	/// Message that occurs when the door is opened
	open_message = "The door beeps, and slides opens."
	/// Message that occurs when the door is closed.
	close_message = "The door buzzes, and slides closed."

/obj/machinery/door/keycard/denominator/podozl/bomj
	name = "yellow airlock"
	desc = "This door only opens when a keycard is swiped."
	icon = 'modular_septic/icons/obj/machinery/tall/doors/airlocks/secretdoor_yellow.dmi'
	icon_state = "door_closed"
	base_icon_state = "door"
	explosion_block = 0
	heat_proof = FALSE
	max_integrity = 300
	armor = list(MELEE = 10, BULLET = 10, LASER = 10, ENERGY = 10, BOMB = 5, BIO = 10, FIRE = 10, ACID = 10)
	resistance_flags = FIRE_PROOF | ACID_PROOF | LAVA_PROOF
	damage_deflection = 5
	/// Make sure that the key has the same puzzle_id as the keycard door!
	puzzle_id = "Bomj"
	/// Message that occurs when the door is opened
	open_message = "The door beeps, and slides opens."
	/// Message that occurs when the door is closed.
	close_message = "The door buzzes, and slides closed."

/obj/machinery/door/keycard/denominator/podozl/attackby(obj/item/I, mob/user, params)
	if(istype(I,/obj/item/keycard))
		var/obj/item/keycard/key = I
		if((!puzzle_id || puzzle_id == key.puzzle_id)  && density)
			to_chat(user, span_notice("[open_message]"))
			playsound(src, 'modular_septic/sound/effects/card_accepted.wav', 70, FALSE, 3)
			sleep(6)
			playsound(src, 'modular_septic/sound/effects/secretopen1.wav', 70, FALSE, 4)
			open()
			return
		else if((!puzzle_id || puzzle_id == key.puzzle_id)  && !density)
			to_chat(user, span_notice("[close_message]"))
			playsound(src, 'modular_septic/sound/effects/card_accepted.wav', 70, FALSE, 3)
			sleep(6)
			playsound(src, 'modular_septic/sound/effects/secretclose2.wav', 70, FALSE, 4)
			close()
			return
		else
			to_chat(user, span_notice("[src] buzzes. This must not be the right key."))
			playsound(src, 'modular_septic/sound/effects/card_declined.wav', 60, FALSE, 1)
			return
