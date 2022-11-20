/**
 * SHIELD
 *
 *
 * This is the ability to use a shield, both to block and to attack.
 * Your active defense with any kind of shield – your Block score – is (skill/2) + 3, rounded down.
 */
/datum/attribute/skill/shield
	name = "Shield"
	desc = "Any shield worn in place with straps. \
			Such shields have the advantage that you can hold (but not wield) something in your shield hand, \
			but the disadvantage of being slow to put on or take off."
	icon_state = "block"
	category = SKILL_CATEGORY_BLOCKING
	governing_attribute = STAT_DEXTERITY
	default_attributes = list(
		STAT_DEXTERITY = -4,
		SKILL_BUCKLER = -2,
	)
	difficulty = SKILL_DIFFICULTY_EASY

/datum/attribute/skill/buckler
	name = "Buckler"
	desc = "Any kind of shield, usually a small one, held in the hand. \
			A buckler occupies one hand completely, but is generally lighter and faster to equip."
	icon_state = "block"
	category = SKILL_CATEGORY_BLOCKING
	governing_attribute = STAT_DEXTERITY
	default_attributes = list(
		STAT_DEXTERITY = -4,
		SKILL_SHIELD = -2,
	)
	difficulty = SKILL_DIFFICULTY_EASY

/datum/attribute/skill/force_shield
	name = "Force Shield"
	desc = "Any shield with a blocking \"surface\" formed from liquid, gas or plasma rather than solid matter."
	icon_state = "block"
	category = SKILL_CATEGORY_BLOCKING
	default_attributes = list(
		STAT_DEXTERITY = -4,
	)
	difficulty = SKILL_DIFFICULTY_EASY
