/obj/item/flashlight/flare
	pickup_sound = 'modular_septic/sound/effects/flare_prepare.ogg'
	var/datum/looping_sound/flare/soundloop

/obj/item/flashlight/flare/Initialize(mapload)
	. = ..()
	soundloop = new(src, FALSE)

/obj/item/flashlight/flare/Destroy()
	. = ..()
	QDEL_NULL(soundloop)

/obj/item/flashlight/flare/process(delta_time)
	open_flame(heat)
	fuel = max(fuel - delta_time, 0)
	if((fuel <= 0) || !on)
		turn_off()
		playsound(src, 'modular_septic/sound/effects/flare_end.ogg', 90, FALSE)
		if(!fuel)
			icon_state = "[initial(icon_state)]-empty"
		STOP_PROCESSING(SSobj, src)

/obj/item/flashlight/flare/attack_self(mob/user)
	if(fuel <= 0)
		to_chat(user, span_warning("[src] ends!"))
		return
	if(on)
		to_chat(user, span_warning("[src] is on fire!"))
		return

	. = ..()
	if(.)
		user.visible_message(span_notice("[user] activates [src]."), span_notice("I activate [src]!"))
		playsound(src, 'modular_septic/sound/effects/flare_start.ogg', 90, FALSE)
		soundloop.start()
		force = on_damage
		damtype = BURN
		START_PROCESSING(SSobj, src)

/obj/item/flashlight/flare/turn_off()
	. = ..()
	soundloop.stop()
