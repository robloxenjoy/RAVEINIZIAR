/client/MouseWheel(object, delta_x, delta_y, location, control, params)
	. = ..()
	if((abs(delta_y) >= 2) && isliving(mob))
		var/mob/living/living_mob = mob
		if(delta_y > 0)
			switch(living_mob.m_intent)
				if(MOVE_INTENT_WALK)
					living_mob.toggle_move_intent(living_mob)
				if(MOVE_INTENT_RUN)
					if(living_mob.combat_flags & COMBAT_FLAG_SPRINT_ACTIVE)
						return
					living_mob.toggle_sprint()
		else
			switch(living_mob.m_intent)
				if(MOVE_INTENT_RUN)
					if(living_mob.combat_flags & COMBAT_FLAG_SPRINT_ACTIVE)
						living_mob.toggle_sprint()
						return
					living_mob.toggle_move_intent(living_mob)

/client/proc/do_fullscreen(activate = FALSE)
	if(activate)
		winset(src, "mainwindow", "is-maximized=true;can-resize=false;titlebar=false;statusbar=false;menu=false")
	else
		winset(src, "mainwindow", "is-maximized=false;can-resize=true;titlebar=true;statusbar=false;menu=menu")
	addtimer(CALLBACK(src, .verb/fit_viewport), 5 SECONDS)

/client/proc/do_winset(control_id, params)
	winset(src, control_id, params)

/client/proc/do_winget(control_id, params)
	winget(src, control_id, params)

/client/proc/open_matrix_tester(atom/in_atom)
	if(!holder)
		return
	var/datum/matrix_editor/nobody_wants_to_learn_matrix_math = new /datum/matrix_editor(in_atom)
	nobody_wants_to_learn_matrix_math.ui_interact(mob)

/client/proc/open_attribute_editor(datum/attribute_holder/attributes)
	if(!holder)
		return
	var/datum/attribute_editor/attribute_editor = new /datum/attribute_editor(attributes)
	attribute_editor.ui_interact(mob)
