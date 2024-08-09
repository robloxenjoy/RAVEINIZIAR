/datum/effort/strength
	name = "+1 ST"
	gain_message = span_effortgained("I feel stronger.")
	lose_message = span_effortlost("I feel weaker.")

/datum/effort/strength/can_use(mob/user)
	if(!user.attributes)
		return FALSE
	return TRUE

/datum/effort/strength/on_activation(mob/user, silent = FALSE)
	user.attributes.add_or_update_variable_attribute_modifier(/datum/attribute_modifier/effort, TRUE, list(STAT_STRENGTH = 1))
	return TRUE

/datum/effort/strength/on_deactivation(mob/user, silent = FALSE)
	user.attributes.remove_attribute_modifier(/datum/attribute_modifier/effort, TRUE)
	return TRUE

/datum/effort/dexterity
	name = "+1 DX"
	gain_message = span_effortgained("I feel faster.")
	lose_message = span_effortlost("I feel slower.")

/datum/effort/dexterity/can_use(mob/user)
	if(!user.attributes)
		return FALSE
	return TRUE

/datum/effort/dexterity/on_activation(mob/user, silent = FALSE)
	user.attributes.add_or_update_variable_attribute_modifier(/datum/attribute_modifier/effort, TRUE, list(STAT_DEXTERITY = 1))
	return TRUE

/datum/effort/dexterity/on_deactivation(mob/user, silent = FALSE)
	user.attributes.remove_attribute_modifier(/datum/attribute_modifier/effort, TRUE)
	return TRUE

/datum/effort/endurance
	name = "+1 ED"
	gain_message = span_effortgained("I feel healthier.")
	lose_message = span_effortlost("I feel unhealthier.")

/datum/effort/endurance/can_use(mob/user)
	if(!user.attributes)
		return FALSE
	return TRUE

/datum/effort/endurance/on_activation(mob/user, silent = FALSE)
	user.attributes.add_or_update_variable_attribute_modifier(/datum/attribute_modifier/effort, TRUE, list(STAT_ENDURANCE = 1))
	return TRUE

/datum/effort/endurance/on_deactivation(mob/user, silent = FALSE)
	user.attributes.remove_attribute_modifier(/datum/attribute_modifier/effort, TRUE)
	return TRUE

/datum/effort/intelligence
	name = "+1 IQ"
	gain_message = span_effortgained("I feel smarter.")
	lose_message = span_effortlost("I feel dumber.")

/datum/effort/intelligence/can_use(mob/user)
	if(!user.attributes)
		return FALSE
	return TRUE

/datum/effort/intelligence/on_activation(mob/user, silent = FALSE)
	user.attributes.add_or_update_variable_attribute_modifier(/datum/attribute_modifier/effort, TRUE, list(STAT_INTELLIGENCE = 1))
	return TRUE

/datum/effort/intelligence/on_deactivation(mob/user, silent = FALSE)
	user.attributes.remove_attribute_modifier(/datum/attribute_modifier/effort, TRUE)
	return TRUE

/datum/effort/perception
	name = "+2 PR"
	gain_message = span_effortgained("I feel eagle-eyed.")
	lose_message = span_effortlost("I feel myopic.")

/datum/effort/perception/can_use(mob/user)
	if(!user.attributes)
		return FALSE
	return TRUE

/datum/effort/perception/on_activation(mob/user, silent = FALSE)
	user.attributes.add_or_update_variable_attribute_modifier(/datum/attribute_modifier/effort, TRUE, list(STAT_PERCEPTION = 2))
	return TRUE

/datum/effort/perception/on_deactivation(mob/user, silent = FALSE)
	user.attributes.remove_attribute_modifier(/datum/attribute_modifier/effort, TRUE)
	return TRUE
