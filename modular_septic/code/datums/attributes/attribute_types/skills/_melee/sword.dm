/**
 * SWORD WEAPONS
 *
 * A sword is a rigid, hilted blade with a thrusting point, cutting edge, or both.
 * All swords are balanced, and can attack and parry without becoming unready.
 */
/datum/attribute/skill/force_sword
	name = "Force Sword"
	desc = "Any sword with a \"blade\" made of energy, liquid, gas or plasma instead of solid matter. \
			This generally refers to a high-tech weapon that project energy from a powered hilt, \
			but extends to similar effects produced using magic or psionics."
	icon_state = "longblade"
	category = SKILL_CATEGORY_MELEE
	governing_attribute = STAT_DEXTERITY
	default_attributes = list(
		STAT_DEXTERITY = -5,
		SKILL_SWORD_TWOHANDED = -3,
		SKILL_LONGSWORD = -3,
		SKILL_SHORTSWORD = -3,
		SKILL_KNIFE = -3,
	)
	difficulty = SKILL_DIFFICULTY_AVERAGE

/datum/attribute/skill/sword_twohanded
	name = "Two-Handed Sword"
	desc = "Any balanced, two-handed blade over 4 feet in length: greatswords, zweihanders, etc. \
			This skill also covers quarterstaffs wielded like swords, as well as bastard swords, katanas, and longswords used two-handed."
	icon_state = "longblade"
	category = SKILL_CATEGORY_MELEE
	governing_attribute = STAT_DEXTERITY
	default_attributes = list(
		STAT_DEXTERITY = -5,
		SKILL_FORCESWORD = -4,
		SKILL_LONGSWORD = -4,
	)
	difficulty = SKILL_DIFFICULTY_AVERAGE

/datum/attribute/skill/longsword
	name = "Longsword"
	desc = "Any balanced, 0.6 to 1.2 meter blade wielded in one hand – Broadsword, cavalry saber, \
			etc. This skill also covers any staff or club of similar size and balance to these blades, \
			as well as bastard swords, katanas, and longswords used one-handed."
	icon_state = "longblade"
	category = SKILL_CATEGORY_MELEE
	governing_attribute = STAT_DEXTERITY
	default_attributes = list(
		STAT_DEXTERITY = -5,
		SKILL_SWORD_TWOHANDED = -4,
		SKILL_FORCESWORD = -4,
		SKILL_RAPIER = -4,
		SKILL_SHORTSWORD = -2,
	)
	difficulty = SKILL_DIFFICULTY_AVERAGE

/datum/attribute/skill/shortsword
	name = "Shortsword"
	desc = "Any balanced, one-handed weapon 0.3 to 0.6 meters in length – \
			Including the shortsword and any club of comparable size and balance (such as a police baton)."
	icon_state = "shortblade"
	category = SKILL_CATEGORY_MELEE
	governing_attribute = STAT_DEXTERITY
	default_attributes = list(
		STAT_DEXTERITY = -5,
		SKILL_FORCESWORD = -4,
		SKILL_RAPIER = -4,
		SKILL_KNIFE = -4,
		SKILL_LONGSWORD = -2,
	)
	difficulty = SKILL_DIFFICULTY_AVERAGE

/datum/attribute/skill/knife
	name = "Knife"
	desc = "Any rigid, hilted blade less than one foot long, from a pocket knife to a bowie knife. \
			A knife has a very small parrying surface, which gives you -1 to your parry score."
	icon_state = "shortblade"
	category = SKILL_CATEGORY_MELEE
	governing_attribute = STAT_DEXTERITY
	default_attributes = list(
		STAT_DEXTERITY = -4,
		SKILL_FORCESWORD = -3,
		SKILL_SHORTSWORD = -3,
	)
	difficulty = SKILL_DIFFICULTY_AVERAGE
