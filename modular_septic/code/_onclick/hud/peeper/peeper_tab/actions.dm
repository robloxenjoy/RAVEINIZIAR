#define ACTIONS_PER_LOADOUT 15

/datum/peeper_tab/actions
	current_loadout_switches = list()
	/// Action buttons currently being exhibited
	var/list/atom/movable/screen/movable/action_button/current_action_buttons
	/// This list is kept up to date with all the fucking action buttons our owner has
	var/list/atom/movable/screen/movable/action_button/action_buttons
	/// Background for the informative tooltip
	var/atom/movable/screen/action_tooltip_background/action_tooltip_background
	/// The thing that holds the maptext of what we're hovering over
	var/atom/movable/screen/action_tooltip/action_tooltip

/datum/peeper_tab/actions/New(datum/peeper/owner)
	. = ..()
	action_tooltip_background = new(mypeeper?.myhud)
	action_tooltip = new(mypeeper?.myhud)
	loadout_up = new /atom/movable/screen/tab_loadout/up/actions(mypeeper?.myhud)
	loadout_up.mytab = src
	loadout_down = new /atom/movable/screen/tab_loadout/down/actions(mypeeper?.myhud)
	loadout_down.mytab = src

/datum/peeper_tab/actions/Destroy()
	. = ..()
	current_action_buttons = null
	action_buttons = null
	QDEL_NULL(action_tooltip_background)
	QDEL_NULL(action_tooltip)
	QDEL_NULL(loadout_up)
	QDEL_NULL(loadout_down)

/datum/peeper_tab/actions/show_tab()
	update_tab_loadout()
	return ..()

/datum/peeper_tab/actions/get_all_screen_atoms()
	. = ..()
	. |= flatten_list(action_buttons)
	. |= loadout_up
	. |= loadout_down
	. |= action_tooltip_background
	. |= action_tooltip

/datum/peeper_tab/actions/get_visible_screen_atoms()
	. = ..()
	. |= current_action_buttons
	. |= current_loadout_switches
	. |= action_tooltip_background
	. |= action_tooltip

/datum/peeper_tab/actions/update_tab_loadout()
	current_action_buttons = list()
	var/counter = 0
	var/current_button = 0
	var/actions_per_row = ACTIONS_PER_LOADOUT/3
	var/atom/movable/screen/movable/action_button/action_button
	for(var/action in action_buttons)
		action_button = action_buttons[action]
		action_button.mytab = src
		counter++
		//only display actions that match the current tab
		if(counter <= (current_loadout * ACTIONS_PER_LOADOUT))
			continue
		if(current_button >= ACTIONS_PER_LOADOUT)
			break
		var/width = 1 + (current_button % actions_per_row)
		var/height = 3 - FLOOR(current_button/actions_per_row, 1)
		current_action_buttons |= action_button
		action_button.screen_loc = "statmap:[width],[height]"
		current_button++
	current_loadout_switches = list()
	var/max_loadout = FLOOR((counter-1)/ACTIONS_PER_LOADOUT, 1)
	if(current_loadout > 0)
		current_loadout_switches |= loadout_up
	if(current_loadout < max_loadout)
		current_loadout_switches |= loadout_down
	return TRUE

/datum/peeper_tab/actions/proc/update_action_tooltip(atom/movable/screen/movable/action_button/action_button)
	if(!istype(action_button))
		action_tooltip?.update_maptext("N/A")
		return
	action_tooltip?.update_maptext(action_button.name)

#undef ACTIONS_PER_LOADOUT
