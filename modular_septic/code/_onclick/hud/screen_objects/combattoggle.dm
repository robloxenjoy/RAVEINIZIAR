/atom/movable/screen/combattoggle
	name = "combat mode on"
	icon = 'modular_septic/icons/hud/quake/screen_quake.dmi'
	icon_state = "combat_on"
	base_icon_state = "combat"
	screen_loc = ui_combat_toggle

/atom/movable/screen/combattoggle/update_name(updates)
	. = ..()
	var/mob/living/user = hud?.mymob
	if(!istype(user) || !user.client)
		return
	name = (user.combat_mode ? "combat mode off" : "combat mode on")

/atom/movable/screen/combattoggle/update_icon_state()
	. = ..()
	var/mob/living/user = hud?.mymob
	if(!istype(user) || !user.client)
		return
	icon_state = user.combat_mode ? "[base_icon_state]_on" : "[base_icon_state]"

