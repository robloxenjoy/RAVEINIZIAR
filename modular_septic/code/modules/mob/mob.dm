/mob
	plane = GAME_PLANE_FOV_HIDDEN
	var/cursor_icon = 'modular_septic/icons/effects/mouse_pointers/normal.dmi'
	var/combat_cursor_icon = 'modular_septic/icons/effects/mouse_pointers/combat.dmi'
	var/examine_cursor_icon_combat = 'modular_septic/icons/effects/mouse_pointers/combat_examine.dmi'
	/// Type of frill blocker we use
	var/frill_blocker

/mob/Initialize(mapload)
	. = ..()
	set_hydration(rand(HYDRATION_LEVEL_START_MIN, HYDRATION_LEVEL_START_MAX))
	set_nutrition(rand(NUTRITION_LEVEL_STARVING, NUTRITION_LEVEL_WELL_FED))
	attribute_initialize()
	if(ispath(frill_blocker, /atom/movable/blocker) && GLOB.blocker_movables[frill_blocker])
		vis_contents |= GLOB.blocker_movables[frill_blocker]
/*
/mob/Login()
//mob/living/ambi
	. = ..()
	var/area/current_area = get_area(src)
	if(current_area)
		SSdroning.area_entered(current_area, client)
		SSambience.process_ambience_client(current_area, client)
*/
/mob/return_screentip(mob/user, params)
	if(flags_1 & NO_SCREENTIPS_1)
		return ""
	return SCREENTIP_MOB(uppertext(name))

/mob/update_action_buttons(reload_screen = TRUE)
	if(!client || !hud_used.peeper)
		return

	hud_used.hide_actions_toggle.screen_loc = null

	var/atom/movable/screen/movable/action_button/action_button
	var/list/actions_list = list()
	for(var/datum/action/action as anything in actions)
		action.UpdateButtonIcon()
		action_button = action.button
		LAZYINITLIST(actions_list[action.action_tab])
		actions_list[action.action_tab][action] = action_button

	//check if current peeper tab should be hidden and later reloaded
	var/should_reload_screen = FALSE
	if(hud_used.peeper_active && istype(hud_used.peeper.current_tab, /datum/peeper_tab/actions))
		should_reload_screen = TRUE
		hud_used.peeper.current_tab.hide_tab()
	// update all action tabs with the new actions
	var/datum/peeper_tab/actions/peeper_actions
	for(var/action_tab_type in actions_list)
		peeper_actions = hud_used.peeper.peeper_tabs[action_tab_type]
		if(!peeper_actions)
			peeper_actions = hud_used.peeper.add_peeper_tab(action_tab_type)
		peeper_actions.action_buttons = actions_list[action_tab_type]
	// reload current tab if necessary
	if(should_reload_screen && reload_screen)
		hud_used.peeper.current_tab.show_tab()
	// check for deletion of unused peeper tabs
	for(var/peeper_tab_type in hud_used.peeper.peeper_tabs)
		peeper_actions = hud_used.peeper.peeper_tabs[peeper_tab_type]
		if(!istype(peeper_actions))
			continue
		peeper_actions.action_buttons = actions_list[peeper_actions.type]
		if((peeper_actions.type != /datum/peeper_tab/actions) && !LAZYLEN(peeper_actions.action_buttons))
			QDEL_NULL(peeper_actions)

/mob/get_projectile_hitsound(obj/projectile/projectile)
	return "modular_septic/sound/bullet/projectile_impact/ric_flesh[rand(1,4)].wav"

/// Attributes
/mob/proc/attribute_initialize()
	// If we have an attribute holder, lets get that W
	if(!ispath(attributes))
		return
	attributes = new attributes(src)

/// Adjust the hydration of a mob
/mob/proc/adjust_hydration(change)
	hydration = max(0, hydration + change)

/// Force set the mob hydration
/mob/proc/set_hydration(change)
	hydration = max(0, change)
