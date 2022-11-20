/atom/movable/screen/skills
	name = "skills"
	icon = 'modular_septic/icons/hud/quake/screen_quake.dmi'
	icon_state = "skills"
	screen_loc = ui_skills

/atom/movable/screen/skills/Click(location, control, params)
	. = ..()
	var/list/modifiers = params2list(params)
	if(!LAZYACCESS(modifiers, SHIFT_CLICK))
		usr.attributes?.ui_interact(usr)
	else
		usr.attributes?.print_skills(usr, usr.attributes.show_bad_skills)

/atom/movable/screen/craft
	name = "crafting"
	icon = 'modular_septic/icons/hud/quake/screen_quake.dmi'
	screen_loc = ui_crafting

/atom/movable/screen/language_menu
	name = "language"
	icon = 'modular_septic/icons/hud/quake/screen_quake.dmi'
	screen_loc = ui_language_menu

/atom/movable/screen/language_menu/Click(location, control, params)
	. = ..()
	var/list/modifiers = params2list(params)
	var/mob/user = usr
	var/datum/language_holder/holder = user.get_language_holder()
	if(LAZYACCESS(modifiers, SHIFT_CLICK))
		var/datum/language/selected_language = holder.get_selected_language()
		var/selected_language_text = "<b>[initial(selected_language.name)]</b>"
		var/datum/asset/spritesheet/sheet = get_asset_datum(/datum/asset/spritesheet/chat)
		if(initial(selected_language.icon_state))
			selected_language_text = "[sheet.icon_tag("language-[initial(selected_language.icon_state)]")] [selected_language_text]"
		to_chat(user, div_infobox(span_notice("I will speak [selected_language_text] by default.")))
	else
		holder.open_language_menu(user)

/atom/movable/screen/area_creator
	name = "area"
	icon = 'modular_septic/icons/hud/quake/screen_quake.dmi'
	screen_loc = ui_building

/atom/movable/screen/area_creator/Click(location, control, params)
	. = ..()
	if(usr.incapacitated() || (isobserver(usr) && !isAdminGhostAI(usr)))
		return TRUE
	var/list/modifiers = params2list(params)
	var/area/our_area = get_area(usr)
	if(LAZYACCESS(modifiers, SHIFT_CLICK))
		to_chat(usr, div_infobox(span_notice("I am located at <b>[our_area.name]</b>.")))
	else
		if(!our_area.outdoors)
			to_chat(usr, span_warning("There is already a defined structure here."))
			return TRUE
		create_area(usr)
