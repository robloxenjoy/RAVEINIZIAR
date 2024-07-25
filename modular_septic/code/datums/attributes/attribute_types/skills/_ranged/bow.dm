// Bow
/datum/attribute/skill/bow
	name = "Bow"
	desc = "This is the ability to use the longbow, short bow, and all similar bows. \
			It also covers the compound bow."
	icon_state = "marksman"
	category = SKILL_CATEGORY_RANGED
	governing_attribute = STAT_DEXTERITY
	default_attributes = list(
		STAT_DEXTERITY = -5,
	)
	difficulty = SKILL_DIFFICULTY_AVERAGE
