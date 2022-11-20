SUBSYSTEM_DEF(credits)
	name = "Credits"
	flags = SS_NO_INIT|SS_NO_FIRE

/datum/controller/subsystem/credits/ui_interact(mob/user, datum/tgui/ui)
	ui = SStgui.try_update_ui(user, src, ui)
	if(!ui)
		ui = new(user, src, "SepticShockCredits")
		ui.open()

/datum/controller/subsystem/credits/ui_state(mob/user)
	return GLOB.always_state
