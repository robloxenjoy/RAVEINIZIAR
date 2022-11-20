/mob/living/ComponentInitialize()
	. = ..()
	RegisterSignal(src, SIGNAL_ADDTRAIT(TRAIT_SPRINT_LOCKED), .proc/on_sprint_locked_gain)
	RegisterSignal(src, SIGNAL_REMOVETRAIT(TRAIT_SPRINT_LOCKED), .proc/on_sprint_locked_loss)

/mob/living/proc/on_sprint_locked_gain()
	disable_sprint()
	hud_used?.sprint?.update_appearance()
	hud_used?.mov_intent?.update_appearance()

/mob/living/proc/on_sprint_locked_loss()
	if(CHECK_BITFIELD(combat_flags, COMBAT_FLAG_SPRINT_ACTIVE))
		enable_sprint()
	hud_used?.sprint?.update_appearance()
	hud_used?.mov_intent?.update_appearance()

/mob/living/proc/toggle_sprint()
	if(HAS_TRAIT(src, TRAIT_SPRINT_LOCKED))
		if(!(combat_flags & COMBAT_FLAG_SPRINT_ACTIVE))
			to_chat(src, span_warning("I can't sprint!"))
		combat_flags ^= COMBAT_FLAG_SPRINT_ACTIVE
		hud_used?.sprint?.update_appearance()
		return
	combat_flags ^= COMBAT_FLAG_SPRINT_ACTIVE
	if(usable_legs < default_num_legs)
		to_chat(src, span_warning("Not enough legs!"))
		return
	if(CHECK_BITFIELD(combat_flags, COMBAT_FLAG_SPRINT_ACTIVE))
		playsound_local(src, 'modular_septic/sound/effects/sprintactivate.ogg', 60, FALSE, pressure_affected = FALSE)
		enable_sprint()
	else
		playsound_local(src, 'modular_septic/sound/effects/sprintdeactivate.ogg', 60, FALSE, pressure_affected = FALSE)
		disable_sprint()
	hud_used?.sprint?.update_appearance()
	hud_used?.mov_intent?.update_appearance()

/mob/living/proc/enable_sprint()
	if(m_intent != MOVE_INTENT_RUN)
		toggle_move_intent()
	combat_flags |= COMBAT_FLAG_SPRINTING
	add_movespeed_modifier(/datum/movespeed_modifier/sprinting, TRUE)

/mob/living/proc/disable_sprint()
	combat_flags &= ~COMBAT_FLAG_SPRINTING
	remove_movespeed_modifier(/datum/movespeed_modifier/sprinting, TRUE)

/mob/living/proc/sprint_loss_tiles(tile_amount = 1)
	adjustStaminaLoss(tile_amount * GLOB.sprint_stamina_cost)
	adjustFatigueLoss(tile_amount * GLOB.sprint_fatigue_cost)
