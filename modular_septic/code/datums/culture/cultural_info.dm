/datum/cultural_info
	/// Name of the cultural thing, be it place, faction, or culture
	var/name
	/// It's description
	var/description
	/// Icon
	var/icon = 'modular_septic/icons/ui_icons/preferences/culture.dmi'
	/// Icon state
	var/icon_state = "none"
	/// How many quirk points this costs
	var/value = 0
	/// It'll force people to know this language if they've picked this cultural thing
	var/list/required_langs
	/// This will allow people to pick extra languages
	var/list/additional_langs
	/// If we modify stats, we should use a sheet for it
	var/attribute_sheet

/datum/cultural_info/proc/get_extra_desc(more = FALSE)
	. = ""
	if(required_langs)
		var/list/required_lang = list()
		for(var/thing in required_langs)
			var/datum/language/lang_datum = thing
			required_lang += initial(lang_datum.name)
		. += "<br>Required Languages: [english_list(required_lang)]"
	if(!more)
		return
	if(additional_langs)
		var/list/additional_lang = list()
		for(var/thing in additional_langs)
			var/datum/language/lang_datum = thing
			additional_lang += initial(lang_datum.name)
		. += "<br>Optional Languages: [english_list(additional_lang)]"

/datum/cultural_info/proc/apply(mob/living/carbon/human/H)
	if(attribute_sheet && H.attributes)
		H.attributes.add_sheet(attribute_sheet)
