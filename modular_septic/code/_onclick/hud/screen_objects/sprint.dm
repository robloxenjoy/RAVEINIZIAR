//Sprint button shit
/atom/movable/screen/sprint
	name = "sprint toggle"
	icon = 'modular_septic/icons/hud/quake/screen_quake.dmi'
	icon_state = "act_sprint"
	base_icon_state = "act_sprint"
	screen_loc = ui_sprint
	var/mutable_appearance/flashy

/atom/movable/screen/sprint/update_name(updates)
	. = ..()
	if(isliving(hud?.mymob))
		var/mob/living/user = hud?.mymob
		if(user.combat_flags & COMBAT_FLAG_SPRINT_ACTIVE)
			name = "toggle sprint off"
		else
			name = "toggle sprint on"

/atom/movable/screen/sprint/Click()
	. = ..()
	if(isliving(usr))
		var/mob/living/user= usr
		user.toggle_sprint()

/atom/movable/screen/sprint/update_icon_state()
	. = ..()
	var/mob/living/user = hud?.mymob
	if(!istype(user))
		return
	if(user.combat_flags & COMBAT_FLAG_SPRINT_ACTIVE)
		icon_state = "[base_icon_state]_on"
	else
		icon_state = base_icon_state
