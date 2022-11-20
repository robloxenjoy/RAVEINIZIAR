/datum/diceroll_modifier/attribute_editor
	modification = 0
	variable = TRUE

// this special snowflake ALWAYS applies, we care not for context
/datum/diceroll_modifier/attribute_editor/applies_to(datum/attribute_holder/holder, context)
	return TRUE
