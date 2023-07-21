/mob/living/simple_animal/hostile/podozl/hydra
	name = "Hydra"
	desc = "WHAT!"
	icon = 'modular_pod/icons/obj/things/things.dmi'
	icon_state = "hydra"
	icon_living = "hydra"
	icon_dead = "hydra_dead"
	icon_gib = "hydra_dead"
	mob_biotypes = MOB_ORGANIC|MOB_HUMANOID
	sentience_type = SENTIENCE_HUMANOID
	speak_chance = 2
	turns_per_move = 1
	move_to_delay = 5
	vision_range = 7
	aggro_vision_range = 7
	dodging = TRUE
	maxHealth = 125
	health = 125
	harm_intent_damage = 16
	melee_damage_lower = 15
	melee_damage_upper = 15
	wound_bonus = 5
	bare_wound_bonus = 5
	sharpness = SHARP_POINTY
	speak = list("Ssssss...", "Ormab ulba.", "HSSSSS!!!", "Urie Welema.")
	attack_verb_continuous = "bites"
	attack_verb_simple = "bite"
	attack_sound = 'modular_pod/sound/mobs_yes/hydra_attack.ogg'
//	loot = list(/obj/effect/mob_spawn/human/corpse/russian,
//				/obj/item/knife/kitchen)
	faction = list("forlorns")
	status_flags = CANPUSH
	ranged = 1
	retreat_distance = 7
	minimum_distance = 7
	ranged_cooldown_time = 50
	stat_attack = HARD_CRIT
	projectilesound = 'modular_septic/sound/weapons/guns/energy/siren.wav'
	projectiletype = /obj/projectile/beam/laser/siren
	deathmessage = "painfully collapses."
	deathsound = 'modular_pod/sound/mobs_yes/hydra_2.ogg'

	footstep_type = FOOTSTEP_MOB_CRAWL

/mob/living/simple_animal/hostile/podozl/hydra/Aggro()
	..()
	say("SSSSS!!")

/mob/living/simple_animal/hostile/podozl/hydra/handle_automated_speech(override)
	if(speak_chance && (override || prob(speak_chance)))
		playsound(src, 'modular_pod/sound/mobs_yes/hydra_talk.wav', 50)
	..()

/mob/living/simple_animal/pet/podozl/shoebill
	name = "Shoebill"
	desc = "Funny bird!"
	icon = 'modular_septic/icons/mob/funny_bird.dmi'
	icon_state = "shoebill"
	icon_living = "shoebill"
	icon_dead = "shoebill_dead"
	speak = list("Cluck!","BWAAAAARK BWAK BWAK BWAK!")
	speak_emote = list("clucks", "croons")
	emote_hear = list("clucks.")
	emote_see = list("shakes their head.", "flaps his wings viciously.")
	speak_chance = 1
	turns_per_move = 5
	see_in_dark = 6
	butcher_results = list(/obj/item/halyabegg = 1)
	response_help_continuous = "pets"
	response_help_simple = "pet"
	response_disarm_continuous = "gently pushes aside"
	response_disarm_simple = "gently push aside"
	response_harm_continuous = "kicks"
	response_harm_simple = "kick"
	can_be_held = FALSE
//	held_state = "fox"
	///In the case 'melee_damage_upper' is somehow raised above 0
	attack_verb_continuous = "bites"
	attack_verb_simple = "bite"
	attack_sound = 'sound/weapons/bite.ogg'
	attack_vis_effect = ATTACK_EFFECT_BITE

	footstep_type = FOOTSTEP_MOB_CLAW

/mob/living/simple_animal/pet/podozl/shoebill/Initialize(mapload)
	. = ..()
	can_buckle = TRUE
	buckle_lying = 0
	AddElement(/datum/element/ridable, /datum/component/riding/creature/carp)
	AddElement(/datum/element/pet_bonus, "crows happily!")


/mob/living/simple_animal/pet/podozl/frog
	name = "Brown Frog"
	desc = "NEUTRAL FROG!"
	icon = 'modular_pod/icons/mob/beasts/various_mobs.dmi'
	icon_state = "brown_frog"
	icon_living = "brown_frog"
	icon_dead = "brown_frog_dead"
	speak = list("Qua","QUA QUA!")
	speak_emote = list("croaks")
	emote_hear = list("croaks.")
	emote_see = list("scratching itself.", "watching.")
	speak_chance = 2
	turns_per_move = 4
	see_in_dark = 6
	maxHealth = 50
	health = 50
	butcher_results = list(/obj/item/skin/human/small/frogbrown = 1)
	response_help_continuous = "pets"
	response_help_simple = "pet"
	response_disarm_continuous = "gently pushes aside"
	response_disarm_simple = "gently push aside"
	response_harm_continuous = "kicks"
	response_harm_simple = "kick"
	can_be_held = FALSE
//	held_state = "fox"
	///In the case 'melee_damage_upper' is somehow raised above 0
	attack_verb_continuous = "bites"
	attack_verb_simple = "bite"
	attack_sound = 'sound/weapons/bite.ogg'
	attack_vis_effect = ATTACK_EFFECT_BITE

	footstep_type = FOOTSTEP_MOB_CLAW

/mob/living/simple_animal/pet/podozl/frog/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/pet_bonus, "happily jumping!")

/mob/living/simple_animal/pet/podozl/frog/handle_automated_speech(override)
	if(speak_chance && (override || prob(speak_chance)))
		playsound(src, 'modular_pod/sound/mobs_yes/frog_talk.ogg', 50)
	..()

/mob/living/simple_animal/pet/podozl/frog/blue_eyes
	name = "Brown Frog"
	desc = "NEUTRAL FROG!"
	icon = 'modular_pod/icons/mob/beasts/various_mobs.dmi'
	icon_state = "brown_frog_blue_eyes"
	icon_living = "brown_frog_blue_eyes"
	icon_dead = "brown_frog_blue_eyes_dead"

/mob/living/simple_animal/pet/podozl/frog/green
	name = "Green Frog"
	desc = "NEUTRAL FROG!"
	icon = 'modular_pod/icons/mob/beasts/various_mobs.dmi'
	icon_state = "green_frog"
	icon_living = "green_frog"
	icon_dead = "green_frog_dead"
	butcher_results = list(/obj/item/skin/human/small/frogreen = 1)