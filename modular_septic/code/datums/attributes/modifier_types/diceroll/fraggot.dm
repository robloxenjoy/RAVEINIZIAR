/datum/diceroll_modifier/fraggot
	modification = -40

// this special snowflake ALWAYS applies, we care not for context
/datum/diceroll_modifier/fraggot/applies_to(datum/attribute_holder/holder, context)
	return TRUE
