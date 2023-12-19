/obj/item
	drop_sound = 'modular_septic/sound/items/drop.ogg'

	/// Sound when missing an attack
	var/miss_sound = 'modular_septic/sound/attack/punchmiss.ogg'
	/// Sound when we parry, if we are able to parry
	var/parry_sound = list('modular_septic/sound/weapons/melee/bladeparry1.ogg', 'modular_septic/sound/weapons/melee/bladeparry2.ogg', 'modular_septic/sound/weapons/melee/bladeparry3.ogg')
	/// Sound when we block, if we are able to block
	var/block_sound = list('modular_septic/sound/weapons/melee/bladeparry1.ogg', 'modular_septic/sound/weapons/melee/bladeparry2.ogg', 'modular_septic/sound/weapons/melee/bladeparry3.ogg')

	// Mutant icon garbage
	var/worn_icon_muzzled = 'modular_septic/icons/mob/clothing/head_muzzled.dmi'
	var/worn_icon_digi = 'modular_septic/icons/mob/clothing/suit_digi.dmi'
	var/worn_icon_taur_snake = 'modular_septic/icons/mob/clothing/suit_taur_snake.dmi'
	var/worn_icon_taur_paw = 'modular_septic/icons/mob/clothing/suit_taur_paw.dmi'
	var/worn_icon_taur_hoof = 'modular_septic/icons/mob/clothing/suit_taur_hoof.dmi'
	var/mutant_variants = NONE

	// Only mattters when worn on the head
	var/fov_shadow_angle = ""

	/// Organ storage component requires this
	var/atom/stored_in

	/// Used for unturning when picked up by a mob
	var/our_angle = 0

	/// How much to remove from edge_protection
	var/edge_protection_penetration = 0
	/// Armour penetration that only applies to subtractible armor
	var/subtractible_armour_penetration = 0
	/// Whether or not our object is easily hindered by the presence of subtractible armor
	var/weak_against_subtractible_armour = FALSE
	/// This is NOT related to armor penetration, and simply works as a bonus for armor damage
	var/armor_damage_modifier = 0

	/// Can it be used for lockpicking?
	var/canlockpick = FALSE
	/// can dig? walls?
	var/can_dig = FALSE
	/// long???
	var/weapon_long = WLENGTH_NORMAL

	/**
	 *  Modifier for block score
	 *
	 * DO NOT SET THIS AS 0 IF YOU DON'T WANT THE ITEM TO ATTEMPT TO BLOCK
	 * SET TO NULL INSTEAD!
	 */
	var/blocking_modifier = null
	/// Flags related to what the fuck we can block (BLOCK_FLAG_LEAP)
	var/blocking_flags = BLOCK_FLAG_MELEE | BLOCK_FLAG_UNARMED | BLOCK_FLAG_THROWN
	/**
	 *  Modifier for parry score
	 *
	 * DO NOT SET THIS AS 0 IF YOU DON'T WANT THE ITEM TO ATTEMPT TO PARRY
	 * SET TO NULL INSTEAD!
	 */
	var/parrying_modifier = null
	/// Flags related to what the fuck we can parry (BLOCK_FLAG_LEAP)
	var/parrying_flags = BLOCK_FLAG_MELEE | BLOCK_FLAG_UNARMED | BLOCK_FLAG_THROWN
	/**
	 *  Modifier for dodge score
	 *
	 * Unlike parrying and blocking, this is not something done by the item itself,
	 * and putting 0 is fine.
	 */
	var/dodging_modifier = 0

	/**
	 * How much fatigue we (normally) take away from the user when attacking with this.
	 *
	 * LEAVING THIS AS NULL WILL CALCULATE A NEW attack_fatigue_cost BASED ON W_CLASS ON INITIALIZE()
	 */
	var/attack_fatigue_cost = null

	/// How much time we (normally) take to recover from attacking with this
	var/attack_delay = CLICK_CD_MELEE

	/// Skill used in melee combat
	var/skill_melee = SKILL_IMPACT_WEAPON
	/// Accuracy modifier for melee combat
	var/melee_modifier = 15
	/// Accuracy modifier for body zone in melee combat
	var/melee_zone_modifier = 15
	/// Skill used in ranged combat
	var/skill_ranged = SKILL_RIFLE
	/// Accuracy modifier for ranged combat
	var/ranged_modifier = 8
	/// Accuracy modifier for body zone in ranged combat
	var/ranged_zone_modifier = 8
	/**
	 * Skill used for blocking
	 *
	 * LEAVING THIS AS NULL WILL MAKE THIS EQUAL TO SKILL_MELEE
	 */
	var/skill_blocking = null
	/**
	 * Skill used for parrying
	 *
	 * LEAVING THIS AS NULL WILL MAKE THIS EQUAL TO SKILL_MELEE
	 */
	var/skill_parrying = null

	/**
	 * This is used to calculate encumbrance on human mobs.
	 *
	 * LEAVING THIS AS NULL WILL CALCULATE A NEW CARRY_WEIGHT BASED ON W_CLASS ON INITIALIZE()
	 */
	var/carry_weight = null

	/// Several flags related to readying behavior
	var/readying_flags = NONE

	// ~TETRIS INVENTORY VARIABLES
	/// Width we occupy on the hud - Keep null to generate based on w_class
	var/tetris_width
	/// Height we occupy on the hud - Keep null to generate based on w_class
	var/tetris_height
