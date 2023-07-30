/datum/asset/spritesheet/birthsigns
	name = "birthsigns"
	early = TRUE

/datum/asset/spritesheet/birthsigns/register()
	var/list/to_insert = list()

	if(!LAZYLEN(GLOB.culture_birthsigns))
		for(var/path in subtypesof(/datum/cultural_info/birthsign))
			var/datum/cultural_info/birthsign = path
			if(!initial(birthsign.name))
				continue
			birthsign = new path()
			GLOB.culture_birthsigns[path] = birthsign

	for(var/birthsign_type in GLOB.culture_birthsigns)
		var/datum/cultural_info/birthsign/birthsign_datum = GLOB.culture_birthsigns[birthsign_type]
		if(birthsign_datum.icon && birthsign_datum.icon_state)
			var/icon/birthsign_icon = icon(icon = birthsign_datum.icon, icon_state = birthsign_datum.icon_state)
			var/css_name = sanitize_css_class_name(birthsign_datum.name)
			var/size = ""
			birthsign_icon.Scale(128, 128)
			size = "[birthsign_icon.Width()]x[birthsign_icon.Height()]"
			LAZYINITLIST(to_insert[size])
			to_insert[size][css_name] = birthsign_icon

	for(var/size in to_insert)
		for(var/spritesheet_key in to_insert[size])
			Insert(spritesheet_key, to_insert[size][spritesheet_key])

	return ..()

/datum/asset/spritesheet/languages
	name = "languages"
	early = TRUE

/datum/asset/spritesheet/languages/register()
	var/list/to_insert = list()

	if(!LAZYLEN(GLOB.all_languages))
		for(var/language_type in subtypesof(/datum/language))
			var/datum/language/language = language_type
			if(!initial(language.key))
				continue

			GLOB.all_languages += language

			var/datum/language/instance = new language

			GLOB.language_datum_instances[language_type] = instance
			GLOB.name_to_language_datum[initial(language.name)] = instance

	if(!LAZYLEN(GLOB.species_to_learnable_languages) || !LAZYLEN(GLOB.species_to_necessary_languages) || !LAZYLEN(GLOB.species_to_default_languages))
		for(var/species_type in subtypesof(/datum/species))
			var/datum/species/species = new species_type()
			GLOB.species_to_learnable_languages[species_type] = species.learnable_languages.Copy()
			GLOB.species_to_necessary_languages[species_type] = species.necessary_languages.Copy()
			GLOB.species_to_default_languages[species_type] = species.default_languages.Copy()
			qdel(species)

	for(var/language_type in GLOB.all_languages)
		var/datum/language/language_datum = GLOB.language_datum_instances[language_type]
		if(language_datum.icon && language_datum.icon_state)
			var/icon/language_icon = icon(icon = language_datum.icon, icon_state = language_datum.icon_state)
			var/css_name = sanitize_css_class_name(language_datum.name)
			var/size = "[language_icon.Width()]x[language_icon.Height()]"
			LAZYINITLIST(to_insert[size])
			to_insert[size][css_name] = language_icon

	for(var/size in to_insert)
		for(var/spritesheet_key in to_insert[size])
			Insert(spritesheet_key, to_insert[size][spritesheet_key])

	return ..()

/datum/asset/spritesheet/attributes_big
	name = "attributes_big"

/datum/asset/spritesheet/attributes_big/register()
	var/list/to_insert = list()

	for(var/attribute_type in GLOB.all_attributes)
		var/datum/attribute/attribute_datum = GET_ATTRIBUTE_DATUM(attribute_type)
		if(attribute_datum.icon && attribute_datum.icon_state)
			var/icon/attribute_icon = icon(icon = attribute_datum.icon, icon_state = attribute_datum.icon_state)
			var/css_name = sanitize_css_class_name(attribute_datum.name)
			var/size = ""
			attribute_icon.Scale(128, 128)
			size = "[attribute_icon.Width()]x[attribute_icon.Height()]"
			LAZYINITLIST(to_insert[size])
			to_insert[size][css_name] = attribute_icon

	for(var/size in to_insert)
		for(var/spritesheet_key in to_insert[size])
			Insert(spritesheet_key, to_insert[size][spritesheet_key])

	return ..()

/datum/asset/spritesheet/attributes_small
	name = "attributes_small"

/datum/asset/spritesheet/attributes_small/register()
	var/list/to_insert = list()

	for(var/attribute_type in GLOB.all_attributes)
		var/datum/attribute/attribute_datum = GET_ATTRIBUTE_DATUM(attribute_type)
		if(attribute_datum.icon && attribute_datum.icon_state)
			var/icon/attribute_icon = icon(icon = attribute_datum.icon, icon_state = attribute_datum.icon_state)
			var/css_name = sanitize_css_class_name(attribute_datum.name)
			var/size = ""
			attribute_icon = icon(icon = attribute_datum.icon, icon_state = attribute_datum.icon_state)
			attribute_icon.Scale(16, 16)
			size = "[attribute_icon.Width()]x[attribute_icon.Height()]"
			LAZYINITLIST(to_insert[size])
			to_insert[size][css_name] = attribute_icon

	for(var/size in to_insert)
		for(var/spritesheet_key in to_insert[size])
			Insert(spritesheet_key, to_insert[size][spritesheet_key])

	return ..()

/datum/asset/spritesheet/chat/register()
	InsertAll("donator",'modular_septic/icons/ui_icons/chat/donator.dmi')
	InsertAll("ooc", 'modular_septic/icons/ui_icons/chat/ooc.dmi')
	InsertAll("emoji", EMOJI_SET_SEPTIC)
	return ..()

/datum/asset/spritesheet/simple/pda/register()
	assets["mail"] = 'modular_septic/icons/pda_icons/pda_zap.png'
	return ..()

/datum/asset/simple/inventory/register()
	assets["inventory-back2.png"] = 'icons/ui_icons/inventory/back2.png'
	return ..()

/datum/asset/simple/music
	early = TRUE
	var/static/list/music_files

/datum/asset/simple/music/New()
	. = ..()
	if(!music_files)
		var/list/musics = list()
//		musics |= DRONING_TAVERN
//		musics |= DRONING_COMBAT
		musics |= DRONING_FOREST
		musics |= DRONING_PURENIGHT
		musics |= DRONING_CATACOMBS
		musics |= DRONING_AKT
		musics |= DRONING_PURENIGHT_AKT
		music_files = musics

/datum/asset/simple/music/send(client)
	. = ..()
	if(!.)
		return
	for(var/music in music_files)
		SEND_SOUND(client, sound(music, FALSE, CHANNEL_ADMIN, 0))
		SEND_SOUND(client, sound(null, FALSE, CHANNEL_ADMIN, 0))
