/datum/species
	/// List of all birthsigns this species can have, defaults to first in list
	var/list/available_birthsigns = list(/datum/cultural_info/birthsign/starless, \
										/datum/cultural_info/birthsign/warrior, \
										/datum/cultural_info/birthsign/mage)
	/// List of all the languages our species can learn NO MATTER their background
	var/list/learnable_languages = list(/datum/language/common = LANGUAGE_SPOKEN, \
										/datum/language/russian = LANGUAGE_SPOKEN, \
										/datum/language/aphasia = LANGUAGE_SPOKEN)
	/// List of languages our character MUST have in the setup
	var/list/necessary_languages = list(/datum/language/common = LANGUAGE_UNDERSTOOD)
	/// List of languages our character has by default in the setup
	var/list/default_languages = list(/datum/language/common = LANGUAGE_SPOKEN)
