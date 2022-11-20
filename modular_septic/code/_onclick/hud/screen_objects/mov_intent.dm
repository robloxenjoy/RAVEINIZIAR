/atom/movable/screen/mov_intent
	name = "jogging"
	icon = 'modular_septic/icons/hud/quake/screen_quake.dmi'
	icon_state = "jogging"
	screen_loc = ui_movi

/atom/movable/screen/mov_intent/update_name(updates)
	. = ..()
	if(hud?.mymob)
		switch(hud?.mymob?.m_intent)
			if(MOVE_INTENT_WALK)
				name = "walking"
			else
				name = "jogging"
		if(iscarbon(hud?.mymob))
			var/mob/living/carbon/C = hud.mymob
			if(C.combat_flags & COMBAT_FLAG_SPRINTING)
				name = "sprinting"

/atom/movable/screen/mov_intent/update_icon_state()
	. = ..()
	if(hud?.mymob)
		switch(hud?.mymob?.m_intent)
			if(MOVE_INTENT_WALK)
				icon_state = "walking"
			else
				icon_state = "jogging"
		if(iscarbon(hud?.mymob))
			var/mob/living/carbon/C = hud.mymob
			if(C.combat_flags & COMBAT_FLAG_SPRINTING)
				icon_state = "sprinting"
