/atom/movable/screen/bookmark
	name = "toggle upper inventory on"
	icon = 'modular_septic/icons/hud/quake/screen_quake.dmi'
	icon_state = "bookmark"
	base_icon_state = "bookmark"
	screen_loc = ui_bookmark_off

/atom/movable/screen/bookmark/update_name(updates)
	. = ..()
	name = (hud?.upper_inventory_shown ? "toggle upper inventory off" : "toggle upper inventory on")

/atom/movable/screen/bookmark/Click()
	var/mob/targetmob = usr

	if(isobserver(targetmob))
		if(ishuman(targetmob.client.eye) && (targetmob.client.eye != targetmob))
			targetmob = targetmob.client.eye

	usr.hud_used?.inventory_shown = TRUE
	if(targetmob.hud_used && usr.hud_used?.upper_inventory_shown)
		usr.hud_used?.upper_inventory_shown = FALSE
		usr.client.screen -= targetmob.hud_used.upper_inventory
		screen_loc = ui_bookmark_off
	else
		usr.hud_used?.upper_inventory_shown = TRUE
		usr.client.screen += targetmob.hud_used.upper_inventory
		screen_loc = ui_bookmark_on

	targetmob.hud_used.hidden_inventory_update(usr)
