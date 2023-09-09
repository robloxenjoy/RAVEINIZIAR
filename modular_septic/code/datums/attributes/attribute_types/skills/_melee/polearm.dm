/**
 * POLE WEAPONS
 *
 * Pole weapons are long (usually wooden) shafts, often adorned with striking heads. All require two hands.
 */
/datum/attribute/skill/polearm
	name = "Polearm"
	desc = "Any very long (at least 2 meters), unbalanced pole weapon with a heavy striking head, including the glaive, halberd, poleaxe, and countless others. \
			Polearms become unready after an attack, but not after a parry."
	icon_state = "spear"
	category = SKILL_CATEGORY_MELEE
	governing_attribute = STAT_STRENGTH
	default_attributes = list(
		STAT_STRENGTH = -5,
		SKILL_IMPACT_WEAPON_TWOHANDED = -4,
		SKILL_SPEAR = -4,
		SKILL_STAFF = -4,
	)
	difficulty = SKILL_DIFFICULTY_AVERAGE

/datum/attribute/skill/spear
	name = "Spear"
	desc = "Any long, balanced pole weapon with a thrusting point, including spears, javelins, tridents, and fixed bayonets."
	icon_state = "spear"
	category = SKILL_CATEGORY_MELEE
	governing_attribute = STAT_DEXTERITY
	default_attributes = list(
		STAT_DEXTERITY = -5,
		SKILL_POLEARM = -4,
		SKILL_STAFF = -2,
	)
	difficulty = SKILL_DIFFICULTY_AVERAGE

/datum/attribute/skill/staff
	name = "Staff"
	desc = "Any long, balanced pole without a striking head. \
			This skill makes good use of the staff's extensive parrying surface when defending, giving +2 to your parry score."
	icon_state = "blunt"
	category = SKILL_CATEGORY_MELEE
	governing_attribute = STAT_DEXTERITY
	default_attributes = list(
		STAT_DEXTERITY = -5,
		SKILL_SPEAR = -4,
		SKILL_POLEARM = -2,
	)
	difficulty = SKILL_DIFFICULTY_AVERAGE
