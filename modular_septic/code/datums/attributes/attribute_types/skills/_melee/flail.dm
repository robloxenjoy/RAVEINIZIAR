/**
 * FLAIL WEAPONS
 *
 * A flail is any flexible, unbalanced weapon with its mass concentrated in the head.
 * Such a weapon cannot parry if you have already attacked with it on your turn.
 * Because flails tend to wrap around the target’s shield or weapon, attempts to block them are at -2 and
 * attempts to parry them are at -4.
 */
/datum/attribute/skill/flail
	name = "Flail"
	desc = "Any one-handed flail, such as a morningstar or nunchaku."
	icon_state = "blunt"
	category = SKILL_CATEGORY_MELEE
	governing_attribute = STAT_DEXTERITY
	default_attributes = list(
		STAT_DEXTERITY = -6,
		SKILL_IMPACT_WEAPON = -4,
		SKILL_FLAIL_TWOHANDED = -3,
	)
	difficulty = SKILL_DIFFICULTY_HARD

/datum/attribute/skill/flail_twohanded
	name = "Two-Handed Flail"
	desc = "Any two-handed flail."
	icon_state = "blunt"
	category = SKILL_CATEGORY_MELEE
	governing_attribute = STAT_DEXTERITY
	default_attributes = list(
		STAT_DEXTERITY = -6,
		SKILL_IMPACT_WEAPON = -4,
		SKILL_IMPACT_WEAPON_TWOHANDED = -4,
		SKILL_FLAIL = -3,
	)
	difficulty = SKILL_DIFFICULTY_HARD
