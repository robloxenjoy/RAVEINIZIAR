#define SLASH_MODE 1
#define STAB_MODE 2
#define BASH_MODE 3

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

/obj/item/melee/shieldo
	skill_blocking = SKILL_SHIELD
	blocking_flags = BLOCK_FLAG_MELEE | BLOCK_FLAG_UNARMED | BLOCK_FLAG_THROWN
	blocking_modifier = 1
	parrying_modifier = null

/obj/item/melee/shieldo/buckler/wooden
	name = "Деревянный Баклер"
	desc = "Может спасти мой зад."
	icon = 'modular_pod/icons/obj/items/weapons.dmi'
	icon_state = "buckler"
	lefthand_file = 'modular_septic/icons/obj/items/inhands/items_and_weapons_lefthand.dmi'
	righthand_file = 'modular_septic/icons/obj/items/inhands/items_and_weapons_righthand.dmi'
	inhand_icon_state = "buckler"
	worn_icon = 'modular_septic/icons/obj/items/guns/worn/back.dmi'
	worn_icon_state = "buckler"
	drop_sound = 'modular_septic/sound/effects/fallmedium.ogg'
	pickup_sound = 'modular_pod/sound/eff/weapon/draw_default.ogg'
	hitsound = list('modular_pod/sound/eff/weapon/blunt1.ogg', 'modular_pod/sound/eff/weapon/blunt2.ogg')
	block_sound = list('modular_pod/sound/eff/weapon/block_shield.ogg')
	havedurability = TRUE
	durability = 210
	carry_weight = 3 KILOGRAMS
	skill_melee = SKILL_IMPACT_WEAPON
	skill_blocking = SKILL_BUCKLER
//	blocking_modifier = 1
	w_class = WEIGHT_CLASS_BULKY
	slot_flags = ITEM_SLOT_BACK | ITEM_SLOT_SUITSTORE
	min_force = 9
	force = 11
	throwforce = 13
	min_force_strength = 1
	force_strength = 1.5
	wound_bonus = 4
	bare_wound_bonus = 4
	throw_speed = 2
	throw_range = 10
	attack_verb_continuous = list("вмазывает", "ударяет")
	attack_verb_simple = list("вмазать", "ударить")
	tetris_width = 64
	tetris_height = 64

/obj/item/stone
	name = "Камень"
	desc = "Твёрдый камушек."
	icon = 'icons/obj/objects.dmi'
	icon_state = "stone"
	drop_sound = 'modular_septic/sound/effects/fallmedium.ogg'
	pickup_sound = 'modular_septic/sound/effects/pickupdefault.ogg'
	havedurability = TRUE
	durability = 160
	carry_weight = 1 KILOGRAMS
	skill_melee = SKILL_IMPACT_WEAPON
	w_class = WEIGHT_CLASS_SMALL
	slot_flags = ITEM_SLOT_BELT | ITEM_SLOT_POCKETS
	min_force = 9
	force = 11
	min_throwforce = 10
	throwforce = 15
	throwforce_strength = 1.5
	min_force_strength = 1
	force_strength = 1.5
	wound_bonus = 4
	bare_wound_bonus = 4
	throw_speed = 2
	throw_range = 9
	attack_verb_continuous = list("ударяет", "хуячит")
	attack_verb_simple = list("ударить", "хуячить")
	tetris_width = 32
	tetris_height = 32

/obj/item/knife/combat/goldenmisericorde
	name = "Golden Misericorde"
	desc = "Expensive dagger. Shove it deep into the idiot."
	icon = 'modular_septic/icons/obj/items/melee/48x32.dmi'
	lefthand_file = 'modular_septic/icons/mob/inhands/sword_lefthand.dmi'
	righthand_file = 'modular_septic/icons/mob/inhands/sword_righthand.dmi'
	icon_state = "goldenmisericorde"
	inhand_icon_state = "goldenmisericorde"
	worn_icon = 'modular_septic/icons/mob/clothing/belt.dmi'
	worn_icon_state = "goldenmisericorde"
	equip_sound = 'modular_septic/sound/weapons/melee/bladesmallsheath.ogg'
	pickup_sound = 'modular_septic/sound/weapons/melee/bladesmalldraw.ogg'
	miss_sound = list('modular_septic/sound/weapons/melee/swingblade.ogg')
	drop_sound = 'modular_septic/sound/effects/fallsmall.ogg'
	hitsound = list('modular_pod/sound/eff/weapon/stab_hit.ogg')
	w_class = WEIGHT_CLASS_SMALL
	wound_bonus = 1
	bare_wound_bonus = 5
	min_force = 12
	force = 15
	min_force_strength = 1
	throwforce = 5
	force_strength = 1.8
	sharpness = SHARP_POINTY
	embedding = list("pain_mult" = 6, "rip_time" = 1, "embed_chance" = 38, "jostle_chance" = 3.5, "pain_stam_pct" = 0.5, "pain_jostle_mult" = 6, "fall_chance" = 0.5, "ignore_throwspeed_threshold" = TRUE)
	skill_melee = SKILL_KNIFE
	carry_weight = 1 KILOGRAMS
	attack_fatigue_cost = 6
	attack_delay = 17
	parrying_flags = BLOCK_FLAG_THROWN | BLOCK_FLAG_UNARMED
	parrying_modifier = 0
//	canrust = TRUE
	havedurability = TRUE
	durability = 180
	tetris_width = 32
	tetris_height = 32
	canlockpick = TRUE
	slot_flags = ITEM_SLOT_BELT
	attack_verb_continuous = list("stabs", "pokes", "jabs")
	attack_verb_simple = list("stab", "poke", "jab")
	custom_materials = list(/datum/material/gold=18000)

//Nice sexy sex
/obj/item/melee/truncheon
	name = "truncheon"
	desc = "A tool to beat the bones out of criminals."
	icon = 'modular_septic/icons/obj/items/melee/baton.dmi'
	icon_state = "truncheon"
	lefthand_file = 'modular_septic/icons/obj/items/melee/inhands/baton_lefthand.dmi'
	righthand_file = 'modular_septic/icons/obj/items/melee/inhands/baton_righthand.dmi'
	inhand_icon_state = "truncheon"
	drop_sound = list('modular_septic/sound/weapons/melee/baton_fall1.ogg', 'modular_septic/sound/weapons/melee/baton_fall2.ogg')
	miss_sound = list('modular_septic/sound/weapons/melee/baton_swish1.ogg', 'modular_septic/sound/weapons/melee/baton_swish2.ogg', 'modular_septic/sound/weapons/melee/baton_swish3.ogg')
	hitsound = list('modular_septic/sound/weapons/melee/baton1.ogg', 'modular_septic/sound/weapons/melee/baton2.ogg', 'modular_septic/sound/weapons/melee/baton3.ogg')
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

/obj/item/melee/bita
	parrying_modifier = 0

/obj/item/melee/bita/pink
	name = "Pink Lump"
	desc = "One-handed lump made of the unique material Halyab'ka."
	icon = 'modular_septic/icons/obj/items/melee/baton.dmi'
	icon_state = "pinkbita"
	lefthand_file = 'modular_septic/icons/obj/items/inhands/items_and_weapons_lefthand.dmi'
	righthand_file = 'modular_septic/icons/obj/items/inhands/items_and_weapons_righthand.dmi'
	inhand_icon_state = "pinkbita"
	drop_sound = list('modular_septic/sound/weapons/melee/baton_fall1.ogg', 'modular_septic/sound/weapons/melee/baton_fall2.ogg')
	miss_sound = list('modular_septic/sound/weapons/melee/baton_swish1.ogg', 'modular_septic/sound/weapons/melee/baton_swish2.ogg', 'modular_septic/sound/weapons/melee/baton_swish3.ogg')
	hitsound = list('modular_septic/sound/weapons/melee/baton1.ogg', 'modular_septic/sound/weapons/melee/baton2.ogg', 'modular_septic/sound/weapons/melee/baton3.ogg')
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
	hitsound = list('modular_pod/sound/eff/weapon/blunt1.ogg', 'modular_pod/sound/eff/weapon/blunt2.ogg')
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
	skill_melee = SKILL_IMPACT_WEAPON
	tetris_width = 32
	tetris_height = 64
	havedurability = TRUE
	durability = 150

/obj/item/melee/bita/branch
	name = "Cursed Branch"
	desc = "A torn branch from a tree."
	icon = 'modular_pod/icons/obj/items/weapons.dmi'
	icon_state = "stick"
	lefthand_file = 'modular_septic/icons/obj/items/inhands/items_and_weapons_lefthand.dmi'
	righthand_file = 'modular_septic/icons/obj/items/inhands/items_and_weapons_righthand.dmi'
	inhand_icon_state = "evilbita"
	hitsound = list('modular_pod/sound/eff/weapon/blunt1.ogg', 'modular_pod/sound/eff/weapon/blunt2.ogg')
	min_force = 7
	force = 11
	throwforce = 10
	min_force_strength = 1.1
	force_strength = 1.2
	wound_bonus = 3
	bare_wound_bonus = 3
	carry_weight = 1 KILOGRAMS
	slot_flags = ITEM_SLOT_BELT
	worn_icon_state = "classic_baton"
	skill_melee = SKILL_STAFF
	tetris_width = 32
	tetris_height = 64
	havedurability = TRUE
	durability = 50
	parrying_flags = BLOCK_FLAG_MELEE | BLOCK_FLAG_UNARMED | BLOCK_FLAG_THROWN
	parrying_modifier = 2

/obj/item/melee/bita/dark
	name = "Dark John"
	desc = "In the dark, the victim will not understand what you are hitting it with."
	icon = 'modular_pod/icons/obj/items/weapons.dmi'
	icon_state = "dark_club"
	lefthand_file = 'modular_septic/icons/obj/items/inhands/items_and_weapons_lefthand.dmi'
	righthand_file = 'modular_septic/icons/obj/items/inhands/items_and_weapons_righthand.dmi'
	inhand_icon_state = "dark_club"
	hitsound = list('modular_pod/sound/eff/weapon/blunt1.ogg', 'modular_pod/sound/eff/weapon/blunt2.ogg')
	min_force = 7
	force = 17
	throwforce = 16
	min_force_strength = 1.1
	force_strength = 1.5
	wound_bonus = 10
	bare_wound_bonus = 4
	armor_damage_modifier = 1
	havedurability = TRUE
	durability = 180
	carry_weight = 1.5 KILOGRAMS
	slot_flags = ITEM_SLOT_BELT
	worn_icon_state = "classic_baton"
	skill_melee = SKILL_IMPACT_WEAPON
	tetris_width = 32
	tetris_height = 64

/obj/item/melee/bita/cep/iron
	name = "Цеп"
	desc = "Из железа."
	icon = 'modular_pod/icons/obj/items/weapons.dmi'
	icon_state = "flail_iron"
	lefthand_file = 'modular_septic/icons/mob/inhands/remis_lefthand.dmi'
	righthand_file = 'modular_septic/icons/mob/inhands/remis_righthand.dmi'
	inhand_icon_state = "cep_iron"
	hitsound = list('modular_pod/sound/eff/weapon/blunty1.ogg', 'modular_pod/sound/eff/weapon/blunty2.ogg', 'modular_pod/sound/eff/weapon/blunty3.ogg')
	drop_sound = 'modular_septic/sound/effects/fallmedium.ogg'
	miss_sound = 'modular_pod/sound/eff/weapon/flail_swing.ogg'
	pickup_sound = 'modular_septic/sound/effects/pickupdefault.ogg'
	ready_sound = 'modular_pod/sound/eff/weapon/flail_ready.ogg'
	readying_flags = READYING_FLAG_JUSTCAUSE
	parrying_modifier = null
	min_force = 10
	force = 22
	throwforce = 5
	min_force_strength = 1.1
	force_strength = 1.5
	wound_bonus = 8
	bare_wound_bonus = 7
	armor_damage_modifier = 1
	attack_fatigue_cost = 9
	attack_delay = 15
	havedurability = TRUE
	durability = 300
	carry_weight = 1 KILOGRAMS
	slot_flags = ITEM_SLOT_BELT
	worn_icon_state = "classic_baton"
	skill_melee = SKILL_FLAIL
	attack_verb_continuous = list("бьёт")
	attack_verb_simple = list("бить")
	tetris_width = 32
	tetris_height = 64

/obj/item/melee/bita/hammer/stone
	name = "Stone Hammer"
	desc = "Good for smithing and killing."
	icon = 'modular_septic/icons/obj/items/melee/48x32.dmi'
	icon_state = "stonehammer"
	inhand_icon_state = "hammer"
	worn_icon = null
	worn_icon_state = null
	righthand_file = 'modular_septic/icons/obj/items/inhands/items_and_weapons_righthand.dmi'
	lefthand_file = 'modular_septic/icons/obj/items/inhands/items_and_weapons_lefthand.dmi'
	drop_sound = 'modular_septic/sound/effects/fallmedium.ogg'
	pickup_sound = 'modular_septic/sound/effects/pickupdefault.ogg'
	hitsound = list('modular_pod/sound/eff/weapon/blunty1.ogg', 'modular_pod/sound/eff/weapon/blunty2.ogg', 'modular_pod/sound/eff/weapon/blunty3.ogg')
	havedurability = TRUE
	durability = 170
	carry_weight = 1 KILOGRAMS
	skill_melee = SKILL_IMPACT_WEAPON
	w_class = WEIGHT_CLASS_SMALL
	slot_flags = ITEM_SLOT_BELT
	min_force = 10
	force = 15
	throwforce = 15
	min_force_strength = 1
	force_strength = 1.6
	wound_bonus = 8
	bare_wound_bonus = 8
	throw_speed = 2
	throw_range = 10
	attack_verb_continuous = list("bashes", "batters", "bludgeons", "whacks", "stones")
	attack_verb_simple = list("bash", "batter", "bludgeon", "whack", "stone")
	tetris_width = 32
	tetris_height = 32

/obj/item/melee/bita/hammer/heavy
	name = "Молот"
	desc = "Крепкий, уже не молоток."
	icon = 'modular_pod/icons/obj/items/weapons.dmi'
	icon_state = "hammer"
	inhand_icon_state = "hammer"
	worn_icon = null
	worn_icon_state = null
	righthand_file = 'modular_septic/icons/obj/items/inhands/items_and_weapons_righthand.dmi'
	lefthand_file = 'modular_septic/icons/obj/items/inhands/items_and_weapons_lefthand.dmi'
	drop_sound = 'modular_septic/sound/effects/fallmedium.ogg'
	pickup_sound = 'modular_septic/sound/effects/pickupdefault.ogg'
	hitsound = list('modular_pod/sound/eff/weapon/blunty1.ogg', 'modular_pod/sound/eff/weapon/blunty2.ogg', 'modular_pod/sound/eff/weapon/blunty3.ogg')
	havedurability = TRUE
	durability = 180
	carry_weight = 2 KILOGRAMS
	skill_melee = SKILL_IMPACT_WEAPON
	w_class = WEIGHT_CLASS_SMALL
	slot_flags = ITEM_SLOT_BELT
	min_force = 10
	force = 18
	throwforce = 15
	min_force_strength = 1
	force_strength = 1.6
	wound_bonus = 8
	bare_wound_bonus = 8
	throw_speed = 2
	throw_range = 10
	attack_verb_continuous = list("отбивает", "ударяет", "вмазывает", "хуярит", "въёбывает")
	attack_verb_simple = list("отбить", "ударить", "вмазать", "хуярить", "въебать")
	tetris_width = 32
	tetris_height = 32

/obj/item/melee/bita/hammer/sledge
	name = "Кувалда"
	desc = "Ну нихуя себе."
	icon = 'modular_pod/icons/obj/items/weapons.dmi'
	icon_state = "sledge"
	inhand_icon_state = "sledge"
	worn_icon = null
	worn_icon_state = null
	lefthand_file = 'modular_septic/icons/mob/inhands/remis_lefthand.dmi'
	righthand_file = 'modular_septic/icons/mob/inhands/remis_righthand.dmi'
	drop_sound = 'modular_septic/sound/effects/fallmedium.ogg'
	pickup_sound = 'modular_septic/sound/effects/pickupdefault.ogg'
	hitsound = list('modular_pod/sound/eff/weapon/big1.ogg', 'modular_pod/sound/eff/weapon/big2.ogg', 'modular_pod/sound/eff/weapon/big3.ogg')
	havedurability = TRUE
	durability = 300
	carry_weight = 5 KILOGRAMS
	skill_melee = SKILL_IMPACT_WEAPON_TWOHANDED
	w_class = WEIGHT_CLASS_HUGE
	slot_flags = null
	min_force = 17
	force = 29
	throwforce = 20
	min_force_strength = 1
	force_strength = 1.6
	wound_bonus = 13
	bare_wound_bonus = 13
	armor_damage_modifier = 1
	edge_protection_penetration = 3
	subtractible_armour_penetration = 3
	attack_fatigue_cost = 13
	attack_delay = 40
	throw_speed = 2
	throw_range = 8
	attack_verb_continuous = list("отбивает", "ударяет", "вмазывает", "хуярит", "въёбывает")
	attack_verb_simple = list("отбить", "ударить", "вмазать", "хуярить", "въебать")
	tetris_width = 32
	tetris_height = 32

/obj/item/melee/bita/macecircle
	name = "Steel Mace"
	desc = "One-handed steel mace."
	icon = 'modular_pod/icons/obj/items/weapons.dmi'
	icon_state = "club2"
	lefthand_file = 'modular_septic/icons/obj/items/inhands/items_and_weapons_lefthand.dmi'
	righthand_file = 'modular_septic/icons/obj/items/inhands/items_and_weapons_righthand.dmi'
	inhand_icon_state = "club2"
	drop_sound = 'modular_septic/sound/effects/fallmedium.ogg'
	pickup_sound = 'modular_septic/sound/effects/pickupdefault.ogg'
	hitsound = list('modular_pod/sound/eff/weapon/blunty1.ogg', 'modular_pod/sound/eff/weapon/blunty2.ogg', 'modular_pod/sound/eff/weapon/blunty3.ogg')
	min_force = 12
	force = 18
	throwforce = 15
	min_force_strength = 1.1
	force_strength = 1.4
	wound_bonus = 15
	bare_wound_bonus = 6
	armor_damage_modifier = 1
	havedurability = TRUE
	durability = 300
	carry_weight = 1.5 KILOGRAMS
	slot_flags = ITEM_SLOT_BELT
	skill_melee = SKILL_IMPACT_WEAPON
	worn_icon_state = "classic_baton"

/obj/item/melee/bita/rebar
	name = "Арматура"
	desc = "Очень привлекательно."
	icon = 'modular_pod/icons/obj/items/weapons.dmi'
	icon_state = "rebar"
	lefthand_file = 'modular_septic/icons/obj/items/inhands/items_and_weapons_lefthand.dmi'
	righthand_file = 'modular_septic/icons/obj/items/inhands/items_and_weapons_righthand.dmi'
	inhand_icon_state = "rebar"
	drop_sound = 'modular_septic/sound/effects/fallmedium.ogg'
	pickup_sound = 'modular_septic/sound/effects/pickupdefault.ogg'
	hitsound = list('modular_pod/sound/eff/weapon/blunty1.ogg', 'modular_pod/sound/eff/weapon/blunty2.ogg', 'modular_pod/sound/eff/weapon/blunty3.ogg')
	min_force = 11
	force = 15
	throwforce = 13
	min_force_strength = 1.1
	force_strength = 1.4
	wound_bonus = 8
	bare_wound_bonus = 6
	armor_damage_modifier = 1
	havedurability = TRUE
	durability = 250
	carry_weight = 2 KILOGRAMS
	slot_flags = ITEM_SLOT_BELT
	skill_melee = SKILL_IMPACT_WEAPON
	worn_icon_state = "classic_baton"
	attack_verb_continuous = list("бьёт")
	attack_verb_simple = list("бить")

/obj/item/melee/bita/rebar/Initialize(mapload)
	. = ..()
	icon_state = "[icon_state][rand(1, 2)]"

/obj/item/melee/bita/obsidian
	name = "Obsidian Fragment"
	desc = "A chipped piece of obsidian. Wait, is this a hallucination, or are the stars sparkling in obsidian?"
	icon = 'modular_pod/icons/obj/items/weapons.dmi'
	icon_state = "obsidian_fragment"
	lefthand_file = 'modular_septic/icons/obj/items/inhands/items_and_weapons_lefthand.dmi'
	righthand_file = 'modular_septic/icons/obj/items/inhands/items_and_weapons_righthand.dmi'
	inhand_icon_state = "obsidian_fragment"
	drop_sound = 'modular_septic/sound/effects/fallmedium.ogg'
	pickup_sound = 'modular_septic/sound/effects/pickupdefault.ogg'
	hitsound = list('modular_pod/sound/eff/weapon/big1.ogg', 'modular_pod/sound/eff/weapon/big2.ogg', 'modular_pod/sound/eff/weapon/big3.ogg')
	min_force = 13
	force = 21
	throwforce = 15
	throw_speed = 3
	throw_range = 3
	min_force_strength = 1.3
	force_strength = 1.8
	wound_bonus = 15
	bare_wound_bonus = 6
	armor_damage_modifier = 1
	edge_protection_penetration = 3
	subtractible_armour_penetration = 3
	w_class = WEIGHT_CLASS_HUGE
	carry_weight = 5 KILOGRAMS
	attack_fatigue_cost = 10
	attack_delay = 40
	havedurability = TRUE
	durability = 350
	slot_flags = null
	slowdown = 2
	skill_melee = SKILL_IMPACT_WEAPON_TWOHANDED
	readying_flags = READYING_FLAG_SOFT_TWO_HANDED
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

/obj/item
	var/slash_hitsound = list('modular_septic/sound/weapons/melee/slasher1.ogg', 'modular_septic/sound/weapons/melee/slasher2.ogg', 'modular_septic/sound/weapons/melee/slasher3.ogg')
	var/stab_hitsound = list('modular_pod/sound/eff/weapon/stab_hit.ogg')
	var/bash_hitsound = list('modular_septic/sound/weapons/melee/baton1.ogg', 'modular_septic/sound/weapons/melee/baton2.ogg', 'modular_septic/sound/weapons/melee/baton3.ogg')

/obj/item/examine(mob/user)
	. = ..()
	if(choose_attack_intent)
		switch(current_attack_intent)
			if(SLASH_ATTACKING)
				. += span_notice("Сейчас порезом.")
			if(STAB_ATTACKING)
				. += span_notice("Сейчас вонзанием.")
			if(BASH_ATTACKING)
				. += span_notice("Сейчас отбитием.")

/obj/item/attack_self(mob/user, modifiers)
	. = ..()
	if(choose_attack_intent)
		swap_intents(user)

/obj/item/proc/swap_intents(mob/user)
	if(choose_attack_intent)
		user.playsound_local(get_turf(src), 'modular_septic/sound/weapons/melee/swap_intent.ogg', 5, FALSE)

/obj/item/update_icon(updates)
	. = ..()
	if(wielded_inhand_state_melee)
		if(SEND_SIGNAL(src, COMSIG_TWOHANDED_WIELD_CHECK))
			inhand_icon_state = "[initial(inhand_icon_state)]_wielded"
		else
			inhand_icon_state = "[initial(inhand_icon_state)]"

/obj/item/podpol_weapon/sword

/obj/item/podpol_weapon/sword/steel
	name = "Меч"
	desc = "Сталь, древняя сила."
	icon_state = "sword"
	inhand_icon_state = "steelsword"
	worn_icon = 'modular_septic/icons/mob/clothing/belt.dmi'
	worn_icon_state = "steelsabre"
	icon = 'modular_pod/icons/obj/items/weapons.dmi'
	lefthand_file = 'modular_septic/icons/obj/items/inhands/items_and_weapons_lefthand.dmi'
	righthand_file = 'modular_septic/icons/obj/items/inhands/items_and_weapons_righthand.dmi'
	equip_sound = 'modular_septic/sound/weapons/melee/sheathblade.ogg'
	pickup_sound = 'modular_septic/sound/weapons/melee/drawblade.ogg'
	miss_sound = list('modular_septic/sound/weapons/melee/swingblade.ogg')
	drop_sound = 'modular_septic/sound/effects/fallsmall.ogg'
	stab_hitsound = list('modular_septic/sound/weapons/melee/heavystabber.ogg')
	slash_hitsound = list('modular_septic/sound/weapons/melee/slashflesh.ogg', 'modular_septic/sound/weapons/melee/slashflesh2.ogg', 'modular_septic/sound/weapons/melee/slashflesh3.ogg')
	hitsound = list('modular_septic/sound/weapons/melee/slashflesh.ogg', 'modular_septic/sound/weapons/melee/slashflesh2.ogg', 'modular_septic/sound/weapons/melee/slashflesh3.ogg')
	choose_attack_intent = TRUE
	current_attack_intent = SLASH_MODE
	min_force = 15
	force = 24
	min_force_strength = 1
	force_strength = 1.4
	min_throwforce = 7
	throwforce = 13
	throwforce_strength = 1.5
	wound_bonus = 10
	bare_wound_bonus = 7
	flags_1 = CONDUCT_1
	w_class = WEIGHT_CLASS_NORMAL
	slot_flags = ITEM_SLOT_BELT
	sharpness = SHARP_EDGED
	parrying_modifier = 1
	skill_melee = SKILL_LONGSWORD
	carry_weight = 2 KILOGRAMS
	attack_fatigue_cost = 9
	attack_delay = 23
	parrying_flags = BLOCK_FLAG_MELEE | BLOCK_FLAG_UNARMED | BLOCK_FLAG_THROWN
//	canrust = TRUE
//	rustbegin = 4000
	havedurability = TRUE
	durability = 250
	tetris_width = 32
	tetris_height = 96
	wielded_inhand_state_melee = TRUE
	attack_verb_continuous = list("режет")
	attack_verb_simple = list("резать")

/obj/item/podpol_weapon/sword/swap_intents(mob/user)
	. = ..()
	switch(current_attack_intent)
		if(SLASH_MODE)
			to_chat(user, span_notice("Теперь я буду вонзать в них с помощью [src]."))
			hitsound = stab_hitsound
			min_force = 14
			force = 19
			min_force_strength = 1
			force_strength = 1.3
			embedding = list("pain_mult" = 11, "rip_time" = 6, "embed_chance" = 12, "jostle_chance" = 3.5, "pain_stam_pct" = 0.5, "pain_jostle_mult" = 6, "fall_chance" = 0.5, "ignore_throwspeed_threshold" = TRUE)
			current_attack_intent = STAB_MODE
			sharpness = SHARP_POINTY
			attack_verb_continuous = list("вонзает")
			attack_verb_simple = list("вонзать")
		if(STAB_MODE)
			to_chat(user, span_notice("Теперь я буду бить их рукоятью с помощью [src]."))
			hitsound = bash_hitsound
			min_force = 7
			force = 13
			min_force_strength = 0.65
			force_strength = 1.3
			wound_bonus = 7
			bare_wound_bonus = 2
			attack_fatigue_cost = 8
			throwforce_strength = 1.5
			attack_delay = 20
			current_attack_intent = BASH_MODE
			sharpness = NONE
			attack_verb_continuous = list("стукает")
			attack_verb_simple = list("стукать")
		if(BASH_MODE)
			to_chat(user, span_notice("Теперь я буду резать их с помощью [src]."))
			hitsound = slash_hitsound
			min_force = 15
			force = 24
			min_force_strength = 1
			force_strength = 1.4
			embedding = list("pain_mult" = 10, "rip_time" = 3, "embed_chance" = 8, "jostle_chance" = 5, "pain_stam_pct" = 0.5, "pain_jostle_mult" = 6, "fall_chance" = 1, "ignore_throwspeed_threshold" = TRUE)
			current_attack_intent = SLASH_MODE
			sharpness = SHARP_EDGED
			attack_verb_continuous = list("режет")
			attack_verb_simple = list("резать")

/obj/item/podpol_weapon/spear/wooden
	name = "Копьё"
	desc = "Сделано из дерева, так что сломается скоро."
	icon = 'modular_pod/icons/obj/items/weapons.dmi'
	icon_state = "wood_spear"
	inhand_icon_state = "spear_wooden"
	lefthand_file = 'modular_septic/icons/mob/inhands/remis_lefthand.dmi'
	righthand_file = 'modular_septic/icons/mob/inhands/remis_righthand.dmi'
//	reach = 2
	min_force = 15
	force = 20
	min_force_strength = 1
	force_strength = 1.4
	min_throwforce = 15
	throwforce = 23
	throwforce_strength = 1.5
	wound_bonus = 10
	bare_wound_bonus = 7
	flags_1 = CONDUCT_1
	w_class = WEIGHT_CLASS_BULKY
	parrying_modifier = 1
	skill_melee = SKILL_SPEAR
	carry_weight = 2 KILOGRAMS
	attack_fatigue_cost = 9
	attack_delay = 20
	parrying_flags = BLOCK_FLAG_MELEE | BLOCK_FLAG_UNARMED | BLOCK_FLAG_THROWN
	havedurability = TRUE
	durability = 100
	drop_sound = 'modular_septic/sound/effects/fallmedium.ogg'
	pickup_sound = 'modular_septic/sound/effects/pickupdefault.ogg'
	miss_sound = list('modular_septic/sound/weapons/melee/swingblade.ogg')
	hitsound = list('modular_pod/sound/eff/weapon/stab_hit.ogg')
	sharpness = SHARP_POINTY
	embedding = list("pain_mult" = 6, "rip_time" = 1.5, "embed_chance" = 38, "jostle_chance" = 3.5, "pain_stam_pct" = 0.5, "pain_jostle_mult" = 6, "fall_chance" = 0.5, "ignore_throwspeed_threshold" = TRUE)
	slot_flags = null
	attack_verb_continuous = list("тычет", "вонзает")
	attack_verb_simple = list("тыкать", "вонзать")

/*
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
	equip_sound = 'modular_septic/sound/weapons/melee/kukri_holster.ogg'
	pickup_sound = 'modular_septic/sound/weapons/melee/kukri_deploy.ogg'
	miss_sound = list('modular_septic/sound/weapons/melee/kukri_swish1.ogg', 'modular_septic/sound/weapons/melee/kukri_swish2.ogg', 'modular_septic/sound/weapons/melee/kukri_swish3.ogg')
	drop_sound = list('modular_septic/sound/weapons/melee/bladedrop1.ogg', 'modular_septic/sound/weapons/melee/bladedrop2.ogg')
	current_atk_mode = SLASH_MODE
	min_force = 6
	force = 10
	min_force_strength = 1
	force_strength = 1.8
	min_throwforce = 4
	throwforce = 8
	min_throwforce_strength = 1
	throwforce_strength = 1.5
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
		if(SLASH_MODE)
			to_chat(user, span_notice("I'm now stabbing them with the pointy end of the [src]."))
			hitsound = stab_hitsound
			min_force = 6
			force = 10
			min_force_strength = 1
			force_strength = 1.8
			current_atk_mode = STAB_MODE
			sharpness = SHARP_POINTY
			embedding = list("pain_mult" = 4, "embed_chance" = 100, "fall_chance" = 10)
		if(STAB_MODE)
			to_chat(user, span_notice("I'm now bashing with the hilt of the [src]."))
			hitsound = bash_hitsound
			min_force = 6
			force = 10
			min_force_strength = 0.6
			force_strength = 1.65
			current_atk_mode = BASH_MODE
			sharpness = NONE
		if(BASH_MODE)
			to_chat(user, span_notice("I'm now slicing with the [src]."))
			hitsound = slash_hitsound
			min_force = 6
			force = 10
			min_force_strength = 1
			force_strength = 1.8
			current_atk_mode = SLASH_MODE
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
	current_atk_mode = SLASH_MODE
	slash_hitsound = list('modular_septic/sound/weapons/melee/heavysharp_slash1.ogg', 'modular_septic/sound/weapons/melee/heavysharp_slash2.ogg', 'modular_septic/sound/weapons/melee/heavysharp_slash3.ogg')
	pickup_sound = 'modular_septic/sound/weapons/melee/heavysharp_deploy.ogg'
	miss_sound = list('modular_septic/sound/weapons/melee/heavysharp_swish1.ogg', 'modular_septic/sound/weapons/melee/heavysharp_swish2.ogg', 'modular_septic/sound/weapons/melee/heavysharp_swish3.ogg')
	drop_sound = list('modular_septic/sound/weapons/melee/bladedrop1.ogg', 'modular_septic/sound/weapons/melee/bladedrop2.ogg')
	min_force = 13
	force = 25
	min_force_strength = 1.3
	wound_bonus = 5
	bare_wound_bonus = 1
	force_strength = 2.5
	min_throwforce = 4
	throwforce = 8
	min_throwforce_strength = 1
	throwforce_strength = 1.5
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
		if(SLASH_MODE)
			to_chat(user, span_notice("I'm now stabbing them with the slanted pointy end of the [src].")) //It's not that great at stabbing
			hitsound = stab_hitsound
			min_force = 8
			force = 10
			min_force_strength = 1.5
			force_strength = 2
			current_atk_mode = STAB_MODE
			sharpness = SHARP_POINTY
		if(STAB_MODE)
			to_chat(user, span_notice("I'm now bashing with the hilt of the [src]."))
			hitsound = bash_hitsound
			min_force = 6
			force = 9
			min_force_strength = 0.65
			force_strength = 1.65
			current_atk_mode = BASH_MODE
			sharpness = NONE
		if(BASH_MODE)
			to_chat(user, span_notice("I'm now slicing with the [src]."))
			hitsound = slash_hitsound
			min_force = 13
			force = 25
			min_force_strength = 1.3
			force_strength = 2.5
			current_atk_mode = SLASH_MODE
			sharpness = SHARP_EDGED
*/

/obj/item/podpol_weapon/axe/big
	name = "Секира"
	desc = "..."
	icon = 'modular_pod/icons/obj/items/weapons.dmi'
	lefthand_file = 'modular_septic/icons/obj/items/melee/inhands/sword_lefthand.dmi'
	righthand_file = 'modular_septic/icons/obj/items/melee/inhands/sword_righthand.dmi'
	icon_state = "axe_big"
	inhand_icon_state = "longaxe"
	choose_attack_intent = TRUE
	current_attack_intent = SLASH_MODE
	hitsound = list('modular_septic/sound/weapons/melee/heavyysharp_slash1.ogg', 'modular_septic/sound/weapons/melee/heavyysharp_slash2.ogg', 'modular_septic/sound/weapons/melee/heavyysharp_slash3.ogg', 'modular_septic/sound/weapons/melee/heavyysharp_slash4.ogg')
	stab_hitsound = list('modular_septic/sound/weapons/melee/heavystabber.ogg')
	slash_hitsound = list('modular_septic/sound/weapons/melee/heavyysharp_slash1.ogg', 'modular_septic/sound/weapons/melee/heavyysharp_slash2.ogg', 'modular_septic/sound/weapons/melee/heavyysharp_slash3.ogg', 'modular_septic/sound/weapons/melee/heavyysharp_slash4.ogg')
	pickup_sound = 'modular_septic/sound/weapons/melee/heavyysharp_deploy.ogg'
	miss_sound = list('modular_septic/sound/weapons/melee/heavyysharp_swish1.ogg', 'modular_septic/sound/weapons/melee/heavyysharp_swish2.ogg', 'modular_septic/sound/weapons/melee/heavyysharp_swish3.ogg')
	drop_sound = list('modular_septic/sound/weapons/melee/bladedrop1.ogg', 'modular_septic/sound/weapons/melee/bladedrop2.ogg')
	embedding = list("pain_mult" = 5, "rip_time" = 7, "embed_chance" = 15, "jostle_chance" = 9, "pain_stam_pct" = 2, "pain_jostle_mult" = 10, "fall_chance" = 0.2)
	min_force = 15
	force = 35
	min_force_strength = 1.5
	wound_bonus = 10
	bare_wound_bonus = 3
	force_strength = 3
	min_throwforce = 5
	throwforce = 11
	throwforce_strength = 1.5
	parrying_modifier = 1
	armor_damage_modifier = 1
	attack_fatigue_cost = 10
	attack_delay = 40
	w_class = WEIGHT_CLASS_BULKY
	sharpness = SHARP_EDGED
	skill_melee = SKILL_POLEARM
	carry_weight = 4 KILOGRAMS
	havedurability = TRUE
	durability = 300
	parrying_flags = BLOCK_FLAG_MELEE | BLOCK_FLAG_UNARMED | BLOCK_FLAG_THROWN
	tetris_width = 32
	tetris_height = 96
	slot_flags = null
	isAxe = TRUE
	attack_verb_continuous = list("рубит")
	attack_verb_simple = list("рубить")

/obj/item/podpol_weapon/axe/big/swap_intents(mob/user)
	. = ..()
	switch(current_attack_intent)
		if(SLASH_MODE)
			to_chat(user, span_notice("Теперь я буду в них тыкать задней частью [src]."))
			user.visible_message(span_danger("[user] переворачивает [src] на другую сторону!"), span_danger("Я переворачиваю [src] на другую сторону!"))
			hitsound = stab_hitsound
			embedding = list("pain_mult" = 5, "rip_time" = 7, "embed_chance" = 19, "jostle_chance" = 8, "pain_stam_pct" = 2, "pain_jostle_mult" = 9, "fall_chance" = 0.2)
			min_force = 8
			force = 13
			min_force_strength = 1.5
			force_strength = 2
			wound_bonus = 15
			bare_wound_bonus = 5
			armor_damage_modifier = 1.5
			attack_fatigue_cost = 8
			armor_damage_modifier = 2
			min_throwforce = 5
			throwforce = 8
			throwforce_strength = 1.5
			attack_delay = 40
			current_attack_intent = STAB_MODE
			sharpness = SHARP_POINTY
			attack_verb_continuous = list("вонзает")
			attack_verb_simple = list("вонзать")
		if(STAB_MODE)
			to_chat(user, span_notice("Теперь я буду их бить рукоятью [src]."))
			hitsound = bash_hitsound
			min_force = 7
			force = 11
			min_force_strength = 0.65
			force_strength = 1.65
			wound_bonus = 7
			bare_wound_bonus = 2
			attack_fatigue_cost = 8
			min_throwforce = 5
			throwforce = 8
			throwforce_strength = 1.5
			attack_delay = 35
			armor_damage_modifier = 0
			current_attack_intent = BASH_MODE
			sharpness = NONE
			attack_verb_continuous = list("бьёт")
			attack_verb_simple = list("бить")
		if(BASH_MODE)
			to_chat(user, span_notice("Теперь я буду их рубить [src]."))
			user.visible_message(span_danger("[user] переворачивает [src] на другую сторону!"), span_danger("Я переворачиваю [src] на другую сторону!"))
			hitsound = slash_hitsound
			embedding = list("pain_mult" = 5, "rip_time" = 7, "embed_chance" = 15, "jostle_chance" = 9, "pain_stam_pct" = 2, "pain_jostle_mult" = 10, "fall_chance" = 0.2)
			min_force = 15
			force = 35
			min_force_strength = 1.5
			force_strength = 3
			wound_bonus = 10
			bare_wound_bonus = 3
			armor_damage_modifier = 1
			min_throwforce = 5
			throwforce = 11
			throwforce_strength = 1.5
			attack_delay = 40
			attack_fatigue_cost = 10
			current_attack_intent = SLASH_MODE
			sharpness = SHARP_EDGED
			attack_verb_continuous = list("рубит")
			attack_verb_simple = list("рубить")
/*
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
	pickup_sound = 'modular_septic/sound/weapons/melee/pickupweapon.ogg'
	miss_sound = list('modular_septic/sound/weapons/melee/missweapon.ogg', 'modular_septic/sound/weapons/melee/missweapon2.ogg')
	drop_sound = 'modular_septic/sound/weapons/melee/dropnotbig.ogg'
	embedding = list("pain_mult" = 4, "rip_time" = 5, "embed_chance" = 20, "jostle_chance" = 5, "pain_stam_pct" = 0.7, "pain_jostle_mult" = 9, "fall_chance" = 0.4)
	current_atk_mode = SLASH_MODE
	min_force = 15
	force = 20
	min_force_strength = 1.5
	wound_bonus = 13
	bare_wound_bonus = 5
	force_strength = 4
	min_throwforce = 5
	throwforce = 8
	throwforce_strength = 1.5
	parrying_modifier = 0.3
	armor_damage_modifier = 0.5
	attack_fatigue_cost = 9
	attack_delay = 30
	w_class = WEIGHT_CLASS_NORMAL
	sharpness = SHARP_EDGED
	skill_melee = SKILL_IMPACT_WEAPON
	carry_weight = 3 KILOGRAMS
	parrying_flags = BLOCK_FLAG_MELEE | BLOCK_FLAG_UNARMED | BLOCK_FLAG_THROWN
//	canrust = TRUE
//	rustbegin = 3600
	havedurability = TRUE
	durability = 195
	tetris_width = 32
	tetris_height = 96
	slot_flags = ITEM_SLOT_BELT
	isAxe = TRUE
/*
/obj/item/changeable_attacks/slashbash/axe/small/steel/Initialize(mapload)
	. = ..()
	durability = rand(150,195)
*/
/obj/item/changeable_attacks/slashbash/axe/small/steel/swap_intents(mob/user)
	. = ..()
	switch(current_atk_mode)
		if(SLASH_MODE)
			to_chat(user, span_notice("I'm now bashing them with heavy back of the [src]."))
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
			min_throwforce = 5
			throwforce = 8
			throwforce_strength = 1.5
			attack_delay = 20
			armor_damage_modifier = 0.4
			current_atk_mode = BASH_MODE
			sharpness = NONE
		if(BASH_MODE)
			to_chat(user, span_notice("I'm now chop them with the heavy blade of the [src]."))
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
			min_throwforce = 5
			throwforce = 8
			throwforce_strength = 1.5
			attack_delay = 20
			attack_fatigue_cost = 9
			current_atk_mode = SLASH_MODE
			sharpness = SHARP_EDGED
*/
/obj/item/podpol_weapon/sabre
	name = "Сабля"
	desc = "В качестве оружия!"
	icon_state = "sabre"
	inhand_icon_state = "steelsabre"
	worn_icon = 'modular_septic/icons/mob/clothing/belt.dmi'
	worn_icon_state = "steelsabre"
	icon = 'modular_pod/icons/obj/items/weapons.dmi'
	lefthand_file = 'modular_septic/icons/obj/items/inhands/items_and_weapons_lefthand.dmi'
	righthand_file = 'modular_septic/icons/obj/items/inhands/items_and_weapons_righthand.dmi'
	equip_sound = 'modular_septic/sound/weapons/melee/sheathblade.ogg'
	pickup_sound = 'modular_septic/sound/weapons/melee/drawblade.ogg'
	miss_sound = list('modular_septic/sound/weapons/melee/swingblade.ogg')
	drop_sound = 'modular_septic/sound/effects/fallsmall.ogg'
	hitsound = list('modular_septic/sound/weapons/melee/slasher1.ogg', 'modular_septic/sound/weapons/melee/slasher2.ogg', 'modular_septic/sound/weapons/melee/slasher3.ogg')
	choose_attack_intent = TRUE
	current_attack_intent = SLASH_MODE
	embedding = list("pain_mult" = 7, "rip_time" = 2, "embed_chance" = 35, "jostle_chance" = 3.5, "pain_stam_pct" = 0.5, "pain_jostle_mult" = 6, "fall_chance" = 1, "ignore_throwspeed_threshold" = TRUE)
	min_force = 14
	force = 20
	min_force_strength = 1
	force_strength = 1.5
	min_throwforce = 5
	throwforce = 10
	throwforce_strength = 1.5
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
	attack_delay = 18
	parrying_flags = BLOCK_FLAG_MELEE | BLOCK_FLAG_UNARMED | BLOCK_FLAG_THROWN
	havedurability = TRUE
	durability = 180
	tetris_width = 32
	tetris_height = 96
	wielded_inhand_state_melee = FALSE
	stab_hitsound = list('modular_pod/sound/eff/weapon/stab_hit.ogg')
/*
/obj/item/changeable_attacks/slashstab/sabre/small/steel/Initialize(mapload)
	. = ..()
	durability = rand(150, 160)
*/
/*
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
	attack_fatigue_cost = 6
	attack_delay = 16
*/
/obj/item/podpol_weapon/sabre/swap_intents(mob/user)
	. = ..()
	switch(current_attack_intent)
		if(SLASH_MODE)
			to_chat(user, span_notice("Теперь я буду в них вонзать с помощью [src]."))
			hitsound = stab_hitsound
			min_force = 16
			force = 19
			min_force_strength = 1
			force_strength = 1.5
			current_attack_intent = STAB_MODE
			sharpness = SHARP_POINTY
			embedding = list("pain_mult" = 6, "rip_time" = 2, "embed_chance" = 35, "jostle_chance" = 3.5, "pain_stam_pct" = 0.5, "pain_jostle_mult" = 6, "fall_chance" = 0.5, "ignore_throwspeed_threshold" = TRUE)
		if(STAB_MODE)
			to_chat(user, span_notice("Теперь я их буду резать с помощью [src]."))
			hitsound = slash_hitsound
			min_force = 14
			force = 20
			min_force_strength = 1
			force_strength = 1.5
			current_attack_intent = SLASH_MODE
			sharpness = SHARP_EDGED
			embedding = list("pain_mult" = 7, "rip_time" = 3, "embed_chance" = 45, "jostle_chance" = 3.5, "pain_stam_pct" = 0.5, "pain_jostle_mult" = 6, "fall_chance" = 1, "ignore_throwspeed_threshold" = TRUE)

/*
/obj/item/changeable_attacks/slashstabbash/sword/medium/steel
	name = "Steel Sword"
	desc = "Standard steel sword. Very good."
	icon_state = "steelsword"
	inhand_icon_state = "steelsword"
	worn_icon = 'modular_septic/icons/mob/clothing/belt.dmi'
	worn_icon_state = "steelsabre"
	icon = 'modular_septic/icons/obj/items/melee/48x32.dmi'
	lefthand_file = 'modular_septic/icons/obj/items/inhands/items_and_weapons_lefthand.dmi'
	righthand_file = 'modular_septic/icons/obj/items/inhands/items_and_weapons_righthand.dmi'
	equip_sound = 'modular_septic/sound/weapons/melee/sheathblade.ogg'
	pickup_sound = 'modular_septic/sound/weapons/melee/drawblade.ogg'
	miss_sound = list('modular_septic/sound/weapons/melee/swingblade.ogg')
	drop_sound = 'modular_septic/sound/effects/fallsmall.ogg'
	stab_hitsound = list('modular_septic/sound/weapons/melee/heavystabber.ogg')
	slash_hitsound = list('modular_septic/sound/weapons/melee/slashflesh.ogg', 'modular_septic/sound/weapons/melee/slashflesh2.ogg', 'modular_septic/sound/weapons/melee/slashflesh3.ogg')
	current_atk_mode = SLASH_MODE
	embedding = list("pain_mult" = 10, "rip_time" = 3, "embed_chance" = 8, "jostle_chance" = 5, "pain_stam_pct" = 0.5, "pain_jostle_mult" = 6, "fall_chance" = 1, "ignore_throwspeed_threshold" = TRUE)
	min_force = 15
	force = 24
	min_force_strength = 1
	force_strength = 1.4
	min_throwforce = 5
	throwforce = 8
	throwforce_strength = 1.5
	wound_bonus = 10
	bare_wound_bonus = 7
	flags_1 = CONDUCT_1
	w_class = WEIGHT_CLASS_NORMAL
	slot_flags = ITEM_SLOT_BELT
	sharpness = SHARP_EDGED
	parrying_modifier = 1
	skill_melee = SKILL_LONGSWORD
	carry_weight = 2 KILOGRAMS
	attack_fatigue_cost = 9
	attack_delay = 23
	parrying_flags = BLOCK_FLAG_MELEE | BLOCK_FLAG_UNARMED | BLOCK_FLAG_THROWN
//	canrust = TRUE
//	rustbegin = 4000
	havedurability = TRUE
	durability = 250
	tetris_width = 32
	tetris_height = 96
	wielded_inhand_state = TRUE

/obj/item/changeable_attacks/slashstabbash/sword/medium/steel/swap_intents(mob/user)
	. = ..()
	switch(current_atk_mode)
		if(SLASH_MODE)
			to_chat(user, span_notice("I'm now stabbing them with the pointy end of the [src]."))
			hitsound = stab_hitsound
			min_force = 14
			force = 19
			min_force_strength = 1
			force_strength = 1.3
			current_atk_mode = STAB_MODE
			sharpness = SHARP_POINTY
			embedding = list("pain_mult" = 11, "rip_time" = 6, "embed_chance" = 12, "jostle_chance" = 3.5, "pain_stam_pct" = 0.5, "pain_jostle_mult" = 6, "fall_chance" = 0.5, "ignore_throwspeed_threshold" = TRUE)
		if(STAB_MODE)
			to_chat(user, span_notice("I'm now bashing them with the iron hilt of the [src]."))
			hitsound = bash_hitsound
			min_force = 7
			force = 13
			min_force_strength = 0.65
			force_strength = 1.3
			wound_bonus = 7
			bare_wound_bonus = 2
			attack_fatigue_cost = 8
			min_throwforce = 5
			throwforce = 8
			throwforce_strength = 1.5
			attack_delay = 20
			current_atk_mode = BASH_MODE
			sharpness = NONE
		if(BASH_MODE)
			to_chat(user, span_notice("I'm now slicing them with the wide blade of the [src]."))
			hitsound = slash_hitsound
			min_force = 15
			force = 24
			min_force_strength = 1
			force_strength = 1.4
			current_atk_mode = SLASH_MODE
			sharpness = SHARP_EDGED
			embedding = list("pain_mult" = 10, "rip_time" = 3, "embed_chance" = 8, "jostle_chance" = 5, "pain_stam_pct" = 0.5, "pain_jostle_mult" = 6, "fall_chance" = 1, "ignore_throwspeed_threshold" = TRUE)

/obj/item/changeable_attacks/slashstabbash/sword/big/bronze
	name = "Two-Handed Bronze Sword"
	desc = "So big sword!"
	icon_state = "broze_two_sword"
	inhand_icon_state = "broze_two_sword"
//	worn_icon = 'modular_septic/icons/mob/clothing/belt.dmi'
//	worn_icon_state = "steelsabre"
	icon = 'modular_septic/icons/obj/items/melee/48x32.dmi'
	lefthand_file = 'modular_septic/icons/obj/items/inhands/items_and_weapons_lefthand.dmi'
	righthand_file = 'modular_septic/icons/obj/items/inhands/items_and_weapons_righthand.dmi'
	equip_sound = 'modular_pod/sound/eff/weapon/2blade_sheath.ogg'
	pickup_sound = 'modular_pod/sound/eff/weapon/2blade_draw.ogg'
	miss_sound = list('modular_pod/sound/eff/weapon/2blade_swing.ogg')
	drop_sound = 'modular_septic/sound/effects/fallmedium.ogg'
	stab_hitsound = list('modular_septic/sound/weapons/melee/heavystabber.ogg')
	slash_hitsound = list('modular_pod/sound/eff/weapon/2blade_impact.ogg', 'modular_pod/sound/eff/weapon/2blade_impact2.ogg', 'modular_pod/sound/eff/weapon/2blade_impact3.ogg')
	current_atk_mode = SLASH_MODE
	embedding = list("pain_mult" = 15, "rip_time" = 3, "embed_chance" = 6, "jostle_chance" = 5, "pain_stam_pct" = 0.5, "pain_jostle_mult" = 6, "fall_chance" = 1, "ignore_throwspeed_threshold" = TRUE)
	min_force = 20
	force = 35
	min_force_strength = 1
	force_strength = 1.6
	min_throwforce = 5
	throwforce = 8
	throwforce_strength = 1.5
	wound_bonus = 10
	bare_wound_bonus = 5
	flags_1 = CONDUCT_1
	w_class = WEIGHT_CLASS_BULKY
	slot_flags = null
	sharpness = SHARP_EDGED
	parrying_modifier = -0.5
	skill_melee = SKILL_SWORD_TWOHANDED
	carry_weight = 2.5 KILOGRAMS
	attack_fatigue_cost = 10
	attack_delay = 25
	parrying_flags = BLOCK_FLAG_MELEE | BLOCK_FLAG_THROWN
	readying_flags = READYING_FLAG_SOFT_TWO_HANDED
	havedurability = TRUE
	durability = 350
	tetris_width = 32
	tetris_height = 96
	wielded_inhand_state = FALSE

/obj/item/changeable_attacks/slashstabbash/sword/big/bronze/swap_intents(mob/user)
	. = ..()
	switch(current_atk_mode)
		if(SLASH_MODE)
			to_chat(user, span_notice("I'm now stabbing them with the pointy end of the [src]."))
			hitsound = stab_hitsound
			min_force = 19
			force = 30
			min_force_strength = 1
			force_strength = 1.3
			current_atk_mode = STAB_MODE
			sharpness = SHARP_POINTY
			embedding = list("pain_mult" = 16, "rip_time" = 8, "embed_chance" = 8, "jostle_chance" = 3.5, "pain_stam_pct" = 0.5, "pain_jostle_mult" = 6, "fall_chance" = 0.5, "ignore_throwspeed_threshold" = TRUE)
		if(STAB_MODE)
			to_chat(user, span_notice("I'm now bashing them with the bronze hilt of the [src]."))
			hitsound = bash_hitsound
			min_force = 10
			force = 16
			min_force_strength = 0.65
			force_strength = 1.3
			wound_bonus = 8
			bare_wound_bonus = 3
			attack_fatigue_cost = 8
			min_throwforce = 5
			throwforce = 8
			throwforce_strength = 1.5
			attack_delay = 25
			current_atk_mode = BASH_MODE
			sharpness = NONE
		if(BASH_MODE)
			to_chat(user, span_notice("I'm now slicing them with the wide blade of the [src]."))
			hitsound = slash_hitsound
			min_force = 20
			force = 35
			min_force_strength = 1
			force_strength = 1.6
			min_throwforce = 5
			throwforce = 8
			throwforce_strength = 1.5
			wound_bonus = 15
			bare_wound_bonus = 10
			current_atk_mode = SLASH_MODE
			sharpness = SHARP_EDGED
			embedding = list("pain_mult" = 15, "rip_time" = 4, "embed_chance" = 6, "jostle_chance" = 5, "pain_stam_pct" = 0.5, "pain_jostle_mult" = 7, "fall_chance" = 1, "ignore_throwspeed_threshold" = TRUE)

/obj/item/changeable_attacks/slashstab/knife/small/steel
	name = "Steel Knife"
	desc = "Use this as weapon!"
	icon_state = "steelknife"
	inhand_icon_state = "steelknife"
	worn_icon = 'icons/mob/clothing/belt.dmi'
	worn_icon_state = "knife"
	icon = 'modular_septic/icons/obj/items/melee/48x32.dmi'
	lefthand_file = 'modular_septic/icons/obj/items/inhands/items_and_weapons_lefthand.dmi'
	righthand_file = 'modular_septic/icons/obj/items/inhands/items_and_weapons_righthand.dmi'
	equip_sound = 'modular_septic/sound/weapons/melee/bladesmallsheath.ogg'
	pickup_sound = 'modular_septic/sound/weapons/melee/bladesmalldraw.ogg'
	miss_sound = list('modular_septic/sound/weapons/melee/swingblade.ogg')
	drop_sound = 'modular_septic/sound/effects/fallsmall.ogg'
	current_atk_mode = SLASH_MODE
	embedding = list("pain_mult" = 6, "rip_time" = 2, "embed_chance" = 15, "jostle_chance" = 3.5, "pain_stam_pct" = 0.5, "pain_jostle_mult" = 6, "fall_chance" = 1, "ignore_throwspeed_threshold" = TRUE)
	min_force = 8
	force = 15
	min_force_strength = 1
	force_strength = 1.2
	min_throwforce = 5
	throwforce = 8
	throwforce_strength = 1.5
	wound_bonus = 6
	bare_wound_bonus = 3
	flags_1 = CONDUCT_1
	w_class = WEIGHT_CLASS_NORMAL
	slot_flags = ITEM_SLOT_BELT
	sharpness = SHARP_EDGED
	skill_melee = SKILL_KNIFE
	carry_weight = 1 KILOGRAMS
	attack_fatigue_cost = 7
	attack_delay = 18
	parrying_flags = BLOCK_FLAG_UNARMED
//	canrust = TRUE
//	rustbegin = 10
	havedurability = TRUE
	durability = 140
	canlockpick = TRUE
	tetris_width = 32
	tetris_height = 96

/obj/item/changeable_attacks/slashstab/knife/small/steel/swap_intents(mob/user)
	. = ..()
	switch(current_atk_mode)
		if(SLASH_MODE)
			to_chat(user, span_notice("I'm now stabbing them with the slightly curved end of the [src]."))
			hitsound = stab_hitsound
			min_force = 8
			force = 15
			min_force_strength = 1
			force_strength = 1.2
			current_atk_mode = STAB_MODE
			sharpness = SHARP_POINTY
			embedding = list("pain_mult" = 7, "rip_time" = 2, "embed_chance" = 25, "jostle_chance" = 3.5, "pain_stam_pct" = 0.5, "pain_jostle_mult" = 6, "fall_chance" = 0.5, "ignore_throwspeed_threshold" = TRUE)
		if(STAB_MODE)
			to_chat(user, span_notice("I'm now slicing them with the wide blade of the [src]."))
			hitsound = slash_hitsound
			min_force = 8
			force = 15
			min_force_strength = 1
			force_strength = 1.2
			current_atk_mode = SLASH_MODE
			sharpness = SHARP_EDGED
			embedding = list("pain_mult" = 6, "rip_time" = 3, "embed_chance" = 15, "jostle_chance" = 3.2, "pain_stam_pct" = 0.6, "pain_jostle_mult" = 6, "fall_chance" = 1, "ignore_throwspeed_threshold" = TRUE)

/obj/item/changeable_attacks/slashstab/knife/big/steel
	name = "Охотничий Нож"
	desc = "Должен быть использован для охоты!"
	icon_state = "bigknife_steel"
	inhand_icon_state = "steelknife"
	worn_icon = 'icons/mob/clothing/belt.dmi'
	worn_icon_state = "knife"
	icon = 'modular_pod/icons/obj/items/weapons.dmi'
	lefthand_file = 'modular_septic/icons/obj/items/inhands/items_and_weapons_lefthand.dmi'
	righthand_file = 'modular_septic/icons/obj/items/inhands/items_and_weapons_righthand.dmi'
	equip_sound = 'modular_septic/sound/weapons/melee/bladesmallsheath.ogg'
	pickup_sound = 'modular_septic/sound/weapons/melee/bladesmalldraw.ogg'
	miss_sound = list('modular_septic/sound/weapons/melee/swingblade.ogg')
	drop_sound = 'modular_septic/sound/effects/fallsmall.ogg'
	attack_verb_continuous = list("режет", "нарезает", "атакует")
	attack_verb_simple = list("резать", "нарезать", "атаковать")
	current_atk_mode = SLASH_MODE
	embedding = list("pain_mult" = 7, "rip_time" = 3, "embed_chance" = 15, "jostle_chance" = 3.5, "pain_stam_pct" = 0.5, "pain_jostle_mult" = 6, "fall_chance" = 1, "ignore_throwspeed_threshold" = TRUE)
	min_force = 10
	force = 17
	min_force_strength = 1
	force_strength = 1.3
	min_throwforce = 6
	throwforce = 10
	throwforce_strength = 1.5
	wound_bonus = 7
	bare_wound_bonus = 4
	flags_1 = CONDUCT_1
	w_class = WEIGHT_CLASS_NORMAL
	slot_flags = ITEM_SLOT_BELT
	sharpness = SHARP_EDGED
	skill_melee = SKILL_KNIFE
	carry_weight = 1 KILOGRAMS
	attack_fatigue_cost = 8
	attack_delay = 19
	parrying_flags = BLOCK_FLAG_UNARMED
	havedurability = TRUE
	durability = 160
	canlockpick = TRUE
	tetris_width = 32
	tetris_height = 96

/obj/item/changeable_attacks/slashstab/knife/big/steel/swap_intents(mob/user)
	. = ..()
	switch(current_atk_mode)
		if(SLASH_MODE)
			to_chat(user, span_notice("Теперь я буду в них вонзать с помощью [src]."))
			hitsound = stab_hitsound
			min_force = 10
			force = 17
			min_force_strength = 1
			force_strength = 1.3
			current_atk_mode = STAB_MODE
			sharpness = SHARP_POINTY
			embedding = list("pain_mult" = 8, "rip_time" = 3, "embed_chance" = 25, "jostle_chance" = 3.5, "pain_stam_pct" = 0.5, "pain_jostle_mult" = 6, "fall_chance" = 0.5, "ignore_throwspeed_threshold" = TRUE)
		if(STAB_MODE)
			to_chat(user, span_notice("Теперь я буду их резать с помощью [src]."))
			hitsound = slash_hitsound
			min_force = 10
			force = 17
			min_force_strength = 1
			force_strength = 1.3
			current_atk_mode = SLASH_MODE
			sharpness = SHARP_EDGED
			embedding = list("pain_mult" = 7, "rip_time" = 3, "embed_chance" = 15, "jostle_chance" = 3.2, "pain_stam_pct" = 0.6, "pain_jostle_mult" = 6, "fall_chance" = 1, "ignore_throwspeed_threshold" = TRUE)
*/

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
	hitsound = list('modular_septic/sound/weapons/melee/kukri1.ogg', 'modular_septic/sound/weapons/melee/kukri2.ogg', 'modular_septic/sound/weapons/melee/kukri3.ogg')
	equip_sound = 'modular_septic/sound/weapons/melee/kukri_holster.ogg'
	pickup_sound = 'modular_septic/sound/weapons/melee/kukri_deploy.ogg'
	miss_sound = list('modular_septic/sound/weapons/melee/kukri_swish1.ogg', 'modular_septic/sound/weapons/melee/kukri_swish2.ogg', 'modular_septic/sound/weapons/melee/kukri_swish3.ogg')
	drop_sound = list('modular_septic/sound/weapons/melee/bladedrop1.ogg', 'modular_septic/sound/weapons/melee/bladedrop2.ogg')
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
	drop_sound = list('modular_septic/sound/weapons/melee/bladedrop1.ogg', 'modular_septic/sound/weapons/melee/bladedrop2.ogg')
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

#undef SLASH_MODE
#undef STAB_MODE
#undef BASH_MODE
