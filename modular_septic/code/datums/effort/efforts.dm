/datum/effort/strength
	name = "+1 СЛ"
	gain_message = span_effortgained("Я чувствую себя сильнее.")
	lose_message = span_effortlost("Я чувствую себя слабее.")

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
	name = "+1 ЛВ"
	gain_message = span_effortgained("Я чувствую себя быстрее.")
	lose_message = span_effortlost("Я чувствую себя медленнее.")

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
	name = "+1 СТ"
	gain_message = span_effortgained("Я чувствую себя здоровее.")
	lose_message = span_effortlost("Я чувствую себя хуже.")

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
	name = "+1 ИЛ"
	gain_message = span_effortgained("Я чувствую себя умнее.")
	lose_message = span_effortlost("Я чувствую себя тупее.")

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
	name = "+2 ВС"
	gain_message = span_effortgained("Я чувствую себя зорким.")
	lose_message = span_effortlost("Я чувствую себя близоруким.")

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
