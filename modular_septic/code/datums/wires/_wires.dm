/datum/wires
	var/revealed_wires = FALSE

/datum/wires/ui_act(action, params) //modularizing because i plan :tm: to eventually expand on this
	. = ..()
	if(. || !interactable(usr))
		return
	var/target_wire = params["wire"]
	var/mob/living/living_user = usr
	var/obj/item/item
	if((living_user.diceroll(GET_MOB_SKILL_VALUE(living_user, SKILL_ELECTRONICS), context = DICE_CONTEXT_PHYSICAL) <= DICE_FAILURE) && action != "attach") //Ultra shitcode
		to_chat(living_user, span_warning(fail_msg())) //But detaching shit would be basically impossible otherwise
		target_wire = pick(colors)
	switch(action)
		if("cut")
			if(GET_MOB_SKILL_VALUE(living_user, SKILL_ELECTRONICS) < 6)
				to_chat(living_user, span_warning("I don't... Know how to do this."))
				return
			item = living_user.is_holding_tool_quality(TOOL_WIRECUTTER)
			if(item || isAdminGhostAI(usr))
				if(item && holder)
					item.play_tool_sound(holder, 20)
				cut_color(target_wire)
				. = TRUE
		if("pulse")
			if(GET_MOB_SKILL_VALUE(living_user, SKILL_ELECTRONICS) < 8)
				to_chat(living_user, span_warning("I don't... know how to do this."))
				return
			item = living_user.is_holding_tool_quality(TOOL_MULTITOOL)
			if(item || isAdminGhostAI(usr))
				if(item && holder)
					item.play_tool_sound(holder, 20)
				pulse_color(target_wire, living_user)
				. = TRUE
		if("attach")
			if(GET_MOB_SKILL_VALUE(living_user, SKILL_ELECTRONICS) < 8) //It's basically a multitool.
				to_chat(living_user, span_warning("I don't know how to do this."))
				return
			if(is_attached(target_wire))
				item = detach_assembly(target_wire)
				if(item)
					living_user.put_in_hands(item)
					. = TRUE
			else
				item = living_user.get_active_held_item()
				if(istype(item, /obj/item/assembly))
					var/obj/item/assembly/assembly = item
					if(assembly.attachable)
						if(!living_user.temporarilyRemoveItemFromInventory(assembly))
							return
						if(!attach_assembly(target_wire, assembly))
							assembly.forceMove(living_user.drop_location())
						. = TRUE
