/datum/element/multitool_emaggable
	element_flags = ELEMENT_DETACH

/datum/element/multitool_emaggable/Attach(datum/target)
	if(!isatom(target))
		return ELEMENT_INCOMPATIBLE
	. = ..()
	RegisterSignal(target, COMSIG_ATOM_TERTIARY_TOOL_ACT(TOOL_MULTITOOL), .proc/try_hacking)

/datum/element/multitool_emaggable/Detach(datum/source, force)
	. = ..()
	UnregisterSignal(source, COMSIG_ATOM_TERTIARY_TOOL_ACT(TOOL_MULTITOOL))

/datum/element/multitool_emaggable/proc/try_hacking(atom/source, mob/living/user, obj/item/tool)
	if(!user.mind || !user.canUseTopic(source))
		return FALSE

	var/electronic_level = GET_MOB_SKILL_VALUE(user, SKILL_ELECTRONICS)
	if(electronic_level < 8)
		to_chat(user, span_warning("I don't know how to do this."))
		return

	source.audible_message(span_warning("\The [source] starts to beep sporadically!"))
	if(!tool.use_tool(source, user, 50))
		to_chat(user, span_warning(fail_msg()))
		return
	if(user.diceroll(electronic_level, context = DICE_CONTEXT_MENTAL) <= DICE_FAILURE)
		source.audible_message(span_warning("[source] pings successfully, defending the hack attempt!"))
		to_chat(user, fail_msg())
		return
	source.audible_message(span_warning("[source] starts to beep even more frantically!"))
	to_chat(user, span_notice("Almost there..."))
	if(!tool.use_tool(source, user, 100))
		to_chat(user, span_warning(fail_msg()))
		return
	if(user.diceroll(electronic_level, context = DICE_CONTEXT_MENTAL) <= DICE_FAILURE)
		source.audible_message(span_warning("[source] pings successfully at defending the hack attempt!"))
		to_chat(user, span_warning(fail_msg()))
		return
	source.audible_message(span_warning("[source] beeps one last time..."))
	to_chat(user, span_notice("Success."))
	source.emag_act(user)
	return COMPONENT_BLOCK_TOOL_ATTACK
