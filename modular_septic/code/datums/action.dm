/datum/action
	transparent_when_unavailable = FALSE
	button_icon = 'modular_septic/icons/hud/quake/actions.dmi'
	background_icon_state = "default"
	/// A character can have multiple action tabs in the peeper, this ensures we display on the correct one
	var/action_tab = /datum/peeper_tab/actions

/datum/action/Grant(mob/granted_to)
	if(granted_to)
		if(owner)
			if(owner == granted_to)
				return
			Remove(owner)
		owner = granted_to
		RegisterSignal(owner, COMSIG_PARENT_QDELETING, .proc/owner_deleted)
		LAZYADD(granted_to.actions, src)
		granted_to.update_action_buttons()
		return
	Remove(owner)

/datum/action/Remove(mob/removed_from)
	for(var/datum/weakref/reference as anything in sharers)
		var/mob/freeloader = reference.resolve()
		if(!freeloader)
			continue
		Unshare(freeloader)
	sharers = null
	if(removed_from)
		if(removed_from.client)
			removed_from.client.screen -= button
		LAZYREMOVE(removed_from.actions, src)
		removed_from.update_action_buttons()
	if(owner)
		UnregisterSignal(owner, COMSIG_PARENT_QDELETING)
		owner = null
	button.moved = initial(button.moved) //so the button appears in its normal position when given to another owner.
	button.locked = initial(button.locked)
	button.id = initial(button.id)
