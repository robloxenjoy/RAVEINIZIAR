/atom/movable/screen/dodge_parry
	name = "dodge/parry toggle"
	icon = 'modular_septic/icons/hud/quake/screen_quake.dmi'
	icon_state = DP_PARRY
	screentip_flags = SCREENTIP_HOVERER_CLICKER
	screen_loc = ui_dodge_parry

/atom/movable/screen/dodge_parry/Click(location, control, params)
	. = ..()
	var/mob/living/carbon/user = usr
	if(!istype(user))
		return
	var/list/modifiers = params2list(params)
	var/icon_y = text2num(LAZYACCESS(modifiers, ICON_Y))
	var/what_we_chose = (icon_y > 16 ? DP_DODGE : DP_PARRY)
	user.toggle_dodge_parry(what_we_chose)
	update_appearance()

/atom/movable/screen/dodge_parry/return_screentip(mob/user, params)
	if(flags_1 & NO_SCREENTIPS_1)
		return ""

	var/list/modifiers = params2list(params)
	var/icon_y = text2num(LAZYACCESS(modifiers, ICON_Y))
	var/what_we_chose = (icon_y > 16 ? DP_DODGE : DP_PARRY)
	return SCREENTIP_OBJ(uppertext(what_we_chose))

/atom/movable/screen/dodge_parry/update_icon_state()
	. = ..()
	var/mob/living/owner = hud?.mymob
	if(istype(owner) && (owner.dodge_parry == DP_DODGE))
		icon_state = DP_DODGE
	else
		icon_state = DP_PARRY
