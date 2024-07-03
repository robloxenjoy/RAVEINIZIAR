//Assistant
/datum/attribute_holder/sheet/job/beggar
	attribute_variance = list(
		STAT_STRENGTH = list(-4, -2),
		STAT_ENDURANCE = list(-4, -2),
		STAT_DEXTERITY = list(-3, -2),
		STAT_INTELLIGENCE = list(-3, -2),
		SKILL_BRAWLING = list(-2, 1),
		SKILL_WRESTLING = list(-2, 3),
		SKILL_KNIFE = list(-2, 0),
		SKILL_GAMING = list(-2, 2),
	)
	raw_attribute_list = list(
		SKILL_BRAWLING = -2,
		SKILL_WRESTLING = -2,
		SKILL_KNIFE = -2,
		SKILL_GAMING = 0,
	)

//Atmos tech/Engineer
/datum/attribute_holder/sheet/job/engineer
	attribute_variance = list(
		STAT_STRENGTH = list(-1, 3),
		STAT_ENDURANCE = list(-1, 2),
		STAT_DEXTERITY = list(-3, 0),
		STAT_INTELLIGENCE = list(-1, 3),
		SKILL_BRAWLING = list(-1, 3),
		SKILL_WRESTLING = list(-1, 3),
		SKILL_IMPACT_WEAPON = list(-1, 3),
		SKILL_SHOTGUN = list(-1, 1),
		SKILL_ELECTRONICS = list(-2, 1),
		SKILL_MASONRY = list(-2, 2),
		SKILL_SMITHING = list(-1, 2),
		SKILL_LOCKPICKING = list(-2, 2),
		SKILL_ACROBATICS = list(-2, 2),
	)
	raw_attribute_list = list(
		SKILL_BRAWLING = -1,
		SKILL_WRESTLING = -1,
		SKILL_IMPACT_WEAPON = -1,
		SKILL_SHOTGUN = -2,
		SKILL_ELECTRONICS = 4,
		SKILL_MASONRY = 4,
		SKILL_SMITHING = -2,
		SKILL_LOCKPICKING = 2,
		SKILL_ACROBATICS = 6,
	)

//Bartender
/datum/attribute_holder/sheet/job/innkeeper
	attribute_variance = list(
		STAT_STRENGTH = list(-1, 3),
		STAT_ENDURANCE = list(1, 2),
		STAT_DEXTERITY = list(-2, 0),
		STAT_INTELLIGENCE = list(-2, 1),
		SKILL_WRESTLING = list(-1, 2),
		SKILL_BRAWLING = list(-2, 2),
		SKILL_IMPACT_WEAPON = list(-1, 2),
		SKILL_SHOTGUN = list(-1, 2),
		SKILL_THROWING = list(-2, 2),
		SKILL_ALCHEMISTRY = list(-2, 2),
		SKILL_COOKING = list(-3, 4),
		SKILL_CLEANING = list(0, 2),
	)
	raw_attribute_list = list(
		SKILL_BRAWLING = 0,
		SKILL_WRESTLING = -2,
		SKILL_IMPACT_WEAPON = -2,
		SKILL_SHOTGUN = -2,
		SKILL_THROWING = -3,
		SKILL_ALCHEMISTRY = 0,
		SKILL_COOKING = 2,
		SKILL_CLEANING = 0,
	)

//Botanist (Formerly Chuck's)
/datum/attribute_holder/sheet/job/farmer
	attribute_variance = list(
		STAT_STRENGTH = list(-1, 3),
		STAT_ENDURANCE = list(-1, 2),
		STAT_DEXTERITY = list(-3, 0),
		STAT_INTELLIGENCE = list(-2, 2),
		SKILL_IMPACT_WEAPON = list(-2, 2),
		SKILL_SHOTGUN = list(-2, 1),
		SKILL_BRAWLING = list(-1, 2),
		SKILL_COOKING = list(-4, 2),
		SKILL_BOTANY = list(-4, 2),
		SKILL_CLEANING = list(-2, 2),
	)
	raw_attribute_list = list(
		SKILL_IMPACT_WEAPON = -2,
		SKILL_SHOTGUN = -4,
		SKILL_BRAWLING = -3,
		SKILL_WRESTLING = 4,
		SKILL_COOKING = 2,
		SKILL_BOTANY = 5,
		SKILL_CLEANING = 0,
	)

//Captain
/datum/attribute_holder/sheet/job/doge
	attribute_variance = list(
		STAT_STRENGTH = list(-1, 3),
		STAT_ENDURANCE = list(-1, 3),
		STAT_DEXTERITY = list(-1, 3),
		STAT_INTELLIGENCE = list(-3, 1),
		SKILL_IMPACT_WEAPON = list(-4, 3),
		SKILL_WRESTLING = list(-1, 2),
		SKILL_BRAWLING = list(-1, 2),
		SKILL_PISTOL = list(-3, 3),
		SKILL_SMG = list(-4, 4),
		SKILL_RIFLE = list(-4, 4),
		SKILL_RAPIER = list(-2, 2),
		SKILL_SHORTSWORD = list(-3, 3),
		SKILL_LONGSWORD = list(-3, 3),
		SKILL_THROWING = list(-1, 3),
		SKILL_CLEANING = list(-2, 2),
		SKILL_MEDICINE = list(-3, 2),
		SKILL_LOCKPICKING = list(-2, 2),
		SKILL_ACROBATICS = list(-2, 4),
	)
	raw_attribute_list = list(
		SKILL_IMPACT_WEAPON = 4,
		SKILL_PISTOL = 4,
		SKILL_RAPIER = 5,
		SKILL_LONGSWORD = 0,
		SKILL_SHORTSWORD = 0,
		SKILL_BRAWLING = -2,
		SKILL_WRESTLING = -2,
		SKILL_SMG = 0,
		SKILL_RIFLE = 0,
		SKILL_THROWING = -3,
		SKILL_CLEANING = 0,
		SKILL_MEDICINE = 0,
		SKILL_LOCKPICKING = -2,
		SKILL_ACROBATICS = 4,
	)

//Cargo tech
/datum/attribute_holder/sheet/job/freighter
	attribute_variance = list(
		STAT_STRENGTH = list(-1, 2),
		STAT_ENDURANCE = list(-1, 2),
		STAT_DEXTERITY = list(-3, 1),
		STAT_INTELLIGENCE = list(-2, 1),
		SKILL_IMPACT_WEAPON = list(-1, 3),
		SKILL_BRAWLING = list(-1, 1),
		SKILL_WRESTLING = list(-1, 1),
		SKILL_KNIFE = list(-2, 2),
		SKILL_PISTOL = list(-2, 1),
		SKILL_CLEANING = list(-2, 2),
		SKILL_MASONRY = list(-2, 2),
		SKILL_SCIENCE = list(-1, 1),
		SKILL_PICKPOCKET = list(-2, 2),
		SKILL_LOCKPICKING = list(-2, 2),
	)
	raw_attribute_list = list(
		SKILL_IMPACT_WEAPON = 0,
		SKILL_PISTOL = 0,
		SKILL_KNIFE = -2,
		SKILL_BRAWLING = -3,
		SKILL_WRESTLING = -3,
		SKILL_CLEANING = -2,
		SKILL_MASONRY = -3,
		SKILL_SCIENCE = -3,
		SKILL_PICKPOCKET = -2,
		SKILL_LOCKPICKING = -2,
	)

//Chaplain
/datum/attribute_holder/sheet/job/chaplain
	attribute_variance = list(
		STAT_STRENGTH = list(-2, 2),
		STAT_ENDURANCE = list(-2, 2),
		STAT_DEXTERITY = list(-1, 3),
		STAT_INTELLIGENCE = list(0, 3),
		SKILL_IMPACT_WEAPON = list(-1, 2),
		SKILL_THROWING = list(-2, 1),
		SKILL_MEDICINE = list(-1, 1),
		SKILL_COOKING = list(-1, 2),
		SKILL_CLEANING = list(-1, 2),
	)
	raw_attribute_list = list(
		SKILL_IMPACT_WEAPON = -2,
		SKILL_THROWING = -2,
		SKILL_MEDICINE = -2,
		SKILL_COOKING = -2,
		SKILL_CLEANING = -2,
	)

//Chemist
/datum/attribute_holder/sheet/job/apothecary
	attribute_variance = list(
		STAT_STRENGTH = list(-2, 1),
		STAT_ENDURANCE = list(-2, 2),
		STAT_DEXTERITY = list(-1, 2),
		STAT_INTELLIGENCE = list(0, 3),
		SKILL_BRAWLING = list(-1, 2),
		SKILL_WRESTLING = list(-1, 2),
		SKILL_KNIFE = list(0, 2),
		SKILL_PISTOL = list(0, 1),
		SKILL_THROWING = list(-1, 2),
		SKILL_ALCHEMISTRY = list(-1, 2),
		SKILL_MEDICINE = list(-2, 2),
		SKILL_SCIENCE = list(0, 1),
	)
	raw_attribute_list = list(
		SKILL_BRAWLING = -2,
		SKILL_WRESTLING = -2,
		SKILL_KNIFE = -3,
		SKILL_PISTOL = -3,
		SKILL_THROWING = -2,
		SKILL_ALCHEMISTRY = 6,
		SKILL_MEDICINE = 1,
		SKILL_SCIENCE = 0,
	)

//Chief engineer
/datum/attribute_holder/sheet/job/chief_engi
	attribute_variance = list(
		STAT_STRENGTH = list(-1, 3),
		STAT_ENDURANCE = list(-1, 3),
		STAT_DEXTERITY = list(-2, 1),
		STAT_INTELLIGENCE = list(-1, 4),
		SKILL_IMPACT_WEAPON = list(-2, 2),
		SKILL_IMPACT_WEAPON_TWOHANDED = list(-2, 2),
		SKILL_BRAWLING = list(-1, 2),
		SKILL_WRESTLING = list(-1, 2),
		SKILL_PISTOL = list(-2, 2),
		SKILL_SHOTGUN = list(-2, 2),
		SKILL_POLEARM = list(0, 3),
		SKILL_ELECTRONICS = list(-2, 3),
		SKILL_MASONRY = list(-2, 3),
		SKILL_SMITHING = list(-2, 4),
		SKILL_LOCKPICKING = list(-2, 2),
		SKILL_ACROBATICS = list(-1, 2),
	)
	raw_attribute_list = list(
		SKILL_IMPACT_WEAPON = 0,
		SKILL_IMPACT_WEAPON_TWOHANDED = 0,
		SKILL_PISTOL = 2,
		SKILL_SHOTGUN = 0,
		SKILL_BRAWLING = 0,
		SKILL_WRESTLING = 0,
		SKILL_POLEARM = -3,
		SKILL_ELECTRONICS = 6,
		SKILL_MASONRY = 6,
		SKILL_SMITHING = -2,
		SKILL_LOCKPICKING = -2,
		SKILL_ACROBATICS = -2,
	)

//CMO
/datum/attribute_holder/sheet/job/hippocrite
	attribute_variance = list(
		STAT_STRENGTH = list(-2, 1),
		STAT_ENDURANCE = list(-2, 1),
		STAT_DEXTERITY = list(-2, 4),
		STAT_INTELLIGENCE = list(-1, 4),
		SKILL_WRESTLING = list(-1, 1),
		SKILL_BRAWLING = list(-1, 1),
		SKILL_PISTOL = list(-1, 1),
		SKILL_KNIFE = list(-2, 2),
		SKILL_IMPACT_WEAPON = list(-1, 1),
		SKILL_THROWING = list(-2, 2),
		SKILL_ALCHEMISTRY = list(-2, 2),
		SKILL_MEDICINE = list(-2, 2),
		SKILL_SURGERY = list(-2, 2),
		SKILL_SCIENCE = list(-2, 2),
	)
	raw_attribute_list = list(
		SKILL_BRAWLING = -3,
		SKILL_WRESTLING = -2,
		SKILL_PISTOL = -2,
		SKILL_KNIFE = 2,
		SKILL_IMPACT_WEAPON = -2,
		SKILL_THROWING = 0,
		SKILL_ALCHEMISTRY = 0,
		SKILL_MEDICINE = 6,
		SKILL_SURGERY = 6,
		SKILL_SCIENCE = 0,
	)

//Clown and mime
/datum/attribute_holder/sheet/job/jester
	attribute_variance = list(
		STAT_STRENGTH = list(-6, 6),
		STAT_ENDURANCE = list(-6, 6),
		STAT_DEXTERITY = list(-6, 6),
		STAT_INTELLIGENCE = list(-6, 6),
		SKILL_BRAWLING = list(-6, 2),
		SKILL_WRESTLING = list(-8, 2),
		SKILL_IMPACT_WEAPON = list(-6, 2),
		SKILL_POLEARM = list(-4, 2),
		SKILL_STAFF = list(-2, 2),
		SKILL_FLAIL = list(-4, 4),
		SKILL_FLAIL_TWOHANDED = list(-4, 4),
		SKILL_THROWING = list(-2, 4),
		SKILL_PICKPOCKET = list(-2, 4),
		SKILL_GAMING = list(-1, 4),
	)
	raw_attribute_list = list(
		SKILL_BRAWLING = 0,
		SKILL_WRESTLING = 0,
		SKILL_IMPACT_WEAPON = 0,
		SKILL_POLEARM = 0,
		SKILL_STAFF = -2,
		SKILL_FLAIL = -2,
		SKILL_FLAIL_TWOHANDED = 0,
		SKILL_THROWING = 2,
		SKILL_PICKPOCKET = 0,
		SKILL_GAMING = 4,
	)

//Chef
/datum/attribute_holder/sheet/job/chef
	attribute_variance = list(
		STAT_STRENGTH = list(-1, 3),
		STAT_ENDURANCE = list(-1, 2),
		STAT_DEXTERITY = list(-1, 2),
		STAT_INTELLIGENCE = list(-2, 2),
		SKILL_BRAWLING = list(-2, 2),
		SKILL_WRESTLING = list(-2, 2),
		SKILL_IMPACT_WEAPON = list(-2, 2),
		SKILL_SHOTGUN = list(-2, 2),
		SKILL_COOKING = list(-2, 4),
		SKILL_BOTANY = list(-2, 4),
		SKILL_CLEANING = list(-2, 4),
	)
	raw_attribute_list = list(
		SKILL_BRAWLING = 0,
		SKILL_WRESTLING = -2,
		SKILL_IMPACT_WEAPON = 0,
		SKILL_SHOTGUN = -2,
		SKILL_COOKING = 6,
		SKILL_BOTANY = 0,
		SKILL_CLEANING = 0,
	)

//Geneticist / Medical Doctor
/datum/attribute_holder/sheet/job/humorist
	attribute_variance = list(
		STAT_STRENGTH = list(-1, 1),
		STAT_ENDURANCE = list(-1, 2),
		STAT_DEXTERITY = list(1, 3),
		STAT_INTELLIGENCE = list(-1, 3),
		SKILL_BRAWLING = list(-2, 1),
		SKILL_WRESTLING = list(-2, 1),
		SKILL_KNIFE = list(-2, 2),
		SKILL_THROWING = list(-3, 1),
		SKILL_PISTOL = list(-2, 2),
		SKILL_ALCHEMISTRY = list(-1, 2),
		SKILL_MEDICINE = list(-1, 3),
		SKILL_SURGERY = list(-1, 3),
		SKILL_SCIENCE = list(-2, 1),
	)
	raw_attribute_list = list(
		SKILL_BRAWLING = -1,
		SKILL_WRESTLING = -1,
		SKILL_KNIFE = -1,
		SKILL_THROWING = -1,
		SKILL_PISTOL = -3,
		SKILL_ALCHEMISTRY = -2,
		SKILL_MEDICINE = 2,
		SKILL_SURGERY = 2,
		SKILL_SCIENCE = -2,
	)

//Head of personnel
/datum/attribute_holder/sheet/job/gatekeeper
	attribute_variance = list(
		STAT_STRENGTH = list(-1, 2),
		STAT_ENDURANCE = list(-1, 2),
		STAT_DEXTERITY = list(-1, 2),
		STAT_INTELLIGENCE = list(-1, 2),
		SKILL_BRAWLING = list(-1, 2),
		SKILL_WRESTLING = list(-1, 2),
		SKILL_SMG = list(-2, 4),
		SKILL_PISTOL = list(-2, 2),
		SKILL_RAPIER = list(-2, 2),
		SKILL_SHORTSWORD = list(-2, 1),
		SKILL_THROWING = list(-2, 2),
		SKILL_PICKPOCKET = list(-3, 2),
		SKILL_LOCKPICKING = list(-2, 2),
		SKILL_SCIENCE = list(-2, 1),
		SKILL_ACROBATICS = list(-1, 3),
	)
	raw_attribute_list = list(
		SKILL_BRAWLING = -2,
		SKILL_WRESTLING = -2,
		SKILL_IMPACT_WEAPON = -2,
		SKILL_SMG = 0,
		SKILL_PISTOL = 0,
		SKILL_RAPIER = 0,
		SKILL_SHORTSWORD = 0,
		SKILL_THROWING = -3,
		SKILL_PICKPOCKET = -2,
		SKILL_LOCKPICKING = -2,
		SKILL_SCIENCE = -3,
		SKILL_ACROBATICS = -3,
	)

//Head of security
/datum/attribute_holder/sheet/job/coordinator
	attribute_variance = list(
		STAT_STRENGTH = list(0, 5),
		STAT_ENDURANCE = list(0, 5),
		STAT_DEXTERITY = list(-2, 3),
		STAT_INTELLIGENCE = list(-2, -1),
		SKILL_BRAWLING = list(-1, 3),
		SKILL_WRESTLING = list(-1, 3),
		SKILL_SHOTGUN = list(-2, 2),
		SKILL_RIFLE = list(-2, 2),
		SKILL_PISTOL = list(-2, 2),
		SKILL_SMG = list(-2, 2),
		SKILL_LAW = list(-1, 1),
		SKILL_KNIFE = list(-2, 2),
		SKILL_RAPIER = list(-2, 3),
		SKILL_LONGSWORD = list(-1, 2),
		SKILL_FORCESWORD = list(-1, 2),
		SKILL_IMPACT_WEAPON = list(-2, 3),
		SKILL_IMPACT_WEAPON_TWOHANDED = list(-1, 3),
		SKILL_SWORD_TWOHANDED = list(0, 3),
		SKILL_THROWING = list(-2, 2),
		SKILL_FORENSICS = list(-3, 2),
		SKILL_ACROBATICS = list(-3, 3),
	)
	raw_attribute_list = list(
		SKILL_BRAWLING = 2,
		SKILL_WRESTLING = 2,
		SKILL_SHOTGUN = 2,
		SKILL_RIFLE = 4,
		SKILL_PISTOL = 4,
		SKILL_SMG = 4,
		SKILL_LAW = 0,
		SKILL_KNIFE = 1,
		SKILL_RAPIER = 1,
		SKILL_LONGSWORD = 2,
		SKILL_FORCESWORD = -3,
		SKILL_IMPACT_WEAPON = 2,
		SKILL_IMPACT_WEAPON_TWOHANDED = 0,
		SKILL_SWORD_TWOHANDED = 0,
		SKILL_THROWING = 2,
		SKILL_FORENSICS = 2,
		SKILL_ACROBATICS = 0,
	)

//Security officer
/datum/attribute_holder/sheet/job/ordinator
	attribute_variance = list(
		STAT_STRENGTH = list(0, 3),
		STAT_ENDURANCE = list(0, 3),
		STAT_DEXTERITY = list(0, 2),
		STAT_INTELLIGENCE = list(-3, 0),
		SKILL_BRAWLING = list(-1, 2),
		SKILL_WRESTLING = list(-1, 2),
		SKILL_IMPACT_WEAPON = list(-1, 2),
		SKILL_IMPACT_WEAPON_TWOHANDED = list(-2, 2),
		SKILL_KNIFE = list(-2, 2),
		SKILL_SMG = list(-2, 2),
		SKILL_PISTOL = list(-2, 2),
		SKILL_SHOTGUN = list(-3, 3),
		SKILL_RIFLE = list(-2, 2),
		SKILL_LONGSWORD = list(-2, 2),
		SKILL_FORCESWORD = list(-2, 2),
		SKILL_THROWING = list(-4, 2),
		SKILL_FORENSICS = list(-2, 2),
		SKILL_ACROBATICS = list(-2, 2),
	)
	raw_attribute_list = list(
		SKILL_BRAWLING = 0,
		SKILL_WRESTLING = 0,
		SKILL_IMPACT_WEAPON = 2,
		SKILL_IMPACT_WEAPON_TWOHANDED = 0,
		SKILL_KNIFE = 0,
		SKILL_SMG = 3,
		SKILL_PISTOL = 2,
		SKILL_SHOTGUN = 0,
		SKILL_RIFLE = 2,
		SKILL_LONGSWORD = 1,
		SKILL_FORCESWORD = -2,
		SKILL_THROWING = 2,
		SKILL_FORENSICS = -2,
		SKILL_ACROBATICS = 3,
	)

//Constable
/datum/attribute_holder/sheet/job/constable
	attribute_variance = list(
		STAT_STRENGTH = list(0, 5),
		STAT_ENDURANCE = list(0, 5),
		STAT_DEXTERITY = list(-2, 3),
		STAT_INTELLIGENCE = list(-2, -1),
		SKILL_BRAWLING = list(-1, 3),
		SKILL_WRESTLING = list(-1, 3),
		SKILL_SHOTGUN = list(-2, 2),
		SKILL_RIFLE = list(-2, 2),
		SKILL_PISTOL = list(-2, 2),
		SKILL_SMG = list(-2, 2),
		SKILL_LAW = list(-1, 1),
		SKILL_KNIFE = list(-2, 2),
		SKILL_RAPIER = list(-2, 3),
		SKILL_LONGSWORD = list(-1, 2),
		SKILL_FORCESWORD = list(-1, 2),
		SKILL_IMPACT_WEAPON = list(-2, 3),
		SKILL_IMPACT_WEAPON_TWOHANDED = list(-1, 3),
		SKILL_SWORD_TWOHANDED = list(0, 3),
		SKILL_THROWING = list(-2, 2),
		SKILL_FORENSICS = list(-3, 2),
		SKILL_ACROBATICS = list(-3, 3),
	)
	raw_attribute_list = list(
		SKILL_BRAWLING = 2,
		SKILL_WRESTLING = 2,
		SKILL_SHOTGUN = 2,
		SKILL_RIFLE = 4,
		SKILL_PISTOL = 4,
		SKILL_SMG = 4,
		SKILL_LAW = 0,
		SKILL_KNIFE = 1,
		SKILL_RAPIER = 1,
		SKILL_LONGSWORD = 2,
		SKILL_FORCESWORD = -3,
		SKILL_IMPACT_WEAPON = 2,
		SKILL_IMPACT_WEAPON_TWOHANDED = 0,
		SKILL_SWORD_TWOHANDED = 0,
		SKILL_THROWING = 2,
		SKILL_FORENSICS = 2,
		SKILL_ACROBATICS = 0,
	)

//Detective
/datum/attribute_holder/sheet/job/bobby
	attribute_variance = list(
		STAT_STRENGTH = list(0, 3),
		STAT_ENDURANCE = list(0, 3),
		STAT_DEXTERITY = list(-2, 2),
		STAT_INTELLIGENCE = list(-3, 0),
		SKILL_BRAWLING = list(-1, 2),
		SKILL_WRESTLING = list(-1, 2),
		SKILL_IMPACT_WEAPON = list(-1, 2),
		SKILL_IMPACT_WEAPON_TWOHANDED = list(-2, 2),
		SKILL_KNIFE = list(-2, 2),
		SKILL_SMG = list(-2, 2),
		SKILL_PISTOL = list(-2, 2),
		SKILL_SHOTGUN = list(-3, 3),
		SKILL_RIFLE = list(-2, 2),
		SKILL_LONGSWORD = list(-2, 2),
		SKILL_FORCESWORD = list(-2, 2),
		SKILL_THROWING = list(-4, 2),
		SKILL_FORENSICS = list(-2, 2),
		SKILL_ACROBATICS = list(-2, 2),
	)
	raw_attribute_list = list(
		SKILL_BRAWLING = 0,
		SKILL_WRESTLING = 0,
		SKILL_IMPACT_WEAPON = 2,
		SKILL_IMPACT_WEAPON_TWOHANDED = 0,
		SKILL_KNIFE = 0,
		SKILL_SMG = 3,
		SKILL_PISTOL = 2,
		SKILL_SHOTGUN = 0,
		SKILL_RIFLE = 2,
		SKILL_LONGSWORD = 1,
		SKILL_FORCESWORD = -2,
		SKILL_THROWING = 2,
		SKILL_FORENSICS = -2,
		SKILL_ACROBATICS = 3,
	)

//Janitor
/datum/attribute_holder/sheet/job/janitor
	attribute_variance = list(
		STAT_STRENGTH = list(-1, 2),
		STAT_ENDURANCE = list(-1, 3),
		STAT_DEXTERITY = list(-2, 1),
		STAT_INTELLIGENCE = list(-3, 2),
		SKILL_BRAWLING = list(-2, 2),
		SKILL_WRESTLING = list(-2, 2),
		SKILL_MASONRY = list(-3, 1),
		SKILL_IMPACT_WEAPON = list(-2, 2),
		SKILL_IMPACT_WEAPON_TWOHANDED = list(-2, 2),
		SKILL_THROWING = list(-2, 2),
		SKILL_ACROBATICS = list(-2, 2),
		SKILL_CLEANING = list(-2, 2),
	)
	raw_attribute_list = list(
		SKILL_BRAWLING = -1,
		SKILL_WRESTLING = -1,
		SKILL_MASONRY = 0,
		SKILL_IMPACT_WEAPON = -2,
		SKILL_IMPACT_WEAPON_TWOHANDED = -2,
		SKILL_THROWING = -2,
		SKILL_ACROBATICS = -2,
		SKILL_CLEANING = 4,
	)

//Paramedic
/datum/attribute_holder/sheet/job/paramedic
	attribute_variance = list(
		STAT_STRENGTH = list(-1, 3),
		STAT_ENDURANCE = list(-1, 3),
		STAT_DEXTERITY = list(-2, 1),
		STAT_INTELLIGENCE = list(-2, 1),
		SKILL_BRAWLING = list(-1, 3),
		SKILL_WRESTLING = list(-1, 3),
		SKILL_IMPACT_WEAPON = list(-2, 2),
		SKILL_THROWING = list(-1, 2),
		SKILL_PISTOL = list(-2, 2),
		SKILL_ALCHEMISTRY = list(-2, 2),
		SKILL_MEDICINE = list(-3, 3),
		SKILL_SURGERY = list(-2, 2),
	)
	raw_attribute_list = list(
		SKILL_BRAWLING = 0,
		SKILL_WRESTLING = 0,
		SKILL_IMPACT_WEAPON = 0,
		SKILL_THROWING = -3,
		SKILL_PISTOL = 0,
		SKILL_ALCHEMISTRY = -3,
		SKILL_MEDICINE = 4,
		SKILL_SURGERY = -2,
	)

//Quartermaster
/datum/attribute_holder/sheet/job/merchant
	attribute_variance = list(
		STAT_STRENGTH = list(-2, 1),
		STAT_ENDURANCE = list(-2, 1),
		STAT_DEXTERITY = list(-1, 3),
		STAT_INTELLIGENCE = list(-1, 3),
		SKILL_BRAWLING = list(-2, 2),
		SKILL_WRESTLING = list(-2, 2),
		SKILL_IMPACT_WEAPON = list(-1, 2),
		SKILL_SMG = list(-3, 3),
		SKILL_PISTOL = list(-2, 1),
		SKILL_THROWING = list(-1, 2),
		SKILL_CLEANING = list(-6, 2),
		SKILL_PICKPOCKET = list(-2, 1),
		SKILL_LOCKPICKING = list(-2, 2),
	)
	raw_attribute_list = list(
		SKILL_BRAWLING = -2,
		SKILL_WRESTLING = -2,
		SKILL_IMPACT_WEAPON = -2,
		SKILL_SMG = 0,
		SKILL_PISTOL = 4,
		SKILL_THROWING = -3,
		SKILL_CLEANING = -2,
		SKILL_PICKPOCKET = -2,
		SKILL_LOCKPICKING = 0,
	)

//Research Director
/datum/attribute_holder/sheet/job/technocrat
	attribute_variance = list(
		STAT_STRENGTH = list(-2, 1),
		STAT_ENDURANCE = list(-2, 1),
		STAT_DEXTERITY = list(1, 3),
		STAT_INTELLIGENCE = list(1, 5),
		SKILL_BRAWLING = list(-1, 2),
		SKILL_WRESTLING = list(-1, 2),
		SKILL_IMPACT_WEAPON = list(0, 4),
		SKILL_PISTOL = list(-2, 2),
		SKILL_LAW = list(-2, 3),
		SKILL_RAPIER = list(-2, 2),
		SKILL_KNIFE = list(-2, 2),
		SKILL_THROWING = list(-2, 1),
		SKILL_ALCHEMISTRY = list(0, 4),
		SKILL_MEDICINE = list(-2, 2),
		SKILL_SURGERY = list(-2, 2),
		SKILL_SCIENCE = list(-2, 2),
		SKILL_ACROBATICS = list(-4, 4),
		SKILL_ELECTRONICS = list(-3, 3),
	)
	raw_attribute_list = list(
		SKILL_BRAWLING = -3,
		SKILL_WRESTLING = -3,
		SKILL_IMPACT_WEAPON = -3,
		SKILL_PISTOL = 2,
		SKILL_LAW = 3,
		SKILL_RAPIER = 1,
		SKILL_KNIFE = 0,
		SKILL_THROWING = -2,
		SKILL_ALCHEMISTRY = 0,
		SKILL_MEDICINE = -2,
		SKILL_SURGERY = -2,
		SKILL_SCIENCE = 6,
		SKILL_ELECTRONICS = 4,
		SKILL_ACROBATICS = 0,
	)

//Technomancer
/datum/attribute_holder/sheet/job/technologist
	attribute_variance = list(
		STAT_STRENGTH = list(-2, 1),
		STAT_ENDURANCE = list(-2, 1),
		STAT_DEXTERITY = list(0, 2),
		STAT_INTELLIGENCE = list(0, 2),
		SKILL_WRESTLING = list(-1, 2),
		SKILL_BRAWLING = list(-1, 2),
		SKILL_IMPACT_WEAPON = list(-2, 2),
		SKILL_KNIFE = list(-2, 2),
		SKILL_PISTOL = list(-2, 2),
		SKILL_LAW = list(-2, 2),
		SKILL_THROWING = list(-2, 1),
		SKILL_ALCHEMISTRY = list(-2, 3),
		SKILL_MEDICINE = list(-1, 3),
		SKILL_SURGERY = list(-1, 2),
		SKILL_SCIENCE = list(-2, 2),
		SKILL_ACROBATICS = list(-3, 2),
	)
	raw_attribute_list = list(
		SKILL_BRAWLING = -3,
		SKILL_WRESTLING = -3,
		SKILL_IMPACT_WEAPON = -3,
		SKILL_KNIFE = 0,
		SKILL_PISTOL = 0,
		SKILL_LAW = 0,
		SKILL_THROWING = -2,
		SKILL_ALCHEMISTRY = 2,
		SKILL_MEDICINE = -2,
		SKILL_SURGERY = -3,
		SKILL_SCIENCE = 4,
		SKILL_ACROBATICS = 0,
	)

//Machinist/Roboticist
/datum/attribute_holder/sheet/job/machinist
	attribute_variance = list(
		STAT_STRENGTH = list(-1, 3),
		STAT_ENDURANCE = list(-1, 3),
		STAT_DEXTERITY = list(-3, 1),
		STAT_INTELLIGENCE = list(-1, 2),
		SKILL_WRESTLING = list(-1, 2),
		SKILL_BRAWLING = list(-1, 2),
		SKILL_IMPACT_WEAPON = list(-2, 2),
		SKILL_KNIFE = list(-2, 2),
		SKILL_PISTOL = list(-2, 2),
		SKILL_LAW = list(-2, 2),
		SKILL_THROWING = list(-5, 0),
		SKILL_ALCHEMISTRY = list(-2, 3),
		SKILL_MEDICINE = list(-2, 2),
		SKILL_SURGERY = list(-2, 2),
		SKILL_SCIENCE = list(-2, 2),
		SKILL_ACROBATICS = list(-2, 4),
		SKILL_ELECTRONICS = list(-2, 6),
	)
	raw_attribute_list = list(
		SKILL_BRAWLING = -3,
		SKILL_WRESTLING = -3,
		SKILL_IMPACT_WEAPON = -3,
		SKILL_KNIFE = 0,
		SKILL_PISTOL = 0,
		SKILL_LAW = 0,
		SKILL_THROWING = -2,
		SKILL_ALCHEMISTRY = 0,
		SKILL_MEDICINE = 2,
		SKILL_SURGERY = 0,
		SKILL_SCIENCE = 0,
		SKILL_ACROBATICS = 0,
		SKILL_ELECTRONICS = 2,
	)

//Miner
/datum/attribute_holder/sheet/job/miner
	attribute_variance = list(
		STAT_STRENGTH = list(-1, 3),
		STAT_ENDURANCE = list(-1, 3),
		STAT_DEXTERITY = list(-2, 2),
		STAT_INTELLIGENCE = list(-3, 0),
		SKILL_BRAWLING = list(-2, 2),
		SKILL_WRESTLING = list(-2, 2),
		SKILL_IMPACT_WEAPON = list(-2, 2),
		SKILL_KNIFE = list(-1, 2),
		SKILL_PISTOL = list(-2, 2),
		SKILL_RIFLE = list(-2, 2),
		SKILL_SHOTGUN = list(-2, 2),
		SKILL_THROWING = list(-5, 0),
		SKILL_FORENSICS = list(-2, 1),
		SKILL_ACROBATICS = list(-2, 3),
	)
	raw_attribute_list = list(
		SKILL_BRAWLING = 0,
		SKILL_WRESTLING = 0,
		SKILL_IMPACT_WEAPON = 4,
		SKILL_KNIFE = 0,
		SKILL_PISTOL = 3,
		SKILL_RIFLE = 0,
		SKILL_SHOTGUN = 2,
		SKILL_THROWING = 2,
		SKILL_FORENSICS = -2,
		SKILL_ACROBATICS = 0,
	)

//PODPOL

//venturer classic
/datum/attribute_holder/sheet/job/venturer
	attribute_variance = list(
		STAT_STRENGTH = list(-2, 3),
		STAT_ENDURANCE = list(-2, 3),
		STAT_DEXTERITY = list(-2, 3),
		STAT_INTELLIGENCE = list(-2, 3),
		SKILL_BRAWLING = list(-1, 2),
		SKILL_WRESTLING = list(-1, 2),
		SKILL_SMG = list(-1, 1),
		SKILL_PISTOL = list(-1, 1),
		SKILL_RAPIER = list(-1, 1),
		SKILL_SHORTSWORD = list(-1, 1),
		SKILL_LONGSWORD = list(-1, 1),
		SKILL_THROWING = list(-5, 2),
		SKILL_PICKPOCKET = list(-3, 2),
		SKILL_LOCKPICKING = list(-2, 2),
		SKILL_SCIENCE = list(-2, 2),
		SKILL_ACROBATICS = list(2, 3),
		SKILL_IMPACT_WEAPON = list(-2, 2),
		SKILL_KNIFE = list(-1, 2),
		SKILL_RIFLE = list(-2, 2),
		SKILL_SHOTGUN = list(-2, 2),
		SKILL_FORENSICS = list(-2, 1),

	)
	raw_attribute_list = list(
		SKILL_BRAWLING = -1,
		SKILL_WRESTLING = -1,
		SKILL_IMPACT_WEAPON = 3,
		SKILL_SMG = 0,
		SKILL_PISTOL = 0,
		SKILL_RAPIER = 0,
		SKILL_SHORTSWORD = 0,
		SKILL_THROWING = 3,
		SKILL_PICKPOCKET = -2,
		SKILL_LOCKPICKING = -2,
		SKILL_SCIENCE = -3,
		SKILL_ACROBATICS = -3,
	)

//venturer thief
/datum/attribute_holder/sheet/job/venturerthief
	attribute_variance = list(
		STAT_STRENGTH = list(-1, 2),
		STAT_ENDURANCE = list(-1, 2),
		STAT_DEXTERITY = list(-1, 5),
		STAT_INTELLIGENCE = list(-1, 3),
		STAT_PERCEPTION = list(1, 3),
		SKILL_BRAWLING = list(-1, 10),
		SKILL_WRESTLING = list(-1, 2),
		SKILL_SMG = list(-1, 1),
		SKILL_PISTOL = list(-1, 1),
		SKILL_RAPIER = list(-1, 1),
		SKILL_SHORTSWORD = list(-1, 1),
		SKILL_THROWING = list(-5, 0),
		SKILL_PICKPOCKET = list(-3, 2),
		SKILL_LOCKPICKING = list(5, 10),
		SKILL_SCIENCE = list(-2, 0),
		SKILL_ACROBATICS = list(2, 10),
	)
	raw_attribute_list = list(
		SKILL_BRAWLING = -1,
		SKILL_WRESTLING = -1,
		SKILL_IMPACT_WEAPON = 3,
		SKILL_SMG = 0,
		SKILL_PISTOL = 0,
		SKILL_RAPIER = 0,
		SKILL_SHORTSWORD = 0,
		SKILL_THROWING = 3,
		SKILL_PICKPOCKET = -2,
		SKILL_LOCKPICKING = -2,
		SKILL_SCIENCE = -3,
		SKILL_ACROBATICS = -3,
	)

//village owner
/datum/attribute_holder/sheet/job/venturervillageowner
	attribute_variance = list(
		STAT_STRENGTH = list(-1, 2),
		STAT_ENDURANCE = list(-1, 2),
		STAT_DEXTERITY = list(-1, 2),
		STAT_INTELLIGENCE = list(0, 2),
		SKILL_BRAWLING = list(-1, 1),
		SKILL_WRESTLING = list(-1, 1),
		SKILL_SMG = list(-1, 1),
		SKILL_PISTOL = list(-1, 1),
		SKILL_RAPIER = list(-1, 1),
		SKILL_SHORTSWORD = list(-1, 1),
		SKILL_THROWING = list(-5, 0),
		SKILL_PICKPOCKET = list(-1, 4),
		SKILL_LOCKPICKING = list(-2, 2),
		SKILL_SCIENCE = list(-2, 0),
		SKILL_ACROBATICS = list(2, 3),
	)
	raw_attribute_list = list(
		SKILL_BRAWLING = -1,
		SKILL_WRESTLING = -1,
		SKILL_IMPACT_WEAPON = 0,
		SKILL_SMG = 0,
		SKILL_PISTOL = 0,
		SKILL_RAPIER = 0,
		SKILL_SHORTSWORD = 0,
		SKILL_THROWING = 3,
		SKILL_PICKPOCKET = -2,
		SKILL_LOCKPICKING = -2,
		SKILL_SCIENCE = -3,
		SKILL_ACROBATICS = -3,
	)

//gardener
/datum/attribute_holder/sheet/job/venturergardener
	attribute_variance = list(
		STAT_STRENGTH = list(-1, 2),
		STAT_ENDURANCE = list(0, 5),
		STAT_DEXTERITY = list(-1, 2),
		STAT_INTELLIGENCE = list(0, 2),
		SKILL_AGRICULTURE = list(10, 11),
		SKILL_BRAWLING = list(-1, 1),
		SKILL_WRESTLING = list(-1, 1),
		SKILL_SMG = list(-1, 1),
		SKILL_PISTOL = list(-1, 1),
		SKILL_RAPIER = list(-1, 1),
		SKILL_SHORTSWORD = list(-1, 1),
		SKILL_THROWING = list(-5, 0),
		SKILL_PICKPOCKET = list(-1, 2),
		SKILL_LOCKPICKING = list(-2, 2),
		SKILL_SCIENCE = list(-2, 0),
		SKILL_ACROBATICS = list(2, 3),
	)
	raw_attribute_list = list(
		SKILL_BRAWLING = -1,
		SKILL_WRESTLING = -1,
		SKILL_IMPACT_WEAPON = 0,
		SKILL_SMG = 0,
		SKILL_PISTOL = 0,
		SKILL_RAPIER = 0,
		SKILL_SHORTSWORD = 0,
		SKILL_THROWING = 3,
		SKILL_PICKPOCKET = -2,
		SKILL_LOCKPICKING = -2,
		SKILL_SCIENCE = -3,
		SKILL_ACROBATICS = -3,
	)

//true venturer
/datum/attribute_holder/sheet/job/venturertrue
	attribute_variance = list(
		STAT_STRENGTH = list(-1, 3),
		STAT_ENDURANCE = list(-1, 3),
		STAT_DEXTERITY = list(-1, 3),
		STAT_INTELLIGENCE = list(-1, 1),
		STAT_PERCEPTION = list(1, 4),
		SKILL_BRAWLING = list(-1, 3),
		SKILL_WRESTLING = list(-1, 3),
		SKILL_SMG = list(-1, 1),
		SKILL_PISTOL = list(-1, 1),
		SKILL_RAPIER = list(-1, 1),
		SKILL_SHORTSWORD = list(-1, 1),
		SKILL_THROWING = list(-5, 0),
		SKILL_PICKPOCKET = list(-3, 2),
		SKILL_LOCKPICKING = list(-2, 2),
		SKILL_SCIENCE = list(-2, 0),
		SKILL_ACROBATICS = list(2, 5),
	)
	raw_attribute_list = list(
		SKILL_BRAWLING = -1,
		SKILL_WRESTLING = -1,
		SKILL_IMPACT_WEAPON = 0,
		SKILL_SMG = 0,
		SKILL_PISTOL = 0,
		SKILL_RAPIER = 0,
		SKILL_SHORTSWORD = 0,
		SKILL_THROWING = 3,
		SKILL_PICKPOCKET = -2,
		SKILL_LOCKPICKING = -2,
		SKILL_SCIENCE = -3,
		SKILL_ACROBATICS = -3,
	)

//meat warrior
/datum/attribute_holder/sheet/job/venturermeatwarrior
	attribute_variance = list(
		STAT_STRENGTH = list(0, 3),
		STAT_ENDURANCE = list(1, 3),
		STAT_DEXTERITY = list(-2, 3),
		STAT_INTELLIGENCE = list(-3, 1),
		SKILL_BRAWLING = list(-1, 5),
		SKILL_WRESTLING = list(-1, 5),
		SKILL_SMG = list(-1, 1),
		SKILL_PISTOL = list(-1, 1),
		SKILL_RAPIER = list(-1, 1),
		SKILL_SHORTSWORD = list(1, 5),
		SKILL_THROWING = list(-5, 0),
		SKILL_PICKPOCKET = list(-3, 2),
		SKILL_LOCKPICKING = list(-2, 2),
		SKILL_SCIENCE = list(-2, 0),
		SKILL_ACROBATICS = list(2, 5),
	)
	raw_attribute_list = list(
		SKILL_BRAWLING = -1,
		SKILL_WRESTLING = -1,
		SKILL_IMPACT_WEAPON = 0,
		SKILL_SMG = 0,
		SKILL_PISTOL = 0,
		SKILL_RAPIER = 0,
		SKILL_SHORTSWORD = 0,
		SKILL_THROWING = 3,
		SKILL_PICKPOCKET = -2,
		SKILL_LOCKPICKING = -2,
		SKILL_SCIENCE = -3,
		SKILL_ACROBATICS = -3,
	)

//goer
/datum/attribute_holder/sheet/job/venturergoer
	attribute_variance = list(
		STAT_STRENGTH = list(0, 3),
		STAT_ENDURANCE = list(0, 3),
		STAT_DEXTERITY = list(-1, 3),
		STAT_INTELLIGENCE = list(-1, 1),
		SKILL_BRAWLING = list(-1, 5),
		SKILL_WRESTLING = list(-1, 5),
		SKILL_SMG = list(-1, 1),
		SKILL_PISTOL = list(-1, 1),
		SKILL_RAPIER = list(-1, 1),
		SKILL_SHORTSWORD = list(1, 3),
		SKILL_LONGSWORD = list(4, 8),
		SKILL_THROWING = list(-5, 0),
		SKILL_PICKPOCKET = list(-3, 2),
		SKILL_LOCKPICKING = list(-2, 2),
		SKILL_SCIENCE = list(-2, 0),
		SKILL_ACROBATICS = list(2, 4),
	)
	raw_attribute_list = list(
		SKILL_BRAWLING = -1,
		SKILL_WRESTLING = -1,
		SKILL_IMPACT_WEAPON = 0,
		SKILL_SMG = 0,
		SKILL_PISTOL = 0,
		SKILL_RAPIER = 0,
		SKILL_SHORTSWORD = 0,
		SKILL_THROWING = 3,
		SKILL_PICKPOCKET = -2,
		SKILL_LOCKPICKING = -2,
		SKILL_SCIENCE = -3,
		SKILL_ACROBATICS = -3,
	)

// chaot
/datum/attribute_holder/sheet/job/chaot
	attribute_variance = list(
		STAT_STRENGTH = list(-1, 2),
		STAT_ENDURANCE = list(-1, 1),
		STAT_DEXTERITY = list(-1, 1),
		STAT_INTELLIGENCE = list(-1, 5),
		SKILL_BRAWLING = list(-1, 1),
		SKILL_WRESTLING = list(-1, 1),
		SKILL_SMG = list(-1, 1),
		SKILL_PISTOL = list(-1, 1),
		SKILL_RIFLE = list(-1, 4),
		SKILL_SHOTGUN = list(2, 6),
//		SKILL_RAPIER = list(-1, 1),
		SKILL_SHORTSWORD = list(-1, 1),
		SKILL_THROWING = list(-5, 0),
		SKILL_PICKPOCKET = list(-3, 2),
		SKILL_LOCKPICKING = list(-2, 2),
		SKILL_SCIENCE = list(-2, 2),
		SKILL_ACROBATICS = list(-2, 1),
		SKILL_MEDICINE = list(-1, 6),
		SKILL_SURGERY = list(-1, 6),
		SKILL_ALCHEMISTRY = list(2, 5),
		SKILL_MASONRY = list(3, 6),
	)
	raw_attribute_list = list(
		SKILL_BRAWLING = -1,
		SKILL_WRESTLING = -1,
		SKILL_IMPACT_WEAPON = 0,
		SKILL_SMG = 0,
		SKILL_PISTOL = 0,
		SKILL_RAPIER = 0,
		SKILL_SHORTSWORD = 0,
		SKILL_THROWING = 3,
		SKILL_PICKPOCKET = -2,
		SKILL_LOCKPICKING = -2,
		SKILL_SCIENCE = -3,
		SKILL_ACROBATICS = -2,
	)

//outcombat
/datum/attribute_holder/sheet/job/outcombat
	attribute_variance = list(
		STAT_STRENGTH = list(-2, 5),
		STAT_ENDURANCE = list(-2, 5),
		STAT_DEXTERITY = list(-2, 5),
		STAT_INTELLIGENCE = list(-2, 5),
		SKILL_BRAWLING = list(-2, 6),
		SKILL_WRESTLING = list(-2, 6),
		SKILL_BUCKLER = list(-2, 6),
		SKILL_SHIELD = list(-2, 6),
		SKILL_IMPACT_WEAPON_TWOHANDED = list(-2, 6),
		SKILL_IMPACT_WEAPON = list(-2, 6),
		SKILL_KNIFE = list(-2, 6),
		SKILL_SHOTGUN = list(-2, 6),
		SKILL_SMG = list(-2, 6),
		SKILL_PISTOL = list(-2, 6),
		SKILL_LAW = list(2, 6),
		SKILL_RAPIER = list(-2, 6),
		SKILL_SHORTSWORD = list(-2, 6),
		SKILL_LONGSWORD = list(-2, 6),
		SKILL_THROWING = list(-5, 3),
		SKILL_PICKPOCKET = list(-2, 6),
		SKILL_LOCKPICKING = list(-2, 6),
		SKILL_SCIENCE = list(-2, 6),,
		SKILL_ACROBATICS = list(-2, 6),
	)
	raw_attribute_list = list(
		SKILL_BRAWLING = -1,
		SKILL_WRESTLING = -1,
		SKILL_IMPACT_WEAPON = 0,
		SKILL_SMG = 0,
		SKILL_PISTOL = 0,
		SKILL_RAPIER = 0,
		SKILL_SHORTSWORD = 0,
		SKILL_THROWING = 3,
		SKILL_PICKPOCKET = -2,
		SKILL_LOCKPICKING = -2,
		SKILL_SCIENCE = -3,
		SKILL_ACROBATICS = -3,
	)


// akt liver
/datum/attribute_holder/sheet/job/aktliver
	attribute_variance = list(
		STAT_STRENGTH = list(-1, 2),
		STAT_ENDURANCE = list(-1, 1),
		STAT_DEXTERITY = list(-1, 1),
		STAT_INTELLIGENCE = list(-2, 2),
		SKILL_BRAWLING = list(-2, 3),
		SKILL_WRESTLING = list(-2, 4),
		SKILL_SMG = list(-1, 1),
		SKILL_PISTOL = list(-1, 1),
		SKILL_RIFLE = list(-1, 4),
//		SKILL_RAPIER = list(-1, 1),
		SKILL_SHORTSWORD = list(-1, 3),
		SKILL_THROWING = list(-5, 0),
		SKILL_PICKPOCKET = list(-3, 2),
		SKILL_LOCKPICKING = list(-2, 2),
		SKILL_SCIENCE = list(-2, 2),
		SKILL_ACROBATICS = list(-2, 4),
	)
	raw_attribute_list = list(
		SKILL_BRAWLING = -1,
		SKILL_WRESTLING = -1,
		SKILL_IMPACT_WEAPON = 0,
		SKILL_SMG = 0,
		SKILL_PISTOL = 0,
		SKILL_RAPIER = 0,
		SKILL_SHORTSWORD = 0,
		SKILL_THROWING = 3,
		SKILL_PICKPOCKET = -2,
		SKILL_LOCKPICKING = -2,
		SKILL_SCIENCE = -3,
		SKILL_ACROBATICS = -2,
	)

// akt granger
/datum/attribute_holder/sheet/job/aktgranger
	attribute_variance = list(
		STAT_STRENGTH = list(-1, 2),
		STAT_ENDURANCE = list(-1, 1),
		STAT_DEXTERITY = list(-1, 1),
		STAT_INTELLIGENCE = list(-2, 2),
		SKILL_BRAWLING = list(-1, 4),
		SKILL_WRESTLING = list(-1, 5),
		SKILL_SMG = list(-1, 1),
		SKILL_PISTOL = list(-1, 1),
		SKILL_RIFLE = list(-1, 4),
//		SKILL_RAPIER = list(-1, 1),
		SKILL_SHORTSWORD = list(-1, 3),
		SKILL_THROWING = list(-5, 0),
		SKILL_PICKPOCKET = list(-3, 2),
		SKILL_LOCKPICKING = list(-2, 2),
		SKILL_SCIENCE = list(-2, 2),
		SKILL_ACROBATICS = list(-2, 4),
		SKILL_AGRICULTURE = list(2, 6),
	)
	raw_attribute_list = list(
		SKILL_BRAWLING = -1,
		SKILL_WRESTLING = -1,
		SKILL_IMPACT_WEAPON = 0,
		SKILL_SMG = 0,
		SKILL_PISTOL = 0,
		SKILL_RAPIER = 0,
		SKILL_SHORTSWORD = 0,
		SKILL_THROWING = 3,
		SKILL_PICKPOCKET = -2,
		SKILL_LOCKPICKING = -2,
		SKILL_SCIENCE = -3,
		SKILL_ACROBATICS = -2,
	)

// akt curer
/datum/attribute_holder/sheet/job/aktcurer
	attribute_variance = list(
		STAT_STRENGTH = list(-1, 2),
		STAT_ENDURANCE = list(-1, 1),
		STAT_DEXTERITY = list(-1, 1),
		STAT_INTELLIGENCE = list(-2, 2),
		SKILL_BRAWLING = list(-1, 4),
		SKILL_WRESTLING = list(-1, 5),
		SKILL_SMG = list(-1, 1),
		SKILL_PISTOL = list(-1, 1),
		SKILL_RIFLE = list(-1, 4),
//		SKILL_RAPIER = list(-1, 1),
		SKILL_SHORTSWORD = list(-1, 3),
		SKILL_THROWING = list(-5, 0),
		SKILL_PICKPOCKET = list(-3, 2),
		SKILL_LOCKPICKING = list(-2, 2),
		SKILL_SCIENCE = list(-2, 2),
		SKILL_ACROBATICS = list(-2, 4),
		SKILL_MEDICINE = list(-1, 6),
		SKILL_SURGERY = list(-1, 6),
	)
	raw_attribute_list = list(
		SKILL_BRAWLING = -1,
		SKILL_WRESTLING = -1,
		SKILL_IMPACT_WEAPON = 0,
		SKILL_SMG = 0,
		SKILL_PISTOL = 0,
		SKILL_RAPIER = 0,
		SKILL_SHORTSWORD = 0,
		SKILL_THROWING = 3,
		SKILL_PICKPOCKET = -2,
		SKILL_LOCKPICKING = -2,
		SKILL_SCIENCE = -3,
		SKILL_ACROBATICS = -2,
	)

// akt gargohelper
/datum/attribute_holder/sheet/job/aktgargohelper
	attribute_variance = list(
		STAT_STRENGTH = list(-1, 2),
		STAT_ENDURANCE = list(-1, 1),
		STAT_DEXTERITY = list(-1, 1),
		STAT_INTELLIGENCE = list(2, 3),
		SKILL_BRAWLING = list(-1, 4),
		SKILL_WRESTLING = list(-1, 5),
		SKILL_SMG = list(-1, 1),
		SKILL_PISTOL = list(-1, 3),
		SKILL_RIFLE = list(-1, 2),
//		SKILL_RAPIER = list(-1, 1),
		SKILL_SHORTSWORD = list(-1, 3),
		SKILL_THROWING = list(-5, 0),
		SKILL_PICKPOCKET = list(-3, 2),
		SKILL_LOCKPICKING = list(-2, 2),
		SKILL_SCIENCE = list(-2, 2),
		SKILL_ACROBATICS = list(-2, 4),
	)
	raw_attribute_list = list(
		SKILL_BRAWLING = -1,
		SKILL_WRESTLING = -1,
		SKILL_IMPACT_WEAPON = 0,
		SKILL_SMG = 0,
		SKILL_PISTOL = 0,
		SKILL_RAPIER = 0,
		SKILL_SHORTSWORD = 0,
		SKILL_THROWING = 3,
		SKILL_PICKPOCKET = -2,
		SKILL_LOCKPICKING = -2,
		SKILL_SCIENCE = -3,
		SKILL_ACROBATICS = -2,
	)

// akt controller
/datum/attribute_holder/sheet/job/aktcontroller
	attribute_variance = list(
		STAT_STRENGTH = list(-1, 3),
		STAT_ENDURANCE = list(-1, 3),
		STAT_DEXTERITY = list(-1, 3),
		STAT_INTELLIGENCE = list(-3, 1),
		STAT_PERCEPTION = list(1, 3),
		SKILL_IMPACT_WEAPON = list(-4, 3),
		SKILL_WRESTLING = list(-1, 2),
		SKILL_BRAWLING = list(-1, 2),
		SKILL_PISTOL = list(-3, 3),
		SKILL_SMG = list(-4, 4),
		SKILL_RIFLE = list(-4, 4),
		SKILL_RAPIER = list(-2, 2),
		SKILL_SHORTSWORD = list(-3, 3),
		SKILL_LONGSWORD = list(-3, 3),
		SKILL_THROWING = list(-5, 0),
		SKILL_CLEANING = list(-2, 2),
		SKILL_MEDICINE = list(-3, 2),
		SKILL_LOCKPICKING = list(-2, 2),
		SKILL_ACROBATICS = list(-2, 4),
	)
	raw_attribute_list = list(
		SKILL_IMPACT_WEAPON = 4,
		SKILL_PISTOL = 4,
		SKILL_RAPIER = 5,
		SKILL_LONGSWORD = 0,
		SKILL_SHORTSWORD = 0,
		SKILL_BRAWLING = -2,
		SKILL_WRESTLING = -2,
		SKILL_SMG = 0,
		SKILL_RIFLE = 0,
		SKILL_THROWING = -3,
		SKILL_CLEANING = 0,
		SKILL_MEDICINE = 0,
		SKILL_LOCKPICKING = -2,
		SKILL_ACROBATICS = 4,
	)


// akt al-chemist
/datum/attribute_holder/sheet/job/alchemist
	attribute_variance = list(
		STAT_STRENGTH = list(-1, 3),
		STAT_ENDURANCE = list(-1, 3),
		STAT_DEXTERITY = list(-1, 3),
		STAT_INTELLIGENCE = list(1, 3),
		SKILL_IMPACT_WEAPON = list(-4, 3),
		SKILL_WRESTLING = list(-1, 2),
		SKILL_BRAWLING = list(-1, 2),
		SKILL_PISTOL = list(-3, 3),
		SKILL_SMG = list(-4, 4),
		SKILL_RIFLE = list(-4, 4),
		SKILL_RAPIER = list(-3, 2),
		SKILL_SHORTSWORD = list(-3, 3),
		SKILL_LONGSWORD = list(-3, 3),
		SKILL_THROWING = list(-5, 0),
		SKILL_CLEANING = list(-2, 2),
		SKILL_MEDICINE = list(-3, 2),
		SKILL_SURGERY = list(-1, 4),
		SKILL_LOCKPICKING = list(-2, 2),
		SKILL_ACROBATICS = list(-2, 4),
		SKILL_ALCHEMISTRY = list(2, 5),
	)
	raw_attribute_list = list(
		SKILL_IMPACT_WEAPON = 4,
		SKILL_PISTOL = 4,
		SKILL_RAPIER = 5,
		SKILL_LONGSWORD = 0,
		SKILL_SHORTSWORD = 0,
		SKILL_BRAWLING = -2,
		SKILL_WRESTLING = -2,
		SKILL_SMG = 0,
		SKILL_RIFLE = 0,
		SKILL_THROWING = -3,
		SKILL_CLEANING = 0,
		SKILL_MEDICINE = 0,
		SKILL_LOCKPICKING = -2,
		SKILL_ACROBATICS = 4,
	)

//aktassertor
/datum/attribute_holder/sheet/job/aktassertor
	attribute_variance = list(
		STAT_STRENGTH = list(1, 4),
		STAT_ENDURANCE = list(1, 3),
		STAT_DEXTERITY = list(1, 3),
		STAT_INTELLIGENCE = list(-1, 1),
		STAT_PERCEPTION = list(1, 3),
		SKILL_BRAWLING = list(1, 10),
		SKILL_WRESTLING = list(1, 10),
		SKILL_SMG = list(-1, 1),
		SKILL_BUCKLER = list(-1, 6),
		SKILL_PISTOL = list(-1, 1),
		SKILL_RAPIER = list(-1, 1),
		SKILL_SHORTSWORD = list(1, 3),
		SKILL_LONGSWORD = list(4, 6),
		SKILL_IMPACT_WEAPON = list(4, 8),
		SKILL_THROWING = list(-5, 0),
		SKILL_PICKPOCKET = list(-3, 2),
		SKILL_LOCKPICKING = list(-2, 2),
		SKILL_SCIENCE = list(-2, 0),
		SKILL_ACROBATICS = list(2, 6),
	)
	raw_attribute_list = list(
		SKILL_BRAWLING = -1,
		SKILL_WRESTLING = -1,
		SKILL_IMPACT_WEAPON = 0,
		SKILL_SMG = 0,
		SKILL_PISTOL = 0,
		SKILL_RAPIER = 0,
		SKILL_SHORTSWORD = 0,
		SKILL_THROWING = 3,
		SKILL_PICKPOCKET = -2,
		SKILL_LOCKPICKING = -2,
		SKILL_SCIENCE = -3,
		SKILL_ACROBATICS = -3,
	)



//aktnailer
/datum/attribute_holder/sheet/job/aktnailer
	attribute_variance = list(
		STAT_STRENGTH = list(1, 4),
		STAT_ENDURANCE = list(1, 3),
		STAT_DEXTERITY = list(-1, 1),
		STAT_INTELLIGENCE = list(-1, 1),
		SKILL_BRAWLING = list(1, 7),
		SKILL_WRESTLING = list(1, 7),
		SKILL_SMG = list(-1, 1),
		SKILL_PISTOL = list(-1, 1),
		SKILL_RAPIER = list(-1, 1),
		SKILL_SHORTSWORD = list(-1, 1),
		SKILL_LONGSWORD = list(-1, 1),
		SKILL_IMPACT_WEAPON = list(4, 8),
		SKILL_IMPACT_WEAPON_TWOHANDED = list(4, 8),
		SKILL_THROWING = list(-5, 0),
		SKILL_PICKPOCKET = list(-3, 2),
		SKILL_LOCKPICKING = list(-2, 1),
		SKILL_MASONRY = list(3, 6),
		SKILL_SMITHING = list(3, 6),
		SKILL_SCIENCE = list(-2, 4),
		SKILL_ACROBATICS = list(-2, 3),
	)
	raw_attribute_list = list(
		SKILL_BRAWLING = -1,
		SKILL_WRESTLING = -1,
		SKILL_IMPACT_WEAPON = 0,
		SKILL_SMG = 0,
		SKILL_PISTOL = 0,
		SKILL_RAPIER = 0,
		SKILL_SHORTSWORD = 0,
		SKILL_THROWING = 3,
		SKILL_PICKPOCKET = -2,
		SKILL_LOCKPICKING = -2,
		SKILL_SCIENCE = -3,
		SKILL_ACROBATICS = -3,
	)

//strong slave
/datum/attribute_holder/sheet/job/strongslave
	attribute_variance = list(
		STAT_STRENGTH = list(3, 6),
		STAT_ENDURANCE = list(3, 9),
		STAT_DEXTERITY = list(-2, 1),
		STAT_INTELLIGENCE = list(-2, 1),
		SKILL_BRAWLING = list(4, 8),
		SKILL_WRESTLING = list(5, 8),
		SKILL_SMG = list(-1, 1),
		SKILL_PISTOL = list(-1, 1),
		SKILL_RAPIER = list(-1, 1),
		SKILL_SHORTSWORD = list(-1, 1),
		SKILL_LONGSWORD = list(-1, 1),
		SKILL_IMPACT_WEAPON = list(6, 8),
		SKILL_IMPACT_WEAPON_TWOHANDED = list(6, 8),
		SKILL_THROWING = list(-1, 2),
		SKILL_PICKPOCKET = list(-3, 2),
		SKILL_LOCKPICKING = list(-2, 1),
		SKILL_MASONRY = list(4, 7),
		SKILL_SMITHING = list(3, 6),
		SKILL_SCIENCE = list(-2, 4),
		SKILL_ACROBATICS = list(-2, 2),
	)
	raw_attribute_list = list(
		SKILL_BRAWLING = -1,
		SKILL_WRESTLING = -1,
		SKILL_IMPACT_WEAPON = 0,
		SKILL_SMG = 0,
		SKILL_PISTOL = 0,
		SKILL_RAPIER = 0,
		SKILL_SHORTSWORD = 0,
		SKILL_THROWING = 3,
		SKILL_PICKPOCKET = -2,
		SKILL_LOCKPICKING = -2,
		SKILL_SCIENCE = -3,
		SKILL_ACROBATICS = -3,
	)

//ESCAPE FROM NEVADO///
// DENOMINATOR
/datum/attribute_holder/sheet/job/denominator
	attribute_variance = list(
		STAT_STRENGTH = list(1, 5),
		STAT_ENDURANCE = list(0, 3),
		STAT_DEXTERITY = list(0, 2),
		STAT_INTELLIGENCE = list(0, 2),
		SKILL_BRAWLING = list(-1, 2),
		SKILL_WRESTLING = list(-1, 2),
		SKILL_IMPACT_WEAPON = list(-1, 2),
		SKILL_IMPACT_WEAPON_TWOHANDED = list(-2, 2),
		SKILL_KNIFE = list(-2, 2),
		SKILL_SMG = list(-2, 2),
		SKILL_PISTOL = list(-2, 2),
		SKILL_SHOTGUN = list(-1, 2),
		SKILL_RIFLE = list(-2, 2),
		SKILL_LONGSWORD = list(-2, 2),
		SKILL_FORCESWORD = list(-2, 2),
		SKILL_THROWING = list(-4, 2),
		SKILL_FORENSICS = list(-2, 2),
		SKILL_ACROBATICS = list(-2, 2),
	)
	raw_attribute_list = list(
		SKILL_BRAWLING = 2,
		SKILL_WRESTLING = 2,
		SKILL_IMPACT_WEAPON = 3,
		SKILL_IMPACT_WEAPON_TWOHANDED = 3,
		SKILL_SHORTSWORD = 4,
		SKILL_KNIFE = 0,
		SKILL_SMG = 2,
		SKILL_PISTOL = 2,
		SKILL_SHOTGUN = 2,
		SKILL_RIFLE = 3,
		SKILL_LONGSWORD = 1,
		SKILL_FORCESWORD = -2,
		SKILL_THROWING = 2,
		SKILL_FORENSICS = -2,
		SKILL_MEDICINE = 10,
		SKILL_SURGERY = 10,
		SKILL_ACROBATICS = 3,
		SKILL_ELECTRONICS = 8,
	)

// DENOMINATOR SHOTGUNNER
/datum/attribute_holder/sheet/job/denominator/shotgunner
	attribute_variance = list(
		STAT_STRENGTH = list(1, 6),
		STAT_ENDURANCE = list(2, 4),
		STAT_DEXTERITY = list(0, 2),
		STAT_INTELLIGENCE = list(-1, 2),
		SKILL_BRAWLING = list(1, 2),
		SKILL_WRESTLING = list(1, 2),
		SKILL_IMPACT_WEAPON = list(1, 2),
		SKILL_IMPACT_WEAPON_TWOHANDED = list(0, 2),
		SKILL_KNIFE = list(-2, 2),
		SKILL_SMG = list(-2, 2),
		SKILL_PISTOL = list(-2, 2),
		SKILL_SHOTGUN = list(2, 4),
		SKILL_RIFLE = list(-2, 1),
		SKILL_LONGSWORD = list(-2, 2),
		SKILL_FORCESWORD = list(-2, 2),
		SKILL_THROWING = list(-4, 2),
		SKILL_FORENSICS = list(-2, 2),
		SKILL_ACROBATICS = list(-2, 2),
	)
	raw_attribute_list = list(
		SKILL_BRAWLING = 2,
		SKILL_WRESTLING = 2,
		SKILL_IMPACT_WEAPON = 3,
		SKILL_IMPACT_WEAPON_TWOHANDED = 3,
		SKILL_SHORTSWORD = 4,
		SKILL_KNIFE = 0,
		SKILL_SMG = 2,
		SKILL_PISTOL = 2,
		SKILL_SHOTGUN = 4,
		SKILL_RIFLE = 3,
		SKILL_LONGSWORD = 1,
		SKILL_FORCESWORD = -2,
		SKILL_THROWING = 2,
		SKILL_FORENSICS = -2,
		SKILL_MEDICINE = 10,
		SKILL_SURGERY = 10,
		SKILL_ACROBATICS = 3,
		SKILL_ELECTRONICS = 8,
	)

// PODPOL 2

/datum/attribute_holder/sheet/job/kapno
	attribute_variance = list(
		STAT_STRENGTH = list(-2, 3),
		STAT_ENDURANCE = list(-2, 3),
		STAT_DEXTERITY = list(-2, 3),
		STAT_INTELLIGENCE = list(-2, 3),
		SKILL_BRAWLING = list(-1, 2),
		SKILL_WRESTLING = list(-1, 2),
		SKILL_SMG = list(-1, 1),
		SKILL_PISTOL = list(-1, 1),
		SKILL_RIFLE = list(-1, 1),
		SKILL_SHOTGUN = list(-1, 1),
		SKILL_RAPIER = list(-1, 1),
		SKILL_SHORTSWORD = list(-1, 1),
		SKILL_LONGSWORD = list(-1, 1),
		SKILL_SPEAR = list(-1, 1),
		SKILL_THROWING = list(-5, 2),
		SKILL_PICKPOCKET = list(-3, 2),
		SKILL_LOCKPICKING = list(-2, 2),
		SKILL_SCIENCE = list(-2, 2),
		SKILL_ACROBATICS = list(2, 3),
		SKILL_IMPACT_WEAPON = list(-2, 2),
		SKILL_BUCKLER = list(-2, 2),
		SKILL_KNIFE = list(-1, 2),
		SKILL_RIFLE = list(-2, 2),
		SKILL_SHOTGUN = list(-2, 2),
		SKILL_FORENSICS = list(-2, 1),

	)
	raw_attribute_list = list(
		SKILL_BRAWLING = -1,
		SKILL_WRESTLING = -1,
		SKILL_IMPACT_WEAPON = 3,
		SKILL_SMG = 0,
		SKILL_PISTOL = 0,
		SKILL_RAPIER = 0,
		SKILL_SHORTSWORD = 0,
		SKILL_THROWING = 3,
		SKILL_PICKPOCKET = -2,
		SKILL_LOCKPICKING = -2,
		SKILL_SCIENCE = -3,
		SKILL_ACROBATICS = -3,
	)

/datum/attribute_holder/sheet/job/konch
	attribute_variance = list(
		STAT_STRENGTH = list(-2, 3),
		STAT_ENDURANCE = list(-2, 3),
		STAT_DEXTERITY = list(-2, 3),
		STAT_INTELLIGENCE = list(-2, 3),
		SKILL_BRAWLING = list(-1, 2),
		SKILL_WRESTLING = list(-1, 2),
		SKILL_SMG = list(-1, 1),
		SKILL_PISTOL = list(-1, 1),
		SKILL_RIFLE = list(-1, 1),
		SKILL_SHOTGUN = list(-1, 1),
		SKILL_RAPIER = list(-1, 1),
		SKILL_SHORTSWORD = list(-1, 1),
		SKILL_LONGSWORD = list(-1, 1),
		SKILL_FLAIL = list(-1, 1),
		SKILL_THROWING = list(-5, 2),
		SKILL_PICKPOCKET = list(-3, 2),
		SKILL_LOCKPICKING = list(-2, 2),
		SKILL_SCIENCE = list(-2, 2),
		SKILL_ACROBATICS = list(2, 3),
		SKILL_IMPACT_WEAPON = list(-2, 2),
		SKILL_BUCKLER = list(-2, 2),
		SKILL_KNIFE = list(-1, 2),
		SKILL_RIFLE = list(-2, 2),
		SKILL_SHOTGUN = list(-2, 2),
		SKILL_FORENSICS = list(-2, 1),

	)
	raw_attribute_list = list(
		SKILL_BRAWLING = -1,
		SKILL_WRESTLING = -1,
		SKILL_IMPACT_WEAPON = 3,
		SKILL_SMG = 0,
		SKILL_PISTOL = 0,
		SKILL_RAPIER = 0,
		SKILL_SHORTSWORD = 0,
		SKILL_THROWING = 3,
		SKILL_PICKPOCKET = -2,
		SKILL_LOCKPICKING = -2,
		SKILL_SCIENCE = -3,
		SKILL_ACROBATICS = -3,
	)
