/datum/peeper_tab
	/// Name of this tab
	var/name = "something"
	/// Description of the tab, for the switch tooltip
	var/desc = "Tab that contains a bunch of stuff."
	/// Icon our switch uses
	var/icon = 'modular_septic/icons/hud/quake/peeper.dmi'
	/// Icon state our switch uses
	var/icon_state = "tab"
	/// The peeper datum that owns us
	var/datum/peeper/mypeeper
	/// In case we have a switch button to switch to this tab
	var/atom/movable/screen/peeper_tab_switch/switch_button = /atom/movable/screen/peeper_tab_switch

	// ~LOADOUT VARIABLES
	/// In case this tab uses some kind of loadout system, this is the current index for the loadout
	var/current_loadout = 0
	/// Loadout switch buttons we are currently exhibiting
	var/list/atom/movable/screen/tab_loadout/current_loadout_switches
	/// Loadout up switch
	var/atom/movable/screen/tab_loadout/up/loadout_up
	/// Loadout down switch
	var/atom/movable/screen/tab_loadout/down/loadout_down

/datum/peeper_tab/New(datum/peeper/owner)
	. = ..()
	if(switch_button)
		switch_button = new switch_button(src)
		switch_button.mytab = src
	set_peeper(owner)
	initialize_screen_atoms()

/datum/peeper_tab/Destroy()
	. = ..()
	if(mypeeper)
		mypeeper.remove_peeper_tab(src)
		mypeeper = null
	if(switch_button)
		QDEL_NULL(switch_button)

/datum/peeper_tab/proc/set_peeper(datum/peeper/new_peeper)
	mypeeper = new_peeper
	if(switch_button)
		if(istype(new_peeper))
			switch_button.hud = new_peeper?.myhud
		else
			switch_button.hud = null

/datum/peeper_tab/proc/show_tab()
	if(!mypeeper?.myhud?.mymob?.client)
		return
	var/list/screen_atoms = get_visible_screen_atoms()
	if(screen_atoms)
		mypeeper.myhud.mymob.client.screen |= screen_atoms

/datum/peeper_tab/proc/hide_tab()
	if(!mypeeper?.myhud?.mymob?.client)
		return
	var/list/screen_atoms = get_all_screen_atoms()
	if(screen_atoms)
		mypeeper.myhud.mymob.client.screen -= screen_atoms

/datum/peeper_tab/proc/initialize_screen_atoms()

/datum/peeper_tab/proc/get_all_screen_atoms()
	. = list()

/datum/peeper_tab/proc/get_visible_screen_atoms()
	. = list()

/datum/peeper_tab/proc/loadout_up()
	current_loadout--
	update_tab_loadout()
	if((mypeeper?.current_tab == src) && (mypeeper.myhud?.peeper_active) && mypeeper.myhud.mymob?.client)
		hide_tab()
		show_tab()

/datum/peeper_tab/proc/loadout_down()
	current_loadout++
	update_tab_loadout()
	if((mypeeper?.current_tab == src) && (mypeeper.myhud?.peeper_active) && mypeeper.myhud.mymob?.client)
		hide_tab()
		show_tab()

/datum/peeper_tab/proc/update_tab_loadout()
	return FALSE
