//floppa
/mob/living/simple_animal/hostile/caracal
	name = "lynx"
	desc = "Run from this cute creature!"
	icon = 'modular_septic/icons/mob/floppa.dmi'
	icon_state = "caracal"
	icon_dead = "caracal_dead"
	mob_biotypes = MOB_ORGANIC|MOB_BEAST
	speak_chance = 3
	speak = list("Flop.", "Meow.", "HSSS")
	emote_hear = list("meows!", "hisses.", "purrs.")
	emote_taunt = list("stares ferociously", "strongly hisses")
	emote_see = list("shows their fangs!", "wags their tail.", "flop their ears!")
	gender = MALE
	attack_verb_continuous = "claws"
	attack_verb_simple = "claw"
	attack_sound = 'sound/weapons/bladeslice.ogg'
	attack_vis_effect = null
	friendly_verb_continuous = "lynx hugs"
	friendly_verb_simple = "lynx hug"
	response_help_continuous = "flops"
	response_help_simple = "flop"
	response_disarm_continuous = "bops"
	response_disarm_simple = "bop"
	response_harm_continuous = "kicks"
	response_harm_simple = "kick"
	turns_per_move = 5
	taunt_chance = 85
	vision_range = 9
	aggro_vision_range = 9
	maxHealth = 60
	health = 60
	speed = 2
	see_in_dark = 3
	move_to_delay = 1.2
	deathmessage = "painfully collapses."

	obj_damage = 40
	harm_intent_damage = 15
	melee_damage_lower = 13
	melee_damage_upper = 20
	wound_bonus = 2
	bare_wound_bonus = 15
	sharpness = SHARP_EDGED
	limb_destroyer = TRUE

	footstep_type = FOOTSTEP_MOB_BAREFOOT

/mob/living/simple_animal/hostile/caracal/floppa
	name = "big floppa"
	desc = "Flops for no hoe."

/mob/living/simple_animal/hostile/caracal/floppa/stanislav
	name = "\proper Stanislav"
	desc = "A war veteran caracal, always carrying it's trust rifle. He has seen terrible things."
	speak = list("I have committed numerous war crimes.", "I must bomb them.", "The horrors of war.")
	icon_state = "stanislav"
	icon_dead = "stanislav_dead"
