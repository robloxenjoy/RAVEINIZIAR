#define SWITCHES_PER_LOADOUT 4

/**
 * THE PEEPER
 * This datum controls a separate section of the hud, that can be accessed by the stat panel.
 * This should be composed of hud elements that don't really need to be constantly shown to the player.
 */
/datum/peeper
	/// Hud that owns us
	var/datum/hud/myhud
	/// Background, necessary so the peeper renders properly
	var/atom/movable/screen/peeper_background/background
	/// The loadout rack
	var/atom/movable/screen/peeper_loadout_background/loadout_background
	/// Button the user clicks on to hide us
	var/atom/movable/screen/peeper_close/closer
	/// Tab we are currently on
	var/datum/peeper_tab/current_tab
	/// All peeper tabs available to us
	var/list/datum/peeper_tab/peeper_tabs = list()
	/// Peeper tab switch objects we are currently exhibiting
	var/list/atom/movable/screen/peeper_tab_switch/current_tab_switches = list()
	/// All peeper tab switch objects available to us
	var/list/atom/movable/screen/peeper_tab_switch/peeper_tab_switches = list()
	/// Loadout switch buttons we are currently exhibiting
	var/list/atom/movable/screen/peeper_loadout/current_loadout_switches = list()
	/// Loadout up switch
	var/atom/movable/screen/peeper_loadout/up/loadout_up
	/// Loadout down switch
	var/atom/movable/screen/peeper_loadout/down/loadout_down
	/// In case we have too many tab switches, which switch "loadout" are we using?
	var/curent_tab_loadout = 0

/datum/peeper/New(datum/hud/owner)
	. = ..()
	if(owner)
		myhud = owner
	initialize_screen_atoms()
	add_default_peeper_tabs()

/datum/peeper/Destroy()
	. = ..()
	if(myhud?.peeper_active && myhud.mymob?.client)
		myhud.mymob.close_peeper()
	for(var/tab_type in peeper_tabs)
		remove_peeper_tab(peeper_tabs[tab_type])
		qdel(peeper_tabs[tab_type])
	current_tab = null
	peeper_tabs = null
	current_tab_switches = null
	peeper_tab_switches = null
	current_loadout_switches = null
	QDEL_NULL(loadout_up)
	QDEL_NULL(loadout_down)
	QDEL_NULL(closer)

/datum/peeper/proc/initialize_screen_atoms()
	closer = new(myhud)
	background = new(myhud)
	loadout_background = new(myhud)
	loadout_up = new(myhud)
	loadout_down = new(myhud)
	if(myhud)
		closer.hud = myhud
		background.hud = myhud
		loadout_background.hud = myhud
		loadout_up.hud = myhud
		loadout_down.hud = myhud

/datum/peeper/proc/show_peeper(mob/shown_to)
	if(!shown_to?.client)
		return
	winset(shown_to.client, "statbrowser", "is-visible=false")
	winset(shown_to.client, "statmap", "is-visible=true")
	myhud?.peeper_active = TRUE
	current_tab?.show_tab()
	shown_to.client.screen |= get_visible_screen_atoms()

/datum/peeper/proc/hide_peeper(mob/hidden_from)
	if(!hidden_from?.client)
		return
	winset(hidden_from.client, "statbrowser", "is-visible=true")
	winset(hidden_from.client, "statmap", "is-visible=false")
	myhud?.peeper_active = FALSE
	current_tab?.hide_tab()
	hidden_from.client.screen -= get_all_screen_atoms()

/datum/peeper/proc/get_visible_screen_atoms()
	. = list()
	. |= closer
	. |= background
	. |= loadout_background
	. |= current_tab_switches
	. |= current_loadout_switches

/datum/peeper/proc/get_all_screen_atoms()
	. = list()
	. |= closer
	. |= background
	. |= loadout_background
	. |= loadout_up
	. |= loadout_down
	. |= flatten_list(peeper_tab_switches)

/datum/peeper/proc/add_default_peeper_tabs()
	change_tab(add_peeper_tab(/datum/peeper_tab/alerts))
	add_peeper_tab(/datum/peeper_tab/actions)
	add_peeper_tab(/datum/peeper_tab/emotes)

/datum/peeper/proc/add_peeper_tab(datum/peeper_tab/tab_type)
	var/datum/peeper_tab/new_tab
	if(istype(tab_type))
		new_tab = tab_type
	else
		new_tab = new tab_type(src)
	peeper_tabs[new_tab.type] = new_tab
	if(new_tab.switch_button)
		peeper_tab_switches[new_tab.type] = new_tab.switch_button
	update_tab_switches()
	if(myhud?.peeper_active && myhud.mymob?.client)
		myhud.mymob.client.screen |= new_tab.switch_button
	return new_tab

/datum/peeper/proc/remove_peeper_tab(datum/peeper_tab/removed_tab)
	if(!istype(removed_tab))
		for(var/peeper_tab in peeper_tabs)
			if(istype(peeper_tab, removed_tab))
				removed_tab = peeper_tab
				break
		if(!istype(removed_tab))
			return FALSE
	peeper_tabs -= removed_tab.type
	if(removed_tab.switch_button)
		peeper_tab_switches -= removed_tab.type
	if(removed_tab == current_tab)
		if(length(peeper_tabs))
			var/new_tab_index = peeper_tabs[1]
			change_tab(peeper_tabs[new_tab_index])
		else
			current_tab = null
	update_tab_switches()
	if(myhud?.peeper_active && myhud.mymob)
		myhud.mymob.client.screen -= removed_tab.switch_button
	return TRUE

/datum/peeper/proc/change_tab(datum/peeper_tab/new_tab)
	if(!istype(new_tab))
		for(var/tab_type in peeper_tabs)
			var/peeper_tab = peeper_tabs[tab_type]
			if(istype(peeper_tab, new_tab))
				new_tab = peeper_tab
				break
		if(!istype(new_tab))
			return FALSE
	current_tab?.hide_tab()
	current_tab = new_tab
	current_tab?.show_tab()

/datum/peeper/proc/update_tab_switches()
	current_tab_switches = list()
	var/current_button = 0
	var/counter = 0
	var/atom/movable/screen/peeper_tab_switch/tab_switch
	for(var/tab_type in peeper_tab_switches)
		tab_switch = peeper_tab_switches[tab_type]
		counter++
		//only display switches that match the current tab
		if(counter <= (curent_tab_loadout * SWITCHES_PER_LOADOUT))
			continue
		current_button++
		if(current_button > SWITCHES_PER_LOADOUT)
			break
		tab_switch.screen_loc = "statmap:0,[SWITCHES_PER_LOADOUT-current_button]"
		current_tab_switches |= tab_switch
	current_loadout_switches = list()
	var/max_loadout = FLOOR((counter-1)/SWITCHES_PER_LOADOUT, 1)
	if(curent_tab_loadout > 0)
		current_loadout_switches |= loadout_up
	if(curent_tab_loadout < max_loadout)
		current_loadout_switches |= loadout_down
	return TRUE

/datum/peeper/proc/loadout_up()
	curent_tab_loadout--
	update_tab_switches()
	if(myhud?.peeper_active && myhud.mymob?.client)
		hide_peeper(myhud.mymob)
		show_peeper(myhud.mymob)

/datum/peeper/proc/loadout_down()
	curent_tab_loadout++
	update_tab_switches()
	if(myhud?.peeper_active && myhud.mymob?.client)
		hide_peeper(myhud.mymob)
		show_peeper(myhud.mymob)

#undef SWITCHES_PER_LOADOUT
