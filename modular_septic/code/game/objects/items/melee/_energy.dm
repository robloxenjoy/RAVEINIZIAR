/obj/item/melee/energy/sword/kelzad
	name = "Bonitinho"
	desc = "A highly dangerous device manufactured by a dumbass scientist used specifically for slicing onions."
	icon = 'modular_septic/icons/obj/items/melee/transforming_energy.dmi'
	base_icon_state = "kelzad"
	icon_state = "kelzad"
	lefthand_file = 'modular_septic/icons/mob/inhands/sword_lefthand.dmi'
	righthand_file = 'modular_septic/icons/mob/inhands/sword_righthand.dmi'
	active_force = 70
	active_hitsound = list('modular_septic/sound/weapons/kelzad1.wav', 'modular_septic/sound/weapons/kelzad2.wav')
	stealthy_audio = FALSE
	sword_color_icon = "blue"
	light_color = COLOR_BLUE
	parrying_modifier = -3
	//Kelzad Sounding
	var/datum/looping_sound/kelzad/soundloop

/obj/item/melee/energy/sword/kelzad/Initialize(mapload)
	. = ..()
	soundloop = new(src, FALSE)

/obj/item/melee/energy/sword/kelzad/Destroy()
	. = ..()
	QDEL_NULL(soundloop)

/obj/item/melee/energy/sword/kelzad/on_transform(obj/item/source, mob/user, active)
	blade_active = active
	if(active)
		if(sword_color_icon)
			icon_state = "[icon_state]_[sword_color_icon]"
		if(embedding)
			updateEmbedding()
		heat = active_heat
		parrying_modifier = 1
		min_force = 70
		force = 70
		min_force_strength = 0
		force_strength = 0
		wound_bonus = 3
		bare_wound_bonus = 0
		parrying_flags = BLOCK_FLAG_MELEE | BLOCK_FLAG_UNARMED | BLOCK_FLAG_THROWN | BLOCK_FLAG_PROJECTILE
		START_PROCESSING(SSobj, src)
	else
		if(embedding)
			disableEmbedding()
		heat = initial(heat)
		parrying_modifier = -3
		min_force = 1
		force = 2
		min_force_strength = 0.2
		force_strength = 0.5
		wound_bonus = 0
		bare_wound_bonus = 0
		parrying_flags = BLOCK_FLAG_MELEE | BLOCK_FLAG_UNARMED | BLOCK_FLAG_THROWN
		STOP_PROCESSING(SSobj, src)
	if(active)
		soundloop.start()
	else
		soundloop.stop()

	balloon_alert(user, "[name] [active ? "enabled":"disabled"]")
	playsound(user ? user : src, active ? 'modular_septic/sound/weapons/kelzadon.wav' : 'modular_septic/sound/weapons/kelzadoff.ogg', 60, TRUE)
	set_light_on(active)
	return COMPONENT_NO_DEFAULT_MESSAGE
