// General combat skills
/datum/attribute/skill/acrobatics
	name = "Акробатика"
	desc = "Ability at acrobatic maneuvers and climbing obstacles."
	icon_state = "acrobatics"
	category = SKILL_CATEGORY_COMBAT
	governing_attribute = STAT_DEXTERITY
	default_attributes = list(
		STAT_DEXTERITY = -6,
	)
	difficulty = SKILL_DIFFICULTY_HARD

/datum/attribute/skill/swimming
	name = "Плавание"
	desc = "Ability at swimming."
	icon_state = "acrobatics"
	category = SKILL_CATEGORY_COMBAT
	governing_attribute = STAT_DEXTERITY
	default_attributes = list(
		STAT_DEXTERITY = -6,
	)
	difficulty = SKILL_DIFFICULTY_HARD

// Skulduggery skills
/datum/attribute/skill/pickpocket
	name = "Кража"
	desc = "Ability to steal without being noticed."
	icon_state = "sneak"
	category = SKILL_CATEGORY_SKULDUGGERY
	governing_attribute = STAT_DEXTERITY
	default_attributes = list(
		STAT_DEXTERITY = -6,
	)
	difficulty = SKILL_DIFFICULTY_HARD

/datum/attribute/skill/lockpick
	name = "Взлом"
	desc = "Ability at breaking mechanical locks open."
	icon_state = "lockpicking"
	category = SKILL_CATEGORY_SKULDUGGERY
	governing_attribute = STAT_INTELLIGENCE
	default_attributes = list(
		STAT_INTELLIGENCE = -5,
	)
	difficulty = SKILL_DIFFICULTY_AVERAGE

/datum/attribute/skill/forensics
	name = "Криминалистика"
	desc = "Proficiency at analyzing the clues and tracks of your enemies."
	icon_state = "illusion"
	category = SKILL_CATEGORY_SKULDUGGERY
	governing_attribute = STAT_INTELLIGENCE
	default_attributes = list(
		STAT_PERCEPTION = -6,
	)
	difficulty = SKILL_DIFFICULTY_EASY

// Medical skills
/datum/attribute/skill/medicine
	name = "Медицина"
	desc = "Proficiency at diagnosis and treatment of physical ailments, and handling of medical instruments."
	icon_state = "restoration"
	category = SKILL_CATEGORY_MEDICAL
	governing_attribute = STAT_INTELLIGENCE
	default_attributes = list(
		STAT_INTELLIGENCE = -6,
	)
	difficulty = SKILL_DIFFICULTY_EASY

/datum/attribute/skill/surgery
	name = "Хирургия"
	desc = "Knowledge in anatomy, as well as surgical procedures and tools."
	icon_state = "alteration"
	category = SKILL_CATEGORY_MEDICAL
	governing_attribute = STAT_INTELLIGENCE
	default_attributes = list(
		SKILL_MEDICINE = -8,
	)
	difficulty = SKILL_DIFFICULTY_HARD

// Engineering skills
/datum/attribute/skill/masonry
	name = "Крафт"
	desc = "Ability to create something."
	icon_state = "smithing"
	category = SKILL_CATEGORY_ENGINEERING
	governing_attribute = STAT_INTELLIGENCE
	default_attributes = list(
		STAT_INTELLIGENCE = -4,
	)
	difficulty = SKILL_DIFFICULTY_EASY

/datum/attribute/skill/smithing
	name = "Кузнечное дело"
	desc = "Ability to create weapons, armor and other items out of metal."
	icon_state = "smithing"
	category = SKILL_CATEGORY_ENGINEERING
	governing_attribute = STAT_INTELLIGENCE
	default_attributes = list(
		STAT_INTELLIGENCE = -5,
	)
	difficulty = SKILL_DIFFICULTY_AVERAGE

/datum/attribute/skill/electronics
	name = "Электроника"
	desc = "Ability at handling, hacking and repairing electrical machinery and wiring."
	icon_state = "smithing"
	category = SKILL_CATEGORY_ENGINEERING
	governing_attribute = STAT_INTELLIGENCE
	default_attributes = list(
		STAT_INTELLIGENCE = -5,
	)
	difficulty = SKILL_DIFFICULTY_AVERAGE

// Research skills
/datum/attribute/skill/science
	name = "Наука"
	desc = "Comprehension, research, experimentation and creation of complex technology."
	icon_state = "mysticism"
	category = SKILL_CATEGORY_RESEARCH
	governing_attribute = STAT_INTELLIGENCE
	default_attributes = list(
		STAT_INTELLIGENCE = -6,
	)
	difficulty = SKILL_DIFFICULTY_HARD

/datum/attribute/skill/alchemistry
	name = "Ал-химия"
	desc = "Capability at handling chemicals and al-chemical reactions."
	icon_state = "alchemy"
	category = SKILL_CATEGORY_RESEARCH
	governing_attribute = STAT_INTELLIGENCE
	default_attributes = list(
		STAT_INTELLIGENCE = -6,
	)
	difficulty = SKILL_DIFFICULTY_HARD

// Domestic skills
/datum/attribute/skill/culinary
	name = "Кулинария"
	desc = "Ability at preparing and cooking food."
	icon_state = "alchemy"
	category = SKILL_CATEGORY_DOMESTIC
	governing_attribute = STAT_INTELLIGENCE
	default_attributes = list(
		STAT_INTELLIGENCE = -5,
		SKILL_CLEANING = -5,
	)
	difficulty = SKILL_DIFFICULTY_AVERAGE

/datum/attribute/skill/agriculture
	name = "Земледелие"
	desc = "Ability at planting and harvesting produce."
	icon_state = "alchemy"
	category = SKILL_CATEGORY_DOMESTIC
	governing_attribute = STAT_INTELLIGENCE
	default_attributes = list(
		STAT_INTELLIGENCE = -5,
	)
	difficulty = SKILL_DIFFICULTY_AVERAGE

/datum/attribute/skill/cleaning
	name = "Домашний очаг"
	desc = "This is the ability to manage a household. It covers both home economics and domestic chores like cleaning."
	icon_state = "athletics"
	category = SKILL_CATEGORY_DOMESTIC
	governing_attribute = STAT_INTELLIGENCE
	default_attributes = list(
		STAT_INTELLIGENCE = -4,
	)
	difficulty = SKILL_DIFFICULTY_EASY

// Dumb meme skills
/datum/attribute/skill/gaming
	name = "Гейминг"
	desc = "Ability at getting totally EPIC kill streaks in fortnight. \
		Applies as competence in both video games, board games and puzzles."
	icon_state = "unarmored"
	category = SKILL_CATEGORY_DUMB
	governing_attribute = STAT_INTELLIGENCE
	default_attributes = list(
		STAT_INTELLIGENCE = -4,
	)
	difficulty = SKILL_DIFFICULTY_EASY
