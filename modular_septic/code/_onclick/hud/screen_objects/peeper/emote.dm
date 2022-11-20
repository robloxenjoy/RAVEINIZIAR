/atom/movable/screen/emote
	name = "Emote"
	icon = 'modular_septic/icons/hud/quake/peeper.dmi'
	icon_state = "emote"
	plane = PEEPER_PLANE
	layer = PEEPER_OBJECT_LAYER
	maptext_height = 16
	maptext_width = 64
	maptext_x = 4
	maptext_y = 0
	mouse_opacity = MOUSE_OPACITY_ICON
	var/emote_key = ""

/atom/movable/screen/emote/New(datum/emote/our_emote)
	. = ..()
	if(our_emote)
		emote_key = our_emote.key
		name = capitalize(emote_key)
		maptext = MAPTEXT_PEEPER(capitalize(emote_key))

/atom/movable/screen/emote/Click(location, control, params)
	. = ..()
	usr.emote(emote_key, intentional = TRUE)

/atom/movable/screen/emote/MouseEntered(location, control, params)
	. = ..()
	maptext = MAPTEXT_PEEPER_CYAN(capitalize(emote_key))

/atom/movable/screen/emote/MouseExited(location, control, params)
	. = ..()
	maptext = MAPTEXT_PEEPER(capitalize(emote_key))
