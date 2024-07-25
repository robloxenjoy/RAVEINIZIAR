// Pistol
/datum/attribute/skill/pistol
	name = "Pistol"
	desc = "All kinds of handguns, including derringers, pepperboxes, revolvers, and automatics, but not machine pistols."
	icon_state = "marksman"
	category = SKILL_CATEGORY_RANGED
	governing_attribute = STAT_DEXTERITY
	default_attributes = list(
		STAT_DEXTERITY = -4,
		SKILL_GRENADE_LAUNCHER = -4,
		SKILL_GYROC = -4,
		SKILL_LAW = -4,
		SKILL_LMG = -2,
		SKILL_MUSKET = -2,
		SKILL_RIFLE = -2,
		SKILL_SHOTGUN = -2,
		SKILL_SMG = -2,
	)
	difficulty = SKILL_DIFFICULTY_EASY
