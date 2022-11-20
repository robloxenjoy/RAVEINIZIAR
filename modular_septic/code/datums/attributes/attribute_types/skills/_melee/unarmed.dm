/**
 * UNARMED COMBAT
 *
 * GURPS has way different rules for unarmed combat, but i kinda don't like them!
 * So i came up with my own interpretation of unarmed combat skills.
 */
/datum/attribute/skill/brawling
	name = "Brawling"
	desc = "Your ability at landing blows in unarmed combat, no matter which limb you are using."
	icon_state = "shortblade"
	category = SKILL_CATEGORY_MELEE
	governing_attribute = STAT_DEXTERITY
	default_attributes = list(
		STAT_DEXTERITY = -3,
	)
	difficulty = SKILL_DIFFICULTY_EASY

/datum/attribute/skill/wrestling
	name = "Wrestling"
	desc = "Your ability at landing and managing grapples in unarmed combat."
	icon_state = "shortblade"
	category = SKILL_CATEGORY_MELEE
	governing_attribute = STAT_DEXTERITY
	default_attributes = list(
		STAT_DEXTERITY = -4,
	)
	difficulty = SKILL_DIFFICULTY_AVERAGE
