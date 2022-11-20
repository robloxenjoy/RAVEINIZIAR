#define EMOTES_PER_LOADOUT 16

/datum/peeper_tab/emotes
	name = "Emote"
	desc = "Tab that contains shortcuts to emotes."
	icon_state = "emote_tab"
	current_loadout_switches = list()
	/// Help button that always appears on this tab
	var/atom/movable/screen/emote/help
	/// Emote buttons currently being exhibited
	var/list/atom/movable/screen/emote/current_emote_buttons = list()
	/// Emote screen atoms indexed by emote datum
	var/list/atom/movable/screen/emote/emote_buttons = list()

/datum/peeper_tab/emotes/initialize_screen_atoms()
	. = ..()
	var/datum/emote/help/help_emote = GLOB.emote_list["help"][1]
	help = new /atom/movable/screen/emote(help_emote)
	help.maptext_x = 5
	help.maptext_y = 0
	help.screen_loc = ui_peeper_emote_help
	loadout_up = new /atom/movable/screen/tab_loadout/up/emotes(mypeeper?.myhud)
	loadout_up.mytab = src
	loadout_down = new /atom/movable/screen/tab_loadout/down/emotes(mypeeper?.myhud)
	loadout_down.mytab = src

/datum/peeper_tab/emotes/Destroy()
	. = ..()
	current_emote_buttons = null
	for(var/emote_type in emote_buttons)
		qdel(emote_buttons[emote_type])
		emote_buttons -= emote_type
	emote_buttons = null
	QDEL_NULL(help)
	current_loadout_switches = null
	QDEL_NULL(loadout_up)
	QDEL_NULL(loadout_down)

/datum/peeper_tab/emotes/show_tab()
	update_tab_loadout()
	return ..()

/datum/peeper_tab/emotes/get_all_screen_atoms()
	. = ..()
	. |= help
	. |= flatten_list(emote_buttons)
	. |= loadout_up
	. |= loadout_down

/datum/peeper_tab/emotes/get_visible_screen_atoms()
	. = ..()
	. |= help
	. |= current_emote_buttons
	. |= current_loadout_switches

/datum/peeper_tab/emotes/update_tab_loadout()
	current_emote_buttons = list()
	var/emotes_per_column = EMOTES_PER_LOADOUT/2
	var/current_button = 0
	var/counter = 0
	var/list/emote_datums_counted = list()
	var/datum/emote/emote_datum
	var/atom/movable/screen/emote/emote_button
	for(var/act in (GLOB.emote_list-"help"))
		emote_datum = null
		for(var/datum/emote/candidate_emote as anything in GLOB.emote_list[act])
			//first emote datum that works wins out
			if(!(candidate_emote in emote_datums_counted) && \
				mypeeper?.myhud?.mymob && \
				candidate_emote.can_run_emote(mypeeper.myhud.mymob, FALSE, TRUE))
				emote_datum = candidate_emote
				emote_datums_counted |= emote_datum
				counter++
				break
		//only display emotes that match the current tab
		if(counter <= (current_loadout * EMOTES_PER_LOADOUT))
			continue
		//no valid emotes for this key
		if(!emote_datum)
			continue
		var/width = FLOOR(current_button/emotes_per_column, 1)
		var/height = emotes_per_column - 1 - (current_button % emotes_per_column)
		//we're done
		if(width >= 2)
			continue
		emote_button = emote_buttons[emote_datum.type]
		if(!emote_button)
			emote_button = new(emote_datum)
			emote_button.hud = mypeeper?.myhud
			emote_buttons[emote_datum.type] = emote_button
		current_emote_buttons |= emote_button
		emote_button.screen_loc = "statmap:1:[width*64],0:[height*16]"
		current_button++
	current_loadout_switches = list()
	var/max_loadout = FLOOR((counter-1)/EMOTES_PER_LOADOUT, 1)
	if(current_loadout > 0)
		current_loadout_switches |= loadout_up
	if(current_loadout < max_loadout)
		current_loadout_switches |= loadout_down
	return TRUE

#undef EMOTES_PER_LOADOUT
