/mob/proc/gain_extra_effort(amount = 1, silent = FALSE)
	extra_effort = max(0, extra_effort + amount)
	if(!silent)
		to_chat(src, span_notice("Этот ритм в моей груди. Я чувствую себя так, что могу продолжать. <b>Хотя бы ещё немного.</b> ([amount] усилие получено)"))

/mob/proc/lose_extra_effort(amount = 1, silent = FALSE)
	extra_effort = max(0, extra_effort - amount)
	if(!silent)
		to_chat(src, span_warning("[amount] усилие потеряно"))

/mob/proc/choose_effort()
	if(HAS_TRAIT(src, TRAIT_EFFORT_ACTIVE))
		to_chat(src, span_warning("Усилие уже проводится!"))
		return
	var/list/available_efforts = list()
	for(var/effort_type in GLOB.path_to_Effort)
		var/datum/effort/effort = GLOB.path_to_Effort[effort_type]
		if(!effort.can_use(src))
			continue
		available_efforts["[effort.name] ([effort.cost] Усилие)"] = effort
	if(!LAZYLEN(available_efforts))
		to_chat(src, span_warning("Усилия недоступны."))
		return
//	var/chosen_effort = tgui_input_list(src, "What effort do you want to activate?", "Choosing effort ([extra_effort] EE)", available_efforts)
	var/chosen_effort = input(src, "Что за усилие я хочу проявить?", "Выбор усилия ([extra_effort] EE)") as null|anything in available_efforts
	if(chosen_effort)
		var/datum/effort/activated_effort = available_efforts[chosen_effort]
		activated_effort.activate(src)
		return
	to_chat(src, span_warning("Неважно."))

/mob/proc/activate_effort(effort_type, silent = FALSE)
	var/datum/effort/activated_effort = GLOB.path_to_Effort[effort_type]
	activated_effort.activate(src, silent)
