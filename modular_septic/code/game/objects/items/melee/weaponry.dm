/obj/item/knife
	skill_melee = SKILL_KNIFE
	carry_weight = 400 GRAMS

/obj/item/knife/combat
	carry_weight = 800 GRAMS

//Horrible
/obj/item/knife/combat/zhunter
	name = "z-hunter brand knife"
	desc = "Illegal in the Separated Kingdom, this surplus knife is barely able to cut through skin. It can, however, hunt many Z's."
	icon = 'modular_septic/icons/obj/items/melee/knife.dmi'
	icon_state = "zhunter"
	min_force = 3
	force = 10
	min_force_strength = 0
	force_strength = 0
	throwforce = 5
	w_class = WEIGHT_CLASS_SMALL
	wound_bonus = 0
	bare_wound_bonus = 5

//Nice sexy sex
/obj/item/melee/truncheon
	name = "truncheon"
	desc = "A tool to beat the bones out of criminals."
	icon = 'modular_septic/icons/obj/items/melee/baton.dmi'
	icon_state = "truncheon"
	lefthand_file = 'modular_septic/icons/obj/items/melee/inhands/baton_lefthand.dmi'
	righthand_file = 'modular_septic/icons/obj/items/melee/inhands/baton_righthand.dmi'
	inhand_icon_state = "truncheon"
	drop_sound = list('modular_septic/sound/weapons/melee/baton_fall1.wav', 'modular_septic/sound/weapons/melee/baton_fall2.wav')
	miss_sound = list('modular_septic/sound/weapons/melee/baton_swish1.wav', 'modular_septic/sound/weapons/melee/baton_swish2.wav', 'modular_septic/sound/weapons/melee/baton_swish3.wav')
	hitsound = list('modular_septic/sound/weapons/melee/baton1.wav', 'modular_septic/sound/weapons/melee/baton2.wav', 'modular_septic/sound/weapons/melee/baton3.wav')
	min_force = 3
	force = 5
	min_force_strength = 1
	force_strength = 1.5
	wound_bonus = 3
	bare_wound_bonus = 0
	carry_weight = 2.5 KILOGRAMS
	slot_flags = ITEM_SLOT_BELT
	worn_icon_state = "classic_baton"
	skill_melee = SKILL_IMPACT_WEAPON
	tetris_width = 32
	tetris_height = 64

/obj/item/melee/bita/pink
	name = "Pink Lump"
	desc = "One-handed lump made of the unique material Halyab'ka."
	icon = 'modular_septic/icons/obj/items/melee/baton.dmi'
	icon_state = "pinkbita"
	lefthand_file = 'modular_septic/icons/obj/items/inhands/items_and_weapons_lefthand.dmi'
	righthand_file = 'modular_septic/icons/obj/items/inhands/items_and_weapons_righthand.dmi'
	inhand_icon_state = "pinkbita"
	drop_sound = list('modular_septic/sound/weapons/melee/baton_fall1.wav', 'modular_septic/sound/weapons/melee/baton_fall2.wav')
	miss_sound = list('modular_septic/sound/weapons/melee/baton_swish1.wav', 'modular_septic/sound/weapons/melee/baton_swish2.wav', 'modular_septic/sound/weapons/melee/baton_swish3.wav')
	hitsound = list('modular_septic/sound/weapons/melee/baton1.wav', 'modular_septic/sound/weapons/melee/baton2.wav', 'modular_septic/sound/weapons/melee/baton3.wav')
	min_force = 10
	force = 16
	throwforce = 16
	min_force_strength = 1.2
	force_strength = 1.6
	wound_bonus = 2
	bare_wound_bonus = 15
	carry_weight = 1 KILOGRAMS
	slot_flags = ITEM_SLOT_BELT
	worn_icon_state = "classic_baton"
	skill_melee = SKILL_IMPACT_WEAPON
	tetris_width = 32
	tetris_height = 64

/obj/item/melee/bita/evil
	name = "Evil Lump"
	desc = "One-handed lump made of piece of wood from a cursed tree."
	icon = 'modular_septic/icons/obj/items/melee/baton.dmi'
	icon_state = "evilbita"
	lefthand_file = 'modular_septic/icons/obj/items/inhands/items_and_weapons_lefthand.dmi'
	righthand_file = 'modular_septic/icons/obj/items/inhands/items_and_weapons_righthand.dmi'
	inhand_icon_state = "evilbita"
	min_force = 9
	force = 14
	throwforce = 16
	min_force_strength = 1.1
	force_strength = 1.5
	wound_bonus = 13
	bare_wound_bonus = 5
	armor_damage_modifier = 1
	carry_weight = 1.3 KILOGRAMS
	slot_flags = ITEM_SLOT_BELT
	worn_icon_state = "classic_baton"

/obj/item/melee/truncheon/black
	name = "black truncheon"
	icon = 'modular_septic/icons/obj/items/melee/baton.dmi'
	icon_state = "truncheon_black"
	lefthand_file = 'modular_septic/icons/obj/items/melee/inhands/baton_lefthand.dmi'
	righthand_file = 'modular_septic/icons/obj/items/melee/inhands/baton_righthand.dmi'
	inhand_icon_state = "truncheon_black"

/obj/item/lead_pipe
	name = "lead pipe"
	desc = "Infantile Behavioral Correction Device."
	icon = 'modular_septic/icons/obj/items/melee/pipe.dmi'
	icon_state = "child_behavior_corrector"
	tetris_width = 32
	tetris_height = 96

/obj/item/lead_pipe/afterattack(atom/target, mob/user, proximity_flag, params)
	. = ..()
	if(ishuman(target) && proximity_flag && (user.zone_selected == BODY_ZONE_HEAD))
		user.client?.give_award(/datum/award/achievement/misc/leadpipe, user)

/obj/item/fireaxe
	min_force = 4
	force = 6
	min_force_strength = 0
	force_strength = 0
	parrying_modifier = 0
	wield_info = /datum/wield_info/fireaxe
	skill_melee = SKILL_IMPACT_WEAPON_TWOHANDED
	readying_flags = READYING_FLAG_SOFT_TWO_HANDED

/obj/item/fireaxe/Initialize()
	. = ..()
	AddComponent(/datum/component/butchering, 100, 80, 0 , hitsound) //axes are not known for being precision butchering tools

#define slash 1
#define stab 2
#define bash 3

/obj/item/changeable_attacks
	name = "a fucked up retarded weapon"
	desc = "report thgis to a retard dev if you see it"
	var/slash_hitsound = list('modular_septic/sound/weapons/melee/slasher1.wav', 'modular_septic/sound/weapons/melee/slasher2.wav', 'modular_septic/sound/weapons/melee/slasher3.wav')
	var/stab_hitsound = list('modular_septic/sound/weapons/melee/stabber1.ogg', 'modular_septic/sound/weapons/melee/stabber2.ogg')
	var/bash_hitsound = list('modular_septic/sound/weapons/melee/baton1.wav', 'modular_septic/sound/weapons/melee/baton2.wav', 'modular_septic/sound/weapons/melee/baton3.wav')
	var/current_atk_mode = null
	var/wielded_inhand_state = FALSE

/obj/item/changeable_attacks/examine(mob/user)
	. = ..()
	if(current_atk_mode)
//		var/attack_text = current_atk_mode
		if(current_atk_mode == slash)
			. += span_info("It's currently ready to slash.")
		else if (current_atk_mode == stab)
			. += span_info("It's currently ready to stab.")
		else if (current_atk_mode == bash)
			. += span_info("It's currently ready to bash.")

/obj/item/changeable_attacks/attack_self(mob/user, modifiers)
	. = ..()
	swap_intents(user)

/obj/item/changeable_attacks/dropped(mob/user, silent)
	. = ..()
	current_atk_mode = initial(current_atk_mode)

/obj/item/changeable_attacks/proc/swap_intents(mob/user)
	if(isnull(current_atk_mode))
		to_chat(user, span_warning("There's no other ways to attack with this weapon."))
		return
	user.playsound_local(get_turf(src), 'modular_septic/sound/weapons/melee/swap_intent.ogg', 5, FALSE)

/obj/item/changeable_attacks/Initialize(mapload)
	. = ..()
	if(current_atk_mode == slash)
		hitsound = slash_hitsound
	if(current_atk_mode == stab)
		hitsound = stab_hitsound
	if(current_atk_mode == bash)
		hitsound = bash_hitsound

/obj/item/changeable_attacks/update_icon(updates)
	. = ..()
	if(wielded_inhand_state)
		if(SEND_SIGNAL(src, COMSIG_TWOHANDED_WIELD_CHECK))
			inhand_icon_state = "[initial(inhand_icon_state)]_wielded"
		else
			inhand_icon_state = "[initial(inhand_icon_state)]"
/*
/obj/item/changeable_attacks/equipped(mob/living/carbon/human/user, slot)
	. = ..()
	if(slot == ITEM_SLOT_HANDS)
		swap_intents(user)
*/
/obj/item/changeable_attacks/sword
	name = "Nice Sword"
	desc = "A Nice Sword."
	icon_state = "cockri"
	inhand_icon_state = "cockri"
	worn_icon_state = "cockri"
	icon = 'modular_septic/icons/obj/items/melee/knife.dmi'
	lefthand_file = 'modular_septic/icons/obj/items/melee/inhands/knife_lefthand.dmi'
	righthand_file = 'modular_septic/icons/obj/items/melee/inhands/knife_righthand.dmi'
	worn_icon = 'modular_septic/icons/obj/items/melee/worn/knife_worn.dmi'
	equip_sound = 'modular_septic/sound/weapons/melee/kukri_holster.wav'
	pickup_sound = 'modular_septic/sound/weapons/melee/kukri_deploy.wav'
	miss_sound = list('modular_septic/sound/weapons/melee/kukri_swish1.wav', 'modular_septic/sound/weapons/melee/kukri_swish2.wav', 'modular_septic/sound/weapons/melee/kukri_swish3.wav')
	drop_sound = list('modular_septic/sound/weapons/melee/bladedrop1.wav', 'modular_septic/sound/weapons/melee/bladedrop2.wav')
	current_atk_mode = slash
	min_force = 6
	force = 10
	min_force_strength = 1
	force_strength = 1.8
	min_throwforce = 5
	min_throwforce_strength = 8
	throwforce_strength = 1.2
	wound_bonus = 5
	bare_wound_bonus = 1
	flags_1 = CONDUCT_1
	w_class = WEIGHT_CLASS_NORMAL
	slot_flags = ITEM_SLOT_BELT
	sharpness = SHARP_EDGED
	parrying_modifier = 1
	skill_melee = SKILL_SHORTSWORD
	carry_weight = 2 KILOGRAMS
	tetris_width = 32
	tetris_height = 96

/obj/item/changeable_attacks/sword/swap_intents(mob/user)
	. = ..()
	switch(current_atk_mode)
		if(slash)
			to_chat(user, span_notice("I'm now stabbing them with the pointy end of the [src]."))
			hitsound = stab_hitsound
			min_force = 6
			force = 10
			min_force_strength = 1
			force_strength = 1.8
			current_atk_mode = stab
			sharpness = SHARP_POINTY
			embedding = list("pain_mult" = 4, "embed_chance" = 100, "fall_chance" = 10)
		if(stab)
			to_chat(user, span_notice("I'm now bashing with the hilt of the [src]."))
			hitsound = bash_hitsound
			min_force = 6
			force = 10
			min_force_strength = 0.6
			force_strength = 1.65
			current_atk_mode = bash
			sharpness = NONE
		if(bash)
			to_chat(user, span_notice("I'm now slicing with the [src]."))
			hitsound = slash_hitsound
			min_force = 6
			force = 10
			min_force_strength = 1
			force_strength = 1.8
			current_atk_mode = slash
			sharpness = SHARP_EDGED
			embedding = list("pain_mult" = 4, "embed_chance" = 55, "fall_chance" = 10)

/obj/item/changeable_attacks/sword/kukri
	name = "Kukri"
	desc = "A carbon-steel kukri, usually found in the hands of people who really want to make cartel videos."
	embedding = list("pain_mult" = 4, "embed_chance" = 55, "fall_chance" = 10)

/obj/item/changeable_attacks/skindeep
	name = "Big Cleaver"
	desc = "A Skin Deep Cleaver, known for It's tiny size and precision, definitely not being essentially a sharp club."
	icon = 'modular_septic/icons/obj/items/melee/48x32.dmi'
	lefthand_file = 'modular_septic/icons/obj/items/melee/inhands/sword_lefthand.dmi'
	righthand_file = 'modular_septic/icons/obj/items/melee/inhands/sword_righthand.dmi'
	icon_state = "skin_cleaver"
	inhand_icon_state = "skin_cleaver"
	current_atk_mode = slash
	slash_hitsound = list('modular_septic/sound/weapons/melee/heavysharp_slash1.ogg', 'modular_septic/sound/weapons/melee/heavysharp_slash2.ogg', 'modular_septic/sound/weapons/melee/heavysharp_slash3.ogg')
	pickup_sound = 'modular_septic/sound/weapons/melee/heavysharp_deploy.ogg'
	miss_sound = list('modular_septic/sound/weapons/melee/heavysharp_swish1.ogg', 'modular_septic/sound/weapons/melee/heavysharp_swish2.ogg', 'modular_septic/sound/weapons/melee/heavysharp_swish3.ogg')
	drop_sound = list('modular_septic/sound/weapons/melee/bladedrop1.wav', 'modular_septic/sound/weapons/melee/bladedrop2.wav')
	min_force = 13
	force = 25
	min_force_strength = 1.3
	wound_bonus = 5
	bare_wound_bonus = 1
	force_strength = 2.5
	min_throwforce = 5
	min_throwforce_strength = 8
	throwforce_strength = 1
	parrying_modifier = 1
	w_class = WEIGHT_CLASS_BULKY
	sharpness = SHARP_EDGED
	skill_melee = SKILL_SHORTSWORD
	carry_weight = 2.5 KILOGRAMS
	tetris_width = 32
	tetris_height = 96
	slot_flags = null

/obj/item/changeable_attacks/skindeep/swap_intents(mob/user)
	. = ..()
	switch(current_atk_mode)
		if(slash)
			to_chat(user, span_notice("I'm now stabbing them with the slanted pointy end of the [src].")) //It's not that great at stabbing
			hitsound = stab_hitsound
			min_force = 8
			force = 10
			min_force_strength = 1.5
			force_strength = 2
			current_atk_mode = stab
			sharpness = SHARP_POINTY
		if(stab)
			to_chat(user, span_notice("I'm now bashing with the hilt of the [src]."))
			hitsound = bash_hitsound
			min_force = 6
			force = 9
			min_force_strength = 0.65
			force_strength = 1.65
			current_atk_mode = bash
			sharpness = NONE
		if(bash)
			to_chat(user, span_notice("I'm now slicing with the [src]."))
			hitsound = slash_hitsound
			min_force = 13
			force = 25
			min_force_strength = 1.3
			force_strength = 2.5
			current_atk_mode = slash
			sharpness = SHARP_EDGED

/obj/item/changeable_attacks/longaxe
	name = "Long Axe"
	desc = "Large two-handed ax with a hook on the butt."
	icon = 'modular_septic/icons/obj/items/melee/48x32.dmi'
	lefthand_file = 'modular_septic/icons/obj/items/melee/inhands/sword_lefthand.dmi'
	righthand_file = 'modular_septic/icons/obj/items/melee/inhands/sword_righthand.dmi'
	icon_state = "longaxe"
	inhand_icon_state = "longaxe"
	current_atk_mode = slash
	slash_hitsound = list('modular_septic/sound/weapons/melee/heavyysharp_slash1.ogg', 'modular_septic/sound/weapons/melee/heavyysharp_slash2.ogg', 'modular_septic/sound/weapons/melee/heavyysharp_slash3.ogg', 'modular_septic/sound/weapons/melee/heavyysharp_slash4.ogg')
	pickup_sound = 'modular_septic/sound/weapons/melee/heavyysharp_deploy.ogg'
	miss_sound = list('modular_septic/sound/weapons/melee/heavyysharp_swish1.ogg', 'modular_septic/sound/weapons/melee/heavyysharp_swish2.ogg', 'modular_septic/sound/weapons/melee/heavyysharp_swish3.ogg')
	drop_sound = list('modular_septic/sound/weapons/melee/bladedrop1.wav', 'modular_septic/sound/weapons/melee/bladedrop2.wav')
	min_force = 15
	force = 35
	min_force_strength = 1.5
	wound_bonus = 10
	bare_wound_bonus = 3
	force_strength = 3
	min_throwforce = 15
	min_throwforce_strength = 10
	throwforce_strength = 2
	throwforce = 17
	parrying_modifier = 1
	armor_damage_modifier = 1
	attack_fatigue_cost = 10
	attack_delay = 40
	w_class = WEIGHT_CLASS_BULKY
	sharpness = SHARP_EDGED
	skill_melee = SKILL_POLEARM
	carry_weight = 4 KILOGRAMS
	parrying_flags = BLOCK_FLAG_MELEE | BLOCK_FLAG_UNARMED | BLOCK_FLAG_THROWN
	tetris_width = 32
	tetris_height = 96
	slot_flags = null

/obj/item/changeable_attacks/longaxe/swap_intents(mob/user)
	. = ..()
	switch(current_atk_mode)
		if(slash)
			to_chat(user, span_notice("I'm now stabbing them with a hook on the butt of [src]."))
			user.visible_message(span_danger("[user] flips [src] to the other side!"), span_danger("You flips [src] to the other side!"))
			hitsound = stab_hitsound
			min_force = 8
			force = 13
			min_force_strength = 1.5
			force_strength = 2
			wound_bonus = 15
			bare_wound_bonus = 5
			armor_damage_modifier = 1.5
			attack_fatigue_cost = 8
			armor_damage_modifier = 2
			min_throwforce = 15
			min_throwforce_strength = 10
			throwforce_strength = 2
			throwforce = 17
			attack_delay = 40
			current_atk_mode = stab
			sharpness = SHARP_POINTY
		if(stab)
			to_chat(user, span_notice("I'm now bashing with the wooden hilt of the [src]."))
			hitsound = bash_hitsound
			min_force = 7
			force = 13
			min_force_strength = 0.65
			force_strength = 1.65
			wound_bonus = 8
			bare_wound_bonus = 2
			attack_fatigue_cost = 8
			min_throwforce = 15
			min_throwforce_strength = 10
			throwforce_strength = 2
			throwforce = 17
			attack_delay = 45
			armor_damage_modifier = 0
			current_atk_mode = bash
			sharpness = NONE
		if(bash)
			to_chat(user, span_notice("I'm now chop with the [src]."))
			user.visible_message(span_danger("[user] flips the [src] to the other side!"), span_danger("You flips the [src] to the other side!"))
			hitsound = slash_hitsound
			min_force = 15
			force = 35
			min_force_strength = 1.5
			force_strength = 3
			wound_bonus = 10
			bare_wound_bonus = 3
			armor_damage_modifier = 1
			min_throwforce = 15
			min_throwforce_strength = 10
			throwforce_strength = 2
			throwforce = 17
			attack_delay = 40
			attack_fatigue_cost = 10
			current_atk_mode = slash
			sharpness = SHARP_EDGED

/obj/item/changeable_attacks/slashbash/axe/small/steel
	name = "Iron Axe"
	desc = "Iron axe. Not bad."
	icon = 'modular_septic/icons/obj/items/melee/48x32.dmi'
	lefthand_file = 'modular_septic/icons/obj/items/inhands/items_and_weapons_lefthand.dmi'
	righthand_file = 'modular_septic/icons/obj/items/inhands/items_and_weapons_righthand.dmi'
	icon_state = "steelaxe"
	inhand_icon_state = "steelaxe"
	worn_icon = 'modular_septic/icons/mob/clothing/belt.dmi'
	worn_icon_state = "steelaxe"
	slash_hitsound = list('modular_septic/sound/weapons/melee/hitweapon.ogg', 'modular_septic/sound/weapons/melee/hitweapon2.ogg')
	pickup_sound = 'modular_septic/sound/weapons/melee/pickupweapon.wav'
	miss_sound = list('modular_septic/sound/weapons/melee/missweapon.wav', 'modular_septic/sound/weapons/melee/missweapon2.wav')
	drop_sound = 'modular_septic/sound/weapons/melee/dropnotbig.wav'
	embedding = list("pain_mult" = 4, "rip_time" = 5, "embed_chance" = 20, "jostle_chance" = 5, "pain_stam_pct" = 0.7, "pain_jostle_mult" = 9, "fall_chance" = 0.4)
	current_atk_mode = bash
	min_force = 15
	force = 20
	min_force_strength = 1.5
	wound_bonus = 13
	bare_wound_bonus = 5
	force_strength = 4
	min_throwforce = 19
	min_throwforce_strength = 12
	throwforce_strength = 3
	throwforce = 20
	parrying_modifier = 0.3
	armor_damage_modifier = 0.5
	attack_fatigue_cost = 9
	attack_delay = 30
	w_class = WEIGHT_CLASS_NORMAL
	sharpness = SHARP_EDGED
	skill_melee = SKILL_IMPACT_WEAPON
	carry_weight = 3 KILOGRAMS
	parrying_flags = BLOCK_FLAG_MELEE | BLOCK_FLAG_UNARMED | BLOCK_FLAG_THROWN
	havedurability = 1
	durability = 195
	tetris_width = 32
	tetris_height = 96
	slot_flags = ITEM_SLOT_BELT
/*
/obj/item/changeable_attacks/slashbash/axe/small/steel/Initialize(mapload)
	. = ..()
	durability = rand(150,195)
*/
/obj/item/changeable_attacks/slashbash/axe/small/steel/swap_intents(mob/user)
	. = ..()
	switch(current_atk_mode)
		if(slash)
			to_chat(user, span_notice("I'm now bashing them with steel back of the [src]."))
			user.visible_message(span_danger("[user] flips the [src] to the other side!"), span_danger("You flips the [src] to the other side!"))
			hitsound = bash_hitsound
			embedding = null
			min_force = 9
			force = 12
			min_force_strength = 0.70
			force_strength = 1.65
			wound_bonus = 10
			bare_wound_bonus = 2
			attack_fatigue_cost = 8
			min_throwforce = 14
			min_throwforce_strength = 9
			throwforce_strength = 2
			throwforce = 16
			attack_delay = 20
			armor_damage_modifier = 0.4
			current_atk_mode = bash
			sharpness = NONE
		if(bash)
			to_chat(user, span_notice("I'm now chop them with steel blade of the [src]."))
			user.visible_message(span_danger("[user] flips the [src] to the other side!"), span_danger("You flips the [src] to the other side!"))
			hitsound = slash_hitsound
			embedding = list("pain_mult" = 4, "rip_time" = 5, "embed_chance" = 20, "jostle_chance" = 5, "pain_stam_pct" = 0.7, "pain_jostle_mult" = 9, "fall_chance" = 0.4, "ignore_throwspeed_threshold" = TRUE)
			min_force = 15
			force = 20
			min_force_strength = 1.5
			force_strength = 4
			wound_bonus = 13
			bare_wound_bonus = 5
			armor_damage_modifier = 0.5
			min_throwforce = 19
			min_throwforce_strength = 12
			throwforce_strength = 3
			throwforce = 20
			attack_delay = 20
			attack_fatigue_cost = 9
			current_atk_mode = slash
			sharpness = SHARP_EDGED

/obj/item/changeable_attacks/slashstab/sabre/small/steel
	name = "Steel Saber"
	desc = "Use this as weapon!"
	icon_state = "steelsabre"
	inhand_icon_state = "steelsabre"
	worn_icon = 'modular_septic/icons/mob/clothing/belt.dmi'
	worn_icon_state = "steelsabre"
	icon = 'modular_septic/icons/obj/items/melee/48x32.dmi'
	lefthand_file = 'modular_septic/icons/obj/items/inhands/items_and_weapons_lefthand.dmi'
	righthand_file = 'modular_septic/icons/obj/items/inhands/items_and_weapons_righthand.dmi'
	equip_sound = 'modular_septic/sound/weapons/melee/sheathblade.wav'
	pickup_sound = 'modular_septic/sound/weapons/melee/drawblade.wav'
	miss_sound = list('modular_septic/sound/weapons/melee/swingblade.wav')
	drop_sound = 'modular_septic/sound/effects/fallsmall.ogg'
	current_atk_mode = stab
	min_force = 18
	force = 19
	min_force_strength = 1
	force_strength = 1.5
	min_throwforce = 5
	min_throwforce_strength = 8
	throwforce = 10
	throwforce_strength = 1.2
	wound_bonus = 10
	bare_wound_bonus = 5
	flags_1 = CONDUCT_1
	w_class = WEIGHT_CLASS_NORMAL
	slot_flags = ITEM_SLOT_BELT
	sharpness = SHARP_EDGED
	parrying_modifier = 1
	skill_melee = SKILL_SHORTSWORD
	carry_weight = 2 KILOGRAMS
	attack_fatigue_cost = 8
	attack_delay = 20
	parrying_flags = BLOCK_FLAG_MELEE | BLOCK_FLAG_UNARMED | BLOCK_FLAG_THROWN
	havedurability = 1
	durability = 160
	tetris_width = 32
	tetris_height = 96
	wielded_inhand_state = TRUE
/*
/obj/item/changeable_attacks/slashstab/sabre/small/steel/Initialize(mapload)
	. = ..()
	durability = rand(150, 160)
*/
/obj/item/changeable_attacks/slashstab/sabre/small/steel/hilt
	desc = "Use this as weapon! Here is hilt."
	icon_state = "steelsabrehilt"
	icon = 'modular_septic/icons/obj/items/melee/48x32.dmi'
	parrying_modifier = 1.5
	durability = 190
/*
/obj/item/changeable_attacks/slashstab/sabre/small/steel/hilt/Initialize(mapload)
	. = ..()
	durability = rand(160, 175)
*/
/obj/item/changeable_attacks/slashstab/sabre/small/steel/fast
	desc = "Use this as weapon! Here is ball."
	icon_state = "steelsabrefast"
	icon = 'modular_septic/icons/obj/items/melee/48x32.dmi'
	carry_weight = 1.5 KILOGRAMS
	parrying_modifier = 0.8
	attack_fatigue_cost = 7
	attack_delay = 17

/obj/item/changeable_attacks/slashstab/sabre/small/steel/swap_intents(mob/user)
	. = ..()
	switch(current_atk_mode)
		if(slash)
			to_chat(user, span_notice("I'm now stabbing them with the pointy end of the [src]."))
			hitsound = stab_hitsound
			min_force = 16
			force = 18
			min_force_strength = 1
			force_strength = 1.8
			current_atk_mode = stab
			sharpness = SHARP_POINTY
			embedding = list("pain_mult" = 6, "rip_time" = 1, "embed_chance" = 40, "jostle_chance" = 3.5, "pain_stam_pct" = 0.5, "pain_jostle_mult" = 6, "fall_chance" = 0.5, "ignore_throwspeed_threshold" = TRUE)
		if(stab)
			to_chat(user, span_notice("I'm now slicing with the [src]."))
			hitsound = slash_hitsound
			min_force = 15
			force = 19
			min_force_strength = 1
			force_strength = 1.8
			current_atk_mode = slash
			sharpness = SHARP_EDGED
			embedding = list("pain_mult" = 7, "rip_time" = 2, "embed_chance" = 45, "jostle_chance" = 3.5, "pain_stam_pct" = 0.5, "pain_jostle_mult" = 6, "fall_chance" = 1, "ignore_throwspeed_threshold" = TRUE)

#undef slash
#undef stab
#undef bash

/obj/item/kukri
	name = "Kukri"
	desc = "A carbon-steel kukri, usually found in the hands of people who really want to make cartel videos."
	icon_state = "cockri"
	inhand_icon_state = "cockri"
	worn_icon_state = "cockri"
	icon = 'modular_septic/icons/obj/items/melee/knife.dmi'
	lefthand_file = 'modular_septic/icons/obj/items/melee/inhands/knife_lefthand.dmi'
	righthand_file = 'modular_septic/icons/obj/items/melee/inhands/knife_righthand.dmi'
	worn_icon = 'modular_septic/icons/obj/items/melee/worn/knife_worn.dmi'
	hitsound = list('modular_septic/sound/weapons/melee/kukri1.wav', 'modular_septic/sound/weapons/melee/kukri2.wav', 'modular_septic/sound/weapons/melee/kukri3.wav')
	equip_sound = 'modular_septic/sound/weapons/melee/kukri_holster.wav'
	pickup_sound = 'modular_septic/sound/weapons/melee/kukri_deploy.wav'
	miss_sound = list('modular_septic/sound/weapons/melee/kukri_swish1.wav', 'modular_septic/sound/weapons/melee/kukri_swish2.wav', 'modular_septic/sound/weapons/melee/kukri_swish3.wav')
	drop_sound = list('modular_septic/sound/weapons/melee/bladedrop1.wav', 'modular_septic/sound/weapons/melee/bladedrop2.wav')
	min_force = 6
	force = 10
	min_force_strength = 1
	force_strength = 1.8
	wound_bonus = 5
	bare_wound_bonus = 1
	flags_1 = CONDUCT_1
	w_class = WEIGHT_CLASS_NORMAL
	slot_flags = ITEM_SLOT_BELT
	sharpness = SHARP_EDGED
	parrying_modifier = 1
	skill_melee = SKILL_SHORTSWORD
	tetris_width = 32
	tetris_height = 96

/obj/item/skin_cleaver
	name = "Skin Deep Cleaver"
	desc = "A Skin Deep Cleaver, known for It's tiny size and precision, definitely not being essentially a sharp club."
	icon_state = "skin_cleaver"
	inhand_icon_state = "skin_cleaver"
	slot_flags = null
	hitsound = list('modular_septic/sound/weapons/melee/heavysharp_slash1.ogg', 'modular_septic/sound/weapons/melee/heavysharp_slash2.ogg', 'modular_septic/sound/weapons/melee/heavysharp_slash3.ogg')
	pickup_sound = 'modular_septic/sound/weapons/melee/heavysharp_deploy.ogg'
	miss_sound = list('modular_septic/sound/weapons/melee/heavysharp_swish1.ogg', 'modular_septic/sound/weapons/melee/heavysharp_swish2.ogg', 'modular_septic/sound/weapons/melee/heavysharp_swish3.ogg')
	drop_sound = list('modular_septic/sound/weapons/melee/bladedrop1.wav', 'modular_septic/sound/weapons/melee/bladedrop2.wav')
	icon = 'modular_septic/icons/obj/items/melee/48x32.dmi'
	lefthand_file = 'modular_septic/icons/obj/items/melee/inhands/sword_lefthand.dmi'
	righthand_file = 'modular_septic/icons/obj/items/melee/inhands/sword_righthand.dmi'
	min_force = 13
	force = 25
	min_force_strength = 1.3
	force_strength = 2.5
	wound_bonus = 10
	bare_wound_bonus = 1
	w_class = WEIGHT_CLASS_BULKY
	sharpness = SHARP_EDGED
	parrying_modifier = 1
	skill_melee = SKILL_SHORTSWORD
	tetris_width = 32
	tetris_height = 96

/obj/item/melee/sabre
	parrying_modifier = 1
	skill_melee = SKILL_RAPIER

/obj/item/melee/chainofcommand
	parrying_modifier = -4
	skill_melee = SKILL_FLAIL

/obj/item/melee/curator_whip
	parrying_modifier = -4
	skill_melee = SKILL_FLAIL

/obj/item/claymore
	parrying_modifier = 0
	skill_melee = SKILL_LONGSWORD

/obj/item/claymore/cutlass
	parrying_modifier = 0
	skill_melee = SKILL_SHORTSWORD

/obj/item/katana
	parrying_modifier = 0
	skill_melee = SKILL_LONGSWORD

/obj/item/switchblade
	parrying_modifier = -2
	skill_melee = SKILL_KNIFE

/obj/item/mounted_chainsaw
	parrying_modifier = -1
	skill_melee = SKILL_IMPACT_WEAPON_TWOHANDED

/obj/item/chainsaw
	parrying_modifier = -1
	skill_melee = SKILL_IMPACT_WEAPON_TWOHANDED

/obj/item/melee/baseball_bat
	parrying_modifier = 0
	skill_melee = SKILL_IMPACT_WEAPON_TWOHANDED

/obj/item/gohei
	parrying_modifier = 0
	skill_melee = SKILL_STAFF

/obj/item/vibro_weapon
	parrying_modifier = 1
	skill_melee = SKILL_FORCESWORD

/obj/item/melee/moonlight_greatsword
	parrying_modifier = 1
	skill_melee = SKILL_FORCESWORD

/obj/item/spear
	parrying_modifier = 0
	skill_melee = SKILL_SPEAR

/obj/item/singularityhammer
	parrying_modifier = -2
	skill_melee = SKILL_POLEARM

/obj/item/mjollnir
	parrying_modifier = -1
	skill_melee = SKILL_POLEARM

/obj/item/pitchfork
	parrying_modifier = -1
	skill_melee = SKILL_SPEAR

/obj/item/melee/energy
	parrying_modifier = 1
	skill_melee = SKILL_FORCESWORD

/obj/item/dualsaber
	parrying_modifier = 2
	skill_melee = SKILL_FORCESWORD
