/atom/movable/screen/special_attack
	name = "special attack"
	icon = 'modular_septic/icons/hud/quake/screen_quake.dmi'
	icon_state = "act_specialatk"
	base_icon_state = "act_specialatk"
	screentip_flags = SCREENTIP_HOVERER_CLICKER
	screen_loc = ui_specialattack

/atom/movable/screen/special_attack/Click(location, control, params)
	. = ..()
	var/mob/living/user = usr
	if(!istype(user))
		return
	var/list/PL = params2list(params)
	var/icon_y = text2num(PL["icon-y"])
	var/what_we_chose = SPECIAL_ATK_KICK
	switch(icon_y)
		if(23 to INFINITY)
			what_we_chose = SPECIAL_ATK_KICK
		if(16 to 22)
			what_we_chose = SPECIAL_ATK_JUMP
		if(9 to 15)
			what_we_chose = SPECIAL_ATK_BITE
		if(0 to 8)
			what_we_chose = SPECIAL_ATK_STEAL
	user.toggle_special_attack(what_we_chose)
	update_appearance()

/atom/movable/screen/special_attack/return_screentip(mob/user, params)
	if(flags_1 & NO_SCREENTIPS_1)
		return ""

	var/list/modifiers = params2list(params)
	var/icon_y = text2num(LAZYACCESS(modifiers, ICON_Y))
	var/what_we_chose = SPECIAL_ATK_KICK
	switch(icon_y)
		if(23 to INFINITY)
			what_we_chose = SPECIAL_ATK_KICK
		if(16 to 22)
			what_we_chose = SPECIAL_ATK_JUMP
		if(9 to 15)
			what_we_chose = SPECIAL_ATK_BITE
		if(0 to 8)
			what_we_chose = SPECIAL_ATK_STEAL
	return SCREENTIP_OBJ(uppertext(what_we_chose))

/atom/movable/screen/special_attack/update_icon_state()
	. = ..()
	var/mob/living/owner = hud?.mymob
	if(istype(owner) && (owner.special_attack != SPECIAL_ATK_NONE))
		icon_state = "[base_icon_state]_[owner.special_attack]"
	else
		icon_state = base_icon_state
