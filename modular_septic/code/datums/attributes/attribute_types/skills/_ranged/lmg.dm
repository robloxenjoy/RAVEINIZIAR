// Light Machine Gun
/datum/attribute/skill/light_machine_gun
	name = "Light Machine Gun "
	desc = "Any machine gun fired from the hip or a bipod."
	icon_state = "marksman"
	category = SKILL_CATEGORY_RANGED
	governing_attribute = STAT_DEXTERITY
	default_attributes = list(
		STAT_DEXTERITY = -4,
		SKILL_GRENADE_LAUNCHER = -4,
		SKILL_GYROC = -4,
		SKILL_LAW = -4,
		SKILL_MUSKET = -2,
		SKILL_PISTOL = -2,
		SKILL_RIFLE = -2,
		SKILL_SHOTGUN = -2,
		SKILL_SMG = -2,
	)
	difficulty = SKILL_DIFFICULTY_EASY
