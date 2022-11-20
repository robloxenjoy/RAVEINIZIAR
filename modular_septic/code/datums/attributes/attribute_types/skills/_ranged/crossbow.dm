// Crossbow
/datum/attribute/skill/crossbow
	name = "Crossbow"
	desc = "This is the ability to use all types of crossbows, including the pistol crossbow, \
			repeating crossbow, and compound crossbow."
	icon_state = "marksman"
	category = SKILL_CATEGORY_RANGED
	governing_attribute = STAT_DEXTERITY
	default_attributes = list(
		STAT_DEXTERITY = -4,
	)
	difficulty = SKILL_DIFFICULTY_EASY
