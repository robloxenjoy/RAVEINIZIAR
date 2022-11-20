/datum/hud
	/// Is the peeper open?
	var/peeper_active = FALSE
	/// This datum essentially controls a completely separate section of the HUD
	var/datum/peeper/peeper

	var/atom/movable/screen/fullscreen/fog_blocker/fog_blocker
	var/atom/movable/screen/fullscreen/noise/noise
	var/atom/movable/screen/fullscreen/pain_flash/pain_flash
	var/atom/movable/screen/sadness/sadness
	var/atom/movable/screen/fov_holder/fov_holder
	var/atom/movable/screen/stats/stat_viewer
	var/atom/movable/screen/lookup/lookup
	var/atom/movable/screen/lookdown/lookdown
	var/atom/movable/screen/surrender/surrender
	var/atom/movable/screen/pressure/pressure
	var/atom/movable/screen/nutrition/nutrition
	var/atom/movable/screen/hydration/hydration
	var/atom/movable/screen/temperature/temperature
	var/atom/movable/screen/bodytemperature/bodytemperature
	var/atom/movable/screen/fixeye/fixeye
	var/atom/movable/screen/human/pain/pain_guy
	var/atom/movable/screen/breath/breath
	var/atom/movable/screen/fatigue/fatigue
	var/atom/movable/screen/bookmark/bookmark
	var/atom/movable/screen/human/equip
	var/atom/movable/screen/swap_hand/swap_hand
	var/atom/movable/screen/info/info_button
	var/atom/movable/screen/combat_style/combat_style
	var/atom/movable/screen/intent_select/intents
	var/atom/movable/screen/dodge_parry/dodge_parry
	var/atom/movable/screen/special_attack/special_attack
	var/atom/movable/screen/sleeping/sleeping
	var/atom/movable/screen/teach/teach
	var/atom/movable/screen/wield/wield
	var/atom/movable/screen/sprint/sprint
	var/atom/movable/screen/mov_intent/mov_intent
	var/atom/movable/screen/enhanced_sel/enhanced_sel
	var/atom/movable/screen/filler/filler

	var/upper_inventory_shown = FALSE
	var/list/upper_inventory = list()

	var/uses_film_grain = TRUE

/datum/hud/New(mob/owner)
	. = ..()
	if(uses_film_grain && (!owner?.client || owner.client?.prefs?.read_preference(/datum/preference/toggle/filmgrain)))
		noise = new()
		noise.hud = src
		screenoverlays |= noise
		noise.update_appearance()
	sadness = new()
	sadness.hud = src
	screenoverlays |= sadness
	pain_flash = new()
	pain_flash.hud = src
	fog_blocker = new()
	fog_blocker.hud = src
	screenoverlays |= pain_flash
	screenoverlays |= fog_blocker
	if(ispath(peeper))
		peeper = new peeper(src)
		peeper?.show_peeper(owner)

/datum/hud/show_hud(version, mob/viewmob)
	. = ..()
	var/mob/screenmob = viewmob || mymob
	if(noise)
		screenmob.client?.screen |= noise
	if(pain_flash)
		screenmob.client?.screen |= pain_flash
	if(sadness)
		screenmob.client?.screen |= sadness
	if(fov_holder)
		screenmob.client?.screen |= fov_holder
	if(fog_blocker)
		screenmob.client?.screen |= fog_blocker
	if((screenmob == mymob) && peeper)
		add_verb(screenmob, /mob/proc/open_peeper)
		add_verb(screenmob, /mob/proc/close_peeper)
		if(peeper_active)
			peeper.show_peeper(screenmob)

/datum/hud/get_action_buttons_icons()
	. = list()
	.["bg_icon"] = 'modular_septic/icons/hud/quake/actions.dmi'
	.["bg_state"] = "template"

	.["toggle_icon"] = 'modular_septic/icons/hud/quake/actions.dmi'
	.["toggle_hide"] = "hide"
	.["toggle_show"] = "show"

/datum/hud/reorganize_alerts(mob/viewmob)
	var/mob/screenmob = viewmob || mymob
	if(!screenmob.client)
		return
	var/list/alerts = mymob.alerts
	if(!hud_shown)
		screenmob.client.screen -= flatten_list(alerts)
		return TRUE
	if(!peeper?.peeper_tabs[/datum/peeper_tab/alerts])
		return TRUE
	var/datum/peeper_tab/alerts/peeper_alerts = peeper.peeper_tabs[/datum/peeper_tab/alerts]
	if(peeper_active && (peeper.current_tab == peeper_alerts))
		peeper_alerts.hide_tab()
	peeper_alerts.all_alerts = list()
	var/atom/movable/screen/alert/alert
	for(var/i in 1 to LAZYLEN(alerts))
		alert = alerts[alerts[i]]
		peeper_alerts.all_alerts |= alert
	peeper_alerts.update_tab_loadout()
	if(peeper_active && (peeper.current_tab == peeper_alerts))
		peeper_alerts.show_tab()

/datum/hud/proc/update_chromatic_aberration(intensity = 0, \
											time = 2 SECONDS, \
											easing = LINEAR_EASING, \
											loop = 0,
											red_x = 0, \
											red_y = 0, \
											green_x = 0, \
											green_y = 0, \
											blue_x = 0, \
											blue_y = 0)
	var/atom/movable/screen/plane_master/rendering_plate/game_world_processing/game_world_processing = plane_masters["[RENDER_PLANE_GAME_PROCESSING]"]
	if(!game_world_processing || (game_world_processing.chromatic_intensity == intensity))
		return
	game_world_processing.chromatic_intensity = intensity
	game_world_processing.transition_filter("blue", time, list("x" = blue_x, "y" = blue_y), easing, loop)
	game_world_processing.transition_filter("green", time, list("x" = green_x, "y" = green_y), easing, loop)
	game_world_processing.transition_filter("red", time, list("x" = red_x, "y" = red_y), easing, loop)

/datum/hud/proc/destroy_remaining_hud()
	QDEL_LIST_ASSOC(inv_slots)
	QDEL_LIST(upper_inventory)
	QDEL_NULL(peeper)
	QDEL_NULL(action_intent)
	QDEL_NULL(intent_select)
	QDEL_NULL(zone_select)
	QDEL_NULL(pull_icon)
	QDEL_NULL(noise)
	QDEL_NULL(sadness)
	QDEL_NULL(pain_flash)
	QDEL_NULL(fov_holder)
	QDEL_NULL(lookup)
	QDEL_NULL(surrender)
	QDEL_NULL(pressure)
	QDEL_NULL(nutrition)
	QDEL_NULL(hydration)
	QDEL_NULL(temperature)
	QDEL_NULL(fixeye)
	QDEL_NULL(pain_guy)
	QDEL_NULL(breath)
	QDEL_NULL(fatigue)
	QDEL_NULL(info_button)
	QDEL_NULL(combat_style)
	QDEL_NULL(intents)
	QDEL_NULL(dodge_parry)
	QDEL_NULL(special_attack)
	QDEL_NULL(sleeping)
	QDEL_NULL(teach)
	QDEL_NULL(wield)
	QDEL_NULL(sprint)
	QDEL_NULL(throw_icon)
	QDEL_NULL(healths)
	QDEL_NULL(healthdoll)
	QDEL_NULL(wanted_lvl)
	QDEL_NULL(internals)
	QDEL_NULL(spacesuit)
	QDEL_NULL(lingchemdisplay)
	QDEL_NULL(lingstingdisplay)
	QDEL_NULL(blobpwrdisplay)
	QDEL_NULL(alien_plasma_display)
	QDEL_NULL(alien_queen_finder)
	QDEL_NULL(combo_display)
