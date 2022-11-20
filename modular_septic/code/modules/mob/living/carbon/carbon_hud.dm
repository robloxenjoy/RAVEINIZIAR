/mob/living/carbon/update_health_hud(shown_health_amount)
	if(!client || !hud_used)
		return
	if(hud_used.healths)
		if(stat != DEAD)
			. = TRUE
			switch(pulse)
				if(PULSE_NONE)
					hud_used.healths.icon_state = "pulse7"
				if(PULSE_SLOW)
					hud_used.healths.icon_state = "pulse3"
				if(PULSE_NORM)
					hud_used.healths.icon_state = "pulse0"
				if(PULSE_FAST)
					hud_used.healths.icon_state = "pulse4"
				if(PULSE_FASTER)
					hud_used.healths.icon_state = "pulse5"
				if(PULSE_THREADY)
					hud_used.healths.icon_state = "pulse6"
				else
					hud_used.healths.icon_state = "pulse6"
		else
			hud_used.healths.icon_state = "pulse7"

/mob/living/carbon/update_spacesuit_hud_icon()
/mob/living/carbon/proc/update_sleeping_hud()
	hud_used?.sleeping?.update_appearance()
