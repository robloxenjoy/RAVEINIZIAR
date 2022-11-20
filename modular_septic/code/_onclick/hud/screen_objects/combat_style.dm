/atom/movable/screen/combat_style
	name = "combat style"
	icon = 'modular_septic/icons/hud/quake/screen_quake_combat_styles.dmi'
	icon_state = CS_DEFAULT
	screen_loc = ui_combat_style
	var/expanded = FALSE
	var/obj/effect/overlay/combatstyle/style_overlay

/atom/movable/screen/combat_style/Initialize()
	. = ..()
	style_overlay = new()
	style_overlay.parent = src
	style_overlay.pixel_y = pixel_y + 32

/atom/movable/screen/combat_style/Click(location, control, params)
	. = ..()
	var/list/modifiers = params2list(params)
	if(LAZYACCESS(modifiers, SHIFT_CLICK))
		var/mob/living/user = usr
		if(istype(user))
			user.print_combat_style(user.combat_style)
		return
	expanded = !expanded
	update_appearance()

/atom/movable/screen/combat_style/update_icon_state()
	. = ..()
	if(hud?.mymob && isliving(hud.mymob))
		var/mob/living/owner = hud.mymob
		icon_state = owner.combat_style

/atom/movable/screen/combat_style/update_overlays()
	. = ..()
	if(expanded && style_overlay)
		vis_contents += style_overlay
	else
		vis_contents -= style_overlay

/obj/effect/overlay/combatstyle
	name = "combat styles"
	icon = 'modular_septic/icons/hud/quake/screen_quake_combat_style.dmi'
	icon_state = "combat_style"
	plane = HUD_PLANE
	screentip_flags = SCREENTIP_HOVERER_CLICKER
	anchored = TRUE
	var/atom/movable/screen/combat_style/parent

/obj/effect/overlay/combatstyle/Click(location, control, params)
	. = ..()
	var/list/modifiers = params2list(params)
	var/icon_x = text2num(LAZYACCESS(modifiers, ICON_X))
	var/icon_y = text2num(LAZYACCESS(modifiers, ICON_Y))
	var/style = get_style_at(icon_x, icon_y)
	if(LAZYACCESS(modifiers, SHIFT_CLICK))
		var/mob/living/user = usr
		if(istype(user))
			user.print_combat_style(style)
		return
	if(!style)
		parent?.expanded = FALSE
		parent?.update_appearance()
	else
		var/mob/living/carbon/user = usr
		if(istype(user))
			user.switch_combat_style(style)
		parent?.update_appearance()

/obj/effect/overlay/combatstyle/return_screentip(mob/user, params)
	if(flags_1 & NO_SCREENTIPS_1)
		return ""

	var/list/modifiers = params2list(params)
	var/icon_x = text2num(LAZYACCESS(modifiers, ICON_X))
	var/icon_y = text2num(LAZYACCESS(modifiers, ICON_Y))
	var/parsed_style = get_style_at(icon_x, icon_y)
	if(!parsed_style)
		parsed_style = name
	return SCREENTIP_OBJ(uppertext(parsed_style))

/obj/effect/overlay/combatstyle/proc/get_style_at(icon_x, icon_y)
	switch(icon_x)
		if(3 to 30)
			switch(icon_y)
				if(12 to 17)
					return CS_NONE
				if(18 to 23)
					return CS_FEINT
				if(24 to 29)
					return CS_DEFEND
				if(30 to 35)
					return CS_GUARD
				if(36 to 41)
					return CS_DUAL
				if(42 to 47)
					return CS_STRONG
				if(48 to 53)
					return CS_FURY
				if(54 to 59)
					return CS_AIMED
				if(60 to 66)
					return CS_WEAK
